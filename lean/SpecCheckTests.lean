/-
  Hermetic string-fixture tests for SpecCheck pure helpers.
  Exit 0 when all pass; exit 1 with FAIL lines on any failure.
-/

import SpecCheck

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

/-- Encode pure-ASCII string to ByteArray for checkFileContent. -/
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

  [
    -- Bullets
    expectNonEmpty "bullet outside fence fails" (checkBullets f bulletOut),
    expectEmpty "bullet inside fence passes" (checkBullets f bulletIn),
    -- Kebab
    expectNonEmpty "excess kebab in prose fails" (checkKebab f kebabProse),
    expectEmpty "kebab in URL passes" (checkKebab f kebabUrl),
    expectEmpty "kebab in inline code passes" (checkKebab f kebabCode),
    -- RFC 2119 (basename must be numbered)
    expectNonEmpty "missing RFC 2119 fails"
      (checkRfc2119 numbered numbered noRfc),
    expectEmpty "present RFC 2119 passes"
      (checkRfc2119 numbered numbered withRfc),
    expectEmpty "non-numbered basename skips RFC"
      (checkRfc2119 "README.md" "README.md" noRfc),
    -- Hard wrap
    expectNonEmpty "hard wrap open line fails" (checkHardWrap f wrapBad),
    expectEmpty "sentence ending with period passes wrap" (checkHardWrap f wrapOk),
    -- Trailing / leading space
    expectNonEmpty "trailing space fails" (checkTrailingWs f trail),
    expectNonEmpty "leading space fails" (checkLeadingSpaces f lead),
    expectEmpty "clean trailing ws passes" (checkTrailingWs f cleanWs),
    expectEmpty "tab leading indent passes leading-space" (checkLeadingSpaces f cleanWs),
    -- Hex / digit spelling filters
    expectTrue "isPureHexToken abcd" (isPureHexToken "abcd"),
    expectTrue "isPureHexToken 0a1B" (isPureHexToken "0a1B"),
    expectFalse "isPureHexToken single digit" (isPureHexToken "a"),
    expectFalse "isPureHexToken non-hex" (isPureHexToken "hello"),
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
        (asciiBytes "Title.\n\nKeywords from RFC 2119.\n") true true true)
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
