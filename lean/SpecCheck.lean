/-
  SpecCheck: mechanical form rule checks for Surmount numbered specifications.

  Default discovery is numbered specifications at the root only (NNNN_*.md). Full suite
  (see 0000_spec.md):
  1. Pure ASCII (tab, LF, printable 0x20-0x7E only)
  2. No markdown bullet list markers outside fenced code
  3. No excess hyphenated tokens (lowercase token with 2+ hyphens) outside fences
    and outside inline code / URLs
  4. In scope specs (NNNN_*.md) MUST cite RFC 2119 (or RFC2119)
  5. No trailing whitespace (space or tab before LF)
  6. Leading indentation uses tabs only (no leading space)
  7. No prose wrapped to a column outside fences (numbered specifications)
  8. American English spelling via aspell (en_US) when AspellHome is provided

  Trailing whitespace and tab indent on project text that is not a specification are
  enforced by pure Nix (nix/whitespace.nix / checks.whitespace), not by Lean.
  When paths are passed explicitly, this module may still apply ASCII/whitespace
  checks to owned text kinds for convenience; that is not the gate across the project.

  UNLICENSE.md / LICENSE* are style excluded (ASCII and whitespace still checked)
  when passed). README.md is not required to cite RFC 2119.

  Implementation: line based with fence tracking (not a full markdown parser).
  Char lists and Nat indices keep Lean 4.30 APIs simple.
-/

namespace SpecCheck

/-- One diagnostic: file, optional 1-based line, message. -/
structure Diag where
  file : String
  line : Option Nat
  message : String
  deriving Repr, Inhabited

def Diag.format (d : Diag) : String :=
  match d.line with
  | some n => s!"{d.file}:{n}: {d.message}"
  | none   => s!"{d.file}: {d.message}"

/-- Bytes allowed by pure ASCII rule: HT, LF, printable ASCII. No CR. -/
def isAllowedAsciiByte (b : UInt8) : Bool :=
  let n := b.toNat
  n == 9 || n == 10 || (32 ≤ n && n ≤ 126)

/-- True when every byte is allowed ASCII. -/
def isPureAscii (bs : ByteArray) : Bool :=
  Id.run do
    for i in [0:bs.size] do
      if !(isAllowedAsciiByte (bs.get! i)) then
        return false
    return true

/-- Map byte offset to 1-based line number (counts LF before offset). -/
def lineOfOffset (bs : ByteArray) (offset : Nat) : Nat :=
  Id.run do
    let mut line : Nat := 1
    let limit := min offset bs.size
    for i in [0:limit] do
      if bs.get! i == 10 then
        line := line + 1
    return line

/-- Collect ASCII violations with line numbers (one report per bad line). -/
def checkAscii (file : String) (bs : ByteArray) : List Diag :=
  Id.run do
    let mut out : List Diag := []
    let mut i : Nat := 0
    while i < bs.size do
      let b := bs.get! i
      if !(isAllowedAsciiByte b) then
        let ln := lineOfOffset bs i
        out := out ++ [{
          file := file
          line := some ln
          message := s!"non ASCII or disallowed control character (byte {b.toNat})"
        }]
        while i < bs.size && bs.get! i != 10 do
          i := i + 1
      else
        i := i + 1
    return out

/-- Decode pure ASCII bytes to a String (one Char per byte). -/
def asciiToString (bs : ByteArray) : String :=
  Id.run do
    let mut cs : Array Char := #[]
    for i in [0:bs.size] do
      cs := cs.push (Char.ofNat (bs.get! i).toNat)
    return String.ofList cs.toList

/-- Split on LF into lines. -/
def splitLines (s : String) : List String :=
  s.splitOn "\n"

/-- True for style excluded basenames (license text). -/
def isStyleExcluded (basename : String) : Bool :=
  basename == "UNLICENSE.md" || basename == "UNLICENSE" ||
  basename == "LICENSE" || basename == "LICENSE.md"

/-- Descriptive stem char: letter, digit, or underscore (ASCII). -/
def isSpecNameChar (c : Char) : Bool :=
  c.isAlphanum || c == '_'

/--
  True for numbered Surmount specs at the repository root naming scheme:
  `^[0-9]{4}_[A-Za-z0-9_]+\\.md$` (basename only).
-/
def isNumberedSpecName (basename : String) : Bool :=
  if !(basename.endsWith ".md") then
    false
  else
    -- stem is basename without trailing ".md" (length at least 4 + 1 + 1 = 6)
    let cs := basename.toList
    if cs.length < 9 then
      -- minimum valid: "0000_x.md" is 9 characters
      false
    else
      let stemCs := cs.take (cs.length - 3)
      match stemCs with
      | c0 :: c1 :: c2 :: c3 :: '_' :: rest =>
        c0.isDigit && c1.isDigit && c2.isDigit && c3.isDigit &&
          !rest.isEmpty && rest.all isSpecNameChar
      | _ => false

/-- True for numbered specifications that are in scope (same as isNumberedSpecName). -/
def isInScopeSpec (basename : String) : Bool :=
  isNumberedSpecName basename

def isMarkdownName (name : String) : Bool :=
  name.endsWith ".md" || name.endsWith ".markdown" || name.endsWith ".mdown"

/-- Does the char list start with three backticks? -/
def startsWithFence (cs : List Char) : Bool :=
  match cs with
  | '`' :: '`' :: '`' :: _ => true
  | _ => false

/-- Lines outside fenced code (and YAML front matter), with original 1-based lines. -/
def linesOutsideFences (content : String) : List (Nat × String) :=
  Id.run do
    let lines := splitLines content
    let mut out : List (Nat × String) := []
    let mut inFence := false
    let mut inFront := false
    let mut lineNo : Nat := 0
    for line in lines do
      lineNo := lineNo + 1
      let cs := line.toList
      if lineNo == 1 && line == "---" then
        inFront := true
      else if inFront then
        if line == "---" then
          inFront := false
      else if startsWithFence cs then
        inFence := !inFence
      else if !inFence then
        out := out ++ [(lineNo, line)]
    return out

/-- Drop leading spaces and tabs. -/
def dropLeadingSpace (cs : List Char) : List Char :=
  cs.dropWhile (fun c => c == ' ' || c == '\t')

/-- Markdown bullet: optional indent, then -, *, or + followed by space/tab. -/
def isBulletLine (line : String) : Bool :=
  let t := dropLeadingSpace line.toList
  match t with
  | c :: c2 :: _ =>
      (c == '-' || c == '*' || c == '+') && (c2 == ' ' || c2 == '\t')
  | _ => false

def truncate (s : String) (n : Nat) : String :=
  let cs := s.toList
  if cs.length ≤ n then s
  else String.ofList (cs.take n) ++ "..."

def checkBullets (file : String) (content : String) : List Diag :=
  Id.run do
    let mut out : List Diag := []
    for pair in linesOutsideFences content do
      let (ln, line) := pair
      if isBulletLine line then
        out := out ++ [{
          file := file
          line := some ln
          message := s!"markdown bullet list marker (prefer numbered or lettered lists): {truncate line 80}"
        }]
    return out

/-- Char array helpers. -/
def arrStartsWith (cs : Array Char) (i : Nat) (pat : List Char) : Bool :=
  Id.run do
    let mut j := 0
    for c in pat do
      let k := i + j
      if k ≥ cs.size then return false
      if cs[k]! != c then return false
      j := j + 1
    return true

/-- Strip `inline code` spans using index scan. -/
def stripInlineCodeArr (cs : Array Char) : Array Char :=
  Id.run do
    let mut out : Array Char := #[]
    let mut i : Nat := 0
    while i < cs.size do
      if cs[i]! == '`' then
        let mut j := i + 1
        let mut found := false
        while j < cs.size do
          if cs[j]! == '`' then
            found := true
            break
          j := j + 1
        if found then
          out := out.push ' '
          i := j + 1
        else
          out := out.push '`'
          i := i + 1
      else
        out := out.push (cs[i]!)
        i := i + 1
    return out

/-- Strip [text](url) markdown links. -/
def stripMdLinksArr (cs : Array Char) : Array Char :=
  Id.run do
    let mut out : Array Char := #[]
    let mut i : Nat := 0
    while i < cs.size do
      if cs[i]! == '[' then
        -- find ](
        let mut j := i + 1
        let mut closeAt : Option Nat := none
        while j < cs.size do
          if cs[j]! == '[' then break
          if cs[j]! == ']' then
            if j + 1 < cs.size && cs[j+1]! == '(' then
              closeAt := some j
            break
          j := j + 1
        match closeAt with
        | none =>
          out := out.push '['
          i := i + 1
        | some cb =>
          let mut k := cb + 2
          let mut depth : Nat := 1
          let mut done := false
          let mut endAt : Option Nat := none
          while k < cs.size && !done do
            let c := cs[k]!
            if c == '(' then depth := depth + 1
            else if c == ')' then
              if depth == 1 then
                endAt := some k
                done := true
              else
                depth := depth - 1
            k := k + 1
          match endAt with
          | some e =>
            out := out.push ' '
            i := e + 1
          | none =>
            out := out.push '['
            i := i + 1
      else
        out := out.push (cs[i]!)
        i := i + 1
    return out

/-- Strip <http...> and bare http(s):// URLs. -/
def stripHttpUrlsArr (cs : Array Char) : Array Char :=
  Id.run do
    let http := "http://".toList
    let https := "https://".toList
    let httpB := "<http://".toList
    let httpsB := "<https://".toList
    let mut out : Array Char := #[]
    let mut i : Nat := 0
    while i < cs.size do
      if arrStartsWith cs i httpB || arrStartsWith cs i httpsB then
        let mut j := i + 1
        while j < cs.size && cs[j]! != '>' do
          j := j + 1
        if j < cs.size && cs[j]! == '>' then
          out := out.push ' '
          i := j + 1
        else
          out := out.push (cs[i]!)
          i := i + 1
      else if arrStartsWith cs i http || arrStartsWith cs i https then
        let mut j := i
        while j < cs.size do
          let c := cs[j]!
          if c == ' ' || c == '\t' || c == '>' then break
          j := j + 1
        out := out.push ' '
        i := j
      else
        out := out.push (cs[i]!)
        i := i + 1
    return out

def stripInlineCode (s : String) : String :=
  String.ofList (stripInlineCodeArr s.toList.toArray).toList

def stripUrls (s : String) : String :=
  String.ofList (stripHttpUrlsArr (stripMdLinksArr s.toList.toArray)).toList

def isLowerAz (c : Char) : Bool :=
  'a' ≤ c && c ≤ 'z'

def isKebabBody (c : Char) : Bool :=
  isLowerAz c || c.isDigit || c == '-'

/-- Find excess kebab tokens: [a-z][a-z0-9]*(-[a-z0-9]+){2,} -/
def findExcessKebab (s : String) : List String :=
  Id.run do
    let cs := s.toList.toArray
    let mut out : List String := []
    let mut i : Nat := 0
    while i < cs.size do
      let c := cs[i]!
      if isLowerAz c then
        let mut j := i + 1
        while j < cs.size && isKebabBody (cs[j]!) do
          j := j + 1
        let mut tokChars : Array Char := #[]
        for k in [i:j] do
          tokChars := tokChars.push (cs[k]!)
        let tok := String.ofList tokChars.toList
        let parts := tok.splitOn "-"
        let firstOk : Bool :=
          match parts.head? with
          | some p0 =>
            match p0.toList.head? with
            | some c0 => isLowerAz c0
            | none => false
          | none => false
        let segsOk := parts.all (fun p =>
          !p.isEmpty && p.toList.all (fun ch => isLowerAz ch || ch.isDigit))
        if parts.length ≥ 3 && firstOk && segsOk then
          out := out ++ [tok]
        i := j
      else
        i := i + 1
    return out

/-- Table separator / underline only: pipes, dashes, colons, spaces, tabs. -/
def isTableSepLine (s : String) : Bool :=
  let cs := s.toList
  !cs.isEmpty && cs.all (fun c =>
    c == '|' || c == ':' || c == '-' || c == ' ' || c == '\t')

def checkKebab (file : String) (content : String) : List Diag :=
  Id.run do
    let mut out : List Diag := []
    for pair in linesOutsideFences content do
      let (ln, line) := pair
      let cleaned := stripUrls (stripInlineCode line)
      if !(isTableSepLine cleaned) then
        for tok in findExcessKebab cleaned do
          out := out ++ [{
            file := file
            line := some ln
            message := s!"excess hyphenated token (2+ hyphens): {tok}"
          }]
    return out

/-- Case insensitive ASCII upper for one char. -/
def asciiUpperChar (c : Char) : Char :=
  if 'a' ≤ c && c ≤ 'z' then Char.ofNat (c.toNat - 32) else c

def asciiUpper (s : String) : String :=
  String.ofList (s.toList.map asciiUpperChar)

/-- Needle appears as contiguous substring (Array scan). -/
def containsSub (hay : String) (needle : String) : Bool :=
  if needle.isEmpty then true
  else
    let h := hay.toList.toArray
    let n := needle.toList
    Id.run do
      let mut i : Nat := 0
      while i < h.size do
        if arrStartsWith h i n then return true
        i := i + 1
      return false

/-- Document cites RFC 2119 (with or without internal space). -/
def hasRfc2119Citation (content : String) : Bool :=
  let u := asciiUpper content
  containsSub u "RFC 2119" || containsSub u "RFC2119"

def checkRfc2119 (file : String) (basename : String) (content : String) : List Diag :=
  if !isInScopeSpec basename then []
  else if hasRfc2119Citation content then []
  else [{
    file := file
    line := some 1
    message := "in scope spec (NNNN_*.md) must cite RFC 2119 (or RFC2119)"
  }]

/-- True if the line ends with space or tab. -/
def hasTrailingWs (line : String) : Bool :=
  Id.run do
    let cs := line.toList
    if cs.isEmpty then return false
    let last := cs.getLast!
    return last == ' ' || last == '\t'

/-- Flag lines with trailing space or tab. -/
def checkTrailingWs (file : String) (content : String) : List Diag :=
  Id.run do
    let mut out : List Diag := []
    let mut ln : Nat := 0
    for line in splitLines content do
      ln := ln + 1
      if hasTrailingWs line then
        out := out ++ [{
          file := file
          line := some ln
          message := "trailing whitespace (space or tab before end of line)"
        }]
    return out

/-- True if the line begins with a space (0x20). Tabs are allowed. -/
def hasLeadingSpace (line : String) : Bool :=
  match line.toList with
  | ' ' :: _ => true
  | _ => false

/-- Flag lines whose leading indentation uses space rather than tab. -/
def checkLeadingSpaces (file : String) (content : String) : List Diag :=
  Id.run do
    let mut out : List Diag := []
    let mut ln : Nat := 0
    for line in splitLines content do
      ln := ln + 1
      if hasLeadingSpace line then
        out := out ++ [{
          file := file
          line := some ln
          message := "leading indent with spaces (use tab for leading indent)"
        }]
    return out

/-- Drop trailing spaces and tabs from a char list. -/
def dropTrailingSpace (cs : List Char) : List Char :=
  (cs.reverse.dropWhile (fun c => c == ' ' || c == '\t')).reverse

/-- Last non whitespace char of line, if any. -/
def lastNonWsChar (line : String) : Option Char :=
  match dropTrailingSpace line.toList with
  | [] => none
  | cs => cs.getLast?

/-- First non whitespace char of line, if any. -/
def firstNonWsChar (line : String) : Option Char :=
  match dropLeadingSpace line.toList with
  | [] => none
  | c :: _ => some c

/-- Line ends a sentence or closed structure for the heuristic for wrapping to a column. -/
def endsClosedForWrap (line : String) : Bool :=
  match lastNonWsChar line with
  | none => true
  | some c => c == '.' || c == '!' || c == '?' || c == ':'

def isLowerLetter (c : Char) : Bool :=
  'a' ≤ c && c ≤ 'z'

def isAsciiLetter (c : Char) : Bool :=
  ('a' ≤ c && c ≤ 'z') || ('A' ≤ c && c ≤ 'Z')

/-- Heading line: optional indent then #. -/
def isHeadingLine (line : String) : Bool :=
  match dropLeadingSpace line.toList with
  | '#' :: _ => true
  | _ => false

/-- Table row or separator: optional indent then |. -/
def isTableLine (line : String) : Bool :=
  match dropLeadingSpace line.toList with
  | '|' :: _ => true
  | _ => false

/-- Blockquote line. -/
def isBlockquoteLine (line : String) : Bool :=
  match dropLeadingSpace line.toList with
  | '>' :: _ => true
  | _ => false

/-- Thematic break of dashes/stars/underscores only (after trim). -/
def isThematicLine (line : String) : Bool :=
  let t := dropTrailingSpace (dropLeadingSpace line.toList)
  match t with
  | [] => false
  | c0 :: rest =>
    (c0 == '-' || c0 == '*' || c0 == '_') &&
      rest.all (fun c => c == c0) &&
      (c0 :: rest).length ≥ 3

/-- HTML like line. -/
def isHtmlLine (line : String) : Bool :=
  match dropLeadingSpace line.toList with
  | '<' :: _ => true
  | _ => false

/-- Skip leading digits from a char list; return the remainder. -/
def dropLeadingDigits (cs : List Char) : List Char :=
  cs.dropWhile Char.isDigit

/-- Numbered or lettered list item (optional tab/space indent). -/
def isListItemLine (line : String) : Bool :=
  let t := dropLeadingSpace line.toList
  match t with
  | c :: rest =>
    if c.isDigit then
      let after := dropLeadingDigits rest
      match after with
      | '.' :: c2 :: _ => c2 == ' ' || c2 == '\t'
      | '.' :: [] => true
      | _ => false
    else if isAsciiLetter c then
      match rest with
      | '.' :: c2 :: _ => c2 == ' ' || c2 == '\t'
      | '.' :: [] => true
      | _ => false
    else false
  | [] => false

/-- Structural lines that break prose wrap pairs (not list items). -/
def isStructuralWrapLine (line : String) : Bool :=
  let stripped := dropTrailingSpace (dropLeadingSpace line.toList)
  stripped.isEmpty ||
    isHeadingLine line ||
    isTableLine line ||
    isBlockquoteLine line ||
    isThematicLine line ||
    isHtmlLine line ||
    startsWithFence line.toList

/-
  Heuristic for wrapping to a column, outside fenced code:
  two consecutive body lines that are not empty where the first does not end a
  sentence/structure (. ! ? :) and the second continues with a lowercase letter.
  Fences, tables, headings, and blockquotes break pairs. List item markers on
  the second line start a new item (not a wrap). List item lines may themselves
  be the first line of a wrap pair when their body continues on the next line.
-/
def checkHardWrap (file : String) (content : String) : List Diag :=
  Id.run do
    let pairs := linesOutsideFences content
    let mut out : List Diag := []
    let mut prev : Option (Nat × String) := none
    for pair in pairs do
      let (ln, line) := pair
      if isStructuralWrapLine line then
        prev := none
      else
        match prev with
        | none =>
          prev := some (ln, line)
        | some (pln, prevLine) =>
          if isListItemLine line then
            prev := some (ln, line)
          else if !endsClosedForWrap prevLine then
            match firstNonWsChar line with
            | none =>
              prev := none
            | some c =>
              if isLowerLetter c then
                out := out ++ [{
                  file := file
                  line := some pln
                  message := s!"prose wrapped to a column (line continues on {ln}; keep one physical line per paragraph or list item)"
                }]
                prev := some (ln, line)
              else
                prev := some (ln, line)
          else
            prev := some (ln, line)
    return out

/--
  Run checks on one file's bytes.

  `fullStyle`: suite for numbered specifications (bullets, kebab, RFC 2119, wrapping to a column).
  `checkLeading`: when false, skip leading space rule (Lean / YAML tooling).
  `checkAsciiFlag`: when false, skip pure ASCII gate (Lean sources).
-/
def checkFileContent (file : String) (basename : String) (bs : ByteArray)
    (fullStyle : Bool) (checkLeading : Bool) (checkAsciiFlag : Bool) : List Diag :=
  let asciiDiags := if checkAsciiFlag then checkAscii file bs else []
  if checkAsciiFlag && !(isPureAscii bs) then
    asciiDiags
  else
    -- Byte to Char map is enough for line based whitespace even when UTF-8 ops appear in Lean.
    let content := asciiToString bs
    let trailing := checkTrailingWs file content
    let leading := if checkLeading then checkLeadingSpaces file content else []
    let wsDiags := trailing ++ leading
    if !fullStyle || isStyleExcluded basename then
      asciiDiags ++ wsDiags
    else
      let styleDiags :=
        checkBullets file content ++
          checkKebab file content ++
          checkRfc2119 file basename content
      let wrapDiags :=
        if isInScopeSpec basename then checkHardWrap file content else []
      asciiDiags ++ wsDiags ++ styleDiags ++ wrapDiags

/-- Basename of a path string (last component after / or \\). -/
def baseName (path : String) : String :=
  let norm := path.replace "\\" "/"
  let parts := norm.splitOn "/"
  match parts.reverse with
  | p :: _ => p
  | [] => path

/-- Normalize path separators to `/` and drop a trailing slash (except root). -/
def normalizeRel (rel : String) : String :=
  let r := rel.replace "\\" "/"
  if r.length > 1 && r.endsWith "/" then
    String.ofList (r.toList.dropLast)
  else
    r

/-- Relative path of `path` under `repoRoot`, or the path string if not under root. -/
def relPathString (repoRoot : System.FilePath) (path : System.FilePath) : String :=
  let pathS := normalizeRel path.toString
  let rootS := normalizeRel repoRoot.toString
  if pathS == rootS then
    "."
  else if pathS.startsWith (rootS ++ "/") then
    let prefixLen := rootS.length + 1
    String.ofList (pathS.toList.drop prefixLen)
  else if !(pathS.startsWith "/") then
    pathS
  else
    pathS

/-- Vendor / generated paths that must not be form checked. -/
def isSkippedRel (rel : String) : Bool :=
  let r := normalizeRel rel
  if r == "ref/semver" || r.startsWith "ref/semver/" then true
  else if r.endsWith ".pdf" then true
  else if r.endsWith "/rfc2119.txt" || r == "rfc2119.txt" then true
  else if r == ".pre-commit-config.yaml" then true
  else if r == "flake.lock" then true
  else if r == "lake-manifest.json" || r.endsWith "/lake-manifest.json" then true
  else if r == ".git" || r.startsWith ".git/" then true
  else if r == ".direnv" || r.startsWith ".direnv/" then true
  else if r == ".lake" || r.startsWith ".lake/" then true
  else if r == "lean/.lake" || r.startsWith "lean/.lake/" then true
  else if r == "result" || r.startsWith "result/" then true
  else if r.startsWith "result-" then true
  else false

/--
  Project owned text kinds: Surmount authored sources and pins, not vendor blobs.
  Includes numbered and other markdown, Lean, Nix, workflows under .github/, SOURCE, etc.
-/
def isOwnedKind (rel : String) : Bool :=
  let r := normalizeRel rel
  let base := baseName r
  if base == "justfile" || base == ".gitignore" || base == ".gitmodules" ||
      base == "SOURCE" || base == "aspell_words.txt" || base == "lean-toolchain" then
    true
  else if base.endsWith ".md" || base.endsWith ".markdown" || base.endsWith ".mdown" ||
      base.endsWith ".lean" || base.endsWith ".nix" || base.endsWith ".toml" ||
      base.endsWith ".yml" || base.endsWith ".yaml" || base.endsWith ".txt" ||
      base.endsWith ".SOURCE" then
    true
  else if r.startsWith ".github/" then
    true
  else
    false

/-- Lean and YAML require space indentation; do not flag leading spaces. -/
def skipsLeadingSpaceRule (rel : String) : Bool :=
  let base := baseName (normalizeRel rel)
  base.endsWith ".lean" || base.endsWith ".yml" || base.endsWith ".yaml"

/--
  Pure ASCII gate for owned text. Skipped for Lean sources (Unicode operators
  such as left arrow and le are normal in Lean). Markdown and other owned text
  stay under the ASCII rule.
-/
def wantsAsciiCheck (rel : String) : Bool :=
  let base := baseName (normalizeRel rel)
  !base.endsWith ".lean"

/-- True if early bytes look like a binary (NUL present). -/
def isBinaryBytes (bs : ByteArray) : Bool :=
  Id.run do
    let n := min bs.size 8192
    for i in [0:n] do
      if bs.get! i == 0 then
        return true
    return false

/--
  Numbered specifications at the root only: `NNNN_descriptive_name.md` matching
  isNumberedSpecName. Skips README, UNLICENSE, AGENTS, and other root markdown.
  This is the default discovery set for `spec_check` with no path args.
-/
def collectRootNumberedSpecs (repoRoot : System.FilePath) : IO (Array System.FilePath) := do
  let mut out : Array System.FilePath := #[]
  let entries ← repoRoot.readDir
  for e in entries do
    let name := e.fileName
    if !name.startsWith "." && isNumberedSpecName name then
      out := out.push (repoRoot / name)
  return out

/-- Writable aspell home (personal word list copy; store tree is read only). -/
structure AspellHome where
  homeDir : System.FilePath
  personal : String := "aspell_words.txt"
  deriving Repr

/-- Skip spelling when SPECS_SPELLING=0 or SPECS_SKIP_SPELLING=1. -/
def spellingSkipRequested : IO Bool := do
  match (← IO.getEnv "SPECS_SPELLING") with
  | some "0" => return true
  | _ =>
    match (← IO.getEnv "SPECS_SKIP_SPELLING") with
    | some "1" => return true
    | _ => return false

/-- True when token is only hex digits and length at least 2 (color tables, etc.). -/
def isPureHexToken (s : String) : Bool :=
  let cs := s.toList
  cs.length ≥ 2 && cs.all fun c =>
    c.isDigit || ('a' ≤ c && c ≤ 'f') || ('A' ≤ c && c ≤ 'F')

/-- True when token is only decimal digits. -/
def isPureDigitToken (s : String) : Bool :=
  let cs := s.toList
  !cs.isEmpty && cs.all Char.isDigit

/--
  Ensure `aspell` is on PATH and copy root `aspell_words.txt` into a writable
  temp home (aspell may rewrite the personal list).
-/
def prepareAspellHome (repoRoot : System.FilePath) : IO (Except String AspellHome) := do
  let aspellOk ←
    try
      let out ← IO.Process.output { cmd := "aspell", args := #["--version"] }
      pure (out.exitCode == 0)
    catch _ =>
      pure false
  if !aspellOk then
    return .error
      "spec_check: aspell not found on PATH; flake check / nix develop must provide aspellWithDicts (en_US). Set SPECS_SPELLING=0 or SPECS_SKIP_SPELLING=1 to skip spelling."
  let wordList := repoRoot / "aspell_words.txt"
  if !(← wordList.pathExists) then
    return .error "spec_check: missing aspell_words.txt at repository root"
  let tmp ← IO.FS.createTempDir
  let personal := "aspell_words.txt"
  let body ← IO.FS.readFile wordList
  IO.FS.writeFile (tmp / personal) body
  return .ok { homeDir := tmp, personal := personal }

/-- ASCII whitespace trim without deprecated String.trim. -/
def asciiTrim (s : String) : String :=
  String.ofList (dropTrailingSpace (dropLeadingSpace s.toList))

/-- 1-based line of first occurrence of `word` as a substring; none if not found. -/
def firstLineOfSubstring (content : String) (word : String) : Option Nat :=
  if word.isEmpty then
    none
  else
    Id.run do
      let mut ln : Nat := 0
      for line in splitLines content do
        ln := ln + 1
        if containsSub line word then
          return some ln
      return none

/--
  Run `aspell list --lang=en_US --mode=markdown` on file content.
  Skips pure hex (length ≥ 2) and pure digit tokens. One diagnostic per unique word.
  Line is the first content line where the word appears as a substring, if findable.
-/
def checkSpelling (home : AspellHome) (file : String) (content : String) : IO (List Diag) := do
  let out ← IO.Process.output {
    cmd := "aspell"
    args := #[
      "list",
      "--lang=en_US",
      "--mode=markdown",
      s!"--home-dir={home.homeDir.toString}",
      s!"--personal={home.personal}"
    ]
  } content
  let stdoutTrim := asciiTrim out.stdout
  if out.exitCode != 0 && stdoutTrim.isEmpty then
    return [{
      file := file
      line := none
      message := s!"spelling (en_US): aspell failed (exit {out.exitCode}): {asciiTrim out.stderr}"
    }]
  let mut outDiags : List Diag := []
  let mut seen : List String := []
  for line in out.stdout.splitOn "\n" do
    let word := asciiTrim line
    if !word.isEmpty && !isPureHexToken word && !isPureDigitToken word && !seen.contains word then
      seen := seen ++ [word]
      outDiags := outDiags ++ [{
        file := file
        line := firstLineOfSubstring content word
        message := s!"spelling (en_US): {word}"
      }]
  return outDiags

/-- Check one path with the rule set implied by basename / relative path. -/
def checkPath (repoRoot : System.FilePath) (path : System.FilePath)
    (aspell? : Option AspellHome := none) : IO (List Diag) := do
  let pathStr := path.toString
  if !(← path.pathExists) then
    return [{ file := pathStr, line := some 1, message := "not a regular file" }]
  if (← path.isDir) then
    return []
  let rel := relPathString repoRoot path
  if isSkippedRel rel then
    return []
  if !isOwnedKind rel then
    -- Explicit non owned paths are ignored (pre-commit may pass noise).
    return []
  let bs ← IO.FS.readBinFile path
  if isBinaryBytes bs then
    return []
  let base := baseName pathStr
  let fullStyle := isNumberedSpecName base
  let checkLeading := !skipsLeadingSpaceRule rel
  let checkAsciiFlag := wantsAsciiCheck rel
  let formDiags := checkFileContent pathStr base bs fullStyle checkLeading checkAsciiFlag
  -- American English spelling on numbered specifications when aspell home is provided.
  if isNumberedSpecName base then
    match aspell? with
    | none => return formDiags
    | some home =>
      if isPureAscii bs then
        let content := asciiToString bs
        let spellDiags ← checkSpelling home pathStr content
        return formDiags ++ spellDiags
      else
        return formDiags
  else
    return formDiags

end SpecCheck
