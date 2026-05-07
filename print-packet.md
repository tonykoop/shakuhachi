# Shakuhachi SHK-D4-P1 — Printable Shop Packet

**Project:** Shakuhachi (SHK-D4-P1)
**Date:** 2026-05-07
**Driver:** Tony Koop
**Skill:** instrument-maker-v4

---

## Cover / summary

A single-instrument build packet for **SHK-D4-P1** — a 1.8-shaku D4 solid-cherry shakuhachi prototype. Open-pipe acoustics; bore drilled with the headstock-driven deep-bore drilling technique on the lathe. Hand-cut utaguchi. Five tone holes (4 front + 1 thumb), tuned to Kinko-ryū intervals.

---

## Quick start (shop reference)

| Step | Operation                      | Time   | Page |
| ---- | ------------------------------ | ------ | ---- |
| 1    | Mill blanks (1×1×24 cherry)    | 30 min | §B   |
| 2    | Build tailstock vise (1-time)  | 90 min | §C   |
| 3    | Pine-scrap validation pass     | 45 min | §D   |
| 4    | Production deep-bore           | 90 min | §D   |
| 5    | Outside turn between centers   | 60 min | §E   |
| 6    | Tone-hole layout + drill 7 mm  | 45 min | §F   |
| 7    | Cut + file utaguchi            | 60 min | §G   |
| 8    | Bisque-style tuning            | 90 min | §H   |
| 9    | Walnut-oil + cure              | 5 d    | §I   |
| 10   | Carnauba wax + final pass      | 30 min | §I   |

---

## File map

- `design.md` — governing model + design narrative
- `bom.csv` — 16-line bill of materials
- `sourcing.csv` — supplier list with verified-on column
- `cut-list.csv` — blank → finished part ops
- `validation.csv` — measurement plan + targets
- `assembly-manual.md` — 13-step shop manual (full detail)
- `risks.md` — red-team register; every risk has a test
- `drawings/` — 6 SVG drawings (overall + section + utaguchi + hole template + 2 fixtures)
- `cad/shakuhachi_master.scad` — OpenSCAD parametric master
- `wolfram-starter.wl` — Wolfram package for cents math + correction-refit
- `shakuhachi-design-table.xlsx` — 11-key parametric workbook
- `site/index.html` — public build log

---

## §A — Design intent

Solid-billet hardwood adaptation of the shakuhachi. Western luthier shop. 1.8-shaku D4 first; sized siblings later. Document the open-pipe acoustic model honestly so the first measurement drives a corrections database update. Not a tradition-faithful reproduction; respectful of Kinko-ryū / Tozan-ryū lineage.

---

## §B — Bill of materials

(extract — full table in `bom.csv`)

| ID            | Item                              | Qty | Cost (USD) |
| ------------- | --------------------------------- | --- | ---------: |
| SHK-BOM-001   | Cherry blanks 1×1×24 in           | 3   |      28.00 |
| SHK-BOM-003   | 3/8 in pilot brad-point bit       | 1   |      16.00 |
| SHK-BOM-004   | Step-up drill set 1/2-3/4 in      | 1   |      42.00 |
| SHK-BOM-005   | 20 mm reamer 24 in OAL            | 1   |      68.00 |
| SHK-BOM-006   | Tailstock vise (build)            | 1   |      35.00 |
| SHK-BOM-007   | Tone-hole drill jig (build)       | 1   |      15.00 |
| SHK-BOM-008   | Diamond files round + flat        | 1   |      22.00 |
| SHK-BOM-010   | Korg OT-120 chromatic tuner       | 1   |      89.00 |
| SHK-BOM-013   | Walnut oil 8 oz                    | 1   |      14.00 |
| SHK-BOM-014   | Carnauba wax 4 oz                  | 1   |      11.00 |

**Total pictured: ~430 USD** excluding optional inlay block.

---

## §C — Sourcing list

Primary: Bell Forest Products (cherry), Travers Tool (reamer), Lee Valley (bits + files), Sweetwater (tuner), Tried & True (walnut oil), McMaster-Carr (vise hardware).

**Long-lead item:** 20 mm reamer (~10 days). Order first.

---

## §D — Cut list (extract)

(full table in `cut-list.csv`)

| Cut ID        | Part            | Operation                                                |
| ------------- | --------------- | -------------------------------------------------------- |
| SHK-CUT-001   | Cherry blank    | Headstock-driven deep-bore + turn between centers        |
| SHK-CUT-002   | Foot end face   | Lathe parting + sandpaper face                           |
| SHK-CUT-003   | Utaguchi notch  | Bandsaw + chisel + file (32° inner bevel)                |
| SHK-CUT-004…008 | Tone holes    | Drill press w/ V-cradle jig; 7 mm brad-point undersize   |

---

## §E — Drawing reference

| Drawing                       | Shows                                       | Scale |
| ----------------------------- | ------------------------------------------- | ----- |
| SHK-D4-P1-overall.svg         | Side elevation, full body, hole positions   | 1:2   |
| SHK-D4-P1-bore-section.svg    | Section A-A through bore axis               | 1:2   |
| SHK-D4-P1-utaguchi.svg        | Utaguchi notch geometry, 32° bevel          | 4:1   |
| SHK-D4-P1-hole-layout.svg     | Unwrapped cylinder paper-wrap template      | 1:1   |
| SHK-D4-P1-blank.svg           | Pre-bore square stock                       | 1:4   |
| SHK-fixture-vise.svg          | Tailstock vise welded fixture               | 1:2   |
| SHK-fixture-hole-jig.svg      | Tone-hole drill-press V-cradle jig          | 1:2   |

---

## §F — Assembly manual

See `assembly-manual.md` for the full 13-step shop manual. The steps are:

1. Read first (design.md, risks.md, instrument-maker#84)
2. Mill blanks
3. Center-mark + cross-mark
4. Build tailstock vise (one-time)
5. Scrap-stock validation pass (mandatory)
6. Production deep-bore (the long one)
7. Outside turn
8. Tone-hole layout + drill undersize
9. Cut utaguchi
10. Bisque-style tuning (post-utaguchi)
11. Per-hole tuning
12. Octave check
13. Finish + record

---

## §G — Validation / tuning sheet

(blanks for shop notes — see `validation.csv` for the full row set)

| Stage                  | Target                          | Measured | Pass / Fail | Notes |
| ---------------------- | ------------------------------- | -------- | ----------- | ----- |
| Bore wander @ 6 in     | < 0.020 in                      | _____    | □           |       |
| Bore wander @ 12 in    | < 0.040 in                      | _____    | □           |       |
| Bore wander @ 18 in    | < 0.080 in                      | _____    | □           |       |
| Bore ID @ foot         | 0.787 ± 0.003                   | _____    | □           |       |
| Bore ID @ mid          | 0.787 ± 0.005                   | _____    | □           |       |
| Bore ID @ top          | 0.787 ± 0.005                   | _____    | □           |       |
| Wall @ hole-4 station  | ≥ 0.150 in (any quadrant)       | _____    | □           |       |
| Ro fundamental         | 293.665 Hz ± 25 ¢ (pre-tune)    | _____    | □           |       |
| Ro fundamental         | 293.665 Hz ± 10 ¢ (post-tune)   | _____    | □           |       |
| Tsu (F4)               | 349.228 Hz ± 10 ¢                | _____    | □           |       |
| Re (G4)                | 391.995 Hz ± 10 ¢                | _____    | □           |       |
| Chi (A4)               | 440.000 Hz ± 10 ¢                | _____    | □           |       |
| Ri (C5)                | 523.251 Hz ± 10 ¢                | _____    | □           |       |
| Thumb (D5)             | 587.330 Hz ± 10 ¢                | _____    | □           |       |
| Octave Ro → Ro′         | 587.330 Hz ± 25 ¢                | _____    | □           |       |
| 30-day drift           | < 5 cents at 68 °F               | _____    | □           |       |

Environment row (mandatory): Temp ____°F · RH ____% · tuner ____ · player ____

---

## §H — Supplier RFQ summary

See `supplier-rfq.md` for the full RFQ. Headlines: 3 quarter-sawn cherry blanks, 20 mm reamer at 24 in OAL, deep-bore drill set, validation hardware, oil + wax finish supplies, hardware for fixtures.

---

## §I — Visual BOM brief

A single-sheet (A3 landscape) plate with hero photo + tooling thumbnails + cost summary. See `visual-bom-brief.md` for the layout spec.

---

## §J — Appendix

- Cross-references: instrument-maker#84 (deep-bore drilling), tonykoop/flutes (NAF K2 — do not port), tonykoop/fujara (long open-pipe sister), tonykoop/transverse-flute (open-pipe packet template).
- Cultural framing: Western adaptation in respect for Kinko-ryū / Tozan-ryū lineage; not a tradition-faithful reproduction.
- Empirical loop: `record_measurement.py` updates per-family `δ_utaguchi` correction; sibling packets read forward.
