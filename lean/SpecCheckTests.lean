/-
  Hermetic string fixture tests for SpecCheck pure helpers.
  Exit 0 when all pass; exit 1 with FAIL lines on any failure.
-/

import SpecCheck
import Cate

open SpecCheck

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectEmpty (name : String) (diags : List Diag) : Case :=
  if diags.isEmpty then
    { name := name, ok := true }
  else
    let msgs := diags.map Diag.format
    { name := name, ok := false, detail := String.intercalate "; " msgs }

def expectNonEmpty (name : String) (diags : List Diag) : Case :=
  if diags.isEmpty then
    { name := name, ok := false, detail := "expected diagnostics, got none" }
  else
    { name := name, ok := true }

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectSomeLine (name : String) (got : Option Nat) (want : Nat) : Case :=
  match got with
  | some n =>
    if n == want then
      { name := name, ok := true }
    else
      { name := name, ok := false, detail := s!"expected line {want}, got {n}" }
  | none =>
    { name := name, ok := false, detail := s!"expected line {want}, got none" }

def expectNone (name : String) (got : Option Nat) : Case :=
  match got with
  | none => { name := name, ok := true }
  | some n => { name := name, ok := false, detail := s!"expected none, got {n}" }

/-- Encode pure ASCII string to ByteArray for checkFileContent. -/
def asciiBytes (s : String) : ByteArray :=
  Id.run do
    let mut ba := ByteArray.empty
    for c in s.toList do
      ba := ba.push (UInt8.ofNat c.toNat)
    return ba

def runCases : List Case :=
  let f := "fixture.md"
  let numbered := "0001_fixture.md"
  -- Bullets
  let bulletOut := "- item outside fence\n"
  let bulletIn := "```\n- item inside fence\n```\n"
  -- Kebab
  let kebabProse := "This uses too-many-hyphens in prose.\n"
  let kebabUrl := "See https://example.com/too-many-hyphens/path for detail.\n"
  let kebabCode := "Use `too-many-hyphens` as a code token.\n"
  -- RFC 2119
  let noRfc := "A numbered-style doc without the required citation.\n"
  let withRfc := "This document uses keywords from RFC 2119.\n"
  -- Hard wrap
  let wrapBad := "This line does not end a sentence\nand continues lowercase on the next line.\n"
  let wrapOk := "This line ends a sentence.\nNext line starts a new sentence.\n"
  -- Trailing / leading space
  let trail := "line with trailing space \n"
  let lead := " space-indented line\n"
  let cleanWs := "no trailing\n\tok tab indent\n"
  -- CATE leftover unstack
  let leftoverNonMd := "Do not write non markdown tooling.\n"
  let leftoverMustLike := "Do not write must like wording.\n"
  let leftoverLfOnly := "Files SHALL use line endings that are LF only (no CR).\n"
  let leftoverLockFree := "Do not write lock free tries as the fix.\n"
  let leftoverTypeChecking := "Do not write fully type checking Slake.\n"
  let leftoverInFence := "```\nnon markdown\nmust like\nLF only\nlock free tries\nfully type checking\n```\n"
  let leftoverInCode := "Say `non markdown` and `LF only` as bad examples.\n"
  let leftoverAllowed := "This uses high assurance, 3 bit color, and time series access.\n"

  [
    -- Bullets
    expectNonEmpty "bullet outside fence fails" (checkBullets f bulletOut),
    expectEmpty "bullet inside fence passes" (checkBullets f bulletIn),
    -- Kebab
    expectNonEmpty "excess hyphenated token in prose fails" (checkKebab f kebabProse),
    expectEmpty "hyphenated token in URL passes" (checkKebab f kebabUrl),
    expectEmpty "hyphenated token in inline code passes" (checkKebab f kebabCode),
    -- RFC 2119 (basename must be numbered)
    expectNonEmpty "missing RFC 2119 fails"
      (checkRfc2119 numbered numbered noRfc),
    expectEmpty "present RFC 2119 passes"
      (checkRfc2119 numbered numbered withRfc),
    expectEmpty "basename that is not numbered skips RFC"
      (checkRfc2119 "README.md" "README.md" noRfc),
    -- Hard wrap
    expectNonEmpty "open line wrapped to a column fails" (checkHardWrap f wrapBad),
    expectEmpty "sentence ending with period passes wrap" (checkHardWrap f wrapOk),
    -- Trailing / leading space
    expectNonEmpty "trailing space fails" (checkTrailingWs f trail),
    expectNonEmpty "leading space fails" (checkLeadingSpaces f lead),
    expectEmpty "clean trailing ws passes" (checkTrailingWs f cleanWs),
    expectEmpty "tab leading indent passes leading space" (checkLeadingSpaces f cleanWs),
    -- Hex / digit spelling filters
    expectTrue "isPureHexToken abcd" (isPureHexToken "abcd"),
    expectTrue "isPureHexToken 0a1B" (isPureHexToken "0a1B"),
    expectFalse "isPureHexToken single digit" (isPureHexToken "a"),
    expectFalse "isPureHexToken non hex" (isPureHexToken "hello"),
    expectTrue "isPureDigitToken 42" (isPureDigitToken "42"),
    expectFalse "isPureDigitToken empty" (isPureDigitToken ""),
    expectFalse "isPureDigitToken mixed" (isPureDigitToken "12a"),
    -- firstLineOfSubstring (spelling line helper)
    expectSomeLine "firstLineOfSubstring finds word"
      (firstLineOfSubstring "alpha\nbeta gamma\n" "gamma") 2,
    expectNone "firstLineOfSubstring missing"
      (firstLineOfSubstring "alpha\nbeta\n" "zzz"),
    -- checkFileContent smoke (numbered full style)
    expectNonEmpty "checkFileContent bullet full style"
      (checkFileContent numbered numbered (asciiBytes bulletOut) true true true),
    expectEmpty "checkFileContent clean numbered with RFC"
      (checkFileContent numbered numbered
        (asciiBytes "Title.\n\nKeywords from RFC 2119.\n") true true true),
    -- CATE leftover unstack
    expectNonEmpty "leftover unstack non markdown fails"
      (checkLeftoverUnstack f leftoverNonMd),
    expectNonEmpty "leftover unstack must like fails"
      (checkLeftoverUnstack f leftoverMustLike),
    expectNonEmpty "leftover unstack LF only fails"
      (checkLeftoverUnstack f leftoverLfOnly),
    expectNonEmpty "leftover unstack lock free tries fails"
      (checkLeftoverUnstack f leftoverLockFree),
    expectNonEmpty "leftover unstack fully type checking fails"
      (checkLeftoverUnstack f leftoverTypeChecking),
    expectEmpty "leftover unstack inside fence passes"
      (checkLeftoverUnstack f leftoverInFence),
    expectEmpty "leftover unstack in inline code passes"
      (checkLeftoverUnstack f leftoverInCode),
    expectEmpty "high assurance 3 bit time series pass leftover unstack"
      (checkLeftoverUnstack f leftoverAllowed),
    expectEmpty "fully typechecks is not leftover unstack"
      (checkLeftoverUnstack f
        "bootstrapped Slake that fully typechecks as required.\n"),
    expectEmpty "lock free without tries is not leftover unstack"
      (checkLeftoverUnstack f "do not write lock free as a leftover pair.\n"),
    expectTrue "leftover unstack list is Cate.leftoverUnstackPhrases"
      (leftoverUnstackPhrases == Cate.leftoverUnstackPhrases),
    expectNonEmpty "checkFileContent leftover unstack full style"
      (checkFileContent numbered numbered (asciiBytes leftoverNonMd) true true true),
    -- Keagan / proofofkeags back linking
    expectNonEmpty "Keagan without proofofkeags.com fails"
      (checkKeaganBacklink numbered numbered
        "Inspired by Keagan McLelland (Proof of Keags).\n"),
    expectNonEmpty "proofofkeags without .com fails"
      (checkKeaganBacklink numbered numbered
        "See proofofkeags essays without a site link.\n"),
    expectEmpty "Keagan with proofofkeags.com passes"
      (checkKeaganBacklink numbered numbered
        "Inspired by Keagan. See https://proofofkeags.com/research/x.html\n"),
    expectEmpty "no Keagan mention skips backlink"
      (checkKeaganBacklink numbered numbered
        "This document uses keywords from RFC 2119.\n"),
    expectEmpty "basename that is not numbered skips Keagan backlink"
      (checkKeaganBacklink "README.md" "README.md"
        "Inspired by Keagan McLelland (Proof of Keags).\n"),
    expectNonEmpty "checkFileContent Keagan without URL full style"
      (checkFileContent numbered numbered
        (asciiBytes "Title.\n\nKeywords from RFC 2119.\n\nInspired by Keagan.\n")
        true true true),
    expectEmpty "checkFileContent Keagan with URL and RFC"
      (checkFileContent numbered numbered
        (asciiBytes "Title.\n\nKeywords from RFC 2119.\n\nInspired by Keagan. See https://proofofkeags.com/x .\n")
        true true true)
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
