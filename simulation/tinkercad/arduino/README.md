# Arduino Instrumentation

The Arduino Uno R3 is instrumentation only; it does not implement the oscillator. The NE555 and its external timing network generate the oscillation.

## Intended Measurement Channels

- A0 -> NE555 VOUT / pin 3
- A1 -> VCAP timing-capacitor node
- A2 -> Tinkercad battery positive rail / VCC measurement
- GND -> circuit common ground

## Authoritative Source

The authoritative logger source was extracted verbatim from the live Tinkercad model during the 2026-08-14 inspection workflow. It is stored at:

`simulation/tinkercad/arduino/pcb001_ne555_logger.ino`

Do not reconstruct or replace this source from memory. Future changes must remain traceable to an explicitly reviewed live-model revision.
