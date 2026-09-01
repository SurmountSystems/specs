/-
  Isomorphism of physical lines between numbered markdown and sibling
  Lean spec encodings (`NNNN_descriptive_name.lean` next to
  `NNNN_descriptive_name.md`).

  The gate fails when a markdown line has no encoding or an encoding
  has no matching markdown line. Compiled `encodedLines` must still
  match the markdown bytes (LF lines). The gate also fails when a
  sibling encoding contains `include_str`. The encoding must
  be explicit Lean `MdLine` or `String` literals, one per physical
  markdown line. `include_str` is not a line encoding.

  Compiled `encodedLines` SHALL NOT contain leftover unstack phrases in
  prose outside fenced code and outside inline code. Comments in
  `lean/FormalVibeficationSpec.lean`, `lean/VocabularySpec.lean`,
  `lean/TechTreeSpec.lean`, `lean/MemexSpec.lean`, `lean/UnlicenseSpec.lean`,
  `lean/CateSpec.lean`, `lean/RsiSpec.lean`, `lean/CiSpec.lean`,
  `lean/BeastDbSpec.lean`, `lean/SssssSpec.lean`,
  `lean/SystemsLeanSpec.lean`, and `lean/LeanMachineSpec.lean`
  SHALL NOT contain those leftover phrases. That scan uses
  `Cate.leftoverUnstackPhrases` and `SpecCheck.checkLeftoverUnstack`.
  It is a floor, not a complete English checker.

  This module is the durable checker library. It is not a numbered
  specification. It is not a proof module for any one spec.
-/

import MdLine
import SpecRegistry
import Cate
import SpecCheck

open MdLine

namespace LineEncodings

/-- One published spec's compiled sibling encoding. -/
structure EncodedSpec where
  specNumber : Nat
  specFileName : String
  siblingEncodingFileName : String
  proofModuleName : String
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  lines : Array MdLine
  deriving Repr

/-- Drift between markdown physical lines and Lean encodings. -/
inductive LineDrift where
  | missingEncoding (line : Nat) (text : String)
  | extraEncoding (line : Nat) (text : String)
  | textMismatch (line : Nat) (markdown : String) (encoding : String)
  | numberMismatch (line : Nat) (markdownNumber encodingNumber : Nat)
  deriving Repr, DecidableEq

def LineDrift.format (d : LineDrift) : String :=
  match d with
  | .missingEncoding n t =>
    s!"line {n}: markdown line has no encoding ({t})"
  | .extraEncoding n t =>
    s!"line {n}: encoding has no matching markdown line ({t})"
  | .textMismatch n m e =>
    s!"line {n}: text mismatch"
      ++ " markdown=" ++ m
      ++ " encoding=" ++ e
  | .numberMismatch n mn en =>
    s!"line {n}: line number mismatch markdown={mn} encoding={en}"

/-- Compare markdown lines to encoded lines in order. -/
def findDrift (markdown encoded : Array MdLine) : Array LineDrift :=
  Id.run do
    let mut out : Array LineDrift := #[]
    let n := Nat.max markdown.size encoded.size
    for i in [0:n] do
      match markdown[i]?, encoded[i]? with
      | some md, some enc =>
        if md.text != enc.text then
          out := out.push (.textMismatch (i + 1) md.text enc.text)
        else if md.number != i + 1 || enc.number != i + 1 then
          out := out.push (.numberMismatch (i + 1) md.number enc.number)
      | some md, none =>
        out := out.push (.missingEncoding (i + 1) md.text)
      | none, some enc =>
        out := out.push (.extraEncoding (i + 1) enc.text)
      | none, none =>
        pure ()
    return out

def isoHolds (markdown encoded : Array MdLine) : Bool :=
  (findDrift markdown encoded).isEmpty

def mashedSibling (e : EncodedSpec) : Bool :=
  e.markedAsSpecEncoding && e.markedAsProof

def siblingFlagsConform (e : EncodedSpec) : Bool :=
  e.markedAsSpecEncoding && !e.markedAsProof && !mashedSibling e

def expectedEncodingName (specFileName : String) : String :=
  MdLine.siblingEncodingFileName specFileName

def expectedProofFileName (n : Nat) : String :=
  MdLine.siblingProofFileName n

structure Finding where
  path : String
  line : Nat
  message : String
  deriving Repr, Inhabited

def Finding.format (f : Finding) : String :=
  s!"{f.path}:{f.line}: {f.message}"

def readEncoded (path : System.FilePath) : IO (Except String (Array MdLine)) := do
  if !(← path.pathExists) then
    return .error s!"missing {path}"
  let bs ← IO.FS.readBinFile path
  return .ok (MdLine.encodeFile (MdLine.bytesToString bs))

def readSiblingSource (path : System.FilePath) : IO (Except String String) := do
  if !(← path.pathExists) then
    return .error s!"missing {path}"
  let bs ← IO.FS.readBinFile path
  return .ok (MdLine.bytesToString bs)

/-- Lean `include_str` is not a sibling line encoding. -/
def includeStrToken : String := "include_str"

def includeStrFindingMessage : String :=
  "include_str is not a line encoding; use explicit MdLine or String literals, one per physical markdown line"

/--
  Replace Lean comments and string contents with spaces and keep
  newlines so physical line numbers stay aligned. Nested block comments
  are counted. `include_str` as code remains visible.
-/
def stripLeanComments (src : String) : String :=
  let cs := src.toList.toArray
  Id.run do
    let mut out : Array Char := Array.mkEmpty cs.size
    let mut i : Nat := 0
    let mut block : Nat := 0
    let mut lineComment := false
    let mut inString := false
    let mut escape := false
    while i < cs.size do
      let c := cs[i]!
      let c2 : Option Char :=
        if i + 1 < cs.size then some (cs[i + 1]!) else none
      if block > 0 then
        match c, c2 with
        | '/', some '-' =>
          out := out.push ' '
          out := out.push ' '
          i := i + 2
          block := block + 1
        | '-', some '/' =>
          out := out.push ' '
          out := out.push ' '
          i := i + 2
          block := block - 1
        | _, _ =>
          out := out.push (if c == '\n' then '\n' else ' ')
          i := i + 1
      else if lineComment then
        if c == '\n' then
          out := out.push '\n'
          lineComment := false
        else
          out := out.push ' '
        i := i + 1
      else if inString then
        if escape then
          out := out.push ' '
          escape := false
        else if c == '\\' then
          out := out.push ' '
          escape := true
        else if c == '"' then
          out := out.push '"'
          inString := false
        else
          out := out.push (if c == '\n' then '\n' else ' ')
        i := i + 1
      else
        match c, c2 with
        | '-', some '-' =>
          out := out.push ' '
          out := out.push ' '
          i := i + 2
          lineComment := true
        | '/', some '-' =>
          out := out.push ' '
          out := out.push ' '
          i := i + 2
          block := 1
        | '"', _ =>
          out := out.push c
          inString := true
          i := i + 1
        | _, _ =>
          out := out.push c
          i := i + 1
    return String.ofList out.toList

/-- True when `include_str` appears in code (comments stripped). -/
def containsIncludeStrOnLine (line : String) : Bool :=
  (line.splitOn includeStrToken).length > 1

/-- True when sibling source uses `include_str` as code. -/
def containsIncludeStr (src : String) : Bool :=
  containsIncludeStrOnLine (stripLeanComments src)

/-- 1-based physical line numbers whose code contains `include_str`. -/
def includeStrLineNumbers (src : String) : Array Nat :=
  Id.run do
    let mut out : Array Nat := #[]
    let mut n : Nat := 1
    for t in MdLine.physicalLines (stripLeanComments src) do
      if containsIncludeStrOnLine t then
        out := out.push n
      n := n + 1
    return out

def findingsForIncludeStr (path : String) (src : String) : Array Finding :=
  (includeStrLineNumbers src).map fun n =>
    { path := path, line := n, message := includeStrFindingMessage }

/-- Join compiled encodings into markdown text for leftover unstack scan. -/
def encodedLinesToContent (lines : Array MdLine) : String :=
  if lines.isEmpty then
    ""
  else
    String.intercalate "\n" (lines.toList.map (fun l => l.text)) ++ "\n"

def findingFromDiag (d : SpecCheck.Diag) : Finding :=
  { path := d.file
    line := match d.line with
      | some n => n
      | none => 1
    message := d.message }

/-- Leftover unstack in compiled encodedLines prose (same scan as spec_check). -/
def findingsForLeftoverUnstackEncoded (path : String) (lines : Array MdLine) :
    Array Finding :=
  (SpecCheck.checkLeftoverUnstack path (encodedLinesToContent lines)).toArray.map
    findingFromDiag

/--
  Replace Lean code and string contents with spaces and keep comments.
  Newlines stay so physical line numbers stay aligned. Nested block
  comments are counted.
-/
def keepLeanComments (src : String) : String :=
  let cs := src.toList.toArray
  Id.run do
    let mut out : Array Char := Array.mkEmpty cs.size
    let mut i : Nat := 0
    let mut block : Nat := 0
    let mut lineComment := false
    let mut inString := false
    let mut escape := false
    while i < cs.size do
      let c := cs[i]!
      let c2 : Option Char :=
        if i + 1 < cs.size then some (cs[i + 1]!) else none
      if block > 0 then
        match c, c2 with
        | '/', some '-' =>
          out := out.push '/'
          out := out.push '-'
          i := i + 2
          block := block + 1
        | '-', some '/' =>
          out := out.push '-'
          out := out.push '/'
          i := i + 2
          block := block - 1
        | _, _ =>
          out := out.push c
          i := i + 1
      else if lineComment then
        out := out.push c
        if c == '\n' then
          lineComment := false
        i := i + 1
      else if inString then
        if escape then
          out := out.push (if c == '\n' then '\n' else ' ')
          escape := false
        else if c == '\\' then
          out := out.push ' '
          escape := true
        else if c == '"' then
          out := out.push '"'
          inString := false
        else
          out := out.push (if c == '\n' then '\n' else ' ')
        i := i + 1
      else
        match c, c2 with
        | '-', some '-' =>
          out := out.push '-'
          out := out.push '-'
          i := i + 2
          lineComment := true
        | '/', some '-' =>
          out := out.push '/'
          out := out.push '-'
          i := i + 2
          block := 1
        | '"', _ =>
          out := out.push c
          inString := true
          i := i + 1
        | _, _ =>
          out := out.push (if c == '\n' then '\n' else ' ')
          i := i + 1
    return String.ofList out.toList

/-- Leftover unstack in Lean spec encoding comments (same scan as spec_check). -/
def findingsForLeftoverUnstackComments (path : String) (src : String) :
    Array Finding :=
  (SpecCheck.checkLeftoverUnstack path (keepLeanComments src)).toArray.map
    findingFromDiag

/-- Marked meaning spec encodings whose comments use the leftover unstack floor. -/
def meaningSpecEncodingRelPaths : Array String :=
  #["lean/FormalVibeficationSpec.lean", "lean/VocabularySpec.lean",
    "lean/TechTreeSpec.lean", "lean/MemexSpec.lean", "lean/UnlicenseSpec.lean",
    "lean/CateSpec.lean", "lean/RsiSpec.lean", "lean/CiSpec.lean",
    "lean/BeastDbSpec.lean", "lean/SssssSpec.lean", "lean/SystemsLeanSpec.lean",
    "lean/LeanMachineSpec.lean"]

def leftoverUnstackPhrasesAreCate : Bool :=
  SpecCheck.leftoverUnstackPhrases == Cate.leftoverUnstackPhrases

def findingsForDrift (mdPath : String) (drifts : Array LineDrift) : Array Finding :=
  drifts.map fun d =>
    match d with
    | .missingEncoding n _ =>
      { path := mdPath, line := n, message := LineDrift.format d }
    | .extraEncoding n _ =>
      { path := mdPath, line := n, message := LineDrift.format d }
    | .textMismatch n _ _ =>
      { path := mdPath, line := n, message := LineDrift.format d }
    | .numberMismatch n _ _ =>
      { path := mdPath, line := n, message := LineDrift.format d }

/-- Cap printed drift so a total mismatch stays readable. -/
def capFindings (xs : Array Finding) (limit : Nat := 50) : Array Finding :=
  if xs.size ≤ limit then
    xs
  else
    let head := (xs.toList.take limit).toArray
    let more := xs.size - limit
    head.push
      { path := "line_encodings_check"
        line := 1
        message := s!"and {more} more line drift findings" }

def checkOne (repo : System.FilePath) (e : EncodedSpec) : IO (Array Finding) := do
  let mut out : Array Finding := #[]
  let mdPath := repo / e.specFileName
  let specPath := repo / e.siblingEncodingFileName
  let proofPath := repo / expectedProofFileName e.specNumber
  if e.siblingEncodingFileName != expectedEncodingName e.specFileName then
    out := out.push
      { path := e.siblingEncodingFileName
        line := 1
        message :=
          s!"expected sibling name {expectedEncodingName e.specFileName}" }
  if e.proofModuleName != MdLine.siblingProofModuleName e.specNumber then
    out := out.push
      { path := expectedProofFileName e.specNumber
        line := 1
        message :=
          s!"expected proof module {MdLine.siblingProofModuleName e.specNumber}" }
  if !siblingFlagsConform e then
    out := out.push
      { path := e.siblingEncodingFileName
        line := 1
        message := "sibling encoding is mashed with proofs or is not marked as a spec encoding" }
  out := out ++ findingsForLeftoverUnstackEncoded e.specFileName e.lines
  if !(← specPath.pathExists) then
    out := out.push
      { path := e.specFileName
        line := 1
        message := s!"missing sibling encoding {e.siblingEncodingFileName}" }
  else
    match (← readSiblingSource specPath) with
    | .error msg =>
      out := out.push
        { path := e.siblingEncodingFileName, line := 1, message := msg }
    | .ok src =>
      out := out ++ findingsForIncludeStr e.siblingEncodingFileName src
  if !(← proofPath.pathExists) then
    out := out.push
      { path := e.specFileName
        line := 1
        message := s!"missing proof module {expectedProofFileName e.specNumber}" }
  if !(← mdPath.pathExists) then
    out := out.push
      { path := e.specFileName
        line := 1
        message := s!"missing numbered markdown {e.specFileName}" }
    return out
  match (← readEncoded mdPath) with
  | .error msg =>
    return out.push { path := e.specFileName, line := 1, message := msg }
  | .ok mdLines =>
    let drifts := findDrift mdLines e.lines
    return out ++ capFindings (findingsForDrift e.specFileName drifts)

def compiledNumbers (compiled : Array EncodedSpec) : Array Nat :=
  compiled.map fun e => e.specNumber

def compiledFiles (compiled : Array EncodedSpec) : Array String :=
  compiled.map fun e => e.specFileName

def missingCompiled (published : List SpecRegistry.RegistryEntry) (compiled : Array EncodedSpec) :
    Array Finding :=
  Id.run do
    let files := compiledFiles compiled
    let mut out : Array Finding := #[]
    for e in published do
      if !files.contains e.fileName then
        out := out.push
          { path := e.fileName
            line := 1
            message :=
              s!"published markdown has no compiled sibling encoding {expectedEncodingName e.fileName}" }
    return out

def checkMeaningSpecEncodingComments (repo : System.FilePath) : IO (Array Finding) := do
  let mut out : Array Finding := #[]
  if !leftoverUnstackPhrasesAreCate then
    out := out.push
      { path := "lean/CateSpec.lean"
        line := 1
        message := "spec_check leftover unstack phrases drifted from Cate.leftoverUnstackPhrases" }
  for rel in meaningSpecEncodingRelPaths do
    let p := repo / rel
    if !(← p.pathExists) then
      out := out.push
        { path := rel
          line := 1
          message := s!"missing meaning spec encoding {rel}" }
    else
      match (← readSiblingSource p) with
      | .error msg =>
        out := out.push { path := rel, line := 1, message := msg }
      | .ok src =>
        out := out ++ findingsForLeftoverUnstackComments rel src
  return out

def extraCompiled (published : List SpecRegistry.RegistryEntry) (compiled : Array EncodedSpec) :
    Array Finding :=
  Id.run do
    let publishedFiles := (published.map (fun e => e.fileName)).toArray
    let mut out : Array Finding := #[]
    for e in compiled do
      if !publishedFiles.contains e.specFileName then
        out := out.push
          { path := e.specFileName
            line := 1
            message := "compiled sibling encoding is not a published numbered specification" }
    return out

def collectRootNumberedSpecs (repoRoot : System.FilePath) : IO (Array System.FilePath) :=
  SpecRegistry.collectRootNumberedSpecs repoRoot

def diskMarkdownWithoutEncoding (repo : System.FilePath) (compiled : Array EncodedSpec) :
    IO (Array Finding) := do
  let paths ← collectRootNumberedSpecs repo
  let files := compiledFiles compiled
  let mut out : Array Finding := #[]
  for p in paths do
    let base := SpecRegistry.baseName p.toString
    if !files.contains base then
      out := out.push
        { path := base
          line := 1
          message := "numbered markdown on disk has no compiled sibling encoding" }
  return out

def checkRepo (repo : System.FilePath) (compiled : Array EncodedSpec) : IO (Array Finding) := do
  let mut out : Array Finding := #[]
  out := out ++ missingCompiled SpecRegistry.publishedEntries compiled
  out := out ++ extraCompiled SpecRegistry.publishedEntries compiled
  out := out ++ (← diskMarkdownWithoutEncoding repo compiled)
  out := out ++ (← checkMeaningSpecEncodingComments repo)
  for e in compiled do
    out := out ++ (← checkOne repo e)
  return out

end LineEncodings
