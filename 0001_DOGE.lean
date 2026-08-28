/-
  SPEC ENCODING of numbered specification markdown `0001_DOGE.md`.
  This file sits next to that markdown at the repository root.

  Every physical line of the markdown (including blank lines) is an
  explicit Lean `MdLine` value (`line0001`, ...). The encoding file
  uses the markdown basename with `.lean` in place of `.md` so a
  reader sees the pair immediately. The file name starts with a
  digit, so Lean uses a quoted module name that matches that stem.

  This module is a spec encoding, not a proof module.
  Proofs live in `lean/Proofs_0001.lean`.
  Numbered markdown is the contract humans read.
  Lean proofs are not the specification.
-/

import MdLine

namespace «0001_DOGE»

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def specNumber : Nat := 1

def specFileName : String := "0001_DOGE.md"

def siblingEncodingFileName : String := "0001_DOGE.lean"

def proofModuleName : String := "Proofs_0001"

def line0001 : MdLine := { number := 1, text := "# Digital Octal Graphical Emissive (DOGE) Color Specification" }

def line0002 : MdLine := { number := 2, text := "" }

def line0003 : MdLine := { number := 3, text := "> v1.0.0 - 20260730" }

def line0004 : MdLine := { number := 4, text := ">" }

def line0005 : MdLine := { number := 5, text := "> Pure 3 bit RGB color palette for high contrast emissive displays" }

def line0006 : MdLine := { number := 6, text := "" }

def line0007 : MdLine := { number := 7, text := "## 1. Scope" }

def line0008 : MdLine := { number := 8, text := "" }

def line0009 : MdLine := { number := 9, text := "This specification defines a pure 3 bit RGB color palette consisting of exactly eight colors. It is intended for high contrast graphical user interfaces, terminal emulators, and emissive displays (OLED and similar) where maximum channel purity is desired, especially for users with eyes sensitive to older LCD style light bleed." }

def line0010 : MdLine := { number := 10, text := "" }

def line0011 : MdLine := { number := 11, text := "The palette is a deliberate pure realization of the classic 3 bit RGB model that underlies the eight named colors of ECMA-48 / ISO/IEC 6429. Unlike those standards, which define only color names, this specification fixes the exact 24 bit sRGB values." }

def line0012 : MdLine := { number := 12, text := "" }

def line0013 : MdLine := { number := 13, text := "### 1.1 Status of this document" }

def line0014 : MdLine := { number := 14, text := "" }

def line0015 : MdLine := { number := 15, text := "1. This document is normative for the DOGE palette, quantization, and related mapping requirements stated herein." }

def line0016 : MdLine := { number := 16, text := "2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec)." }

def line0017 : MdLine := { number := 17, text := "" }

def line0018 : MdLine := { number := 18, text := "## 2. Normative references" }

def line0019 : MdLine := { number := 19, text := "" }

def line0020 : MdLine := { number := 20, text := "The following documents are indispensable for the application of this specification. For undated references, the latest edition applies. Local copies under `ref/` are preferred when present." }

def line0021 : MdLine := { number := 21, text := "" }

def line0022 : MdLine := { number := 22, text := "1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels. Local path when present: `ref/rfc2119`." }

def line0023 : MdLine := { number := 23, text := "2. ECMA-48, 5th Edition (1991) / ISO/IEC 6429, Control Functions for Coded Character Sets. Local path when present: `ref/ecma48`." }

def line0024 : MdLine := { number := 24, text := "3. ITU-T Recommendation T.416 (03/93) / ISO/IEC 8613-6, Character Content Architectures (for extended color models). Local path: `ref/itu_t416`. Official free ITU PDF pin; the PDF states identical text is also published as ISO/IEC International Standard 8613-6." }

def line0025 : MdLine := { number := 25, text := "" }

def line0026 : MdLine := { number := 26, text := "## 3. Definitions" }

def line0027 : MdLine := { number := 27, text := "" }

def line0028 : MdLine := { number := 28, text := "### 3.1 DOGE" }

def line0029 : MdLine := { number := 29, text := "" }

def line0030 : MdLine := { number := 30, text := "Digital Octal Graphical Emissive. The full name of this palette." }

def line0031 : MdLine := { number := 31, text := "" }

def line0032 : MdLine := { number := 32, text := "### 3.2 RGBCMYKW" }

def line0033 : MdLine := { number := 33, text := "" }

def line0034 : MdLine := { number := 34, text := "The ordered set of the eight pure colors: Red, Green, Blue, Cyan, Magenta, Yellow, Black, White." }

def line0035 : MdLine := { number := 35, text := "" }

def line0036 : MdLine := { number := 36, text := "### 3.3 Pure 3 bit RGB" }

def line0037 : MdLine := { number := 37, text := "" }

def line0038 : MdLine := { number := 38, text := "A color model in which each of the red, green, and blue channels is restricted to the extreme values 0 or 255 (1 bit per channel). The resulting eight combinations are the only permitted colors. No grayscale colors or other shades are permitted, for reasons including efficiency on more limited experimental hardware stacks, and the understanding that display brightness is best toggled for visibility." }

def line0039 : MdLine := { number := 39, text := "" }

def line0040 : MdLine := { number := 40, text := "### 3.4 Requirement keywords" }

def line0041 : MdLine := { number := 41, text := "" }

def line0042 : MdLine := { number := 42, text := "The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119." }

def line0043 : MdLine := { number := 43, text := "" }

def line0044 : MdLine := { number := 44, text := "## 4. Color table" }

def line0045 : MdLine := { number := 45, text := "" }

def line0046 : MdLine := { number := 46, text := "The eight colors SHALL be exactly:" }

def line0047 : MdLine := { number := 47, text := "" }

def line0048 : MdLine := { number := 48, text := "| Index | Name     | Hex     | sRGB (R,G,B)     | Binary (RGB) |" }

def line0049 : MdLine := { number := 49, text := "|-------|----------|---------|------------------|--------------|" }

def line0050 : MdLine := { number := 50, text := "| 0     | Red      | #FF0000 | 255, 0, 0        | 100          |" }

def line0051 : MdLine := { number := 51, text := "| 1     | Green    | #00FF00 | 0, 255, 0        | 010          |" }

def line0052 : MdLine := { number := 52, text := "| 2     | Blue     | #0000FF | 0, 0, 255        | 001          |" }

def line0053 : MdLine := { number := 53, text := "| 3     | Cyan     | #00FFFF | 0, 255, 255      | 011          |" }

def line0054 : MdLine := { number := 54, text := "| 4     | Magenta  | #FF00FF | 255, 0, 255      | 101          |" }

def line0055 : MdLine := { number := 55, text := "| 5     | Yellow   | #FFFF00 | 255, 255, 0      | 110          |" }

def line0056 : MdLine := { number := 56, text := "| 6     | Black    | #000000 | 0, 0, 0          | 000          |" }

def line0057 : MdLine := { number := 57, text := "| 7     | White    | #FFFFFF | 255, 255, 255    | 111          |" }

def line0058 : MdLine := { number := 58, text := "" }

def line0059 : MdLine := { number := 59, text := "1. No other colors are permitted within a conforming DOGE implementation." }

def line0060 : MdLine := { number := 60, text := "2. Implementations SHALL NOT support alpha channels or different shades as additional palette colors." }

def line0061 : MdLine := { number := 61, text := "" }

def line0062 : MdLine := { number := 62, text := "### 4.1 Alpha channel handling" }

def line0063 : MdLine := { number := 63, text := "" }

def line0064 : MdLine := { number := 64, text := "1. When source data contains an alpha channel, the alpha component SHALL be discarded before quantization." }

def line0065 : MdLine := { number := 65, text := "2. Fully transparent pixels (alpha = 0) SHALL be treated as black." }

def line0066 : MdLine := { number := 66, text := "3. Premultiplied alpha data SHALL be converted to straight RGB by the implementation before the alpha is discarded." }

def line0067 : MdLine := { number := 67, text := "4. No other alpha behavior is defined or permitted." }

def line0068 : MdLine := { number := 68, text := "" }

def line0069 : MdLine := { number := 69, text := "This specification addresses the physical characteristics of emissive display hardware rather than internal software implementation details." }

def line0070 : MdLine := { number := 70, text := "" }

def line0071 : MdLine := { number := 71, text := "## 5. Mapping to ECMA-48 SGR parameters" }

def line0072 : MdLine := { number := 72, text := "" }

def line0073 : MdLine := { number := 73, text := "Implementations that interoperate with ECMA-48 / ANSI terminals SHOULD map the DOGE colors as follows:" }

def line0074 : MdLine := { number := 74, text := "" }

def line0075 : MdLine := { number := 75, text := "| DOGE Color | SGR Foreground | SGR Background | Bright FG | Bright BG |" }

def line0076 : MdLine := { number := 76, text := "|------------|----------------|----------------|-----------|-----------|" }

def line0077 : MdLine := { number := 77, text := "| Red        | 31             | 41             | 91        | 101       |" }

def line0078 : MdLine := { number := 78, text := "| Green      | 32             | 42             | 92        | 102       |" }

def line0079 : MdLine := { number := 79, text := "| Blue       | 34             | 44             | 94        | 104       |" }

def line0080 : MdLine := { number := 80, text := "| Cyan       | 36             | 46             | 96        | 106       |" }

def line0081 : MdLine := { number := 81, text := "| Magenta    | 35             | 45             | 95        | 105       |" }

def line0082 : MdLine := { number := 82, text := "| Yellow     | 33             | 43             | 93        | 103       |" }

def line0083 : MdLine := { number := 83, text := "| Black      | 30             | 40             | 90        | 100       |" }

def line0084 : MdLine := { number := 84, text := "| White      | 37             | 47             | 97        | 107       |" }

def line0085 : MdLine := { number := 85, text := "" }

def line0086 : MdLine := { number := 86, text := "1. Because the DOGE values are already pure, the \"normal\" and \"bright\" slots MAY both be assigned the same pure value." }

def line0087 : MdLine := { number := 87, text := "2. The ordering of the color table and this map matches the preferred DOGE ordering and is not required to match the original ECMA-48 ordering of named colors." }

def line0088 : MdLine := { number := 88, text := "" }

def line0089 : MdLine := { number := 89, text := "## 6. Quantization (conversion of arbitrary color data)" }

def line0090 : MdLine := { number := 90, text := "" }

def line0091 : MdLine := { number := 91, text := "Two methods are defined for converting continuous or higher bit depth color data into the DOGE palette. A conforming implementation that performs quantization of external color data SHALL use either Clause 6.1 or Clause 6.2." }

def line0092 : MdLine := { number := 92, text := "" }

def line0093 : MdLine := { number := 93, text := "### 6.1 Hard threshold" }

def line0094 : MdLine := { number := 94, text := "" }

def line0095 : MdLine := { number := 95, text := "For each 8 bit channel independently:" }

def line0096 : MdLine := { number := 96, text := "" }

def line0097 : MdLine := { number := 97, text := "1. If value is greater than or equal to 128, the result SHALL be 255." }

def line0098 : MdLine := { number := 98, text := "2. Otherwise the result SHALL be 0." }

def line0099 : MdLine := { number := 99, text := "" }

def line0100 : MdLine := { number := 100, text := "This is the direct electronic realization of 1 bit per channel RGB." }

def line0101 : MdLine := { number := 101, text := "" }

def line0102 : MdLine := { number := 102, text := "### 6.2 Floyd-Steinberg error diffusion" }

def line0103 : MdLine := { number := 103, text := "" }

def line0104 : MdLine := { number := 104, text := "Nearest color selection among the eight DOGE colors, followed by Floyd-Steinberg error diffusion. This method preserves more perceived detail while remaining strictly within the eight pure colors." }

def line0105 : MdLine := { number := 105, text := "" }

def line0106 : MdLine := { number := 106, text := "#### 6.2.1 Algorithm selection reasoning (informative)" }

def line0107 : MdLine := { number := 107, text := "" }

def line0108 : MdLine := { number := 108, text := "Floyd-Steinberg error diffusion was selected because it is deterministic, preserves structure and edges, and remains strictly within the specified eight pure colors. Gaussian dithering instead introduces random noise drawn from a normal distribution prior to quantization. The result is more stochastic and may reduce patterned artifacts, yet it appears grainier and less sharp." }

def line0109 : MdLine := { number := 109, text := "" }

def line0110 : MdLine := { number := 110, text := "The existing design principles emphasize intentional minimalism, high contrast, pure channel values, and a clean two method structure. Adding Gaussian dithering would increase complexity without advancing the primary aims of the palette. Hard threshold remains the simple electronic baseline. Floyd-Steinberg already addresses the case of greater perceived detail." }

def line0111 : MdLine := { number := 111, text := "" }

def line0112 : MdLine := { number := 112, text := "### 6.3 Value handling" }

def line0113 : MdLine := { number := 113, text := "" }

def line0114 : MdLine := { number := 114, text := "1. Input values SHALL be clamped to the closed interval [0, 255] before either quantization method is applied." }

def line0115 : MdLine := { number := 115, text := "2. Floating point or normalized values in the range [0.0, 1.0] SHALL first be scaled by 255 and then clamped." }

def line0116 : MdLine := { number := 116, text := "3. Values outside these ranges after scaling are undefined and SHALL be rejected or clamped at the discretion of the implementer, provided the result remains within the eight specified DOGE colors." }

def line0117 : MdLine := { number := 117, text := "" }

def line0118 : MdLine := { number := 118, text := "## 7. Design principles" }

def line0119 : MdLine := { number := 119, text := "" }

def line0120 : MdLine := { number := 120, text := "1. Black (#000000) SHALL turn emissive pixels fully off." }

def line0121 : MdLine := { number := 121, text := "2. Each pure primary lights only a single subpixel channel. Each secondary lights exactly two. White lights all three." }

def line0122 : MdLine := { number := 122, text := "3. High contrast is mandatory. Soft midtones are outside the scope of this specification." }

def line0123 : MdLine := { number := 123, text := "4. The palette is intentionally minimal. Any color not listed in Clause 4 is nonconforming." }

def line0124 : MdLine := { number := 124, text := "" }

def line0125 : MdLine := { number := 125, text := "## 8. Conformance" }

def line0126 : MdLine := { number := 126, text := "" }

def line0127 : MdLine := { number := 127, text := "An implementation is DOGE conformant if and only if:" }

def line0128 : MdLine := { number := 128, text := "" }

def line0129 : MdLine := { number := 129, text := "1. All colors used are exactly those listed in Clause 4." }

def line0130 : MdLine := { number := 130, text := "2. Quantization of external color data, when performed, follows either Clause 6.1 or Clause 6.2." }

def line0131 : MdLine := { number := 131, text := "" }

def line0132 : MdLine := { number := 132, text := "Optional semantic roles (for example error = red, success = green) MAY be defined by applications but are not required by this specification." }

def line0133 : MdLine := { number := 133, text := "" }

def line0134 : MdLine := { number := 134, text := "## 9. Changelog" }

def line0135 : MdLine := { number := 135, text := "" }

def line0136 : MdLine := { number := 136, text := "### 1.0.0 - 20260730" }

def line0137 : MdLine := { number := 137, text := "" }

def line0138 : MdLine := { number := 138, text := "Defines the pure 3 bit RGB palette, the exact sRGB values, the mapping to ECMA-48 SGR parameters, the two quantization methods, design principles, and implementer conformance. Aligns document form with the Surmount spec spec (`0000_spec.md`): SemVer version line, RFC 2119 requirement keywords and citation, and local `ref/` paths for RFC 2119, ECMA-48, and ITU-T T.416 / ISO/IEC 8613-6 (`ref/itu_t416`)." }

def line0139 : MdLine := { number := 139, text := "" }

def line0140 : MdLine := { number := 140, text := "Document layout follows the Surmount spec spec whitespace rules (prose is not wrapped to a column; tab leading indent; no trailing whitespace)." }

def line0141 : MdLine := { number := 141, text := "" }

def line0142 : MdLine := { number := 142, text := "This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough." }

def line0143 : MdLine := { number := 143, text := "" }

def line0144 : MdLine := { number := 144, text := "No prior public release of this specification exists." }

def line0145 : MdLine := { number := 145, text := "" }

def line0146 : MdLine := { number := 146, text := "## 10. Copyright" }

def line0147 : MdLine := { number := 147, text := "" }

def line0148 : MdLine := { number := 148, text := "This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository." }

def line0149 : MdLine := { number := 149, text := "" }

def line0150 : MdLine := { number := 150, text := "## 11. Acknowledgments" }

def line0151 : MdLine := { number := 151, text := "" }

def line0152 : MdLine := { number := 152, text := "This specification was prepared by Hunter \"cryptoquick\" Beast with assistance and revisions from Grok. The color model builds on the classic 3 bit RGB foundation described in ECMA-48 and related terminal standards." }

def line0153 : MdLine := { number := 153, text := "" }

def line0154 : MdLine := { number := 154, text := "Credit for the clarification on Gaussian dithering goes to a good question from Wesley Parr (@rustchain64 on GitHub)." }

/-- Every physical line of the sibling markdown, including blank lines. -/
def encodedLines : Array MdLine := #[
  line0001,
  line0002,
  line0003,
  line0004,
  line0005,
  line0006,
  line0007,
  line0008,
  line0009,
  line0010,
  line0011,
  line0012,
  line0013,
  line0014,
  line0015,
  line0016,
  line0017,
  line0018,
  line0019,
  line0020,
  line0021,
  line0022,
  line0023,
  line0024,
  line0025,
  line0026,
  line0027,
  line0028,
  line0029,
  line0030,
  line0031,
  line0032,
  line0033,
  line0034,
  line0035,
  line0036,
  line0037,
  line0038,
  line0039,
  line0040,
  line0041,
  line0042,
  line0043,
  line0044,
  line0045,
  line0046,
  line0047,
  line0048,
  line0049,
  line0050,
  line0051,
  line0052,
  line0053,
  line0054,
  line0055,
  line0056,
  line0057,
  line0058,
  line0059,
  line0060,
  line0061,
  line0062,
  line0063,
  line0064,
  line0065,
  line0066,
  line0067,
  line0068,
  line0069,
  line0070,
  line0071,
  line0072,
  line0073,
  line0074,
  line0075,
  line0076,
  line0077,
  line0078,
  line0079,
  line0080,
  line0081,
  line0082,
  line0083,
  line0084,
  line0085,
  line0086,
  line0087,
  line0088,
  line0089,
  line0090,
  line0091,
  line0092,
  line0093,
  line0094,
  line0095,
  line0096,
  line0097,
  line0098,
  line0099,
  line0100,
  line0101,
  line0102,
  line0103,
  line0104,
  line0105,
  line0106,
  line0107,
  line0108,
  line0109,
  line0110,
  line0111,
  line0112,
  line0113,
  line0114,
  line0115,
  line0116,
  line0117,
  line0118,
  line0119,
  line0120,
  line0121,
  line0122,
  line0123,
  line0124,
  line0125,
  line0126,
  line0127,
  line0128,
  line0129,
  line0130,
  line0131,
  line0132,
  line0133,
  line0134,
  line0135,
  line0136,
  line0137,
  line0138,
  line0139,
  line0140,
  line0141,
  line0142,
  line0143,
  line0144,
  line0145,
  line0146,
  line0147,
  line0148,
  line0149,
  line0150,
  line0151,
  line0152,
  line0153,
  line0154]

def lineCount : Nat := encodedLines.size

end «0001_DOGE»
