/-
  Runtime checks for the aspell / 0005_CATE.md catalog isomorphism.

  Theorems in VocabAspell.lean cover inverse maps, letter counts, and
  duplicate ids on finite lists. This executable re-checks those facts
  and reads both repository files under REPO_ROOT (or cwd).
  Number 0009 is Unlicense. 0009_VOCABULARY.md MUST NOT exist.
-/

import SpecCheck
import VocabAspell

open VocabAspell
open SpecCheck

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEmpty {α : Type} [Repr α] (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected empty, got {repr xs}" }

def hermeticCases : List Case :=
  [
    expectTrue "fixture well formed" (wellFormed fixtureEntries),
    expectTrue "fixture no duplicate ids" (noDupIdsBool fixtureEntries),
    expectTrue "fixture no duplicate words" (noDupWordsBool fixtureEntries),
    expectEqNat "fixture letter A count" (letterCount fixtureEntries 'A') 2,
    expectEqNat "fixture letter B count" (letterCount fixtureEntries 'B') 1,
    expectEqNat "fixture letter X count" (letterCount fixtureEntries 'X') 0,
    expectTrue "toAspell ofAspell fixture"
      (toAspell (ofAspell fixtureWords) == fixtureWords),
    expectTrue "ofAspell toAspell fixture"
      (ofAspell (toAspell fixtureEntries) == fixtureEntries),
    expectTrue "Changelog sorts before changelog"
      (cmpWord "Changelog" "changelog" == Ordering.lt),
    expectTrue "Markdown sorts before markdown"
      (cmpWord "Markdown" "markdown" == Ordering.lt),
    expectEqString "parse ABI heading"
      (match parseHeading "### A_1 `ABI`" with
       | some e => e.word
       | none => "")
      "ABI",
    expectTrue "parse ABI letter A"
      (match parseHeading "### A_1 `ABI`" with
       | some e => e.letter == 'A' && e.index == 1
       | none => false),
    expectTrue "fence example is not an entry line"
      (parseHeading "An example that matches is the heading for entry A_1 whose token is ABI." == none),
    expectTrue "malformed heading rejected"
      (parseHeading "### A_1 ABI" == none),
    expectTrue "header 210 parses"
      (parseAspellHeader "personal_ws-1.1 en 210" == some 210),
    expectEqString "runtime catalog is 0005_CATE.md"
      vocabMarkdownFileName "0005_CATE.md",
    expectTrue "CATE number equals vocabulary ownership"
      (specFileName == "0005_CATE.md" && specNumber == 5),
    expectTrue "runtime catalog is not the pointer"
      (vocabMarkdownFileName != pointerFileName)
  ]

def firstMismatch : List String → List String → Nat → Option (Nat × String × String)
  | [], [], _ => none
  | x :: xr, y :: yr, i =>
    if x != y then some (i, x, y) else firstMismatch xr yr (i + 1)
  | x :: _, [], i => some (i, x, "<end>")
  | [], y :: _, i => some (i, "<end>", y)

def ordName : Ordering → String
  | .lt => "lt"
  | .eq => "eq"
  | .gt => "gt"

def firstUnsorted : List String → Option (String × String × String)
  | a :: b :: rest =>
    match cmpWord a b with
    | .lt => firstUnsorted (b :: rest)
    | o => some (a, b, ordName o)
  | _ => none

def letterHistogram (es : List VocabEntry) : List (Char × Nat) :=
  Id.run do
    let mut out : List (Char × Nat) := []
    for code in [65:91] do
      let L := Char.ofNat code
      let n := letterCount es L
      if n > 0 then
        out := out ++ [(L, n)]
    return out

def formatHistogram (h : List (Char × Nat)) : String :=
  String.intercalate ", " (h.map fun p => s!"{p.1}:{p.2}")

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def diagCases (diags : List Diag) : List Case :=
  diags.map fun d =>
    { name := Diag.format d, ok := false, detail := d.message }

def checkIsoFiles (repo : System.FilePath) : IO (List Case) := do
  let vocabPath := repo / vocabMarkdownFileName
  let pointerPath := repo / pointerFileName
  let aspellPath := repo / "aspell_words.txt"
  let withdrawnPath := repo / "0009_VOCABULARY.md"
  if (← withdrawnPath.pathExists) then
    return [{
      name := "0009_VOCABULARY.md must not exist"
      ok := false
      detail := s!"withdrawn file still present at {withdrawnPath}"
    }]
  if !(← vocabPath.pathExists) then
    return [{
      name := "0005_CATE.md exists"
      ok := false
      detail := s!"missing {vocabPath}"
    }]
  if !(← pointerPath.pathExists) then
    return [{
      name := "VOCABULARY.md pointer exists"
      ok := false
      detail := s!"missing {pointerPath}"
    }]
  if !(← aspellPath.pathExists) then
    return [{
      name := "aspell_words.txt exists"
      ok := false
      detail := s!"missing {aspellPath}"
    }]
  let vocabBs ← IO.FS.readBinFile vocabPath
  let aspellBs ← IO.FS.readBinFile aspellPath
  let formDiags :=
    checkAscii vocabMarkdownFileName vocabBs ++
      (if isPureAscii vocabBs then
        let content := asciiToString vocabBs
        checkTrailingWs vocabMarkdownFileName content ++
          checkLeadingSpaces vocabMarkdownFileName content ++
          checkBullets vocabMarkdownFileName content ++
          checkLeftoverUnstack vocabMarkdownFileName content
       else [])
  if !formDiags.isEmpty then
    return diagCases formDiags
  let vocab := asciiToString vocabBs
  let aspell := asciiToString aspellBs
  match parseAspellFile aspell with
  | .error msg =>
    return [{ name := "parse aspell_words.txt", ok := false, detail := msg }]
  | .ok (headerCount, words) =>
    match parseVocabEntries vocab with
    | .error (ln, msg) =>
      return [{
        name := s!"{vocabMarkdownFileName}:{ln}"
        ok := false
        detail := msg
      }]
    | .ok entries =>
      let mut cases : List Case := []
      cases := cases ++ [
        expectTrue "withdrawn 0009_VOCABULARY.md is absent" true,
        expectEqNat "aspell header count equals word count"
          headerCount words.length,
        expectTrue "every aspell token has a letter"
          (allHaveLetters words),
        (match firstUnsorted words with
         | none =>
           expectTrue "aspell tokens sorted (folded ASCII then ASCII)" true
         | some (a, b, o) =>
           {
             name := "aspell tokens sorted (folded ASCII then ASCII)"
             ok := false
             detail := s!"{a} then {b} compares {o}"
           }),
        (match firstUnsorted (toAspell entries) with
         | none =>
           expectTrue "vocabulary entries well formed" (wellFormed entries)
         | some (a, b, o) =>
           {
             name := "vocabulary entries well formed"
             ok := false
             detail := s!"{a} then {b} compares {o}; wellFormed={wellFormed entries}"
           }),
        expectTrue "no duplicate L_n ids" (noDupIdsBool entries),
        expectTrue "no duplicate vocabulary words" (noDupWordsBool entries),
        expectTrue "ids consecutive per letter"
          (idsConsecutiveGo none 0 entries),
        expectEqNat "entry count equals aspell count"
          entries.length words.length
      ]
      let gotWords := toAspell entries
      let assignedEntries := ofAspell words
      if gotWords != words then
        match firstMismatch gotWords words 1 with
        | some (i, g, w) =>
          cases := cases ++ [{
            name := "toAspell entries = aspell words"
            ok := false
            detail := s!"first mismatch at {i}: vocabulary {g} vs aspell {w}"
          }]
        | none =>
          cases := cases ++ [
            expectTrue "toAspell entries = aspell words" false
          ]
      else
        cases := cases ++ [
          expectTrue "toAspell entries = aspell words" true
        ]
      if assignedEntries != entries then
        cases := cases ++ [{
          name := "ofAspell words = vocabulary entries"
          ok := false
          detail := "assigned ids do not match 0005_CATE.md headings"
        }]
      else
        cases := cases ++ [
          expectTrue "ofAspell words = vocabulary entries" true
        ]
      let beastdbOk :=
        entries.all fun e =>
          if e.word.toList.map toLowerAscii == "beastdb".toList then
            e.word == "beastdb"
          else
            true
      cases := cases ++ [
        expectTrue "beastdb stays lowercase" beastdbOk
      ]
      let letters := nonemptyLetters entries
      let headings := parseLetterHeadings vocab
      cases := cases ++ [
        expectTrue "letter headings match nonempty letters"
          (headings == letters)
      ]
      let hist := letterHistogram entries
      cases := cases ++ [
        expectTrue s!"letter histogram {formatHistogram hist}" true
      ]
      return cases

def reportCases (cs : List Case) : IO Nat := do
  let mut failed : Nat := 0
  for c in cs do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  return failed

def main (_args : List String) : IO UInt32 := do
  let repo ← resolveRepoRoot
  let fileCases ← checkIsoFiles repo
  let allCases := hermeticCases ++ fileCases
  let failed ← reportCases allCases
  if failed == 0 then
    IO.println s!"All {allCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {allCases.length} tests failed."
    return 1
