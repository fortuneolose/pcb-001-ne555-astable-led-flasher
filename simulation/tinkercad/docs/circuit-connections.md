# Circuit Connections

This document records design intent and the completed 2026-08-14 live-model inspection of the virtual breadboard.

## NE555 Connections

| Physical implementation item | Design intent | Live Tinkercad inspection status |
| --- | --- | --- |
| Pin 1 GND | GND | VERIFIED |
| Pin 2 TRIG | VCAP | VERIFIED |
| Pin 3 OUT | red LED -> 330 ohm -> GND | VERIFIED |
| Pin 4 RESET | positive supply | VERIFIED |
| Pin 5 CTRL | 10 nF capacitor -> GND | VERIFIED |
| Pin 6 THRS | VCAP | VERIFIED |
| Pin 7 DIS | RA/RB junction | VERIFIED |
| Pin 8 VCC | positive supply | VERIFIED |

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
| RA | 10 kOhm from positive supply to pin 7 DIS | VERIFIED |
| Fixed RB | 10 kOhm from pin 7 DIS toward the potentiometer | VERIFIED |
| Potentiometer | 100 kOhm, used as a rheostat between fixed RB and VCAP | VERIFIED |
| C1 timing capacitor | 10 uF from VCAP to GND | VERIFIED |
| CTRL capacitor | 10 nF from pin 5 CTRL to GND | VERIFIED |
| Decoupling capacitor | 100 nF VCC-to-GND supply decoupling | VERIFIED |
| LED output stage | red LED with 330 ohm resistor to GND | VERIFIED |
| Supply | 3 x AAA representation; nominal 4.5 V and approximately 4.49 V in recorded measurements | VERIFIED |
| Overall timing-network implementation | RA, fixed RB, rheostat, VCAP, and timing capacitor topology | VERIFIED |

## Potentiometer Wiring

- Value = 100 kOhm
- Terminal 1 -> fixed 10 kOhm RB
- Wiper -> VCAP
- Terminal 2 -> VCAP
- Wiper tied to outer terminal 2
- Used as a rheostat

## Reference-Designator Traceability

Design nomenclature:

- C1 = 10 uF timing capacitor
- C2 = 10 nF CTRL capacitor
- C3 = 100 nF decoupling capacitor

Live Tinkercad reference labels:

- CC1 = 10 uF timing capacitor
- C1 = 10 nF CTRL capacitor
- CC3 = 100 nF decoupling capacitor

This is a reference-designator naming difference only, not an electrical discrepancy. The exact powered rail voltage was not re-measured during this static inspection because the simulation remained stopped.
