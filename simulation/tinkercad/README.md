# PCB-001 — Adjustable NE555 Astable LED Flasher

## Purpose

This directory preserves reproducible artifacts and evidence from the Tinkercad virtual breadboard verification stage.

The interactive Tinkercad circuit is cloud-hosted. This directory preserves code, measurements, circuit documentation, screenshots, and verification evidence derived from the live model. LTspice remains the precision electrical simulation model. Tinkercad represents the virtual breadboard and implementation translation. KiCad will become the authoritative PCB schematic and layout source.

The Tinkercad stage verifies practical pin mapping, component polarity, breadboard connectivity, potentiometer operation, instrumentation, and observable circuit behaviour. Static screenshots and the Arduino logger source were extracted directly from the live model during the 2026-08-14 inspection workflow.

## Current Verification Gates

- G1A Analytical Design: PASS
- G1B LTspice Full-Range Verification: PASS
- G1C LED Output Verification: PASS
- G1D Tinkercad Virtual Breadboard Verification: PASS

G1D is supported by minimum, midpoint, and maximum operating-point measurements.

## Live Project Metadata

- Project name: Spectacular Juttuli
- Tinkercad project URL: https://www.tinkercad.com/things/cFG6PsBppi5-spectacular-juttuli/editel
- Live inspection workflow date: 2026-08-14

## Preserved Static Evidence

- `evidence/breadboard-overview.png`
- `evidence/ne555-pin-wiring.png`
- `evidence/timing-network.png`
- `evidence/potentiometer-wiring.png`
- `evidence/led-output-stage.png`
- `evidence/arduino-logger-wiring.png`
- `evidence/arduino-code-panel.png`
- `evidence/tinkercad-schematic-view.png`

These files are genuine screenshots from the stopped live Tinkercad project. They do not establish powered waveforms or new measurement results.

## Corrected Dynamic Verification

On 2026-08-15, the Arduino logger was hardened against partial boundary cycles; the corrected source is preserved in commit `67e7f33`. The minimum, midpoint, and maximum operating points were re-run and all three passed. Genuine Serial Monitor and potentiometer evidence was captured at every operating point, with useful VOUT and VCAP scope evidence captured at midpoint and maximum. The electrical circuit itself was unchanged.

Corrected result records:

- `results/minimum_corrected_logger_2026-08-15.txt`
- `results/midpoint_corrected_logger_2026-08-15.txt`
- `results/maximum_corrected_logger_2026-08-15.txt`

Dynamic evidence:

- `evidence/potentiometer-minimum-2026-08-15.png`
- `evidence/serial-minimum-corrected-2026-08-15.png`
- `evidence/potentiometer-midpoint-2026-08-15.png`
- `evidence/serial-midpoint-corrected-2026-08-15.png`
- `evidence/scope-vout-midpoint-2026-08-15.png`
- `evidence/scope-vcap-midpoint-2026-08-15.png`
- `evidence/potentiometer-maximum-2026-08-15.png`
- `evidence/serial-maximum-corrected-2026-08-15.png`
- `evidence/scope-vout-maximum-2026-08-15.png`
- `evidence/scope-vcap-maximum-2026-08-15.png`
