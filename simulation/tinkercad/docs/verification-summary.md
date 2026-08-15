# Tinkercad Three-Point Verification Summary

The virtual breadboard was instrumented using an Arduino Uno R3 ADC logger.

- Capture duration = 8000 ms
- Sample interval = 10 ms

VCAP repeatedly moved between approximately 1/3 VCC and 2/3 VCC, consistent with NE555 astable operation.

## Minimum Potentiometer Setting

- Complete cycles analysed = 38
- Average tHIGH = 138.421 ms
- Average tLOW = 69.500 ms
- Average period = 207.921 ms
- Frequency = 4.8095 Hz
- Duty cycle = 66.574 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4901 V

## Midpoint Potentiometer Setting

- Complete cycles analysed = 8
- Average tHIGH = 481.250 ms
- Average tLOW = 420.000 ms
- Average period = 901.250 ms
- Frequency = 1.1096 Hz
- Duty cycle = 53.398 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4913 V

## Maximum Potentiometer Setting

- Complete cycles analysed = 4
- Average tHIGH = 822.500 ms
- Average tLOW = 775.000 ms
- Average period = 1597.500 ms
- Frequency = 0.6260 Hz
- Duty cycle = 51.487 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4916 V

Measured adjustable frequency range: approximately 0.6260 Hz to 4.8095 Hz

G1D: PASS

## Live Model Inspection

On 2026-08-14, the live Tinkercad implementation was inspected against `circuit-connections.md`.

- Electrical topology discrepancy: none observed
- Component-value discrepancy: none observed
- Potentiometer implementation: verified as a rheostat with the wiper tied to terminal 2
- Arduino instrumentation: verified
- Oscilloscope wiring: verified
- Exact powered rail voltage during this inspection: not verified because the simulation remained stopped
- Live waveforms during this inspection: not verified because the simulation remained stopped
- Tinkercad reference-designator naming differs from the design nomenclature, but electrical values and connections agree

## Corrected Logger Dynamic Re-Verification — 2026-08-15

The original logger could initialize `cycleRiseTime` when capture began while VOUT was already HIGH, allowing a partial initial HIGH interval to enter cycle timing. The corrected implementation uses explicit `haveRise` and `haveFall` state. Only a complete RISE -> FALL -> RISE sequence enters the averages, so incomplete first and final cycles are excluded. This was a logger robustness issue; it does not indicate a defect in the NE555 circuit.

### Minimum

- Complete cycles analysed = 37
- Average tHIGH = 138.351 ms
- Average tLOW = 69.486 ms
- Average period = 207.838 ms
- Frequency = 4.8114 Hz
- Duty cycle = 66.567 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4900 V
- Capture duration = 8000 ms
- Sample interval = 10 ms

Comparison with the historical result:

- Historical cycles = 38
- Period difference = -0.083 ms
- Frequency difference = +0.0019 Hz
- Duty difference = -0.007 percentage points
- Result = PASS

### Midpoint

- Complete cycles analysed = 8
- Average tHIGH = 481.250 ms
- Average tLOW = 420.000 ms
- Average period = 901.250 ms
- Frequency = 1.1096 Hz
- Duty cycle = 53.398 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4913 V
- Capture duration = 8000 ms
- Sample interval = 10 ms

All reported values match the historical midpoint result at printed precision. Result = PASS.

### Maximum

- Complete cycles analysed = 4
- Average tHIGH = 822.500 ms
- Average tLOW = 775.000 ms
- Average period = 1597.500 ms
- Frequency = 0.6260 Hz
- Duty cycle = 51.487 %
- VCAP minimum = 1.5005 V
- VCAP maximum = 2.9912 V
- VOUT minimum = 0.0000 V
- VOUT maximum = 4.3793 V
- Average VCC = 4.4916 V
- Capture duration = 8000 ms
- Sample interval = 10 ms

All reported values match the historical maximum result at printed precision. Result = PASS.

Corrected measured frequency range: 0.6260 Hz to 4.8114 Hz

All three corrected operating points: PASS

G1D Tinkercad Virtual Breadboard Verification: PASS — confirmed after corrected-logger dynamic re-verification.

The midpoint oscilloscopes used 250 ms/div, and the maximum oscilloscopes used 500 ms/div. Minimum scope screenshots were deliberately not preserved because the unchanged 100 us/div display was unsuitable for a period of approximately 208 ms. This omission is an evidence-quality decision, not a failed measurement.
