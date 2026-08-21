# PCB-001 Production Definition and Fabrication Profile

Status: controlled prototype baseline; not yet a released fabrication package

Design: NE555 astable LED flasher

Authoritative PCB: `kicad/pcb-001-ne555/pcb-001-ne555-placement-modified.kicad_pcb`

Authoritative schematic: `kicad/pcb-001-ne555/pcb-001-ne555-placement-modified.kicad_sch`

## 1. Scope and release intent

This document fixes the component selections and board-construction requirements for PCB-001. It is the procurement and fabrication baseline for the first physical prototype. It does not replace the KiCad schematic, PCB, netlist, or design-rule checks.

The machine-readable companion BOM is `fabrication/PCB-001-production-bom.csv`. Quantities are per assembled board and exclude procurement attrition. No component substitution is automatically approved by this document.

The simulation-only resistor R4 is not present in the authoritative schematic or PCB and is not a production component. TP1 through TP4 are bare plated PCB test features; no test-point hardware is fitted or purchased.

## 2. Exact fitted components

| References | Qty | Selected manufacturer part | Controlled purpose and fit |
|---|---:|---|---|
| U1 | 1 | Texas Instruments `NE555P` | Bipolar 555 timer in PDIP-8; matches the 7.62 mm DIP footprint and the validated uA555 simulation path. A CMOS TLC555 is not an approved drop-in for this release. |
| RV1 | 1 | Bourns `3386P-1-104LF` | 100 kOhm, single-turn, top-adjust cermet trimmer; its 3386P pin geometry matches the board footprint. |
| R1, R2 | 2 | YAGEO `MFR-25FBF52-10K` | 10 kOhm, 1%, 0.25 W axial metal-film; 6.3 x 2.4 mm body fits the DIN0207 footprint. |
| R3 | 1 | YAGEO `MFR-25FBF52-330R` | 330 Ohm, 1%, 0.25 W axial metal-film. The measured simulation peak of about 8.92 mW provides ample rating margin. |
| C1 | 1 | Panasonic Industry `ECEA1VKA100` | 10 uF, 35 V, 5 x 7 mm radial electrolytic on 2.0 mm pitch. Pad 1 is positive. |
| C2 | 1 | Vishay BCcomponents `K103K10X7RF53H5` | 10 nF, 10%, X7R, 50 V radial MLCC; 5.0 mm pitch and 3.6 x 2.3 mm body. |
| C3 | 1 | Vishay BCcomponents `K104K10X7RF53H5` | 100 nF, 10%, X7R, 50 V radial MLCC; 5.0 mm pitch and 3.6 x 2.3 mm body. |
| D1 | 1 | Kingbright `L-53LID` | Low-current red diffused 5 mm LED. Pad 1 is cathode and pad 2 is anode/VOUT. |
| J1 | 1 | Same Sky `TB007-508-02BE` | Blue two-position, 5.08 mm-pitch horizontal terminal block with slotted screws. Pin 1 is +5 V; pin 2 is GND. |

Part specifications and source documents are recorded in the companion CSV. Distributor inventory is deliberately not part of the controlled definition because it changes independently of the design.

## 3. Substitution control

The listed manufacturer part numbers are the release baseline. A proposed substitute requires an engineering review before purchase or assembly. At minimum, the review must confirm all of the following:

- identical electrical value, pin numbering, polarity, and circuit function;
- equal or better voltage, power, temperature, and tolerance ratings;
- body, lead diameter, lead pitch, and seated height compatible with the assigned KiCad footprint and adjacent courtyards;
- no material change to the validated oscillator frequency, duty cycle, LED current, or decoupling behaviour;
- updated BOM evidence and a repeated ERC, DRC, schematic-parity, and simulation check when the substitute can affect behaviour.

In particular, a generic 5 mm LED, a CMOS 555, a different potentiometer terminal style, or a terminal block with vertical wire entry is not pre-approved.

## 4. Bare-board fabrication profile

| Attribute | Controlled requirement |
|---|---|
| Board outline | Rectangular, 38.50 mm x 40.75 mm; no internal cut-outs, slots, castellations, or edge plating |
| Layer count | 2 copper layers: F.Cu and B.Cu |
| Base material | FR-4, Tg >=130 degC, UL-recognised material |
| Finished thickness | 1.60 mm nominal, +/-10% |
| Finished copper | 35 um nominal (1 oz) on both outer layers |
| Surface finish | Lead-free HASL |
| Solder mask | Green LPI mask on both sides |
| Legend | White component legend on F.SilkS; B.SilkS only if present in released Gerbers |
| Copper geometry | Actual minimum track 0.30 mm; actual minimum copper clearance 0.25 mm; copper-to-board-edge minimum rule 0.50 mm |
| Fabricator capability | 0.20 mm / 0.20 mm track/space or better; 0.25 mm minimum annular-ring capability or better |
| Copper pours | GND zone on F.Cu and B.Cu; 0.25 mm zone clearance; 0.25 mm minimum zone feature; thermal reliefs |
| Holes | Plated through-holes only; minimum finished component hole 0.80 mm; LED 0.90 mm; test pads 1.00 mm; terminal block 1.60 mm |
| Vias | None in the released design |
| Plating | PTH copper plating >=20 um in hole wall |
| Controlled impedance | None |
| Special processes | No blind/buried/microvias, via fill, via-in-pad, countersink, carbon ink, peelable mask, or press-fit control |
| Outline tolerance | +/-0.20 mm unless the selected fabricator's standard Class 2 tolerance is tighter |
| Workmanship | IPC-6012 Class 2 target; IPC-A-600 Class 2 visual acceptability |
| Electrical test | 100% bare-board netlist test required |
| Compliance | RoHS-compatible materials and lead-free finish |
| Panelisation | Fabricator standard production panel; supply PCB-001 as a single finished board after depanelisation |

The design has 38 routed track segments: 11 F.Cu +5 V segments at 0.50 mm, 2 F.Cu GND segments at 0.50 mm, 18 remaining F.Cu signal segments at 0.30 mm, and 7 B.Cu signal segments at 0.30 mm. There are no vias. These counts are descriptive checks against the current PCB and are not substitutes for Gerber/netlist comparison.

## 5. Assembly profile

- Assembly type: all through-hole, components fitted on the front side and soldered from the back side.
- Preferred process for the prototype: manual soldering with SAC305 lead-free solder and no-clean flux. The selected terminal block also permits a 260 degC maximum, 5-second wave-solder exposure according to its datasheet.
- No paste stencil, solder-paste Gerber, or pick-and-place file is required.
- Observe U1 notch/pin 1, C1 positive pad 1, D1 cathode pad 1, and J1 pin 1 `+5 V` / pin 2 `GND`.
- Seat C2 and C3 without stressing their formed leads. Keep TP1 through TP4 unobstructed and accessible to a probe.
- Fit RV1 with its adjustment slot accessible from the component side; set its initial position to mid-travel before first power-up.
- Trim leads after soldering and inspect for solder bridges, insufficient wetting, lifted pads, reversed polarised parts, and conductive debris.
- Workmanship target: IPC-A-610 Class 2.

## 6. Fabrication-package outputs

The release package shall be generated from the authoritative PCB only after the release checks below. It must contain:

- Gerber X2 copper: F.Cu and B.Cu;
- Gerber solder mask: F.Mask and B.Mask;
- Gerber legend: F.SilkS and B.SilkS only where populated;
- Gerber board profile: Edge.Cuts;
- Excellon plated-through-hole drill file and drill map;
- Gerber job file;
- this fabrication profile and the production BOM;
- a checksum manifest for the released archive.

No Gerber or drill file should be accepted if its board outline differs from 38.50 mm x 40.75 mm or if it introduces an unplated hole class absent from the source PCB.

## 7. Release gates still required

This definition does not by itself authorise fabrication. Before labelling the archive `RELEASED`, complete and record:

1. ERC: zero violations and zero unintended ignored tests.
2. PCB DRC: zero violations, zero unconnected items, and zero schematic-parity findings.
3. Visual polarity/orientation review against the BOM and front/back fabrication previews.
4. Gerber and drill re-import or independent viewer inspection.
5. BOM-to-schematic reference/value/footprint comparison.
6. Procurement availability check for every exact MPN; any substitution follows Section 3.
7. Final checksum and dated release note.

The current KiCad checks were clean at the time this profile was drafted, but a fresh run is required after any later design or metadata change and immediately before fabrication output generation.

## 8. Primary component sources

- Texas Instruments NE555: <https://www.ti.com/lit/ds/symlink/ne555.pdf>
- Bourns 3386: <https://www.bourns.com/docs/product-datasheets/3386.pdf>
- YAGEO MFR-25 10 kOhm: <https://www.yageogroup.com/component-documentation/download/specsheet/MFR-25FBF52-10K>
- YAGEO MFR-25 330 Ohm: <https://www.yageogroup.com/component-documentation/download/specsheet/MFR-25FBF52-330R>
- Panasonic ECEA1VKA100: <https://industrial.panasonic.com/ww/products/pt/aluminum-cap-lead/models/ECEA1VKA100>
- Vishay K Series: <https://www.vishay.com/docs/45171/kseries.pdf>
- Kingbright L-53LID: <https://www.kingbrightusa.com/images/catalog/SPEC/W53LID.pdf>
- Same Sky TB007-508: <https://www.sameskydevices.com/product/resource/tb007-508.pdf>
