/-
  PROOFS for the sibling line encoding of `0001_DOGE.md`.

  This module is not the specification. It imports «0001_DOGE» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.

  Lake SpecProofs lists only named roots. An extra DogeProofs module
  is not compiled from an import. Meaning encodings and proofs
  therefore live in this root as well as in DogeSpec.lean and
  DogeProofs.lean. That mash is leftover until the Lake file can
  list those modules.
-/

import «0001_DOGE»
import FormalVibeficationSpec

namespace Proofs_0001

open «0001_DOGE»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 1 := rfl

theorem spec_file : specFileName = "0001_DOGE.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0001_DOGE.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0001" := rfl

theorem proof_module_distinct :
    proofModuleName ≠ siblingEncodingFileName := by
  decide

theorem mash_hidden_split_is_false :
    FormalVibeficationSpec.hidesSplit
      { moduleName := siblingEncodingFileName
        containsSpecEncodings := markedAsSpecEncoding
        containsProofsOfThoseEncodings := markedAsProof
        markedAsSpecEncoding := markedAsSpecEncoding
        markedAsProof := markedAsProof } = false :=
  rfl

theorem encoded_size : encodedLines.size = 154 := by
  native_decide

theorem first_line_matches :
    line0001.text = "# Digital Octal Graphical Emissive (DOGE) Color Specification" ∧
      encodedLines[0]? = some line0001 :=
  And.intro rfl (by native_decide)

theorem doge_phrase_exists :
    line0030.text = "Digital Octal Graphical Emissive. The full name of this palette." ∧
      encodedLines[29]? = some line0030 :=
  And.intro rfl (by native_decide)

end Proofs_0001

/-
  SPEC ENCODINGS for numbered specification 0001. Namespace Doge.
  Preferred home is DogeSpec.lean. Copied here so SpecProofs compiles.
-/

namespace Doge

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def specNumber : Nat := 1

def specFileName : String := "0001_DOGE.md"

def specVersion : String := "1.0.0"

structure Srgb where
  r : Nat
  g : Nat
  b : Nat
  deriving DecidableEq, Repr, BEq

structure PaletteRow where
  name : String
  hex : String
  srgb : Srgb
  bits : String
  deriving DecidableEq, Repr, BEq

def isPureChannel (c : Nat) : Bool :=
  c == 0 || c == 255

def isRepresentable (c : Srgb) : Bool :=
  isPureChannel c.r && isPureChannel c.g && isPureChannel c.b

def red : PaletteRow :=
  { name := "Red", hex := "#FF0000"
    srgb := { r := 255, g := 0, b := 0 }, bits := "100" }

def green : PaletteRow :=
  { name := "Green", hex := "#00FF00"
    srgb := { r := 0, g := 255, b := 0 }, bits := "010" }

def blue : PaletteRow :=
  { name := "Blue", hex := "#0000FF"
    srgb := { r := 0, g := 0, b := 255 }, bits := "001" }

def cyan : PaletteRow :=
  { name := "Cyan", hex := "#00FFFF"
    srgb := { r := 0, g := 255, b := 255 }, bits := "011" }

def magenta : PaletteRow :=
  { name := "Magenta", hex := "#FF00FF"
    srgb := { r := 255, g := 0, b := 255 }, bits := "101" }

def yellow : PaletteRow :=
  { name := "Yellow", hex := "#FFFF00"
    srgb := { r := 255, g := 255, b := 0 }, bits := "110" }

def black : PaletteRow :=
  { name := "Black", hex := "#000000"
    srgb := { r := 0, g := 0, b := 0 }, bits := "000" }

def white : PaletteRow :=
  { name := "White", hex := "#FFFFFF"
    srgb := { r := 255, g := 255, b := 255 }, bits := "111" }

def palette : List PaletteRow :=
  [red, green, blue, cyan, magenta, yellow, black, white]

def midtoneGray : Srgb := { r := 128, g := 128, b := 128 }

def mashVga256AsDogePalette : Bool :=
  256 == palette.length

def hardThresholdChannel (v : Nat) : Nat :=
  if v >= 128 then 255 else 0

inductive QuantizationMethod where
  | hardThreshold
  | floydSteinberg
  deriving DecidableEq, Repr, BEq

def gaussianSelected : Bool := false

def methodIs61or62 : QuantizationMethod → Bool
  | .hardThreshold => true
  | .floydSteinberg => true

def clause8Conforming (paletteIsClause4 : Bool) (quantizes : Bool)
    (m : QuantizationMethod) : Bool :=
  paletteIsClause4 && (!quantizes || methodIs61or62 m)

def sgrMappingIsConformanceConjunct : Bool := false

structure SgrRow where
  name : String
  fg : Nat
  bg : Nat
  brightFg : Nat
  brightBg : Nat
  deriving DecidableEq, Repr, BEq

def sgrRed : SgrRow :=
  { name := "Red", fg := 31, bg := 41, brightFg := 91, brightBg := 101 }

def sgrGreen : SgrRow :=
  { name := "Green", fg := 32, bg := 42, brightFg := 92, brightBg := 102 }

def sgrBlue : SgrRow :=
  { name := "Blue", fg := 34, bg := 44, brightFg := 94, brightBg := 104 }

def sgrCyan : SgrRow :=
  { name := "Cyan", fg := 36, bg := 46, brightFg := 96, brightBg := 106 }

def sgrMagenta : SgrRow :=
  { name := "Magenta", fg := 35, bg := 45, brightFg := 95, brightBg := 105 }

def sgrYellow : SgrRow :=
  { name := "Yellow", fg := 33, bg := 43, brightFg := 93, brightBg := 103 }

def sgrBlack : SgrRow :=
  { name := "Black", fg := 30, bg := 40, brightFg := 90, brightBg := 100 }

def sgrWhite : SgrRow :=
  { name := "White", fg := 37, bg := 47, brightFg := 97, brightBg := 107 }

def sgrTable : List SgrRow :=
  [sgrRed, sgrGreen, sgrBlue, sgrCyan, sgrMagenta, sgrYellow, sgrBlack, sgrWhite]

def sgrFg (name : String) : Option Nat :=
  (sgrTable.find? (fun row => row.name == name)).map (fun row => row.fg)

def dogeIndexOrder : List String :=
  palette.map (fun row => row.name)

def ecma48NameOrder : List String :=
  ["Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"]

def mashEcma48NameOrderIsDogeIndexOrder : Bool :=
  ecma48NameOrder == dogeIndexOrder

def mapAlphaZeroToBlack (alpha : Nat) (rgb : Srgb) : Srgb :=
  if alpha == 0 then { r := 0, g := 0, b := 0 } else rgb

def semanticRolesRequired : Bool := false

def softMidtoneInPalette : Bool := false

def mashCitingT416AddsExtendedColors : Bool := false

def rfc2119PinPath : String := "ref/rfc2119"

def ecma48PinPath : String := "ref/ecma48"

def ituT416PinPath : String := "ref/itu_t416"

end Doge

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
