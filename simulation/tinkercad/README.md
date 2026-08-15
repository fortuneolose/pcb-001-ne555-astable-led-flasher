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

## Pending Dynamic Evidence

- `evidence/potentiometer-minimum.png`
- `evidence/potentiometer-midpoint.png`
- `evidence/potentiometer-maximum.png`
- `evidence/scope-vout.png`
- `evidence/scope-vcap.png`
- `evidence/serial-monitor-summary.png`

Do not create these files until the corresponding operating point or live output has been deliberately captured and reviewed.
