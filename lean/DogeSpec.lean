/-
  SPEC ENCODINGS for numbered specification 0001 Digital Octal
  Graphical Emissive (`0001_DOGE.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in DogeProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not dump 0001_DOGE.md as string literals.
  It does not transcribe the ITU-T T.416 PDF.
  DOGE remains version 1.0.0. Number 0009 is PDOSS.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

namespace Doge

/-- This module is a spec encoding, not a proof. -/
def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0001. DOGE remains 1.0.0. -/
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

/-- Clause 4 table in preferred DOGE order. Exactly eight rows. -/
def palette : List PaletteRow :=
  [red, green, blue, cyan, magenta, yellow, black, white]

def midtoneGray : Srgb := { r := 128, g := 128, b := 128 }

/-- Mash fixture: 256 color VGA as the DOGE palette. -/
def mashVga256AsDogePalette : Bool :=
  256 == palette.length

/-- Clause 6.1. Each 8 bit channel: 128 and above becomes 255, else 0. -/
def hardThresholdChannel (v : Nat) : Nat :=
  if v >= 128 then 255 else 0

/-- Clause 6. Two selected methods. Gaussian is not a constructor. -/
inductive QuantizationMethod where
  | hardThreshold
  | floydSteinberg
  deriving DecidableEq, Repr, BEq

def gaussianSelected : Bool := false

def methodIs61or62 : QuantizationMethod → Bool
  | .hardThreshold => true
  | .floydSteinberg => true

/-- Clause 8. SGR mapping is SHOULD and is not a conjunct. -/
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

/-- Clause 5 table in DOGE order, not ECMA-48 name order. -/
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

/-- Clause 4.1. Fully transparent pixels are black before quantization. -/
def mapAlphaZeroToBlack (alpha : Nat) (rgb : Srgb) : Srgb :=
  if alpha == 0 then { r := 0, g := 0, b := 0 } else rgb

def semanticRolesRequired : Bool := false

def softMidtoneInPalette : Bool := false

/-- Mash fixture: citing T.416 does not widen the eight color palette. -/
def mashCitingT416AddsExtendedColors : Bool := false

def rfc2119PinPath : String := "ref/rfc2119"

def ecma48PinPath : String := "ref/ecma48"

def ituT416PinPath : String := "ref/itu_t416"

end Doge
