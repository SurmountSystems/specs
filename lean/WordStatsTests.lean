/-
  Hermetic tests for unique English word tracking.
  Observe fail on tokenizer, proven set, and percent contracts.
  Exit 1 on FAIL.
-/

import WordStats
import VocabAspell
import SpecRegistry

open WordStats

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

def tokensOf (s : String) : List String :=
  (tokenizeString s).toList

def fixtureCatalog : List String :=
  ["ABI", "beastdb", "LanguageID"]

def fixtureTokens : Array String :=
  tokenizeString "The ABI and beastdb SHALL use LanguageID. RFC 2119 must not invent 0005."

def fixtureStats : Stats :=
  statsOf ["0005_CATE.md", "README.md"] fixtureTokens fixtureCatalog

def runCases : List Case :=
  let proven := provenWords fixtureCatalog
  let hello := tokensOf "Hello, RFC 2119 and beastdb."
  let lang := tokensOf "LanguageID"
  let specCheck := tokensOf "spec_check"
  let hyphen := tokensOf "self-improving"
  [
    expectEqString "report file is WORD_STATS.md"
      reportFileName "WORD_STATS.md",
    expectEqNat "extra markdown files are four"
      extraMarkdownFileNames.length 4,
    expectTrue "extra markdown list matches honesty scan list"
      (extraMarkdownFileNames == SpecRegistry.extraHonestyMarkdownFileNames),
    expectEqNat "RFC 2119 letter token count"
      rfc2119LetterTokens.length 7,
    expectTrue "RFC 2119 tokens are sorted"
      (VocabAspell.wordsSortedList rfc2119LetterTokens),
    expectEqString "fold ABI"
      (foldWord "ABI") "abi",
    expectEqString "fold LanguageID"
      (foldWord "LanguageID") "languageid",
    expectEqString "fold RFC"
      (foldWord "RFC") "rfc",
    expectTrue "hello tokenizes to lowercase words"
      (hello == ["hello", "rfc", "and", "beastdb"]),
    expectTrue "LanguageID stays one letter token"
      (lang == ["languageid"]),
    expectTrue "beastdb stays one token"
      (tokensOf "beastdb" == ["beastdb"]),
    expectTrue "underscore breaks spec_check"
      (specCheck == ["spec", "check"]),
    expectTrue "hyphen breaks self-improving"
      (hyphen == ["self", "improving"]),
    expectTrue "digits are not words"
      (tokensOf "2119 0005" == []),
    expectTrue "empty string has no tokens"
      (tokensOf "" == []),
    expectTrue "catalog ABI is proven as abi"
      (containsSorted proven "abi"),
    expectTrue "catalog beastdb is proven"
      (containsSorted proven "beastdb"),
    expectTrue "catalog LanguageID is proven as languageid"
      (containsSorted proven "languageid"),
    expectTrue "RFC 2119 shall is proven without a catalog row"
      (containsSorted proven "shall"),
    expectTrue "RFC 2119 must is proven"
      (containsSorted proven "must"),
    expectTrue "RFC 2119 may is proven"
      (containsSorted proven "may"),
    expectFalse "ordinary not is not a requirement keyword"
      (containsSorted proven "not"),
    expectFalse "the is not proven"
      (containsSorted proven "the"),
    expectEqNat "percent 2 of 3 is 66.67"
      (percentHundredths 2 3) 6667,
    expectEqString "format 66.67 percent"
      (formatPercent 6667) "66.67%",
    expectEqNat "percent 1 of 2 is 50.00"
      (percentHundredths 1 2) 5000,
    expectEqNat "percent of zero total is 0"
      (percentHundredths 1 0) 0,
    expectEqNat "fixture unique count" fixtureStats.uniqueCount 11,
    expectTrue "fixture unique words include the"
      (fixtureStats.counts.any (fun p => p.1 == "the" && p.2 == 1)),
    expectTrue "fixture unique words include shall"
      (fixtureStats.counts.any (fun p => p.1 == "shall" && p.2 == 1)),
    expectTrue "fixture beastdb count is one"
      (fixtureStats.counts.any (fun p => p.1 == "beastdb" && p.2 == 1)),
    expectEqNat "fixture occurrence count" fixtureStats.occurrenceCount 11,
    expectEqNat "fixture proven unique count" fixtureStats.provenUniqueCount 5,
    expectEqNat "fixture proven occurrence count" fixtureStats.provenOccurrenceCount 5,
    expectTrue "fixture unique percent is in range"
      (uniquePercentHundredths fixtureStats > 0
        && uniquePercentHundredths fixtureStats ≤ 10000),
    expectTrue "stale report does not match"
      (!reportMatches "old\n" (renderReport fixtureStats)),
    expectTrue "rendered report matches itself"
      (reportMatches (renderReport fixtureStats) (renderReport fixtureStats)),
    expectTrue "rendered report names unique word count"
      (!(((renderReport fixtureStats).splitOn "Unique word count:").length == 1)),
    expectTrue "rendered report names percent by prevalence"
      (!(((renderReport fixtureStats).splitOn "Percent by prevalence:").length == 1)),
    expectEqNat "fixture proven set is catalog plus RFC 2119"
      (provenWords fixtureCatalog).length 10,
    expectEqNat "Markdown and markdown collapse when folded"
      (provenWords ["Markdown", "markdown", "ABI"]).length 9,
    expectEqNat "folded catalog unique for that pair is two"
      (foldedCatalogWords ["Markdown", "markdown", "ABI"]).length 2,
    expectTrue "insertSorted dedups"
      (insertSorted ["may", "shall"] "may" == ["may", "shall"]),
    expectTrue "parse catalog headings"
      (match catalogTokensFromMarkdown
          "## A\n\n### A_1 `ABI`\n\n### B_1 `beastdb`\n" with
       | .ok ws => ws == ["ABI", "beastdb"]
       | .error _ => false)
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
