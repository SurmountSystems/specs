/-
  Hermetic tests for isomorphism of markdown lines and Lean encodings.
  Observe fail on drift, pass when lines match. Exit 1 on FAIL.
-/

import MdLine
import LineEncodings

open MdLine
open LineEncodings

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEmpty {α : Type} [Repr α] (name : String) (xs : Array α) : Case :=
  if xs.isEmpty then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected empty, got {repr xs.toList}" }

def expectNonEmpty {α : Type} (name : String) (xs : Array α) : Case :=
  if xs.isEmpty then
    { name := name, ok := false, detail := "expected diagnostics, got none" }
  else
    { name := name, ok := true }

def posixTwoLines : String := "alpha\nbeta\n"

def posixTwoLinesBlank : String := "alpha\n\nbeta\n"

def sampleIncludeStrSource : String :=
  "import MdLine\n" ++
    "def encodedLines := include_str \"0001_DOGE.md\"\n"

def runCases : List Case :=
  let enc := encodeFile posixTwoLines
  let encBlank := encodeFile posixTwoLinesBlank
  let includeStrLines := includeStrLineNumbers sampleIncludeStrSource
  let includeStrFindings :=
    findingsForIncludeStr "0001_DOGE.lean" sampleIncludeStrSource
  [
    expectEqString "pad4 of 0 is 0000" (pad4 0) "0000",
    expectEqString "pad4 of 8 is 0008" (pad4 8) "0008",
    expectEqString "pad4 of 10 is 0010" (pad4 10) "0010",
    expectEqString "sibling encoding name for 0000_spec.md"
      (siblingEncodingFileName "0000_spec.md") "0000_spec.lean",
    expectEqString "sibling encoding name for 0010_Surmount_Systems.md"
      (siblingEncodingFileName "0010_Surmount_Systems.md") "0010_Surmount_Systems.lean",
    expectEqString "proof module name for 8"
      (siblingProofModuleName 8) "Proofs_0008",
    expectEqString "proof file name for 8"
      (siblingProofFileName 8) "lean/Proofs_0008.lean",
    expectEqNat "POSIX two lines count" enc.size 2,
    expectEqNat "first line number starts at 1" (enc[0]!).number 1,
    expectEqString "first line text" (enc[0]!).text "alpha",
    expectEqString "second line text" (enc[1]!).text "beta",
    expectEqNat "blank line is encoded" encBlank.size 3,
    expectEqString "middle blank line text" (encBlank[1]!).text "",
    expectTrue "matching lines hold iso"
      (isoHolds enc enc),
    expectEmpty "matching lines have no drift"
      (findDrift enc enc),
    expectNonEmpty "markdown longer than encoding is missing encoding"
      (findDrift (encodeFile "a\nb\nc\n") (encodeFile "a\nb\n")),
    expectNonEmpty "encoding longer than markdown is extra encoding"
      (findDrift (encodeFile "a\nb\n") (encodeFile "a\nb\nc\n")),
    expectNonEmpty "text mismatch is drift"
      (findDrift (encodeFile "a\nb\n") (encodeFile "a\nB\n")),
    expectTrue "iso fails on mismatch"
      (!isoHolds (encodeFile "a\n") (encodeFile "b\n")),
    expectTrue "file with only a newline is one blank line"
      ((encodeFile "\n").size == 1 && (encodeFile "\n")[0]!.text == ""),
    expectEqNat "empty file has zero lines" (encodeFile "").size 0,
    expectTrue "residual heading detected"
      (hasResidualHeading (encodeFile "# Title\n\n## 6. Residual\n")),
    expectFalse "no residual heading"
      (hasResidualHeading (encodeFile "# Title\n")),
    expectTrue "conforming sibling flags"
      (siblingFlagsConform
        { specNumber := 1
          specFileName := "0001_DOGE.md"
          siblingEncodingFileName := "0001_DOGE.lean"
          proofModuleName := "Proofs_0001"
          markedAsSpecEncoding := true
          markedAsProof := false
          lines := #[] }),
    expectFalse "mashed sibling flags do not conform"
      (siblingFlagsConform
        { specNumber := 1
          specFileName := "0001_DOGE.md"
          siblingEncodingFileName := "0001_DOGE.lean"
          proofModuleName := "Proofs_0001"
          markedAsSpecEncoding := true
          markedAsProof := true
          lines := #[] }),
    expectTrue "ofLine without role"
      (MdLine.ofLine 1 "alpha" == { number := 1, text := "alpha", role := none }),
    expectTrue "ofLine with role"
      (MdLine.ofLine 2 "beta" (some "heading") ==
        { number := 2, text := "beta", role := some "heading" }),
    expectTrue "explicit ofLine encodings hold iso with encodeFile"
      (isoHolds enc #[MdLine.ofLine 1 "alpha", MdLine.ofLine 2 "beta"]),
    expectTrue "include_str in sibling source is nonconforming"
      (containsIncludeStr
        "def encodedLines := MdLine.encodeFile (include_str \"0001_DOGE.md\")"),
    expectFalse "explicit MdLine literals are not include_str"
      (containsIncludeStr
        "def encodedLines : Array MdLine := #[{ number := 1, text := \"hi\" }]"),
    expectFalse "include_str in a block comment is not a use"
      (containsIncludeStr
        ("/-\n" ++
          "  explicit Lean MdLine value. This module does not use include_str.\n" ++
          "-/\n" ++
          "def encodedLines : Array MdLine := #[{ number := 1, text := \"hi\" }]\n")),
    expectFalse "include_str in a line comment is not a use"
      (containsIncludeStr
        "def encodedLines : Array MdLine := #[] -- include_str is not a line encoding\n"),
    expectFalse "include_str inside a string literal is not a use"
      (containsIncludeStr
        "def encodedLines : Array MdLine := #[{ number := 1, text := \"include_str is not a line encoding\" }]\n"),
    expectEqNat "include_str line count is 1"
      includeStrLines.size
      1,
    expectEqNat "include_str is on line 2"
      (if includeStrLines.isEmpty then 0 else includeStrLines[0]!)
      2,
    expectNonEmpty "include_str finding is present"
      includeStrFindings,
    expectEqString "include_str finding path"
      (if includeStrFindings.isEmpty then "" else includeStrFindings[0]!.path)
      "0001_DOGE.lean",
    expectEqNat "include_str finding line"
      (if includeStrFindings.isEmpty then 0 else includeStrFindings[0]!.line)
      2,
    expectEqString "include_str finding names the rule"
      (if includeStrFindings.isEmpty then "" else includeStrFindings[0]!.message)
      includeStrFindingMessage,
    expectTrue "source without include_str has no include_str findings"
      (findingsForIncludeStr "0001_DOGE.lean"
        "def encodedLines : Array MdLine := #[{ number := 1, text := \"a\" }]\n").isEmpty,
    expectTrue "spec_check leftover unstack list is Cate"
      leftoverUnstackPhrasesAreCate,
    expectEqNat "thirteen meaning spec encoding comment paths"
      meaningSpecEncodingRelPaths.size
      13,
    expectTrue "UnlicenseSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/UnlicenseSpec.lean"),
    expectTrue "FormalVibeficationSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/FormalVibeficationSpec.lean"),
    expectTrue "VocabularySpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/VocabularySpec.lean"),
    expectTrue "Vocabulary collision encodings are a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/Vocabulary.lean"),
    expectTrue "TechTreeSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/TechTreeSpec.lean"),
    expectTrue "MemexSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/MemexSpec.lean"),
    expectTrue "CateSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/CateSpec.lean"),
    expectTrue "RsiSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/RsiSpec.lean"),
    expectTrue "CiSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/CiSpec.lean"),
    expectTrue "BeastDbSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/BeastDbSpec.lean"),
    expectTrue "SssssSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/SssssSpec.lean"),
    expectTrue "SystemsLeanSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/SystemsLeanSpec.lean"),
    expectTrue "LeanMachineSpec is a meaning spec encoding path"
      (meaningSpecEncodingRelPaths.toList.contains "lean/LeanMachineSpec.lean"),
    expectNonEmpty "leftover unstack in encodedLines prose fails"
      (findingsForLeftoverUnstackEncoded "0001_DOGE.md"
        (encodeFile "Do not write non markdown tooling.\n")),
    expectEmpty "leftover unstack in encodedLines fence passes"
      (findingsForLeftoverUnstackEncoded "0005_CATE.md"
        (encodeFile "```\nnon markdown\nmust like\nLF only\nlock free tries\nfully type checking\n```\n")),
    expectEmpty "leftover unstack in encodedLines inline code passes"
      (findingsForLeftoverUnstackEncoded "0000_spec.md"
        (encodeFile "Say `non markdown` and `LF only` as bad examples.\n")),
    expectEmpty "high assurance 3 bit time series pass encodedLines leftover unstack"
      (findingsForLeftoverUnstackEncoded "0003_beastdb.md"
        (encodeFile "This uses high assurance, 3 bit color, and time series access.\n")),
    expectNonEmpty "leftover unstack in spec encoding block comments fails"
      (findingsForLeftoverUnstackComments "lean/FormalVibeficationSpec.lean"
        ("/-\n" ++
          "  Do not write non markdown tooling.\n" ++
          "-/\n" ++
          "def specNumber : Nat := 8\n")),
    expectNonEmpty "leftover unstack in spec encoding line comments fails"
      (findingsForLeftoverUnstackComments "lean/VocabularySpec.lean"
        "def specNumber : Nat := 5 -- must like wording is leftover unstack\n"),
    expectEmpty "leftover unstack in Lean string is not a comment hit"
      (findingsForLeftoverUnstackComments "lean/FormalVibeficationSpec.lean"
        "def leftoverUnstackPhrases := [\"non markdown\"]\n"),
    expectEmpty "leftover unstack in inline code inside comments passes"
      (findingsForLeftoverUnstackComments "lean/VocabularySpec.lean"
        "/-\n  Say `non markdown` as a bad example.\n-/\n"),
    expectNonEmpty "never-real product claim in encodedLines prose fails"
      (findingsForNeverRealProductEncoded "0013_Lean_Machine.md"
        (encodeFile "A conforming Lean Machine does not exist.\n")),
    expectEmpty "honesty BAN in encodedLines is allowed"
      (findingsForNeverRealProductEncoded "0003_beastdb.md"
        (encodeFile "Authors MUST NOT write that beastdb never started or does not exist.\n")),
    expectEmpty "not claimed to exist in encodedLines is allowed"
      (findingsForNeverRealProductEncoded "0013_Lean_Machine.md"
        (encodeFile "A conforming Lean Machine is not claimed to exist.\n")),
    expectNonEmpty "never-real product claim in spec encoding comments fails"
      (findingsForNeverRealProductComments "lean/LeanMachineSpec.lean"
        ("/-\n" ++
          "  A conforming Lean Machine does not exist.\n" ++
          "-/\n" ++
          "def specNumber : Nat := 13\n")),
    expectEmpty "honesty BAN in spec encoding comments is allowed"
      (findingsForNeverRealProductComments "lean/BeastDbSpec.lean"
        "/-\n  Authors MUST NOT write that beastdb never started or does not exist.\n-/\n"),
    expectEmpty "never-real phrase in Lean string is not a comment hit"
      (findingsForNeverRealProductComments "lean/LeanMachineSpec.lean"
        "def neverReal := \"A conforming Lean Machine does not exist\"\n"),
    expectTrue "keepLeanComments keeps block comment body"
      (((keepLeanComments
          "/-\n  hello leftover\n-/\ndef x := 1\n").splitOn "hello leftover").length > 1),
    expectTrue "keepLeanComments blanks Lean code"
      (!(((keepLeanComments
          "/-\n  comment\n-/\ndef non markdown := 1\n").splitOn "def non markdown").length > 1))
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  if failed == 0 then
    IO.println s!"All {runCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {runCases.length} tests failed."
    return 1
