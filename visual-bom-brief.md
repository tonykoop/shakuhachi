# Visual BOM Brief — SHK-D4-P1

A single-sheet visual bill of materials laid out as a printed plate. Used for shop reference, capstone-deck "BOM" slide, and the build-log site's BOM section.

## Sheet layout

- A3 landscape (16.5 × 11.7 in), printable at 100% scale on a tabloid printer.
- Title block: top, full-width band with project name, drawing rev, date.
- Body: 4 columns × 4 rows of part cells; 1 hero photo cell spanning two cells in the upper-left.

## Cells (4 × 4 grid, by row)

### Row 1 (hero + critical-path tooling)

- **Hero (cells A1+B1+A2+B2, 2×2):** finished SHK-D4-P1 instrument, oblique view, 35° from horizontal. Background neutral. Caption: *"Shakuhachi SHK-D4-P1 — solid cherry, 1.8-shaku D4, 21.5 in OAL."*
- **C1: Hardwood blank (SHK-BOM-001)** — photo of unmilled 1×1×24 in cherry blank with end-grain visible. Caption: *"Quarter-sawn cherry, kiln-dried < 8% MC. 3 blanks ordered."*
- **D1: Long reamer (SHK-BOM-005)** — photo of the 20 mm × 24 in reamer flat on white seamless. Caption: *"20 mm straight-flute reamer, 24 in OAL. Final-pass bore tool."*

### Row 2

- **C2: Pilot + step-up bits (SHK-BOM-003 + 004)** — group photo. Caption: *"3/8 → 1/2 → 5/8 → 3/4 in long-shank bits. Stepped-up bore in 4 mm increments."*
- **D2: Tailstock vise (SHK-BOM-006)** — staged photo of the welded fixture on the lathe tailstock. Caption: *"Custom carrier — square blank gripped, MT2-mounted. See instrument-maker#84."*

### Row 3

- **A3: Tone-hole jig (SHK-BOM-007)** — drill-press jig photo. Caption: *"V-cradle + index pin, drills front and back holes from the same axis."*
- **B3: Utaguchi gauge (SHK-BOM-009)** — printed-and-glued 32° gauge resting on a sample notch. Caption: *"Reference angle: 32° inner bevel. Printed at 1:1, glued to acrylic."*
- **C3: Diamond files (SHK-BOM-008)** — round + flat 6-in pair on white. Caption: *"Hole-tuning toolkit. File-open in 0.5 mm steps."*
- **D3: Chromatic tuner (SHK-BOM-010)** — Korg OT-120 face-on. Caption: *"Korg OT-120 — ≤1 cent resolution. Already in shop."*

### Row 4

- **A4: Walnut oil + carnauba (SHK-BOM-013 + 014)** — bottle + tin grouped. Caption: *"Tried & True walnut oil bore + outside; carnauba wax outside only."*
- **B4: Buffalo horn block (SHK-BOM-002)** — single photo if pursued; else replace cell with empty box and caption *"Optional inlay — skipped for SHK-D4-P1."*
- **C4: Brad-point hole bits (SHK-CUT-004 et al.)** — 7 mm brad-point drill close-up. Caption: *"Tone-hole drill: 7 mm brad-point, undersize. File to final size."*
- **D4: Pin gauge / bore gauge (SHK-BOM-011)** — measurement tools on white. Caption: *"Bore-ovalization check: 3 readings 120° apart at each station."*

## Photo treatment

- Lighting: soft side light, 45°. White or neutral-grey background.
- Color: shoot ColorChecker reference with first photo of the day; correct in post.
- File format: PNG for visual BOM cells (preserves edges); JPG for hero.
- Resolution: 1200 × 1200 px minimum per cell (4 in @ 300 dpi).

## Cross-reference table

| Cell | BOM ID(s)             | Drawing reference                |
| ---- | --------------------- | -------------------------------- |
| A1-B2 | SHK-D4-P1 (assembly) | drawings/SHK-D4-P1-overall.svg   |
| C1   | SHK-BOM-001           | drawings/SHK-D4-P1-blank.svg     |
| D1   | SHK-BOM-005           | assembly-manual.md § Step 5      |
| C2   | SHK-BOM-003 + 004     | assembly-manual.md § Step 4–5    |
| D2   | SHK-BOM-006           | drawings/SHK-fixture-vise.svg    |
| A3   | SHK-BOM-007           | drawings/SHK-fixture-hole-jig.svg|
| B3   | SHK-BOM-009           | drawings/SHK-D4-P1-utaguchi.svg  |
| C3   | SHK-BOM-008           | validation.csv per-hole rows     |
| D3   | SHK-BOM-010           | validation.csv all measure rows  |
| A4   | SHK-BOM-013 + 014     | assembly-manual.md § Step 12     |
| B4   | SHK-BOM-002 (optional)| drawings/SHK-D4-P1-utaguchi.svg  |
| C4   | (cut-list)            | cut-list.csv SHK-CUT-004…008     |
| D4   | SHK-BOM-011           | validation.csv post-bore rows    |

## Total pictured cost

Sum of `bom.csv estimated_cost` for items pictured: ~430 USD (excluding the optional buffalo-horn inlay and mortising chisels). Update this number in the visual BOM bottom-right "Total" cell as orders confirm.
