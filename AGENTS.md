# Repository Guidelines

## Project Scope and Engineering Workflow

PCB-001 is an adjustable NE555 astable LED flasher. Maintain this gated workflow:

1. Analytical design and component calculations.
2. LTspice electrical verification.
3. Tinkercad virtual breadboard verification.
4. KiCad schematic capture and electrical review.
5. PCB layout and design-rule review.
6. Fabrication output and board manufacture.
7. Assembly and inspection.
8. Physical validation against requirements.

Completion of one activity does not prove the next gate passed. Never invent engineering results or measurements. Never mark a verification gate PASS without recorded evidence.

## Repository Structure and Authority

- `docs/` holds requirements, design rationale, test records, engineering logs, and datasheets.
- `simulation/matlab/` holds analytical visualization scripts.
- `simulation/ltspice/` holds the LTspice source schematic, generated results, and LTspice evidence.
- `simulation/tinkercad/` is reserved for virtual breadboard artifacts and evidence; never mix these with LTspice evidence.
- `worklogs/<YYYY-MM-DD_HHMM>/` preserves dated engineering activity and supporting evidence.

KiCad files, once introduced, are the authoritative PCB schematic and layout source. Tinkercad remains a virtual breadboard/simulation artifact and must not supersede KiCad. Before repository-wide operations or broad staging/move operations, inspect existing files and run `git status --short --untracked-files=all`. Use `git mv` for tracked relocations so history remains traceable.

## Evidence and Traceability

Preserve traceability from analytical design through LTspice, Tinkercad, KiCad, fabrication, assembly, and physical validation. Link requirements and design decisions to calculations, tool setup, observations, test results, and evidence paths. Record component values, supply voltage, NE555 model, tool/version, parameter sweep, tolerance, and date. Identify each result's provenance. Never modify verified LTspice evidence unless explicitly requested. Historical engineering worklogs must never be deleted, overwritten, or rewritten to alter the historical record; add clearly identified superseding records instead.

## Verification Practices

Use `matlab -batch "run('simulation/matlab/ne555_astable_cycle_animation.m')"` for the analytical model. In LTspice, run `pcb001_ne555_astable.asc` and review frequency, duty cycle, capacitor limits, output levels, and LED current for every `RBval` step. Document acceptance criteria before testing and record actual results in `docs/test-report.md`. For Tinkercad and physical tests, capture circuit configuration, instrument readings, and images separately. Mark unavailable or unperformed checks as pending, not passed.

## File, Commit, and Review Practices

Use SI units, explicit tolerances, descriptive Markdown headings, and filenames that identify the stage and date. Do not hand-edit generated LTspice `.raw`, `.log`, `.net`, or `.op.raw` files. Before review, run `git status --short --untracked-files=all` and `git diff --check`. Use concise commits such as `docs: record LTspice duty-cycle verification`. Do not commit or push unless explicitly instructed. Never run `upload-changes.ps1` during a controlled staged workflow unless explicitly instructed. The script stages the entire worktree, commits, and pushes the current branch. Reviews must state affected requirements, changed design artifacts, verification performed, evidence locations, and remaining gates.
