# Shakuhachi — Design Document

## Source And Scope

- Date: 2026-05-07
- Repo: `tonykoop/shakuhachi`
- Source workbook (this repo): [`shakuhachi-design-table.xlsx`](shakuhachi-design-table.xlsx) — sheet `Shakuhachi`, 11-key parametric family from C4 (#40) through B4 (#50) plus higher.
- Sister design table referenced for cross-validation: `Musical Instruments V2.xlsx` → sheet `Shakuhachi`.
- Sister repos: [`flutes`](https://github.com/tonykoop/flutes) (NAF; K2 reference — see "Empirical-correction guard" below), [`fujara`](https://github.com/tonykoop/fujara) (closest open-pipe wood neighbor), [`transverse-flute`](https://github.com/tonykoop/transverse-flute) (slip-cast open-pipe — packet template).

This document is the parametric design narrative behind the rest of this build packet (`bom.csv`, `cut-list.csv`, `validation.csv`, `assembly-manual.md`, `risks.md`, drawings, site, etc.). The companion .xlsx is the editable parametric surface; `design.md` is the explanation.

## Design Intent

Build a small, manufacturable family of solid-billet shakuhachi (1.8 shaku D4 first; sized siblings later) on Tony's lathe + CNC pipeline, with the bore drilled using the **headstock-driven deep-bore drilling** technique on square stock before the outside is turned round. Document the acoustic model honestly — open-pipe physics with explicit, separately-tracked end corrections — so the first prototype's measured pitch can drive a corrections database update rather than a hand-tuned one-off. Cultural framing stays respectful and factual: this is a Western luthier-shop solid-billet build; traditional split-bamboo shakuhachi (madake, urushi-lined) is a separate craft with its own lineage.

The first prototype is **SHK-D4-P1**: 1.8-shaku solid-billet hardwood D4, no urushi lining, intentionally undersized hole bores so a bisque-style tuning step can bring it inside ±10 cents.

## Governing Model

Open-open pipe with two open ends — the lower (foot) is a free open end; the upper (utaguchi) is a beveled/notched open end with player-jet excitation. First-pass:

```text
f = c / (2 · L_eff)
L_eff = L_physical + δ_foot + δ_utaguchi
δ_foot ≈ 0.6 · r_bore                    # standard open-end correction (Levine/Schwinger)
δ_utaguchi ≈ 1.5 · r_bore to 2.0 · r_bore  # empirical shakuhachi extension; see below
hole_distance_from_foot ≈ L_eff_acoustic · (f_fund / f_hole)
```

`c = 13552 in/s` at 68 °F (1 atm dry air). `f = 440 · 2^((MIDI − 69)/12)`. `cents = 1200 · log₂(measured / target)`.

The standard NAF/Irish-flute 0.6·r end correction at the foot is well-validated. The **utaguchi** end is harder: the beveled notch + player's lip + jet airspace shift the acoustic open-point upward of the physical rim, so the *effective* extension is larger than 0.6·r. This is why a standard 1.8-shaku (21.5 in / 54.5 cm) physical length sounds D4 (293.66 Hz) — back-solving from `f = c/(2·L_eff)` gives `L_eff ≈ 23.1 in`, leaving `1.6 in` to be split between two end corrections, dominated by the utaguchi end. Per-end ≈ 1.5·r–2.0·r is the empirical band Western and Japanese makers report; it is **not** the same correction as a flanged open pipe (~0.85·r) and it is **not** the NAF K2 correction. Document it as a shakuhachi-specific empirical extension and refine after measurement.

## Empirical-correction guard

Tony's NAF K2 bore-diameter corrections (`+0.4%` at 0.875 in, `+1.0–1.6%` ≥1.125 in, `−0.7 to −6.0%` ≤0.75 in — see `flutes` and `references/acoustic-models.md` in instrument-maker-v4) were derived from 150+ Native American flutes with fipple block, slow-air chamber (SAC), and a fipple-driven embouchure. **A shakuhachi has none of those features** — no SAC, no fipple, no SAC→bore window — so K2 does not transfer. This packet uses the standard 0.6·r foot correction plus the explicit shakuhachi-specific utaguchi extension above. K2 columns in the workbook are intentionally left blank for shakuhachi rows.

## Hardware Alignment

- Pipeline: **CNC + lathe + hand-finished utaguchi**, not split-bamboo. Tony's shop is set up for solid-billet drilling and turning, and madake import is impractical for a study series.
- Bore-making strategy: **headstock-driven deep-bore drilling on square stock** ([`tonykoop/instrument-maker#84`](https://github.com/tonykoop/instrument-maker/issues/84)). The bit spins in the lathe headstock (Morse taper → Jacobs chuck); the square blank is gripped in a tailstock-mounted vise with a positive anti-rotation feature (V-block + side clamps); the tailstock quill advances the blank into the bit in short pecks. The bore is established before the outside is turned round, so the round-turning operation later registers off the established bore axis.
- Outside turn: between centers off the bore, after the bore is reamed/lapped to finish ID.
- Utaguchi: hand-cut bevel — chisel + fine file. Optional buffalo-horn or hardwood inlay (water buffalo horn = traditional; lignum vitae or African blackwood = Western substitute).
- Tone-hole boring: drill press with index-fixed jig referenced off the bore axis. Holes start undersized (~7 mm / 0.276 in) and are filed open during tuning.
- Finish: walnut oil + carnauba (food-safe inside; no urushi for the prototype). Note: traditional madake shakuhachi use *urushi* (Japanese lacquer) inside the bore — that workflow is out of scope for this packet but documented for future builds.

## Family Targets — first parametric pass

Eleven-key family from the workbook, computed at 68 °F. Hole frequencies use Kinko-ryū intervals (Ro / Tsu / Re / Chi / Ri / thumb-Ro′) at +0, +3, +5, +7, +10, +12 semitones.

| Member ID  | Key | Shaku   | Fund (Hz) | L_acoustic (in) | δ_total (in) | L_physical (in) | Bore ID (in) | Bore-OD wall (in) | Status |
| ---------- | --- | ------- | ---------:| ---------------:| ------------:| ---------------:| -----------:| -----------------:| ------ |
| SHK-C4-001 | C4  | 1.91    | 261.626   |          25.91  |        1.65  |          24.26  |       0.787 |             0.236 | Family — defer |
| SHK-D4-001 | D4  | 1.80    | 293.665   |          23.08  |        1.55  |          21.53  |       0.787 |             0.236 | **First prototype (SHK-D4-P1)** |
| SHK-Eb4-001| Eb4 | 1.70    | 311.127   |          21.78  |        1.50  |          20.28  |       0.787 |             0.236 | Family — queued |
| SHK-E4-001 | E4  | 1.60    | 329.628   |          20.55  |        1.45  |          19.10  |       0.787 |             0.236 | Family — queued |
| SHK-F4-001 | F4  | 1.50    | 349.228   |          19.40  |        1.30  |          18.10  |       0.669 |             0.197 | Family — queued |
| SHK-G4-001 | G4  | 1.30    | 391.995   |          17.28  |        1.20  |          16.08  |       0.669 |             0.197 | Family — queued |
| SHK-A4-001 | A4  | 1.10    | 440.000   |          15.40  |        1.10  |          14.30  |       0.591 |             0.197 | Family — queued |
| SHK-B4-001 | B4  | 1.05    | 493.883   |          13.72  |        1.00  |          12.72  |       0.591 |             0.197 | Family — queued |

Notes:
- `δ_total = δ_foot + δ_utaguchi`, with `δ_foot = 0.6·r_bore` and `δ_utaguchi` chosen empirically so `L_physical` matches the historical shaku-length tradition (D4 1.8 shaku → 21.5 in, F4 1.5 shaku → 18.0 in, etc.). The fitted `δ_utaguchi` is approximately `1.4·r_bore – 2.1·r_bore` across the family — wider than the foot correction.
- Workbook columns (`Bore ID`, `Wall Thickness`) preserve the source values: 0.787 in / 0.236 in for C4–E4, 0.669 / 0.197 for F4–G4, 0.591 / 0.197 for A4–B4.
- "Shaku" column is approximate; the historical naming (1.8, 1.6, 2.4) maps to physical length, not exactly to key. The actual first-pass `L_physical` is what feeds the cut list.

### Tone holes for SHK-D4-P1 (D4 standard 1.8-shaku)

Acoustic stations from the foot, computed as `d = L_acoustic · f₀ / f_hole`. Physical reality will be 5–15 mm shorter (i.e. holes nearer the foot) once finite-hole-diameter corrections are applied during tuning. Hole diameters start undersize and open during validation.

| Hole          | Note (Kinko-ryū) | Δsemitones | f_hole (Hz) | Predicted d_foot (in) | Initial bore Ø (in) | Ergonomic notes |
| ------------- | ---------------- | ----------:|-----------:| ---------------------:|--------------------:| --------------- |
| Hole 1 (Tsu)  | F4               |         +3 |    349.228 |                 19.40 |              0.276  | Front, lowest finger (right pinky) |
| Hole 2 (Re)   | G4               |         +5 |    391.995 |                 17.29 |              0.276  | Front (right ring)                  |
| Hole 3 (Chi)  | A4               |         +7 |    440.000 |                 15.40 |              0.276  | Front (left middle)                 |
| Hole 4 (Ri)   | C5               |        +10 |    523.251 |                 12.95 |              0.276  | Front, highest (left index)         |
| Thumb (Ro′)   | D5               |        +12 |    587.330 |                 11.54 |              0.276  | Back, opposite/just below Hole 4    |

Tuning workflow assumes holes are **filed slightly open** (not enlarged with the drill) so each cents-flat measurement converts directly to a known file-pass action. See `assembly-manual.md` step 7 and `validation.csv` rows for SHK-D4-P1.

### Utaguchi geometry (first-pass)

| Parameter           | Value      | Source / rationale |
| ------------------- | ---------- | ------------------ |
| Notch width         | 0.787 in   | = bore ID (full bore opening) |
| Notch depth         | 0.315 in   | ~0.40 · bore ID — typical Kinko-ryū depth |
| Inner bevel angle   | 32°        | Workbook standard; Kinko-ryū makers report 28–35° |
| Outer-edge profile  | Round-over | 0.020–0.030 in radius — softens chip on overblowing |
| Inlay (optional)    | 0.060 in   | Buffalo horn / lignum vitae block, 0.5 in × 0.787 in × 0.060 in, mortised flush |

The utaguchi profile dominates first-prototype voicing far more than millimeter-scale bore tuning — plan time for hand-shaping iterations.

## Manufacturing Strategy (summary)

Detail in `assembly-manual.md`. Headlines:

1. Mill 1×1×24 in square hardwood blanks on the table saw + planer. Quarter-sawn cherry / hard maple / black walnut for SHK-D4-P1.
2. Center-mark both ends; cross-mark the bore axis with awl + center-finder.
3. Headstock-driven deep-bore drilling per [`instrument-maker#84`](https://github.com/tonykoop/instrument-maker/issues/84):
   - Pilot bit (3/8 in / 9.5 mm) brad-point, lathe MT2 → Jacobs chuck, square blank in tailstock vise.
   - Step up: 1/2 in (12.7 mm) → 5/8 in (15.9 mm) → 3/4 in (19.05 mm) → final 0.787 in (20 mm) reamer or step-down endmill in collet chuck.
   - Pecks ≤ 1.5 in deep; retract to clear chips.
4. Mount blank between centers using the bore as the registration axis (pin centers in the bore). Turn the outside round to 1.10 in OD — modest profile, no decorative beads on prototype.
5. Cut blank to 21.5 in finish length; square the foot end.
6. Lay out tone holes from foot using a paper wrap template; drill undersized (7 mm) on the drill press with the bore axis indexed.
7. Cut utaguchi: bandsaw rough notch → chisel inner bevel to 32° → flat-file → buffer the round-over.
8. Bisque-style tuning: stop all holes, blow Ro, measure cents — file utaguchi or bore foot to bring fundamental within range; then file each hole open in 0.5 mm steps to bring its sounded note within ±10 cents.
9. Oil finish — walnut oil flooded inside the bore and outside; let cure; carnauba wax buff outside only.

## Validation Plan

- **Stage 1 (post-bore):** measure ID at foot, mid, and top with a bore gauge; record three diameters per station to catch ovalization.
- **Stage 2 (post-turn):** measure OD at five stations; verify wall ≥ 0.150 in everywhere (avoid splitting under hole drilling).
- **Stage 3 (post-utaguchi):** blow Ro fundamental, measure with tuner against `f₀ = 293.665 Hz`. Target ±25 cents pre-tuning, ±10 cents post-tuning.
- **Stage 4 (per hole):** open one hole at a time (others closed), record cents error vs target. File open in 0.5 mm increments; remeasure.
- **Stage 5 (octave):** overblow Ro to Ro′; record cents error vs `587.330 Hz`. Octave error >25 cents indicates bore taper or utaguchi geometry; reshape rather than tone-hole-tune.

Each measurement gets a row in `validation.csv` — environment columns (temp, RH, tuner make/model) are mandatory because shakuhachi pitch shifts ~3 cents/°C.

## Open Assumptions

1. **Utaguchi correction `~1.5–2.0·r_bore` per end** is empirical and shakuhachi-specific. SHK-D4-P1 will produce a single data point; the correction will be re-fit on `record_measurement.py` ingest.
2. **Bore is straight cylindrical** (not tapered). Traditional madake shakuhachi has internal taper from the natural bamboo + urushi build-up. Solid-billet straight bore is acoustically simpler but tonally less complex; documented as a planned divergence.
3. **Hole diameters are uniform 0.276 in (7 mm) starting size**. Real shakuhachi often have slightly larger holes (8–10 mm) to flatten higher overtones. Starting smaller leaves room to file open during tuning.
4. **Wood species sensitivity not yet measured.** SHK-D4-P1 is cherry. Differences in modulus / density between cherry / hard maple / black walnut will affect the structural margin around hole walls but should not significantly affect pitch in a sealed-bore build.
5. **No urushi lining.** Western prototype is oil-sealed; pitch stability under humidity changes will be measured over 30 days but no urushi-equivalent damping correction is applied.
6. **Player calibration absorbed into utaguchi correction.** Tony is the test player; embouchure variation between players will shift measured pitch by 5–20 cents. Validation rows note "player = TK" so cross-player corrections can be added later.

## Highest-risk Unknowns

| Risk                                                 | Trigger                                          | Test                                                            |
| ---------------------------------------------------- | ------------------------------------------------ | --------------------------------------------------------------- |
| Bore wander on 21.5-in deep bore                     | Pilot bit deflection on long blank               | Scrap-stock validation row; bore-axis runout check at 6/12/18″ |
| Utaguchi geometry mistuned beyond filing recovery    | Bevel angle wrong, notch too deep                | Cut shallow; measure fundamental; deepen incrementally          |
| Wall thickness too thin around hole 4 / thumb        | Wall ≈ 0.150″, hole Ø 0.394″ → 38% wall loss    | Wall-thickness map post-turn; abort if any station < 0.140″   |
| Octave (Ro→Ro′) > 25 cents off                       | Bore-axis ≠ acoustic axis, or taper drift       | Stage-5 measurement; root cause = bore, not hole                |
| Foot end-correction assumption fails on shorter keys | δ_foot scales with r but utaguchi scales weakly | F4 / A4 prototypes will reveal whether δ_utaguchi is constant   |

## Empirical Loop

After SHK-D4-P1 is measured, run:

```bash
python3 ~/.claude/skills/instrument-maker-v4/scripts/record_measurement.py \
  --packet . \
  --note-id Ro \
  --measured-hz 293.6 \
  --tuner "Korg OT-120" \
  --environment "shop, 68F, 45% RH"
```

This updates `validation.csv`, computes cents error vs `f₀ = 293.665`, and refines the per-family `δ_utaguchi` correction so SHK-Eb4-001 / SHK-F4-001 / etc. predictions tighten before they're cut.

## Cultural Framing

The shakuhachi (尺八) originates from Tang-Chinese xiao ancestors imported to Japan in the 7th–8th c., and was central to the practice of *suizen* ("blowing meditation") within the Fuke sect of Zen Buddhism (Edo period komusō, "emptiness monks"). The Meiji government banned the Fuke sect in 1871; the instrument survived in concert and ensemble use (sankyoku trio with koto + shamisen), and modern Kinko-ryū and Tozan-ryū schools continue traditional practice. Traditional makers in Kyoto, Tokyo, and Hamamatsu still use madake bamboo with urushi-lined bores; the instruments built from this packet are non-Slovak…—correction—non-Japanese Western luthier prototypes that respectfully model the acoustics and finger-hole logic without claiming to replicate the traditional craft. Where this packet diverges from tradition (solid billet, hardwood, straight bore, oil finish) it is documented as such.

## Cross-references

- [`tonykoop/instrument-maker#84`](https://github.com/tonykoop/instrument-maker/issues/84) — headstock-driven deep-bore drilling (technique reference).
- [`tonykoop/flutes`](https://github.com/tonykoop/flutes) — NAF family + K2 derivation (do **not** apply K2 to shakuhachi; see "Empirical-correction guard").
- [`tonykoop/fujara`](https://github.com/tonykoop/fujara) — long open-pipe stave-built sister; closest geometric neighbor.
- [`tonykoop/transverse-flute`](https://github.com/tonykoop/transverse-flute) — slip-cast open-pipe sister; packet template baseline.
- `instrument-maker-v4/references/acoustic-models.md` § "Open-Open Pipes", § "Empirical-correction guard rules".
- `instrument-maker-v4/references/techniques/headstock-driven-deep-bore-drilling.md`.
