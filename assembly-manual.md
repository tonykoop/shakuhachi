# Shakuhachi Assembly Manual — SHK-D4-P1 (1.8-shaku D4 prototype)

This manual builds the first prototype documented in `design.md` and the rows of `bom.csv` / `cut-list.csv` / `validation.csv`. It assumes a North American luthier shop with a wood-lathe (MT2 or MT3 spindle), drill press, bandsaw, and standard hand tools — *not* a traditional Japanese bamboo workshop.

> **Cultural note:** traditional shakuhachi are built from madake bamboo with urushi-lined bores. This packet documents a Western-shop solid-billet hardwood adaptation. Where it diverges from tradition (solid billet, straight bore, oil finish, no urushi), it is documented as such. Apprenticeship under a *seibei* (traditional maker) is the right path if the goal is a tradition-faithful instrument; this packet is a parametric study tool.

## Bill of materials reference

See `bom.csv` (16 line items). Confirm SHK-BOM-001 through 008 + 010 + 013 are on hand before starting Step 1. SHK-BOM-002 (buffalo-horn inlay) and SHK-BOM-016 (mortising chisels) are optional for the first prototype.

## Step 0 — Read first

1. Read `design.md` § Governing Model and § Empirical-correction guard. The shakuhachi-specific utaguchi end correction is the source of most prediction error; understand what it is before measuring.
2. Read `risks.md` end-to-end. Each risk has a verification test attached.
3. Read [`tonykoop/instrument-maker#84`](https://github.com/tonykoop/instrument-maker/issues/84) and the technique reference at `references/techniques/headstock-driven-deep-bore-drilling.md`. The deep-bore step is the single highest-risk operation.

## Step 1 — Mill blanks

1. Select three quarter-sawn cherry blanks at least `1.00 x 1.00 x 24.50 in`, or mill them from longer 6/4 stock. One blank is for SHK-D4-P1; two are for bore / utaguchi practice and recovery. Inspect for runout, knots, and internal checks.
2. Mill each blank to `1.000 x 1.000 x 24.000 in` (±0.005 in). Quarter-sawing matters for deep-bore drilling: tangential expansion is anisotropic, and quarter-sawn blanks wander less under heat from drill chips.
3. Mark each blank with face / edge / end orientation in pencil.

## Step 2 — Center-mark and cross-mark

1. Find the center of each end face with a center-finder. Punch with an awl.
2. Use a marking gauge to draw the bore-axis line on two adjacent faces of the blank, end to end. This line is the visual reference for jig alignment.
3. Choose the face that will become the **front** (utaguchi side) and mark "F" on a non-machined surface. The utaguchi notch and four front holes go on this face; the thumb hole goes on the opposite face.

## Step 3 — Build the tailstock vise (one-time)

If `SHK-fixture-vise` has already been built, skip to Step 4. Otherwise:

1. Cut steel angle (SHK-SRC-013) to two 6 in pieces; weld into a U-channel that bolts to a Morse-tapered shank that fits the lathe tailstock.
2. Drill / tap two 3/8-16 holes for the side clamp screws. The square blank rests in the V of the channel; the screws push it against the V from above.
3. Indicate the V-channel against the spindle axis using a test indicator. Adjust the Morse-taper shank until centerline runout is < 0.005 in.

> Reference: `references/techniques/headstock-driven-deep-bore-drilling.md` § Fixture Requirements.

## Step 4 — Scrap-stock validation pass (mandatory)

1. Mount the 3/8 in pilot bit (SHK-BOM-003) in the headstock Jacobs chuck. Indicate runout < 0.003 in.
2. Clamp a straight pine or poplar scrap blank at least 24 in long in the tailstock vise. Tighten side clamps; the blank must not rotate under finger pressure.
3. Bring the blank up to the bit; verify the punch mark on the end face tracks the spindle axis.
4. Pilot-bore 6 in into the scrap with the lathe at ~1500 rpm. Peck depth ≤ 1 in; retract every peck to clear chips.
5. Withdraw blank; measure bore axis offset at 6 in. Target: ≤ 0.020 in offset. If exceeded, re-indicate the fixture and repeat.
6. Continue scrap pilot-bore to 12 in, 18 in. Record offsets in `validation.csv` rows `scrap-validation`. If offsets fall outside spec, **stop** and reset; do not proceed to production cherry.

## Step 5 — Production deep-bore (the long one)

> This step is the highest-risk operation in the build. Expect 90 minutes for a full bore + measurements; do not rush.

1. Clamp a cherry blank (SHK-BOM-001) in the tailstock vise. Re-verify centering.
2. Lathe at ~1200 rpm with the 3/8 in pilot. Peck 1 in deep, retract, advance, repeat until pilot bore is 23 in (full length minus 1 in clearance at the foot end).
3. Step up: 1/2 in bit → 5/8 in → 3/4 in (SHK-BOM-004). Each step pecks the full 23 in. Slow the lathe to ~800 rpm for the larger bits; long bits whip at higher rpm.
4. Final reamer pass with the 0.787 in / 20 mm reamer (SHK-BOM-005) at ~600 rpm with cutting oil. Single advance, no peck — reamers cut on the side and chatter if reciprocated.
5. Withdraw, blow chips out of the bore, and measure ID at foot, mid (10.75 in), and top stations using the bore gauge. Record `validation.csv` `post-bore` rows.
6. **Halt criterion:** ovalization > 0.005 in or any station outside 0.787 ±0.005 in → reject blank; pull the next prepared cherry blank.

## Step 6 — Turn outside

1. Cut two pieces of dowel (or two pin-centers) sized to slip-fit the bore. Insert one into each end of the bored blank.
2. Mount the blank between centers, *registering off the bore* — this is why the bore is drilled first. The bore axis becomes the lathe rotation axis and any wander stays inside the wall, not visible on the outside.
3. Rough-turn to ~1.20 in OD with a roughing gouge.
4. Finish-turn to 1.10 in OD with a spindle gouge + skew chisel. Keep the profile straight (no decorative beads on the prototype). Final OD ±0.010 in.
5. Sand 220 → 320 → 400 grit. Wipe with mineral spirits to check for tearout.
6. Part off at 21.5 in finished length, leaving ~0.5 in waste. Square the foot end on the lathe with a parting tool + sandpaper face.

## Step 7 — Tone-hole layout and undersized drilling

1. Print the hole-position template (`drawings/SHK-D4-P1-hole-layout.svg`) at 100% scale on A3 (or two A4 sheets joined). Verify printed length = 21.5 in.
2. Wrap the template around the cylindrical body, aligning the foot mark with the foot end of the body. Tape in place.
3. Punch each tone-hole center through the template with a sharp awl. Remove template.
4. Build / dust off the tone-hole jig (`SHK-fixture-hole-jig`): a V-cradle with an index pin that registers off the back of the body (180° from front holes), and an indexed sliding stop that moves the body along the V to each hole position.
5. Mount jig on drill press. Mount 7 mm brad-point in chuck. Indicate so bit is centered on the V-cradle radius.
6. Drill each hole one at a time, advancing the body along the index. Drill **undersized** to 0.276 in (7 mm). Do not enlarge with the drill — leave room for filing during tuning.
7. Rotate jig 180° (or rotate body 180° in jig) and drill the thumb hole at 11.54 in from foot, on the back face.

## Step 8 — Cut the utaguchi

1. Mark the utaguchi notch on the top end of the body: width 0.787 in (= bore ID), depth 0.315 in.
2. Bandsaw the rough notch — straight cuts only, leaving 0.030 in of finishing stock all around the layout line.
3. Clamp body horizontally in a padded vise. Use a 1/2 in bench chisel to pare the inner bevel to a 32° angle. Reference the angle against a printed-and-glued utaguchi gauge (`SHK-BOM-009`).
4. File the inner bevel flat with a fine mill-bastard file. The outer-edge profile gets a 0.020-0.030 in round-over with a fine file.
5. **Do not over-shape on the first cut.** The next step measures fundamental pitch, and you can always deepen / re-angle the notch — you cannot un-cut wood.

## Step 9 — Bisque-style tuning (post-utaguchi)

1. Block all five tone holes with painter's tape (cleanly, edges flush with bore).
2. Blow Ro (fundamental). Use the chromatic tuner; record cents error vs `f₀ = 293.665 Hz` in `validation.csv`.
3. Sounding sharp (> +25 cents): deepen the utaguchi notch in 0.020 in increments. Each 0.010 in of depth ≈ 5–8 cents flatter.
4. Sounding flat (< −25 cents): shorten the foot end on the lathe by 0.05 in increments. Each 0.10 in of length ≈ 13 cents sharper.
5. Re-measure. Iterate until ±25 cents pre-tuning band is hit. Record final fundamental in `validation.csv`.

## Step 10 — Per-hole tuning

1. Open hole 1 (Tsu / F4). Close all others with tape. Blow; record cents error.
2. If hole 1 sounds flat (< −15 cents), file the hole open in 0.5 mm increments using the round diamond file (SHK-BOM-008). Each 0.5 mm step ≈ 6–10 cents sharper. Record after each step.
3. Stop when within ±10 cents.
4. Repeat for holes 2, 3, 4, and the thumb hole — *one at a time*, with all others taped closed.
5. After all holes tune, record the full fingering progression Ro → Tsu → Re → Chi → Ri → Ro′ as a single connected pass. Cross-hole interactions can shift earlier-tuned holes; if the progression sits inside ±15 cents end to end, accept; otherwise re-file the worst offender 0.2 mm and re-measure.

## Step 11 — Octave check

1. Block all holes. Overblow Ro at the player's stronger jet — Ro′ should sound at ~587.33 Hz.
2. Record octave error in `validation.csv` row `octave`.
3. **Octave error > 25 cents** = bore-axis or utaguchi geometry problem; do **not** try to tone-hole-tune around it. Re-shape the utaguchi or accept the prototype as a study artifact for SHK-D4-P2.

## Step 12 — Finish

1. Flood the bore with walnut oil (SHK-BOM-013). Stand vertically, foot up, on a paper towel; let oil drain through. Wipe outside with same oil and a lint-free cloth.
2. Cure 3–5 days, depending on RH. Walnut oil cures by oxidation; warm dry air helps, plastic-bag storage hurts.
3. After cure: buff outside only with carnauba wax (SHK-BOM-014). Do **not** wax the bore — wax film changes acoustic damping.
4. Re-tune (Step 9–10) — finish often shifts pitch 3–8 cents flatter.

## Step 13 — Document

1. Photograph per `photo-shotlist.md`.
2. Record final measurements (one row per fingering) in `validation.csv` and run:

   ```bash
   python3 <instrument-maker-v4-install>/scripts/record_measurement.py \
     --packet . \
     --note-id Ro \
     --measured-hz <measured> \
     --tuner "Korg OT-120" \
     --environment "shop, <T>F, <RH>% RH"
   ```

3. Replace `<instrument-maker-v4-install>` with the local install path for the v4 skill/scripts bundle. The record-measurement script updates the per-family corrections database. Future packets in the shakuhachi family (SHK-Eb4-001 et al.) will read the updated `δ_utaguchi` correction automatically.
