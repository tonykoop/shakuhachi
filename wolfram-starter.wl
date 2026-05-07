(* ============================================================================
   wolfram-starter.wl
   Shakuhachi parametric model — first-pass, paste into Wolfram Desktop / Cloud.

   Sister: tonykoop/shakuhachi
   Skill:  instrument-maker-v4
   Date:   2026-05-07

   Workflow:
     1. Paste this whole file into a Wolfram notebook.
     2. Evaluate from top to bottom; the Manipulate at the end becomes the
        interactive design surface.
     3. Tune `cUtaguchi` from measured-vs-predicted Ro fundamental.
     4. Export an updated design table:
          familySpec[] // TableForm // Export["family-spec.csv", #, "CSV"]&
   ============================================================================ *)

(* ---------- Constants ---------- *)
cAir68 = 13552;                                  (* in/s, speed of sound at 68 F dry air *)
mToShaku = 1./0.303;                              (* 1 shaku = 30.3 cm *)
inToShaku = 1./11.93;                             (* 1 shaku = 11.93 in *)
A4 = 440;                                         (* tuning anchor *)

(* Equal-temperament frequency from MIDI number *)
freqFromMidi[m_] := A4 * 2^((m - 69)/12.0)

(* ---------- Open-pipe model ---------- *)
(* Foot end: standard 0.6 r flange-like correction.
   Utaguchi end: empirical shakuhachi extension, fitted from 1.8-shaku D4 anchor.
   The factor cUtaguchi is the design degree of freedom that the empirical
   loop refines (run record_measurement.py to update). *)
deltaFoot[boreID_] := 0.6 * (boreID/2.)
deltaUtaguchi[boreID_, cUtaguchi_:1.7] := cUtaguchi * (boreID/2.)
endCorrTotal[boreID_, cUtaguchi_:1.7] := deltaFoot[boreID] + deltaUtaguchi[boreID, cUtaguchi]

physLength[freq_, boreID_, cUtaguchi_:1.7] :=
  cAir68/(2.*freq) - endCorrTotal[boreID, cUtaguchi]

(* Hole-position first pass — acoustic stations from the foot. Real shakuhachi
   hole positions sit a bit closer to the foot than this prediction (5-15 mm)
   because finite-hole-diameter corrections matter; that's what bisque-style
   tuning fixes. *)
holePosFromFoot[fund_, fhole_, lAcoustic_] := lAcoustic * (fund/fhole)

(* Acoustic length used for hole-position formula = c/(2 f0); that's the ideal
   pipe length without end corrections, and the formula scales linearly with
   it because both numerator and denominator share the same end-correction. *)
acousticLen[freq_] := cAir68/(2.*freq)

(* ---------- Kinko-ryu hole intervals (semitones above fundamental) ---------- *)
kinkoSemis = <|
  "Ro"  -> 0,
  "Tsu" -> 3,
  "Re"  -> 5,
  "Chi" -> 7,
  "Ri"  -> 10,
  "Ro'" -> 12
|>;

holeFreqs[fund_] := AssociationMap[fund * 2^(#/12.) &, Values[kinkoSemis]]

(* ---------- One-shaku-shape report ---------- *)
shakuhachiSpec[fund_, boreID_, cUtaguchi_:1.7] := Module[
  {lac = acousticLen[fund], lph = physLength[fund, boreID, cUtaguchi]},
  <|
    "fund_Hz"          -> fund,
    "L_acoustic_in"    -> lac,
    "L_physical_in"    -> lph,
    "shaku_approx"     -> lph * inToShaku,
    "delta_total_in"   -> endCorrTotal[boreID, cUtaguchi],
    "hole_distances"   -> Association @ KeyValueMap[
      Function[{name, semis},
        name -> If[semis == 0, "(foot, all closed)",
                   holePosFromFoot[fund, fund * 2^(semis/12.), lac]
                  ]
      ],
      kinkoSemis
    ]
  |>
]

(* ---------- Family table for the workbook ---------- *)
familySpec[cUtaguchi_:1.7] := Module[
  {keys = {{"C4",60,0.787}, {"D4",62,0.787}, {"Eb4",63,0.787}, {"E4",64,0.787},
           {"F4",65,0.669}, {"G4",67,0.669}, {"A4",69,0.591}, {"B4",71,0.591}}},
  Table[
    With[{label = k[[1]], midi = k[[2]], bore = k[[3]],
          fund = freqFromMidi[k[[2]]]},
      {label, midi, fund,
       acousticLen[fund],
       endCorrTotal[bore, cUtaguchi],
       physLength[fund, bore, cUtaguchi],
       physLength[fund, bore, cUtaguchi] * inToShaku,
       bore}
    ],
    {k, keys}
  ] // Prepend[#, {"Key", "MIDI", "Fund (Hz)", "L_acoustic (in)",
                   "delta_total (in)", "L_physical (in)",
                   "shaku approx", "Bore ID (in)"}] &
]

(* Run: familySpec[] // TableForm  *)

(* ---------- Cents math ---------- *)
cents[measured_, target_] := 1200. * Log[2., measured/target]

(* Example: cents[296.0, 293.665]  -> ~13.7 cents sharp *)

(* ---------- Empirical-loop estimator ----------
   Given a measured Ro fundamental, solve for cUtaguchi consistent with the
   built physical length. *)
fitUtaguchiCorrection[lphysMeasured_, freqMeasured_, boreID_] := Module[
  {totalCorr, lacoust},
  lacoust = acousticLen[freqMeasured];
  totalCorr = lacoust - lphysMeasured;
  (* totalCorr = deltaFoot + deltaUtaguchi = 0.6*r + c*r => c = (totalCorr/r) - 0.6 *)
  Quiet[ (totalCorr / (boreID/2.)) - 0.6, {Power::infy, Infinity::indet}]
]

(* Example:
   fitUtaguchiCorrection[21.50, 293.665, 0.787]
   Should return ~1.71, matching the design.md fitted value.   *)

(* ---------- Manipulate (interactive) ---------- *)
shakuhachiManipulate[] := Manipulate[
  Module[{spec = shakuhachiSpec[fund, bore, cU]},
    Column[{
      Row[{"L_acoustic = ", spec["L_acoustic_in"], " in"}],
      Row[{"delta_total = ", spec["delta_total_in"], " in"}],
      Row[{"L_physical  = ", spec["L_physical_in"], " in   (",
           spec["shaku_approx"], " shaku)"}],
      Row[{"Bore        = ", bore, " in"}],
      "Hole distances from foot (in):",
      Grid[
        Prepend[
          KeyValueMap[{#1, #2} &, spec["hole_distances"]],
          {"Note", "d_foot (in)"}
        ],
        Frame -> All
      ]
    }]
  ],
  {{fund, 293.665, "Fundamental (Hz)"}, 200, 600, 0.001},
  {{bore, 0.787, "Bore ID (in)"}, 0.5, 1.0, 0.001},
  {{cU, 1.7, "Utaguchi correction multiplier"}, 0.6, 2.5, 0.01}
]

(* Run: shakuhachiManipulate[] *)

(* ---------- Validation example ----------
   Build SHK-D4-P1 prediction, then pretend Tony measured 296.0 Hz instead
   of 293.665 Hz on the post-utaguchi check. Output cents error and
   re-fit utaguchi correction. *)
validationExample[] := Module[
  {predicted, measured, lphys, refittedC},
  predicted = shakuhachiSpec[293.665, 0.787, 1.7];
  measured  = 296.0;
  lphys     = predicted["L_physical_in"];
  refittedC = fitUtaguchiCorrection[lphys, measured, 0.787];
  <|
    "predicted_Lphys_in" -> lphys,
    "predicted_Hz"       -> 293.665,
    "measured_Hz"        -> measured,
    "cents_error"        -> cents[measured, 293.665],
    "refit_cUtaguchi"    -> refittedC,
    "delta_correction"   -> refittedC - 1.7
  |>
]

(* Run: validationExample[]
   Use the refit cUtaguchi value to update the family-spec for sibling members
   before cutting blanks. *)

(* ---------- Notebook ideas (next-pass) ----------
   - Webster horn equation for non-cylindrical bamboo bore: NDSolve PDE on
     r(z) profile; compare modes vs cylindrical reference.
   - Meri / kari pitch-shift map: empirical model of chin-tilt angle vs
     cents shift; calibrate against AudioRecord on Tony's prototype.
   - Per-hole finite-diameter correction: parametric study of hole_diam /
     bore_diam ratio vs cents flat-shift to refine first-pass hole positions.
   - Octave error vs ovalization: ParametricPlot the second harmonic shift
     for elliptical-bore approximations of the post-bore measurement set.
   - Cultural atlas: GeoGraphics China -> Japan import arc;
     TimelinePlot[{700, 1300, 1614, 1871, 1950s} -> events]; Entity[
     "MusicalInstrument", "Shakuhachi"].
*)
