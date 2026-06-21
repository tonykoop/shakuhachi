(* Shakuhachi parametric acoustic model.
   Open-open pipe (foot + utaguchi). Physically grounded in this repo's
   design.md (governing model: f = c/(2 L_eff), L_eff = L_phys + delta_foot
   + delta_utaguchi). All values are first-pass estimates pending the
   SHK-D4-P1 prototype measurement; reference_only, not fabrication authority. *)

ClearAll["Global`*"];

shakuhachiMetadata = <|
   "instrument" -> "Shakuhachi",
   "packet" -> "Wolfram interactive acoustic model",
   "modelName" -> "Open-open pipe with foot and utaguchi end corrections",
   "authority" -> "reference_only",
   "calibrationStatus" -> "uncalibrated estimates; pending SHK-D4-P1 measurement"
   |>;

(* ---- Nominal estimates (SHK-D4-P1, from design.md, SI) ---- *)
lengthEstimate = 0.5470;        (* m; 21.53 in physical length, D4 1.8-shaku *)
boreDiameterEstimate = 0.0200;  (* m; 0.787 in bore ID *)
utaguchiFactorEstimate = 3.2;   (* delta_utaguchi / r_bore; reproduces SHK-D4-P1 historical 1.8-shaku length. Empirically delta_utaguchi ~ 1.5-2.0x bore DIAMETER for shakuhachi (= ~3-4x bore radius), far larger than the 0.6x foot correction. Tune from measured Ro. *)
footFactor = 0.6;               (* delta_foot / r_bore; Levine/Schwinger open end *)
temperatureEstimateC = 20.0;    (* deg C; design.md uses 68 F = 20 C *)

minLength = 0.30; maxLength = 0.70;
minBore = 0.012; maxBore = 0.026;
minUtaguchi = 1.0; maxUtaguchi = 4.5;
minTemp = 5.0; maxTemp = 35.0;

(* speed of sound in dry air, m/s, as a function of temperature (deg C) *)
soundSpeed[tempC_] := 331.3*Sqrt[1 + tempC/273.15];

effectiveLength[lengthM_, boreM_, utaguchiFactor_] :=
  Module[{r = boreM/2},
   lengthM + footFactor*r + utaguchiFactor*r];

fundamentalHz[lengthM_, boreM_, utaguchiFactor_, tempC_] :=
  soundSpeed[tempC]/(2*effectiveLength[lengthM, boreM, utaguchiFactor]);

(* equal-tempered reference and cents deviation *)
midiToHz[m_] := 440.*2^((m - 69)/12);
nearestMidi[f_] := Round[69 + 12*Log2[f/440.]];
centsDeviation[f_] := 1200.*Log2[f/midiToHz[nearestMidi[f]]];

(* Kinko-ryu tone-hole stations: acoustic distance from foot, d = L_acoustic * f0 / f_hole *)
holeSemitones = {3, 5, 7, 10, 12};
holeNames = {"Tsu (F4)", "Re (G4)", "Chi (A4)", "Ri (C5)", "Thumb Ro' (D5)"};
toneHoleTable[lengthM_, boreM_, utaguchiFactor_, tempC_] :=
  Module[{lAc, f0},
   lAc = effectiveLength[lengthM, boreM, utaguchiFactor];
   f0 = fundamentalHz[lengthM, boreM, utaguchiFactor, tempC];
   Dataset[
    MapThread[
     <|"hole" -> #1, "deltaSemitone" -> #2,
       "f_hole_Hz" -> N[f0*2^(#2/12)],
       "d_from_foot_in" -> N[(lAc*f0/(f0*2^(#2/12)))/0.0254]|> &,
     {holeNames, holeSemitones}]]];

shakuhachiNominalEstimate = <|
   "fundamentalHzEstimate" ->
    fundamentalHz[lengthEstimate, boreDiameterEstimate, utaguchiFactorEstimate, temperatureEstimateC],
   "effectiveLengthInEstimate" ->
    effectiveLength[lengthEstimate, boreDiameterEstimate, utaguchiFactorEstimate]/0.0254,
   "centsVsNearestET" ->
    centsDeviation[fundamentalHz[lengthEstimate, boreDiameterEstimate, utaguchiFactorEstimate, temperatureEstimateC]],
   "toneHoleStationsEstimate" ->
    toneHoleTable[lengthEstimate, boreDiameterEstimate, utaguchiFactorEstimate, temperatureEstimateC]
   |>;

shakuhachiExplorer =
  Manipulate[
   Column[{
     Style["Shakuhachi open-open pipe estimate model", 14, Bold],
     "Reference_only; pending SHK-D4-P1 measurement, not fabrication authority.",
     <|"fundamentalHzEstimate" -> fundamentalHz[lengthM, boreM, utaguchiFactor, tempC],
       "nearestNoteMIDI" -> nearestMidi[fundamentalHz[lengthM, boreM, utaguchiFactor, tempC]],
       "centsVsNearestET" -> centsDeviation[fundamentalHz[lengthM, boreM, utaguchiFactor, tempC]],
       "effectiveLength_in" -> effectiveLength[lengthM, boreM, utaguchiFactor]/0.0254|>,
     Plot[
      fundamentalHz[L, boreM, utaguchiFactor, tempC],
      {L, minLength, maxLength},
      AxesLabel -> {"physical length (m)", "fundamental estimate (Hz)"},
      PlotRange -> All],
     toneHoleTable[lengthM, boreM, utaguchiFactor, tempC]
     }],
   {{lengthM, lengthEstimate, "physical length (m)"}, minLength, maxLength},
   {{boreM, boreDiameterEstimate, "bore diameter (m)"}, minBore, maxBore},
   {{utaguchiFactor, utaguchiFactorEstimate, "utaguchi extension (x r_bore)"}, minUtaguchi, maxUtaguchi},
   {{tempC, temperatureEstimateC, "air temperature (deg C)"}, minTemp, maxTemp},
   SaveDefinitions -> True
   ];

shakuhachiModel = <|
   "metadata" -> shakuhachiMetadata,
   "nominalEstimate" -> shakuhachiNominalEstimate,
   "explorer" -> shakuhachiExplorer
   |>
