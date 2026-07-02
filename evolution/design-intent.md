# Design Intent — shakuhachi rev A

- Master CAD: `cad/shakuhachi_master.scad` (sha256: 5e1eab587df07bde368e7b54522ce0b5beb3cecc83d5baec8c92fb0c24edd8a5), driven by `shakuhachi-design-table.xlsx` (sha256: e20c7322fb02a1b126804d6d7b2a8281e23369728cbd3b6d9807a8e49a280e54)
- Function: Solid-billet hardwood shakuhachi (Japanese end-blown bamboo flute adaptation), 11-key parametric family (C4-B4), first prototype SHK-D4-P1 (1.8-shaku D4, cherry). Open-open pipe acoustics: foot end open, utaguchi (blowing edge) end open with player-jet excitation; `f = c/(2*L_eff)`, `L_eff = L_physical + delta_foot + delta_utaguchi`. Bore drilled via headstock-driven deep-bore drilling on square stock before outside turning.
- Environment: hand-played wind instrument; walnut-oil/carnauba finish (no urushi lining for the prototype). No physical build exists yet.
- Target qty: 1 prototype (SHK-D4-P1). Deadline: TBD. Budget/unit ceiling: TBD (bom.csv line items ~$28-68 per tooling/material item).

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Physical length (SHK-D4-P1) | 21.53 in | measured Ro fundamental within ±25 cents | fundamental pitch (D4, 293.665 Hz) | design.md Family Targets table (SHK-D4-001) |
| Bore ID | 0.787 in | reamed/lapped finish ID | end-correction magnitude, tone | design.md Family Targets table |
| Wall thickness at bore | 0.236 in | structural min around hole 4/thumb hole (risks.md S1) | avoid blowout during hole drilling | design.md Family Targets table |
| Utaguchi end correction (delta_utaguchi) | ~1.4-2.1 x r_bore (empirical) | pending SHK-D4-P1 measurement, ±25 cents gate | dominant term in L_eff; NOT the NAF K2 correction (risks.md A1/A2) | design.md Governing Model + Empirical-correction guard |
| Tone-hole stations (5: Tsu/Re/Chi/Ri/thumb) | see design.md hole table | filed open during tuning, not enlarged with drill | intonation of Kinko-ryu intervals | design.md "Tone holes for SHK-D4-P1" |
| Foot end correction (delta_foot) | 0.6 x r_bore | standard Levine/Schwinger open-end value | secondary L_eff term | design.md Governing Model |

## Incidental (free for DFM)

- Exterior turned profile/taper styling, optional buffalo-horn or hardwood inlay cosmetic choice (risks.md C2 provenance caveat), non-mating surface finish sheen.

## Must-nots (DFM may never violate)

- Do not apply NAF K2 bore-diameter corrections to shakuhachi rows — a shakuhachi has no SAC/fipple, so K2 does not transfer (risks.md A2, design.md Empirical-correction guard).
- Do not cut sibling family blanks (Eb4 etc.) until the corrected delta_utaguchi from SHK-D4-P1 measurement predicts the next member within ±15 cents (risks.md A1).
- Do not enlarge tone holes with a drill after the initial undersized bore — holes are filed open only, per the tuning workflow (design.md Tone holes section).
- Do not thin the wall below spec around hole 4/thumb hole (risks.md S1 structural risk).
- Utaguchi (blowing-edge) bevel geometry stays hand-refined/tuning-sensitive — out of scope for the OpenSCAD envelope model (V5 woodwind addendum).

## Material intent

- Body: quarter-sawn, kiln-dried cherry (primary), hard maple / black walnut backups (bom.csv SHK-BOM-001).
- Optional inlay: buffalo horn or lignum vitae alternative (bom.csv SHK-BOM-002; provenance caveat risks.md C2).
- Finish: walnut oil + carnauba wax (food-safe inside; no urushi lining for the prototype).
- Forbidden: none recorded beyond the cultural-attribution caveat (risks.md C1 — do not overstate traditional-lineage claims on this Western solid-billet prototype).

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. No physical prototype exists yet (SHK-D4-P1 not yet built).
