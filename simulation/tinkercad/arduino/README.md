# Arduino Instrumentation

The Arduino Uno R3 is instrumentation only; it does not implement the oscillator. The NE555 and its external timing network generate the oscillation.

## Intended Measurement Channels

- A0 -> NE555 VOUT / pin 3
- A1 -> VCAP timing-capacitor node
- A2 -> Tinkercad battery positive rail / VCC measurement
- GND -> circuit common ground

Authoritative logger source: PENDING LIVE TINKERCAD EXTRACTION

Future source location: `simulation/tinkercad/arduino/pcb001_ne555_logger.ino`

The logger source must be copied from the live Tinkercad model rather than reconstructed from memory. Do not create or claim an authoritative source file until that extraction is complete.
