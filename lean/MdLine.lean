/-
  Physical line encoding for numbered specification markdown.

  A sibling `NNNN_descriptive_name.lean` at the repository root holds
  one `MdLine` per physical line of `NNNN_descriptive_name.md` (line
  numbers start at 1, exact text, optional role). The encoding uses
  the markdown basename with `.lean` in place of `.md` so a reader
  sees the pair immediately. Those encodings are explicit Lean
  `MdLine` or `String` literals, one per physical markdown line.
  `include_str` is not a line encoding. This module is the shared type
  and the functions that split file bytes on LF.

  Numbered markdown is the contract humans read. These encodings are
  not a substitute for that markdown. This module is not a proof module.
-/

/-- One physical line of numbered specification markdown. -/
structure MdLine where
  number : Nat
  text : String
  role : Option String := none
  deriving Repr, DecidableEq, BEq, Inhabited

namespace MdLine

/-- Four digit zero padded specification number for sibling file names. -/
def pad4 (n : Nat) : String :=
  let s := toString n
  match s.length with
  | 0 => "0000"
  | 1 => "000" ++ s
  | 2 => "00" ++ s
  | 3 => "0" ++ s
  | _ => s

/--
  Sibling spec encoding file name at the repository root: the markdown
  basename with `.md` replaced by `.lean`.
-/
def siblingEncodingFileName (specFileName : String) : String :=
  if specFileName.endsWith ".md" then
    (specFileName.take (specFileName.length - 3)).copy ++ ".lean"
  else
    specFileName ++ ".lean"

/-- Proof module name (file `lean/Proofs_NNNN.lean`). -/
def siblingProofModuleName (n : Nat) : String :=
  "Proofs_" ++ pad4 n

/-- Proof file path relative to the repository root. -/
def siblingProofFileName (n : Nat) : String :=
  "lean/" ++ siblingProofModuleName n ++ ".lean"

/--
  Split on LF into physical lines.

  A POSIX text file ends in a newline. `splitOn` then yields a trailing
  empty string that is not a physical line, and that empty string is
  dropped. A file that does not end in a newline keeps its last line.
-/
def physicalLines (s : String) : List String :=
  let parts := s.splitOn "\n"
  match parts.reverse with
  | [] => []
  | "" :: rest => rest.reverse
  | _ => parts

/-- Decode bytes as one character per byte (exact LF lines, no wrap). -/
def bytesToString (bs : ByteArray) : String :=
  Id.run do
    let mut cs : Array Char := #[]
    for i in [0:bs.size] do
      cs := cs.push (Char.ofNat (bs.get! i).toNat)
    return String.ofList cs.toList

/-- One explicit line encoding: line number, exact text, optional role. -/
def ofLine (number : Nat) (text : String) (role : Option String := none) : MdLine :=
  { number, text, role }

/-- Encode file text as `MdLine` values, including blank lines. -/
def encodeFile (s : String) : Array MdLine :=
  let ls := physicalLines s
  Id.run do
    let mut out : Array MdLine := Array.mkEmpty ls.length
    let mut i : Nat := 1
    for t in ls do
      out := out.push (ofLine i t)
      i := i + 1
    return out

/-- Heading used by numbered specifications that record residual. -/
def isResidualHeading (s : String) : Bool :=
  s == "# Residual" || s == "## Residual" || s == "## 6. Residual"

def hasResidualHeading (lines : Array MdLine) : Bool :=
  lines.any fun l => isResidualHeading l.text

end MdLine
