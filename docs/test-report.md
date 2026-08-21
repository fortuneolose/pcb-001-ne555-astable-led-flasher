# KiCad Simulation Results — 2026-08-21

## Scope and status

This report records transient-simulation characterization of the PCB-001 adjustable NE555 astable LED flasher. The KiCad simulation schematic is separate from the production schematic.

**Status:** Simulation evidence recorded. These results do not constitute physical validation, fabrication approval, or a production-gate pass. Formal acceptance criteria were not recorded before this run, so the observations below are not marked as requirement passes.

## Simulation configuration

- Tool: KiCad Simulator; application version not recorded.
- Analysis: transient, with PSpice/LTspice compatibility enabled.
- Supply: 5 V DC.
- Timer model: external `uA555.sub`, subcircuit `UA555`, with symbol pins 1–8 mapped to model pins 1–8.
- Timing network: R1 = 10 kΩ, R2 = 10 kΩ, C1 = 10 µF.
- `R4` is the simulation-only substitute for RV1 and was evaluated at 1 Ω, 50 kΩ, and 100 kΩ. The 1 Ω case approximates the minimum setting while avoiding a zero-ohm SPICE element.
- Timing-range runs: D1 and R3 excluded; 100 µs time step and maximum step; 2 s duration for the 1 Ω and 50 kΩ cases, and 10 s for the 100 kΩ case.
- Loaded-LED run: R4 = 50 kΩ, D1 and R3 = 330 Ω included; 2 s duration with a 100 µs time step and maximum step.
- LED model: generic built-in diode adjusted for red-LED behaviour (`is = 1e-18 A`, `rs = 5 Ω`, `n = 2`). This is not a manufacturer-specific LED model.

## Timing-range results

| R4 setting | Period | Frequency | VOUT high time | VOUT low time | Duty cycle | VCAP range |
|---|---:|---:|---:|---:|---:|---:|
| 1 Ω | 0.197 s | 5.08 Hz | 0.127 s | 0.070 s | 64.5% | approximately 1.85–3.38 V |
| 50 kΩ | 0.845 s | 1.18 Hz | 0.443 s | 0.402 s | 52.4% | approximately 1.85–3.38 V |
| 100 kΩ | 1.45 s | 0.690 Hz | 0.767 s | 0.683 s | 52.9% | approximately 1.85–3.38 V |

The saved CSV data confirms that VCAP repeatedly traverses approximately one-third to two-thirds of the 5 V supply while VOUT toggles. Brief VOUT switching spikes are attributed to the external `UA555` model and numerical switching behaviour; they are not treated as expected hardware output levels.

## Loaded LED-branch results at R4 = 50 kΩ

| Quantity | Recorded result |
|---|---:|
| Steady VOUT high level | approximately 3.62 V |
| D1 cathode / R3 input node while on | approximately 1.72 V |
| LED forward voltage | approximately 1.90 V |
| LED on-current | approximately 5.20 mA |
| R3 steady on-state power | approximately 8.92 mW |
| R3 maximum saved transient power | 10.19 mW |

The branch values are internally consistent: `1.72 V / 330 Ω = 5.21 mA`, which agrees with the simulated 5.20 mA LED current. Final suitability still depends on the selected LED datasheet, resistor power rating, tolerances, temperature, and bench measurement.

## Evidence

| Evidence | PNG | CSV |
|---|---|---|
| Mid timing, R4 = 50 kΩ | [plot](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/01_timing_mid_50k.png) | [data](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/01_timing_mid_50k.csv) |
| Minimum timing, R4 = 1 Ω | [plot](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/02_timing_min_1ohm.png) | [data](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/02_timing_min_1ohm.csv) |
| Maximum timing, R4 = 100 kΩ | [plot](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/03_timing_max_100k.png) | [data](../simulation/kicad/schematic_simulation_response_plots/Timing_range_exports/03_timing_max_100k.csv) |
| LED current, R4 = 50 kΩ | [plot](../simulation/kicad/schematic_simulation_response_plots/led_current/04_led_current_mid_50k.png) | [data](../simulation/kicad/schematic_simulation_response_plots/led_current/04_led_current_mid_50k.csv) |
| Loaded LED voltages, R4 = 50 kΩ | [plot](../simulation/kicad/schematic_simulation_response_plots/loaded_voltage_exports/05_led_loaded_voltages_mid_50k.png) | [data](../simulation/kicad/schematic_simulation_response_plots/loaded_voltage_exports/05_led_loaded_voltages_mid_50k.csv) |
| R3 power, R4 = 50 kΩ | [plot](../simulation/kicad/schematic_simulation_response_plots/r3_power_recording/06_r3_power_mid_50k.png) | [data](../simulation/kicad/schematic_simulation_response_plots/r3_power_recording/06_r3_power_mid_50k.csv) |
| Loaded LED composite | [plot](../simulation/kicad/schematic_simulation_response_plots/loaded_led_exports/07_led_branch_composite.png) | [data](../simulation/kicad/schematic_simulation_response_plots/loaded_led_exports/07_led_branch_composite.csv) |

Additional source artifacts:

- [KiCad simulation schematic](../simulation/kicad/simulation_schematic/pcb-001-ne555.kicad_sch)
- [KiCad simulator workbook](../simulation/kicad/workbook/pcb-001-ne555.wbk)
- [Archived plot package](../simulation/kicad/schematic_simulation_response_plots.zip)
- [UA555 subcircuit model](../kicad/models/uA555.sub)

## Remaining verification

- Record the exact KiCad version used for reproducibility.
- Define requirement-level acceptance criteria before assigning PASS/FAIL status.
- Confirm component tolerances and temperature sensitivity.
- Confirm the selected LED and R3 ratings against their manufacturer datasheets.
- Perform fabrication review, assembly inspection, and powered bench measurements before physical-validation closure.
