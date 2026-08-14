# Circuit Connections

This document records design intent for comparison with the live virtual breadboard. It does not establish visual verification of any physical connection.

## NE555 Connections

| Physical implementation item | Design intent | Live Tinkercad inspection status |
| --- | --- | --- |
| Pin 1 GND | GND | PENDING LIVE TINKERCAD INSPECTION |
| Pin 2 TRIG | VCAP | PENDING LIVE TINKERCAD INSPECTION |
| Pin 3 OUT | red LED -> 330 ohm -> GND | PENDING LIVE TINKERCAD INSPECTION |
| Pin 4 RESET | positive supply | PENDING LIVE TINKERCAD INSPECTION |
| Pin 5 CTRL | 10 nF capacitor -> GND | PENDING LIVE TINKERCAD INSPECTION |
| Pin 6 THRS | VCAP | PENDING LIVE TINKERCAD INSPECTION |
| Pin 7 DIS | RA/RB junction | PENDING LIVE TINKERCAD INSPECTION |
| Pin 8 VCC | positive supply | PENDING LIVE TINKERCAD INSPECTION |

## Timing Network and Supporting Components

Intended timing path:

```text
positive supply
-> RA = 10 kOhm
-> pin 7 DIS
-> fixed RB = 10 kOhm
-> 100 kOhm potentiometer used as rheostat
-> VCAP
-> C1 = 10 uF
-> GND
```

| Physical implementation item | Design intent | Live Tinkercad inspection status |
| --- | --- | --- |
| RA | 10 kOhm from positive supply to pin 7 DIS | PENDING LIVE TINKERCAD INSPECTION |
| Fixed RB | 10 kOhm from pin 7 DIS toward the potentiometer | PENDING LIVE TINKERCAD INSPECTION |
| Potentiometer | 100 kOhm, used as a rheostat between fixed RB and VCAP | PENDING LIVE TINKERCAD INSPECTION |
| C1 | 10 uF from VCAP to GND | PENDING LIVE TINKERCAD INSPECTION |
| C2 | 10 nF from pin 5 CTRL to GND | PENDING LIVE TINKERCAD INSPECTION |
| C3 | 100 nF VCC-to-GND supply decoupling | PENDING LIVE TINKERCAD INSPECTION |
| LED output stage | red LED with 330 ohm resistor to GND | PENDING LIVE TINKERCAD INSPECTION |
| Supply | approximately 4.49 V from a 3 x AAA battery representation | PENDING LIVE TINKERCAD INSPECTION |

No physical breadboard connection is marked visually verified.
