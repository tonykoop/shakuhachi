# Drawing Brief — SHK-D4-P1

Required drawings for the first prototype, with title block, scale, datums, critical dimensions, tolerances, and material/finish notes. SVG outputs live in `drawings/`. CAD masters live in `cad/`. CNC programs (when generated) live in `cnc/`.

## Title-block convention

Every drawing carries the same title block in the bottom-right corner:

```
Project:  Shakuhachi (SHK-D4-P1)
Drawing:  <name>
Drawn by: Tony Koop
Date:     2026-05-07
Scale:    <as marked>
Units:    Inches (mm in parens where ambiguous)
Material: <as marked>
Sheet:    1 of 1
Rev:      A — first issue
```

## Datum conventions

- Bore axis is **A** (cylindrical reference).
- Foot end-face is **B** (planar, perpendicular to A).
- Front centerline (utaguchi side) is **C** (planar, contains A).
- All longitudinal dimensions chain from datum **B** (foot end). All radial dimensions chain from **A** (bore axis).
- Thumb hole drawn on the back face is dimensioned with a "(back face)" annotation.

## Drawings list

### 1. `drawings/SHK-D4-P1-overall.svg` — overall instrument

- Side elevation (front view) of finished body, full length.
- Top of drawing = utaguchi end; bottom = foot end.
- Critical dims:
  - Overall length 21.50 in (datum B → top end-face).
  - OD 1.10 in (parallel-line callout, mid-body).
  - Bore ID 0.787 in (centered phantom-line, full length).
  - Foot-end square (datum B perpendicularity ±0.005 in).
- Scale: 1:2.

### 2. `drawings/SHK-D4-P1-bore-section.svg` — bore section A-A

- Section view through the bore axis showing inner geometry.
- Critical dims:
  - Bore length end-to-end = 21.50 in.
  - Bore ID = 0.787 in (callout shown at three stations: foot, mid 10.75, top 21.50).
  - Wall thickness shown at thinnest mid-station: 0.157 in nominal (= (1.10 − 0.787)/2).
- Section labels: A-A on overall view at 90° rotation indicator.
- Scale: 1:1.

### 3. `drawings/SHK-D4-P1-utaguchi.svg` — utaguchi detail

- Section through utaguchi notch, showing inner-bevel geometry.
- Critical dims:
  - Notch width 0.787 in (at outside surface, full bore opening).
  - Notch depth 0.315 in (vertical from outside surface).
  - Inner-bevel angle 32° (referenced to bore axis).
  - Outer-edge round-over radius 0.020–0.030 in (callout note).
  - Optional inlay block 0.787 W × 0.500 L × 0.060 D (phantom).
- Scale: 4:1.

### 4. `drawings/SHK-D4-P1-hole-layout.svg` — tone-hole layout (paper-wrap template)

- Unwrapped cylindrical surface drawn as a flat rectangle.
- Width = π · OD = π · 1.10 = 3.456 in.
- Length = 21.50 in.
- Hole-center crosshairs at:
  - Hole 1 (Tsu / F4): 19.40 in from foot, **front** centerline.
  - Hole 2 (Re / G4): 17.29 in from foot, front.
  - Hole 3 (Chi / A4): 15.40 in from foot, front.
  - Hole 4 (Ri / C5): 12.95 in from foot, front.
  - Thumb (Ro′ / D5): 11.54 in from foot, **back** centerline (= +π·OD/2 from front).
- Initial hole Ø 0.276 in (drawn as drilled-bore circles).
- Scale: 1:1 (must print full-size for paper-wrap use).

### 5. `drawings/SHK-D4-P1-blank.svg` — pre-bore blank

- Square blank 1.000 × 1.000 × 24.000 in (with 0.5 in waste at each end).
- Centerlines marked on both end faces.
- Bore axis dimension: 0.500 in from each adjacent face.
- Material spec: cherry, quarter-sawn, < 8 % MC.
- Scale: 1:4.

### 6. `drawings/SHK-fixture-vise.svg` — tailstock vise / square-stock carrier

- Top view + side view of the welded fixture.
- Critical dims:
  - V-channel angle 90° internal.
  - V-channel length 6.0 in.
  - Side-clamp screws 3/8-16, two pcs at 1.5 in and 4.5 in from inboard end.
  - Morse-taper shank: MT2 (or MT3 if Tony's lathe is MT3) — note variant on print.
  - Centerline runout to spindle axis < 0.005 in.
- Scale: 1:2.

### 7. `drawings/SHK-fixture-hole-jig.svg` — tone-hole drill-press jig

- V-cradle with sliding stop; index pin on back face for thumb-hole rotation.
- Cradle V-radius matches Ø 1.10 OD.
- Index pin offset = π · OD / 2 = 1.728 in (clocks the body 180° for back-side thumb hole).
- Sliding stop graduated in 0.05 in increments from 0 (foot reference) to 21.50 in.
- Scale: 1:2.

## Tolerance philosophy

- Bore ID: H7 (+0.000 / +0.0008 in) is the target — slight oversize on the reamer is acceptable; oversize is corrected by re-fitting acoustic predictions, not by re-cutting the bore.
- OD: ±0.010 in.
- Hole positions (longitudinal): ±0.020 in pre-tuning. Post-tuning, the radial-edge file marks are not dimensional; only the center-of-mass position is meaningful.
- Hole diameters: pre-tuning ±0.005 in (drilled). Post-tuning Ø not specified — final hole geometry is whatever the chromatic tuner accepts.
- Utaguchi angle: ±2° pre-tuning. Re-finishing during Step 9 of the assembly manual is expected.

## Cross-references

- Hole-layout SVG must match `cut-list.csv` rows SHK-CUT-004 through SHK-CUT-008.
- Utaguchi detail must match `bom.csv` SHK-BOM-002 / SHK-BOM-009.
- Vise + jig drawings cross-reference [`tonykoop/instrument-maker#84`](https://github.com/tonykoop/instrument-maker/issues/84) and `references/techniques/headstock-driven-deep-bore-drilling.md`.
