# `cnc/` — CNC toolpaths for SHK-D4-P1

This packet's primary build pipeline is **lathe + drill press**, not CNC router. The CNC pipeline is documented for completeness and for siblings that may benefit from CNC pocketing of fixture parts.

## Out-of-scope for SHK-D4-P1

- **Body bore.** The 21.5-in deep bore is drilled with the headstock-driven deep-bore drilling technique on the lathe (see `instrument-maker#84` and `assembly-manual.md` § Step 5). CNC routers cannot match the depth-to-diameter ratio without specialty tooling that doesn't make sense for a one-off prototype.
- **Body outside turn.** Between centers on the wood lathe; CNC turning a 21.5-in cylinder would be a wasted setup.
- **Tone holes.** Drill press with the V-cradle jig (SHK-BOM-007). CNC drilling on a curved cylindrical surface requires a 4-axis fixture that isn't available in Tony's shop.

## In-scope (optional, future)

- **Tailstock vise (SHK-fixture-vise) plate cutouts.** If the steel-angle vise (SHK-CUT-010) is fabricated using a CNC plasma cutter, drop the DXF in `cnc/SHK-fixture-vise.dxf`. Not required — bandsaw + drill press works.
- **Tone-hole jig V-cradle (SHK-fixture-hole-jig).** If made from MDF or plywood with a CNC router, the V-radius matching Ø 1.10 OD is easier to cut accurately than by bandsaw. DXF / 1/4-in endmill toolpath would live at `cnc/SHK-fixture-hole-jig.gcode`. Not required.

## Why this doc exists

Reviewer expectation under instrument-maker-v4 is that every packet has a `cnc/` folder with at least a README explaining the manufacturing pipeline. This file documents an explicit "no CNC for body" decision so a future agent doesn't accidentally generate CNC programs for an instrument that doesn't need them.
