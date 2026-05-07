# Risk Register — SHK-D4-P1

Red-team pass over the design. Each risk is paired with a verification test that produces a row in `validation.csv` (or another concrete artifact). Risks are categorized: **acoustic**, **structural**, **manufacturing**, **ergonomic**, **supply**, **fit-and-finish**, **cultural**.

## Acoustic risks

### A1 — Utaguchi end-correction assumption is wrong

- **What:** `design.md` § Governing Model assumes `δ_utaguchi ≈ 1.5–2.0 · r_bore` based on back-fitting from the traditional 1.8-shaku ↔ D4 anchor. If the real correction is outside this band (e.g. 0.85·r if utaguchi behaves more like a flanged open end, or > 2.5·r at unusual bore geometries), SHK-D4-P1 will sound either too sharp or too flat by 15–40 cents and the entire family-spec table needs re-fitting.
- **Why it matters:** every other family member's predicted `L_physical` rolls forward from this single assumption. Bad correction → eight bad blanks.
- **Test:** post-utaguchi Stage 3 measurement of Ro fundamental in `validation.csv`. If pre-tuning fundamental is outside ±25 cents, run `record_measurement.py` to update `δ_utaguchi`; do not cut sibling blanks until the corrected value predicts SHK-Eb4-001 to within ±15 cents.
- **Mitigation:** the workflow only commits to one prototype before the correction is measured. Sibling blanks are queued, not cut.

### A2 — NAF K2 corrections accidentally applied

- **What:** Tony's K2 NAF corrections are baked into the workflow muscle-memory and into `flutes/`'s K2 columns. A future agent (or Tony in haste) could reflexively apply K2 to a shakuhachi row.
- **Why it matters:** K2 was derived from fipple-block + SAC NAFs. Shakuhachi has neither. K2 would over-correct hole positions by 3–10 mm and produce unplayable cents errors.
- **Test:** `design.md` § Empirical-correction guard explicitly calls this out. Workbook K2 columns for shakuhachi rows are intentionally blank. If a future packet generation adds K2 columns to shakuhachi, the validator should flag the cells.
- **Mitigation:** documented warning in `design.md`; per-instrument sister-repo registry entry includes "no K2" note.

### A3 — Octave (Ro → Ro′) error > 25 cents

- **What:** if the bore axis isn't a true cylinder (taper, ovalization, or wander from deep-bore drilling), the second harmonic will land off-octave even when the fundamental tunes cleanly.
- **Why it matters:** octave errors are not tone-hole-tunable. They require re-shaping the utaguchi or accepting the prototype as a study artifact.
- **Test:** validation.csv `octave` row. Threshold ±25 cents = soft fail; > 50 cents = hard fail.
- **Mitigation:** post-bore `validation.csv` rows measure ovalization at three stations; reject blank if ovalization > 0.005 in.

## Structural risks

### S1 — Wall thickness too thin around hole 4 / thumb hole

- **What:** with a 1.10 in OD and 0.787 in bore, nominal wall is 0.157 in. A 0.394 in tone hole (Ø ≈ wall × 2.5) leaves wall on either side of the hole-edge of only ~0.157 − 0.394/2 in × cos(angle), and any local thinning during turning could push it below the structural margin.
- **Why it matters:** thin wall around a hole edge can crack during finger pressure or seasonal humidity swings.
- **Test:** post-turn `validation.csv` row "wall thickness at hole 4 station". Reject blank if any quadrant < 0.140 in.
- **Mitigation:** keep OD at 1.10 in (no decorative beads / coves on the prototype). Use cherry first (relatively crack-resistant); if a different species shows splitting, switch to hard maple.

### S2 — Foot end-face splits during parting

- **What:** parting a turned blank at 21.5 in cleanly is a hand skill. A poor parting cut leaves a stress-riser end-grain rough that can chip while installing pin-centers, especially if grain run-out is steep.
- **Why it matters:** the foot end is the acoustic open end; a chipped foot changes effective length unpredictably.
- **Test:** visual inspection + caliper check post-parting. Reject any blank with end-face chip > 0.020 in deep.
- **Mitigation:** hand-saw the last 0.060 in instead of parting; sand flat on a disc sander.

## Manufacturing risks

### M1 — Bore wander > spec on production cherry

- **What:** the headstock-driven deep-bore drilling step is tooling-light and operator-dependent. Production cherry could wander > 0.080 in at the 18 in mark even after a clean scrap-stock validation pass.
- **Why it matters:** wander beyond spec wastes a cherry blank and forces a switch to staged drilling from both ends, which doubles setup time.
- **Test:** scrap-stock validation rows (mandatory before each production blank). If wander on production cherry then exceeds spec, log and switch to dual-end drilling for the remaining blanks.
- **Mitigation:** mandatory pine-scrap validation pass before each cherry blank. Pecks ≤ 1 in deep. Retract often.
- **Open question:** is steady-rest support behind the tailstock vise worth the setup time? Decision deferred until the scrap-stock data exists.

### M2 — Reamer chatter scores the bore wall

- **What:** the 20 mm reamer is a 24 in OAL slender tool. If reciprocated (pecked) it can chatter and leave spiral scoring on the bore wall.
- **Why it matters:** scoring increases damping and shifts pitch slightly flat; it also makes the bore harder to clean (chips lodge in scores).
- **Test:** post-bore visual inspection with bore camera or fiber-optic scope. Reject if scoring depth visible to the naked eye.
- **Mitigation:** single-advance reamer pass at 600 rpm with cutting oil. No retraction during the cut.

### M3 — Tool runout exceeds 0.005 in on first pilot

- **What:** Jacobs chuck runout, MT2 taper fit, and Jacobs-to-bit eccentricity stack up. If total runout > 0.005 in, the pilot bore wanders even on a perfect setup.
- **Test:** indicate runout with a dial indicator on the chuck before each session. Re-seat the MT2 taper if reading is high.
- **Mitigation:** clean the MT2 taper with isopropyl + lint-free cloth before each session. Tap the chuck onto the taper with a dead-blow mallet.

## Ergonomic risks

### E1 — Hole 4 reach exceeds player's index span

- **What:** Hole 4 (Ri / C5) sits at 12.95 in from foot. With holes 1–3 at 19.40 / 17.29 / 15.40 from foot, the four front holes span 19.40 − 12.95 = 6.45 in. A player with smaller hand span may not be able to comfortably reach hole 4 with the index finger.
- **Why it matters:** ergonomic non-fit means the prototype doesn't get played, which means it doesn't get tuned, which means the empirical loop never closes.
- **Test:** dry-fit on Tony's hand before drilling holes; mark the hole-1 and hole-4 positions with painter's tape and check span.
- **Mitigation:** the 1.8-shaku D4 standard places holes within the typical span of an adult shakuhachi player; this is well-established. If Tony's span doesn't match, the design is correct and player technique adapts. Annotate as "standard D4 1.8-shaku — adapt fingering, not geometry."

### E2 — Thumb hole misaligns with finger reach

- **What:** thumb hole at 11.54 in from foot, on the back face. If the player's thumb naturally sits at a different position when supporting the body, the thumb hole is unreachable while the four front holes are addressed.
- **Test:** dry-fit before drilling. Tape-mark the thumb position.
- **Mitigation:** Kinko-ryū tradition places the thumb hole roughly between holes 4 and 5 — slight forward offset is acceptable. Document if Tony shifts thumb position from canonical 11.54 in.

## Supply risks

### SP1 — 20 mm reamer back-ordered

- **What:** the 24 in OAL 20 mm reamer (SHK-SRC-007) is a specialty tool with longer lead times than the rest of the order. If back-ordered, the entire deep-bore step blocks.
- **Mitigation:** verify lead time at order placement. Fallback: rent a reamer or substitute step-down endmill in collet chuck (reduces final-pass quality but works).

### SP2 — Cherry quarter-sawn 1×1×24 sold out

- **What:** specialty turning blanks ship in small batches. A "buy 3" order can ship 1 of 3 with the rest back-ordered.
- **Mitigation:** order from Bell Forest Products (primary) and a backup supplier simultaneously. Cherry is the primary preference but hard maple and walnut backups are spec-compatible.

## Fit-and-finish risks

### F1 — Walnut oil cure fails (still tacky after 5 days)

- **What:** walnut oil cures by oxidation; cold or humid conditions slow cure to weeks. A tacky bore traps dust and changes acoustic damping.
- **Test:** light finger-press on cured surface; should not leave a print.
- **Mitigation:** cure at > 65 °F and < 60 % RH. If still tacky after 7 days, reapply thinner coat and re-cure under lamp warmth.

### F2 — Carnauba wax inadvertently inside the bore

- **What:** carnauba paste applied carelessly migrates inside the bore.
- **Why it matters:** wax film changes acoustic damping by ~5–15 cents (typically flat) and is unevenly distributed.
- **Mitigation:** plug both ends with painter's tape during waxing. Wipe outside only with a tampon-style applicator.

## Cultural risks

### C1 — Overstating tradition lineage on Western prototype

- **What:** the README or capstone deck overclaims that this prototype "follows the Kinko-ryū tradition" or similar. It does not — it's a Western luthier-shop solid-billet adaptation.
- **Why it matters:** misrepresentation is disrespectful to traditional makers and inaccurate.
- **Mitigation:** README + design.md + capstone deck all use the framing "Western solid-billet adaptation modeling shakuhachi acoustics, with respect for the Japanese Buddhist tradition." Specifically avoid claims like "authentic," "traditional," or "in the style of [named master]."

### C2 — Buffalo-horn inlay with unverified provenance

- **What:** if the buffalo-horn block is sourced without species verification, it could be a CITES-listed African black-buffalo (Synceros caffer) horn rather than the unrestricted water buffalo (Bubalus bubalis).
- **Mitigation:** order only from suppliers who specify *Bubalus bubalis* on the product page. Defer the inlay if provenance is unclear; the prototype works without it.
