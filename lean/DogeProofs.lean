/-
  PROOFS for numbered specification 0001 Digital Octal Graphical
  Emissive (DOGE).

  This module is not the specification. It imports DogeSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import DogeSpec

namespace DogeProofs

open Doge

theorem spec_number_is_1 : specNumber = 1 := rfl

theorem spec_file_is_0001_doge : specFileName = "0001_DOGE.md" :=
  rfl

theorem spec_version_is_1_0_0 : specVersion = "1.0.0" := rfl

theorem spec_is_not_pdoss_number : specNumber ≠ 9 := by decide

theorem marked_encoding_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem palette_has_eight_colors : palette.length = 8 := rfl

theorem palette_channels_are_pure :
    palette.all (fun row => isRepresentable row.srgb) = true :=
  rfl

theorem red_is_index_zero :
    palette[0]? = some red :=
  rfl

theorem red_srgb_is_255_0_0 :
    red.srgb = { r := 255, g := 0, b := 0 } :=
  rfl

theorem red_bits_are_100 : red.bits = "100" := rfl

theorem black_bits_are_000 : black.bits = "000" := rfl

theorem white_bits_are_111 : white.bits = "111" := rfl

theorem gray_is_not_representable :
    isRepresentable midtoneGray = false :=
  rfl

theorem mash_vga256_as_doge_palette_is_false :
    mashVga256AsDogePalette = false :=
  rfl

theorem hard_threshold_zero :
    hardThresholdChannel 0 = 0 :=
  rfl

theorem hard_threshold_127 :
    hardThresholdChannel 127 = 0 :=
  rfl

theorem hard_threshold_128 :
    hardThresholdChannel 128 = 255 :=
  rfl

theorem hard_threshold_255 :
    hardThresholdChannel 255 = 255 :=
  rfl

theorem gaussian_is_not_a_selected_method :
    gaussianSelected = false :=
  rfl

theorem blue_sgr_foreground_is_34 : sgrBlue.fg = 34 := rfl

theorem yellow_sgr_foreground_is_33 : sgrYellow.fg = 33 := rfl

theorem mash_ecma48_name_order_is_doge_index_order_is_false :
    mashEcma48NameOrderIsDogeIndexOrder = false :=
  rfl

theorem sgr_mapping_is_not_a_conformance_conjunct :
    sgrMappingIsConformanceConjunct = false :=
  rfl

theorem clause8_conforming_with_hard_threshold :
    clause8Conforming true true QuantizationMethod.hardThreshold = true :=
  rfl

theorem clause8_conforming_with_floyd_steinberg :
    clause8Conforming true true QuantizationMethod.floydSteinberg = true :=
  rfl

theorem clause8_conforming_without_quantization :
    clause8Conforming true false QuantizationMethod.hardThreshold = true :=
  rfl

theorem clause8_rejects_wrong_palette :
    clause8Conforming false true QuantizationMethod.hardThreshold = false :=
  rfl

theorem semantic_roles_are_not_required :
    semanticRolesRequired = false :=
  rfl

theorem soft_midtone_is_not_in_palette :
    softMidtoneInPalette = false :=
  rfl

theorem alpha_zero_maps_to_black :
    mapAlphaZeroToBlack 0 { r := 255, g := 0, b := 0 } =
      { r := 0, g := 0, b := 0 } :=
  rfl

theorem mash_citing_t416_does_not_add_extended_colors :
    mashCitingT416AddsExtendedColors = false :=
  rfl

theorem rfc2119_pin_path : rfc2119PinPath = "ref/rfc2119" := rfl

theorem ecma48_pin_path : ecma48PinPath = "ref/ecma48" := rfl

theorem itu_t416_pin_path : ituT416PinPath = "ref/itu_t416" := rfl

end DogeProofs
