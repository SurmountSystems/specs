/-
  Markdown path links in this repository.

  Floor: markdown [text](target) links in numbered specifications and
  README.md. Skip http:// and https://. Resolve remaining targets
  relative to the file or the repository root. Fail when the path
  does not exist. Fragment only targets are the same file.

  This is not a numbered specification. It is not a .sstt producer.
  It does not parse every HTML href. It does not parse reference
  style markdown links.
-/

namespace RepoLinks

structure Finding where
  file : String
  line : Nat
  message : String
  deriving Repr, Inhabited

def Finding.format (f : Finding) : String :=
  s!"{f.file}:{f.line}: {f.message}"

structure MdLink where
  line : Nat
  target : String
  deriving Repr, DecidableEq

def splitLines (s : String) : List String :=
  s.splitOn "\n"

def startsWithStr (s pre : String) : Bool :=
  let sc := s.toList
  let pc := pre.toList
  if sc.length < pc.length then
    false
  else
    (sc.take pc.length) == pc

def isHttp (t : String) : Bool :=
  startsWithStr t "http://" || startsWithStr t "https://"

def isMailto (t : String) : Bool :=
  startsWithStr t "mailto:"

def stripFragment (t : String) : String :=
  match t.splitOn "#" with
  | p :: _ => p
  | [] => t

/-- Skip remote URLs and fragment only targets. -/
def skipTarget (t : String) : Bool :=
  isHttp t || isMailto t || (stripFragment t).isEmpty

/-- Replace inline `code` with spaces so `[text](target)` inside backticks is not a link. -/
def stripInlineCode (s : String) : String :=
  Id.run do
    let cs := s.toList.toArray
    let mut out : Array Char := Array.mkEmpty cs.size
    let mut i := 0
    let mut inCode := false
    while i < cs.size do
      let c := cs[i]!
      if c == '`' then
        inCode := !inCode
        out := out.push ' '
      else if inCode then
        out := out.push ' '
      else
        out := out.push c
      i := i + 1
    return String.ofList out.toList

def fenceLine (line : String) : Bool :=
  let cs := line.toList.dropWhile (fun c => c == ' ' || c == '\t')
  match cs with
  | '`' :: '`' :: '`' :: _ => true
  | _ => false

/-- First `](` on the line, then bytes until `)`. -/
def firstLinkTarget (line : String) : Option String :=
  let parts := line.splitOn "]("
  match parts with
  | _ :: rest :: _ =>
    match rest.splitOn ")" with
    | t :: _ => some t
    | [] => none
  | _ => none

/-- All `](` targets on one line (several links). -/
def targetsOnLine (line : String) : List String :=
  Id.run do
    let mut out : List String := []
    let mut rest := line
    for _ in [0:line.length + 1] do
      match firstLinkTarget rest with
      | none => return out
      | some t =>
        out := out ++ [t]
        let parts := rest.splitOn "]("
        rest :=
          match parts with
          | _ :: r :: more => String.intercalate "](" (r :: more)
          | _ => ""
    return out

def extractLinks (content : String) : List MdLink :=
  Id.run do
    let mut out : List MdLink := []
    let mut ln : Nat := 0
    let mut inFence := false
    for line in splitLines content do
      ln := ln + 1
      if fenceLine line then
        inFence := !inFence
      else if !inFence then
        for t in targetsOnLine (stripInlineCode line) do
          out := out ++ [{ line := ln, target := t }]
    return out

def splitPath (p : String) : List String :=
  (p.replace "\\" "/").splitOn "/" |>.filter (fun s => s != "" && s != ".")

def joinPath (parts : List String) : String :=
  String.intercalate "/" parts

def normalizeParts (parts : List String) : List String :=
  parts.foldl
    (fun acc s =>
      if s == ".." then
        match acc.reverse with
        | _ :: rest => rest.reverse
        | [] => []
      else
        acc ++ [s])
    []

def parentDir (relFile : String) : String :=
  let norm := relFile.replace "\\" "/"
  let parts := norm.splitOn "/"
  match parts.reverse with
  | _ :: rest => joinPath rest.reverse
  | [] => ""

/-- Resolve a path target relative to the source file or repository root. -/
def resolveTarget (sourceRel : String) (target : String) : String :=
  let path := stripFragment target
  if path.isEmpty then
    sourceRel
  else if startsWithStr path "/" then
    joinPath (normalizeParts (splitPath path))
  else
    let parent := parentDir sourceRel
    let combined :=
      if parent.isEmpty then path
      else parent ++ "/" ++ path
    joinPath (normalizeParts (splitPath combined))

def missingMessage (target resolved : String) : String :=
  s!"markdown path link target does not exist: {target} (resolved {resolved})"

/-- Pure scan: `pathOk` is true when a repository-relative path exists. -/
def findingsForLinks (sourceRel : String) (content : String)
    (pathOk : String → Bool) : List Finding :=
  Id.run do
    let mut out : List Finding := []
    for link in extractLinks content do
      if skipTarget link.target then
        pure ()
      else
        let resolved := resolveTarget sourceRel link.target
        let alt := joinPath (normalizeParts (splitPath (stripFragment link.target)))
        if pathOk resolved || pathOk alt then
          pure ()
        else
          out := out ++ [{
            file := sourceRel
            line := link.line
            message := missingMessage link.target resolved
          }]
    return out

def isNumberedSpecName (basename : String) : Bool :=
  if !(basename.endsWith ".md") then
    false
  else
    let cs := basename.toList
    match cs with
    | c0 :: c1 :: c2 :: c3 :: '_' :: rest =>
      c0.isDigit && c1.isDigit && c2.isDigit && c3.isDigit &&
        !rest.isEmpty
    | _ => false

def baseName (path : String) : String :=
  let norm := path.replace "\\" "/"
  let parts := norm.splitOn "/"
  match parts.reverse with
  | p :: _ => p
  | [] => path

def collectScanRelPaths (repoRoot : System.FilePath) : IO (Array String) := do
  let mut out : Array String := #[]
  let entries ← repoRoot.readDir
  for e in entries do
    let name := e.fileName
    if !name.startsWith "." && isNumberedSpecName name then
      out := out.push name
  if (← (repoRoot / "README.md").pathExists) then
    out := out.push "README.md"
  return out

def pathExistsRel (repoRoot : System.FilePath) (p : String) : IO Bool := do
  if p.isEmpty then
    return true
  (repoRoot / p).pathExists

def checkRepo (repoRoot : System.FilePath) : IO (List Finding) := do
  let rels ← collectScanRelPaths repoRoot
  let mut out : List Finding := []
  for rel in rels do
    let fp := repoRoot / rel
    if !(← fp.pathExists) then
      continue
    let content ← IO.FS.readFile fp
    for link in extractLinks content do
      if skipTarget link.target then
        pure ()
      else
        let resolved := resolveTarget rel link.target
        let alt := joinPath (normalizeParts (splitPath (stripFragment link.target)))
        let a ← pathExistsRel repoRoot resolved
        let b ← pathExistsRel repoRoot alt
        if !(a || b) then
          out := out ++ [{
            file := rel
            line := link.line
            message := missingMessage link.target resolved
          }]
  return out

end RepoLinks
