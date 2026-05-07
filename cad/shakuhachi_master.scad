// shakuhachi_master.scad
// Parametric OpenSCAD master for SHK-D4-P1 (1.8-shaku D4 solid-billet)
// Sister: tonykoop/shakuhachi
// Skill:  instrument-maker-v4
// Date:   2026-05-07
//
// Render notes:
//   - $fn = 96 for production renders; reduce to 24 for live preview.
//   - Outputs an STL representation of the *finished* instrument geometry.
//     The bore is subtracted; the utaguchi notch is subtracted; tone holes
//     are subtracted at their predicted first-pass positions.
//   - This is a CAD reference, NOT a CNC toolpath. The actual build is
//     bore-first via the headstock-driven deep-bore drilling technique
//     (instrument-maker#84) followed by an outside turn.
//   - Tone-hole positions come from the open-pipe model in design.md.
//     Final hole sizes/positions are determined empirically via
//     bisque-style filing.

// ===== Parameters =====

// Acoustic
fund_freq        = 293.665;     // D4 fundamental, Hz
c_air            = 13552;       // Speed of sound at 68 F, in/s
bore_id          = 0.787;       // Final bore diameter, in (= 20 mm)
delta_foot       = 0.6 * (bore_id / 2);
delta_utaguchi   = 1.7 * (bore_id / 2);   // empirical; refine after measurement

// Geometry
od               = 1.10;
length_phys      = c_air / (2 * fund_freq) - delta_foot - delta_utaguchi;  // ~21.50

// Utaguchi
utag_width       = bore_id;
utag_depth       = 0.315;
utag_angle_deg   = 32;

// Tone holes — first-pass acoustic stations from foot
hole_diam        = 0.276;     // 7 mm starting size, file open during tuning
function hole_d_from_foot(semis) =
    (c_air / (2 * fund_freq)) * (fund_freq / (fund_freq * pow(2, semis/12)));
hole1_d_foot     = hole_d_from_foot(3);   // Tsu / F4   ~19.40
hole2_d_foot     = hole_d_from_foot(5);   // Re  / G4   ~17.29
hole3_d_foot     = hole_d_from_foot(7);   // Chi / A4   ~15.40
hole4_d_foot     = hole_d_from_foot(10);  // Ri  / C5   ~12.95
thumb_d_foot     = hole_d_from_foot(12);  // Ro' / D5   ~11.54

$fn = 64;

// ===== Modules =====

module body_blank() {
    // Origin: centered on bore axis, foot at z=0, utaguchi at z=length_phys.
    cylinder(h = length_phys, d = od, $fn = 96);
}

module bore() {
    translate([0, 0, -0.05])
        cylinder(h = length_phys + 0.10, d = bore_id, $fn = 96);
}

module utaguchi_notch() {
    // Notch is cut into the +Y face at the top end (utaguchi side).
    // It removes a wedge whose inner-bevel angle is utag_angle_deg
    // measured from the bore axis.
    top_z = length_phys;
    notch_h = utag_depth;
    inner_bevel = utag_angle_deg;

    translate([0, od/2 - 0.001, top_z - notch_h])
        rotate([0, 0, 0])
        // Wedge: a triangular prism cut into the wall.
        difference() {
            translate([-utag_width/2, 0, 0])
                cube([utag_width, od, notch_h + 0.05]);

            // Inner-bevel wall — the angled face that defines edge tone.
            translate([-utag_width/2 - 0.05, -0.05, notch_h])
                rotate([90 - inner_bevel, 0, 0])
                cube([utag_width + 0.10, od + 0.10, notch_h * 2]);
        }
}

module tone_hole(d_from_foot, on_back = false) {
    // Drill a Ø hole_diam through the wall at distance d_from_foot from the
    // foot, centered on the front (+Y) face by default, or on the back (-Y)
    // for the thumb hole.
    y_dir = on_back ? -1 : 1;
    translate([0, y_dir * (od/2 + 0.10), d_from_foot])
        rotate([90, 0, 0])
        cylinder(h = od + 0.20, d = hole_diam, $fn = 32);
}

module shakuhachi_d4_p1() {
    difference() {
        body_blank();
        bore();
        utaguchi_notch();
        tone_hole(hole1_d_foot);
        tone_hole(hole2_d_foot);
        tone_hole(hole3_d_foot);
        tone_hole(hole4_d_foot);
        tone_hole(thumb_d_foot, on_back = true);
    }
}

// ===== Render =====
shakuhachi_d4_p1();

// ----- Console echo for design table cross-check -----
echo(str("L_physical = ", length_phys, " in"));
echo(str("delta_foot = ", delta_foot, " in"));
echo(str("delta_utaguchi = ", delta_utaguchi, " in"));
echo(str("hole1 (Tsu / F4) d_from_foot = ", hole1_d_foot, " in"));
echo(str("hole2 (Re / G4)  d_from_foot = ", hole2_d_foot, " in"));
echo(str("hole3 (Chi / A4) d_from_foot = ", hole3_d_foot, " in"));
echo(str("hole4 (Ri / C5)  d_from_foot = ", hole4_d_foot, " in"));
echo(str("thumb (Ro' / D5) d_from_foot = ", thumb_d_foot, " in"));
