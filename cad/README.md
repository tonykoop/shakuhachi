# `cad/` — CAD references for SHK-D4-P1

- `shakuhachi_master.scad` — parametric OpenSCAD master for the finished SHK-D4-P1 geometry. Renders the body with the bore subtracted, utaguchi notch subtracted, and five tone holes drilled at first-pass acoustic stations. Updates to the bore/length/correction parameters propagate through.

## Generate STL

```bash
openscad -o shakuhachi_d4_p1.stl shakuhachi_master.scad
```

## Notes

- The master is a **CAD reference**, not a CNC toolpath. The build path is bore-first via the headstock-driven deep-bore drilling technique (`instrument-maker#84`), followed by outside turn between centers — see `assembly-manual.md`.
- Tone-hole positions and diameters in the SCAD file are first-pass acoustic stations; the as-built instrument is bisque-style tuned and will deviate (holes 5–15 mm closer to the foot, diameters slightly enlarged via filing).
- A SolidWorks master layout (Part + Design Table) for SHK-D4-P1 is planned but not in this packet drop. When generated, it will live under `sw-reference/` with the same file naming convention as `fujara/sw-reference/`.
