/-
  Unique English word tracking for Surmount authored markdown.

  Tokens are ASCII letters only, folded A-Z to a-z. Digits are not
  words. beastdb is one token. RFC folds to rfc.

  Proven tokens are lowercased CATE L_n catalog entries from
  0005_CATE.md, plus RFC 2119 requirement keywords already named in
  0000_spec.md Clause 4.1 and 0005_CATE.md Clause 3.9. That is not a
  second CATE catalog. CATE owns domain words. RFC 2119 owns those
  requirement keywords.

  This module is tracking. It is not a proof that every English
  sentence is CATE. Leftover unstack remains a separate floor.
  Lean comments are not in the scan.

  Number 0009 is withdrawn. This module is not ISO 24495.
-/

import VocabAspell
import SpecCheck
import SpecRegistry

namespace WordStats

/-- Human report at the repository root. Not a numbered specification. -/
def reportFileName : String := "WORD_STATS.md"

theorem report_file_is_word_stats_md : reportFileName = "WORD_STATS.md" :=
  rfl

/-- Extra Surmount authored markdown besides root numbered specifications. -/
def extraMarkdownFileNames : List String :=
  ["AGENTS.md", "README.md", "RESIDUAL.md", "VOCABULARY.md"]

theorem extra_files_are_four : extraMarkdownFileNames.length = 4 :=
  rfl

/--
  RFC 2119 requirement keywords as lowercased letter tokens.
  MUST NOT, SHALL NOT, and SHOULD NOT contribute must, shall, should.
  The word not is ordinary English and is not a requirement keyword.
  This list is not a second CATE catalog.
-/
def rfc2119LetterTokens : List String :=
  ["may", "must", "optional", "recommended", "required", "shall", "should"]

theorem rfc2119_token_count : rfc2119LetterTokens.length = 7 :=
  rfl

def foldWord (w : String) : String :=
  String.ofList (w.toList.map VocabAspell.toLowerAscii)

def ltWord (a b : String) : Bool :=
  match VocabAspell.cmpWord a b with
  | Ordering.lt => true
  | _ => false

def insertSorted (xs : List String) (w : String) : List String :=
  match xs with
  | [] => [w]
  | x :: rest =>
    match VocabAspell.cmpWord w x with
    | Ordering.lt => w :: xs
    | Ordering.eq => xs
    | Ordering.gt => x :: insertSorted rest w

/-- Case-folded catalog tokens, duplicates removed. -/
def foldedCatalogWords (catalogTokens : List String) : List String :=
  (catalogTokens.map foldWord).foldl insertSorted []

/-- Proven set: folded CATE catalog tokens union RFC 2119 keywords. -/
def provenWords (catalogTokens : List String) : List String :=
  (foldedCatalogWords catalogTokens).foldl insertSorted rfc2119LetterTokens

def isAsciiLetterByte (b : UInt8) : Bool :=
  let n := b.toNat
  (65 ≤ n && n ≤ 90) || (97 ≤ n && n ≤ 122)

def lowerAsciiByte (b : UInt8) : Char :=
  let n := b.toNat
  if 65 ≤ n && n ≤ 90 then
    Char.ofNat (n + 32)
  else
    Char.ofNat n

/-- ASCII [A-Za-z]+ folded to lowercase. Non-letter bytes break tokens. -/
def tokenizeBytes (bs : ByteArray) : Array String :=
  Id.run do
    let mut buf : Array Char := #[]
    let mut acc : Array String := #[]
    for i in [0:bs.size] do
      let b := bs.get! i
      if isAsciiLetterByte b then
        buf := buf.push (lowerAsciiByte b)
      else if buf.size != 0 then
        acc := acc.push (String.ofList buf.toList)
        buf := #[]
    if buf.size != 0 then
      acc := acc.push (String.ofList buf.toList)
    return acc

def tokenizeString (s : String) : Array String :=
  tokenizeBytes s.toUTF8

def insertAt
    (entries : Array (String × Nat)) (i : Nat) (p : String × Nat) :
    Array (String × Nat) :=
  Id.run do
    let mut out : Array (String × Nat) := #[]
    let mut j := 0
    while j < entries.size do
      if j == i then
        out := out.push p
      out := out.push entries[j]!
      j := j + 1
    if i == entries.size then
      out := out.push p
    return out

def setAt {α} [Inhabited α] (a : Array α) (i : Nat) (v : α) : Array α :=
  Id.run do
    let mut out : Array α := #[]
    let mut j := 0
    while j < a.size do
      if j == i then
        out := out.push v
      else
        out := out.push a[j]!
      j := j + 1
    return out

def bumpBucket (entries : Array (String × Nat)) (w : String) :
    Array (String × Nat) :=
  Id.run do
    let mut i := 0
    while i < entries.size do
      let (x, n) := entries[i]!
      if x == w then
        return setAt entries i (x, n + 1)
      if ltWord w x then
        return insertAt entries i (w, 1)
      i := i + 1
    return entries.push (w, 1)

def letterIndex (w : String) : Nat :=
  match w.toList with
  | c :: _ =>
    let n := c.toNat - 'a'.toNat
    if n < 26 then n else 0
  | [] => 0

def emptyBuckets : Array (Array (String × Nat)) :=
  Id.run do
    let mut a : Array (Array (String × Nat)) := #[]
    for _ in [0:26] do
      a := a.push (#[] : Array (String × Nat))
    return a

def countTokens (tokens : Array String) : Array (String × Nat) :=
  Id.run do
    let mut buckets := emptyBuckets
    for w in tokens do
      if !w.isEmpty then
        let idx := letterIndex w
        let bumped := bumpBucket buckets[idx]! w
        buckets := setAt buckets idx bumped
    let mut out : Array (String × Nat) := #[]
    for b in buckets do
      for p in b do
        out := out.push p
    return out

def containsSorted (xs : List String) (w : String) : Bool :=
  match xs with
  | [] => false
  | x :: rest =>
    match VocabAspell.cmpWord w x with
    | Ordering.eq => true
    | Ordering.lt => false
    | Ordering.gt => containsSorted rest w

/-- Rounded hundredths of a percent: proven or total times 100. -/
def percentHundredths (n d : Nat) : Nat :=
  if d == 0 then
    0
  else
    (n * 10000 + d / 2) / d

def formatPercent (hundredths : Nat) : String :=
  let whole := hundredths / 100
  let frac := hundredths % 100
  let d1 := frac / 10
  let d2 := frac % 10
  s!"{whole}.{d1}{d2}%"

structure Stats where
  counts : List (String × Nat)
  uniqueCount : Nat
  provenUniqueCount : Nat
  occurrenceCount : Nat
  provenOccurrenceCount : Nat
  files : List String
  catalogTokenCount : Nat
  foldedCatalogCount : Nat
  proven : List String
  deriving Repr

def provenSetSize (s : Stats) : Nat :=
  s.proven.length

def uniquePercentHundredths (s : Stats) : Nat :=
  percentHundredths s.provenUniqueCount s.uniqueCount

def prevalencePercentHundredths (s : Stats) : Nat :=
  percentHundredths s.provenOccurrenceCount s.occurrenceCount

def statsOf
    (files : List String) (tokens : Array String)
    (catalogTokens : List String) : Stats :=
  Id.run do
    let proven := provenWords catalogTokens
    let counted := countTokens tokens
    let counts := counted.toList
    let uniqueCount := counts.length
    let occurrenceCount := counts.foldl (fun acc p => acc + p.2) 0
    let mut provenUniqueCount : Nat := 0
    let mut provenOccurrenceCount : Nat := 0
    for p in counts do
      if containsSorted proven p.1 then
        provenUniqueCount := provenUniqueCount + 1
        provenOccurrenceCount := provenOccurrenceCount + p.2
    return {
      counts
      uniqueCount
      provenUniqueCount
      occurrenceCount
      provenOccurrenceCount
      files
      catalogTokenCount := catalogTokens.length
      foldedCatalogCount := (foldedCatalogWords catalogTokens).length
      proven
    }

def renderWordLine (proven : List String) (p : String × Nat) : String :=
  if containsSorted proven p.1 then
    s!"{p.1} {p.2} proven"
  else
    s!"{p.1} {p.2}"

def renderReport (s : Stats) : String :=
  let fileLines := s.files.map (fun f => s!"{f}")
  let wordLines := s.counts.map (renderWordLine s.proven)
  let body : List String :=
    [
      "# Word stats",
      "",
      "This file tracks unique English words in Surmount authored markdown in this repository. Tokens are ASCII letters only, folded to lowercase. Digits are not words. beastdb is one token. RFC folds to rfc.",
      "",
      "Proven tokens are lowercased CATE L_n catalog entries from 0005_CATE.md, plus the RFC 2119 requirement keywords already named in 0000_spec.md Clause 4.1 and 0005_CATE.md Clause 3.9 (must, shall, should, required, recommended, may, optional). That is not a second CATE catalog. CATE owns domain words. RFC 2119 owns those requirement keywords. The CATE catalog is case sensitive. This scan folds to lowercase, so pairs such as Markdown and markdown are one unique word.",
      "",
      "This tracking is not a proof that every English sentence is CATE. The leftover unstack floor in 0005_CATE.md remains a separate check.",
      "",
      "Scope is root numbered NNNN markdown files, README.md, AGENTS.md, RESIDUAL.md, and VOCABULARY.md. This file is not in the scan. Vendor trees under ref, the Lean 4 skill pack, Lake build output, Nix result links, and git metadata are not in the scan. Lean comments are not in the scan.",
      "",
      "The Lean program word_stats writes this file and fails when this file is stale.",
      "",
      "## Headline",
      "",
      s!"Unique word count: {s.uniqueCount}",
      s!"Proven unique count: {s.provenUniqueCount}",
      s!"Percent of unique words that are proven: {formatPercent (uniquePercentHundredths s)}",
      s!"Total occurrence count: {s.occurrenceCount}",
      s!"Proven occurrence count: {s.provenOccurrenceCount}",
      s!"Percent by prevalence: {formatPercent (prevalencePercentHundredths s)}",
      "",
      s!"CATE catalog token count (case sensitive): {s.catalogTokenCount}",
      s!"Folded catalog unique count: {s.foldedCatalogCount}",
      s!"Proven set size after union with RFC 2119 keywords: {provenSetSize s}",
      "",
      "## Files scanned",
      ""
    ]
      ++ fileLines
      ++ [
        "",
        "## Unique words",
        "",
        "Each line is the lowercased token, a space, the occurrence count, and the word proven when that token is in the proven set.",
        "",
        "```text"
      ]
      ++ wordLines
      ++ [
        "```",
        ""
      ]
  String.intercalate "\n" body

def reportMatches (disk generated : String) : Bool :=
  disk == generated

def firstDiffLine : List String → List String → Nat → Option (Nat × String × String)
  | [], [], _ => none
  | x :: xr, y :: yr, i =>
    if x != y then some (i, x, y) else firstDiffLine xr yr (i + 1)
  | x :: _, [], i => some (i, x, "<end>")
  | [], y :: _, i => some (i, "<end>", y)

def catalogTokensFromMarkdown (content : String) :
    Except (Nat × String) (List String) :=
  match VocabAspell.parseVocabEntries content with
  | .error e => .error e
  | .ok entries => .ok (entries.map (·.word))

def ltPathName (a b : System.FilePath) : Bool :=
  ltWord
    (SpecRegistry.baseName a.toString)
    (SpecRegistry.baseName b.toString)

def insertPath (xs : List System.FilePath) (p : System.FilePath) :
    List System.FilePath :=
  match xs with
  | [] => [p]
  | x :: rest =>
    if ltPathName p x then p :: xs else x :: insertPath rest p

def collectScopedFiles (repo : System.FilePath) : IO (Array System.FilePath) := do
  let numbered ← SpecRegistry.collectRootNumberedSpecs repo
  let mut paths := numbered
  for name in extraMarkdownFileNames do
    paths := paths.push (repo / name)
  return (paths.toList.foldl insertPath []).toArray

def readTokens (p : System.FilePath) : IO (Array String) := do
  let bs ← IO.FS.readBinFile p
  return tokenizeBytes bs

def statsForRepo (repo : System.FilePath) : IO (Except String Stats) := do
  let catalogPath := repo / VocabAspell.vocabMarkdownFileName
  if !(← catalogPath.pathExists) then
    return .error s!"missing {catalogPath}"
  let catalogBs ← IO.FS.readBinFile catalogPath
  if !(SpecCheck.isPureAscii catalogBs) then
    return .error s!"{VocabAspell.vocabMarkdownFileName} is not pure ASCII"
  let catalogText := SpecCheck.asciiToString catalogBs
  match catalogTokensFromMarkdown catalogText with
  | .error (ln, msg) =>
    return .error s!"{VocabAspell.vocabMarkdownFileName}:{ln}: {msg}"
  | .ok catalogTokens =>
    let paths ← collectScopedFiles repo
    let mut tokens : Array String := #[]
    let mut files : List String := []
    for p in paths do
      if !(← p.pathExists) then
        return .error s!"missing {p}"
      let name := SpecRegistry.baseName p.toString
      files := files ++ [name]
      let more ← readTokens p
      tokens := tokens ++ more
    return .ok (statsOf files tokens catalogTokens)

def generatedReport (repo : System.FilePath) : IO (Except String String) := do
  match (← statsForRepo repo) with
  | .error msg => return .error msg
  | .ok s => return .ok (renderReport s)

end WordStats
