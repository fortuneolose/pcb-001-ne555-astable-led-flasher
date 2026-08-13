%% NE555 Astable Operating Cycle Animation
% PCB-001 learning script
clear; clc; close all;

%% Parameters
VCC = 5;
RA = 10e3;
RB = 50e3;
C  = 10e-6;
nCycles = 3;

saveVideo = false;
videoName = 'ne555_astable_cycle.mp4';

%% Thresholds and timing
VTRIG = VCC/3;
VTH   = 2*VCC/3;

tHIGH = log(2)*(RA + RB)*C;
tLOW  = log(2)*RB*C;
T = tHIGH + tLOW;
f = 1/T;

fprintf('tHIGH = %.3f s\n', tHIGH);
fprintf('tLOW  = %.3f s\n', tLOW);
fprintf('f     = %.3f Hz\n', f);

%% Build waveform
t = [];
vc = [];
vout = [];
state = strings(1,0);
offset = 0;

for k = 1:nCycles
    tc = linspace(0,tHIGH,100);
    vcharge = VCC - (VCC - VTRIG).*exp(-tc/((RA+RB)*C));
    vcharge(end) = VTH;

    t = [t offset+tc];
    vc = [vc vcharge];
    vout = [vout VCC*ones(size(tc))];
    state = [state repmat("CHARGING",1,numel(tc))];
    offset = offset + tHIGH;

    td = linspace(0,tLOW,80);
    vdis = VTH.*exp(-td/(RB*C));
    vdis(end) = VTRIG;

    t = [t offset+td];
    vc = [vc vdis];
    vout = [vout zeros(size(td))];
    state = [state repmat("DISCHARGING",1,numel(td))];
    offset = offset + tLOW;
end

%% Figure
fig = figure('Name','NE555 Astable Operating Cycle',...
    'NumberTitle','off','Position',[100 80 1200 720]);

tl = tiledlayout(2,2,'TileSpacing','compact','Padding','compact');

% Left: conceptual diagram
ax1 = nexttile([2 1]);
axis([0 10 0 12]); axis off; hold on;
title('Astable timing network');

text(4.5,11.3,'+V_{CC}','HorizontalAlignment','center','FontWeight','bold');
plot([4.5 4.5],[10.8 11.1],'k','LineWidth',1.5);

rectangle('Position',[4.1 9.3 0.8 1.4],'LineWidth',1.2);
text(5.2,10,'R_A','FontWeight','bold');

plot([4.5 4.5],[9.3 8.6],'k','LineWidth',1.5);
plot(4.5,8.6,'ko','MarkerFaceColor','k');
text(5.2,8.6,'Pin 7: DISCHARGE');

rectangle('Position',[4.1 6.9 0.8 1.4],'LineWidth',1.2);
text(5.2,7.6,'R_B','FontWeight','bold');

plot([4.5 4.5],[6.9 5.8],'k','LineWidth',1.5);
plot(4.5,5.8,'ko','MarkerFaceColor','k');
text(5.2,6.1,'Pins 2 + 6');
text(5.2,5.7,'TRIGGER + THRESHOLD');

plot([3.8 5.2],[5.0 5.0],'k','LineWidth',2);
plot([3.8 5.2],[4.6 4.6],'k','LineWidth',2);
plot([4.5 4.5],[5.8 5.0],'k','LineWidth',1.5);
plot([4.5 4.5],[4.6 3.9],'k','LineWidth',1.5);
text(5.2,4.8,'C','FontWeight','bold');

plot([3.9 5.1],[3.8 3.8],'k','LineWidth',1.4);
plot([4.1 4.9],[3.55 3.55],'k','LineWidth',1.4);
plot([4.3 4.7],[3.3 3.3],'k','LineWidth',1.4);

text(0.8,10.6,'STATE','FontWeight','bold','FontSize',12);
stateText = text(0.8,10.0,'Waiting...','FontWeight','bold','FontSize',13);
infoText = text(0.8,9.2,'','VerticalAlignment','top','FontSize',10);

text(0.8,4.5,sprintf(['1/3 VCC = %.2f V  -> trigger level\n' ...
                      '2/3 VCC = %.2f V  -> threshold level'],...
                      VTRIG,VTH));

% Right top: capacitor voltage
ax2 = nexttile;
hold on; grid on;
plot([0 t(end)],[VTRIG VTRIG],'--','DisplayName','1/3 VCC');
plot([0 t(end)],[VTH VTH],'--','DisplayName','2/3 VCC');
capLine = animatedline('LineWidth',1.8);
capDot = plot(t(1),vc(1),'o','MarkerFaceColor','auto');
xlabel('Time (s)'); ylabel('V_C (V)');
title('Timing capacitor');
xlim([0 t(end)]); ylim([0 VCC]);
legend('Location','best');

% Right bottom: output
ax3 = nexttile;
hold on; grid on;
outLine = animatedline('LineWidth',1.8);
outDot = plot(t(1),vout(1),'o','MarkerFaceColor','auto');
xlabel('Time (s)'); ylabel('V_{OUT} (V)');
title(sprintf('555 output   f = %.2f Hz',f));
xlim([0 t(end)]); ylim([-0.3 VCC+0.5]);

if saveVideo
    writer = VideoWriter(videoName,'MPEG-4');
    writer.FrameRate = 30;
    open(writer);
end

%% Animation loop
for i = 1:numel(t)
    addpoints(capLine,t(i),vc(i));
    set(capDot,'XData',t(i),'YData',vc(i));

    addpoints(outLine,t(i),vout(i));
    set(outDot,'XData',t(i),'YData',vout(i));

    if state(i) == "CHARGING"
        set(stateText,'String','CHARGING');
        set(infoText,'String',sprintf([...
            'OUTPUT = HIGH\n'...
            'Pin 7 discharge path = OFF\n'...
            'C charges through R_A + R_B\n'...
            'V_C = %.2f V\n\n'...
            'Next event: reach 2/3 VCC'],vc(i)));
    else
        set(stateText,'String','DISCHARGING');
        set(infoText,'String',sprintf([...
            'OUTPUT = LOW\n'...
            'Pin 7 discharge path = ON\n'...
            'C discharges through R_B\n'...
            'V_C = %.2f V\n\n'...
            'Next event: fall to 1/3 VCC'],vc(i)));
    end

    drawnow;

    if saveVideo
        writeVideo(writer,getframe(fig));
    else
        pause(0.01);
    end
end

if saveVideo
    close(writer);
    fprintf('Saved video: %s\n',videoName);
end

sgtitle(sprintf('NE555 Astable Operating Cycle   T = %.3f s',T),...
    'FontWeight','bold');
