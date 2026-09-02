/-
  Writer and reader of .sstt files for numbered specification 0011.

  Format laws live in TechTreeSpec. This module builds a graph from
  files in this repository, orients numbered spec edges from the
  lower spec number to the higher, and writes or reads the bytes.
  It is product implementation. It is not the specification.
  It is not a proof module. It is not Majestic Memex.

  Number 0009 is Public Domain Open Source Software (PDOSS).
  Unlicense remains the license. The word catalog is CATE,
  specification 0005. The Unlicense numbered markdown file
  for 0009 is withdrawn.
-/

import TechTreeSpec
import RepoLinks
import SpecRegistry

namespace Sstt

open TechTreeSpec
open RepoLinks

def encode := encodeGraph

def decode := decodeGraph

def fileExtension : String := TechTreeSpec.fileExtension

def unpublishedBasename (name : String) : Bool :=
  name == "0009_VOCABULARY.md" || name == "0005_fargo.md" ||
    name == "0011_Unlicense.md" || name == "0009_Unlicense.md"

/-- Default file name. The writer refuses this name in the repository root. -/
def defaultOutputFileName : String := "tech_tree.sstt"

/-- Drop one leading `./` so `-o ./tech_tree.sstt` matches the bare dump name. -/
def stripLeadingDotSlash (s : String) : String :=
  if s.startsWith "./" then String.ofList (s.toList.drop 2) else s

/-- True when `outPath` is `tech_tree.sstt` in the repository root, or the bare file name that would land there from that root as the working directory. -/
def isRepoRootOutput (repo outPath : System.FilePath) : Bool :=
  let raw := stripLeadingDotSlash (toString outPath)
  let dump := repo / defaultOutputFileName
  raw == toString dump || raw == defaultOutputFileName

def keepPath (p : String) : Bool :=
  pathIsAscii p && !unpublishedBasename (baseName p)

def numberedSpecNodes (nodes : List Node) : List Node :=
  nodes.filter (fun n => n.kind == .numberedSpec)

def noWithdrawnNodes (nodes : List Node) : Bool :=
  nodes.all (fun n => !unpublishedBasename (baseName n.path))

def publishedSpecsPresent (nodes : List Node) : Bool :=
  SpecRegistry.publishedBasenames.all (fun b =>
    (numberedSpecNodes nodes).any (fun n => n.path == b))

def onlyPublishedNumberedSpecs (nodes : List Node) : Bool :=
  (numberedSpecNodes nodes).all (fun n =>
    SpecRegistry.publishedBasenames.contains n.path)

/-- Full repository graph: every published numbered file is a node, none of the withdrawn names are. -/
def repoGraphHonest (nodes : List Node) : Bool :=
  noWithdrawnNodes nodes &&
    publishedSpecsPresent nodes &&
    onlyPublishedNumberedSpecs nodes

/-- `--decode` fails the published numbered specification set check when `REPO_ROOT` is set and the graph is not `repoGraphHonest`. Without `REPO_ROOT`, that check is not applied. Wrong magic and a cyclic encoded graph still fail in `decodeGraph`. -/
def decodeHonestyFails (repoRoot : Option String) (nodes : List Node) : Bool :=
  match repoRoot with
  | none => false
  | some _ => !repoGraphHonest nodes

def hasSlash (p : String) : Bool :=
  let n := ((p.replace "\\" "/").splitOn "/").length
  decide (n > 1)

def isRootNumberedSpec (p : String) : Bool :=
  !hasSlash p && isNumberedSpecName p && !unpublishedBasename p

def isRootSiblingLean (p : String) : Bool :=
  !hasSlash p && p.endsWith ".lean" && (parseFourDigitPrefix p).isSome &&
    !unpublishedBasename p

def startsWithPath (s pre : String) : Bool :=
  RepoLinks.startsWithStr s pre

def classifyPath (p : String) : NodeKind :=
  if isRootNumberedSpec p then
    .numberedSpec
  else if isRootSiblingLean p then
    .siblingEncoding
  else if p.endsWith "SOURCE.md" || p.endsWith ".SOURCE" then
    .sourceNote
  else if startsWithPath p "ref/" then
    .refPin
  else if startsWithPath p ".agents/skills/" then
    .skill
  else
    .otherCited

def insertSortedPath (xs : List String) (p : String) : List String :=
  match xs with
  | [] => [p]
  | x :: rest =>
    if p == x then
      xs
    else if p < x then
      p :: xs
    else
      x :: insertSortedPath rest p

def sortPaths (ps : List String) : List String :=
  ps.foldl insertSortedPath []

def enumFrom (i : Nat) : List String → List (Nat × String)
  | [] => []
  | p :: rest => (i, p) :: enumFrom (i + 1) rest

def assignNodes (paths : List String) : List Node :=
  (enumFrom 0 (sortPaths paths)).map fun (i, p) =>
    { id := i, kind := classifyPath p, path := p }

def idOfPath (nodes : List Node) (p : String) : Option Nat :=
  match nodes.find? (fun n => n.path == p) with
  | some n => some n.id
  | none => none

def siblingLeanName (md : String) : String :=
  if md.endsWith ".md" then
    let cs := md.toList
    String.ofList (cs.take (cs.length - 3)) ++ ".lean"
  else
    md

def skipCitedTarget (t : String) : Bool :=
  skipTarget t

def citedPaths (sourceRel : String) (content : String) : List String :=
  Id.run do
    let mut out : List String := []
    for link in extractLinks content do
      if skipCitedTarget link.target then
        pure ()
      else
        let resolved := resolveTarget sourceRel link.target
        if unpublishedBasename (baseName resolved) then
          pure ()
        else
          out := out ++ [resolved]
    return out

/-- Markdown files supply citation edges. Other files are nodes only. -/
def contentsAreMarkdown (path : String) : Bool :=
  path.endsWith ".md"

/-- Skill paths, ref/ pins, and SOURCE notes cited from markdown must exist. Remote URLs and other path dests are not this check. -/
def isRequiredCiteDest (p : String) : Bool :=
  let k := classifyPath p
  k == .skill || k == .refPin || k == .sourceNote

def citedRequiredMissing (files : List (String × String)) : List String :=
  Id.run do
    let present := files.map (fun f => f.1)
    let mut miss : List String := []
    for (path, content) in files do
      if contentsAreMarkdown path then
        for dest in citedPaths path content do
          if unpublishedBasename (baseName dest) then
            pure ()
          else if isRequiredCiteDest dest then
            if present.contains dest then
              pure ()
            else if miss.contains dest then
              pure ()
            else
              miss := miss ++ [dest]
    return miss

/-- True when every cited skill, ref/ pin, or SOURCE dest is in the file list. -/
def citedRequiredPresent (files : List (String × String)) : Bool :=
  citedRequiredMissing files == []

def missingCitedDestMessage (p : String) : String :=
  s!"cited dest is missing: {p}"

def edgeKindFor (srcKind dstKind : NodeKind) : EdgeKind :=
  match srcKind, dstKind with
  | .numberedSpec, .numberedSpec => .cites
  | .numberedSpec, .refPin => .pin
  | .numberedSpec, .sourceNote => .pin
  | _, _ => .link

def addEdge (acc : List Edge) (e : Edge) : List Edge :=
  if acc.contains e then acc else acc ++ [e]

def edgesFromContents (nodes : List Node) (files : List (String × String)) :
    List Edge :=
  Id.run do
    let mut acc : List Edge := []
    for (path, content) in files do
      match idOfPath nodes path with
      | none => pure ()
      | some src =>
        match nodes.find? (fun n => n.id == src) with
        | none => pure ()
        | some srcNode =>
          if srcNode.kind == .numberedSpec then
            let lean := siblingLeanName path
            match idOfPath nodes lean with
            | some dst =>
              acc := addEdge acc
                { src := src, dst := dst, kind := .siblingEncoding }
            | none => pure ()
          if contentsAreMarkdown path then
            for destPath in citedPaths path content do
              match idOfPath nodes destPath with
              | none => pure ()
              | some dst =>
                if dst == src then
                  pure ()
                else
                  match nodes.find? (fun n => n.id == dst) with
                  | none => pure ()
                  | some dstNode =>
                    acc := addEdge acc
                      { src := src
                        dst := dst
                        kind := edgeKindFor srcNode.kind dstNode.kind }
    return acc

/-- Drop later edges that would create a directed cycle. Spec to spec
    edges are already oriented from the lower number to the higher. -/
def keepAcyclic (nodes : List Node) (edges : List Edge) : List Edge :=
  edges.foldl
    (fun acc e =>
      if isDag (nodeIds nodes) (edgePairs (acc ++ [e])) then
        acc ++ [e]
      else
        acc)
    []

def graphFailReason (nodes : List Node) (edges : List Edge) : String :=
  if !nodesHaveUniqueIds nodes then
    "duplicate node ids"
  else if !edgeEndpointsExist nodes edges then
    "edge endpoint missing"
  else if !pathsAreAscii nodes then
    "path is not ASCII"
  else if !isDag (nodeIds nodes) (edgePairs edges) then
    "encoded graph has a directed cycle"
  else
    "ok"

/-- Honest producer from a file list: nodes from paths, edges from markdown. Withdrawn numbered names are not nodes. -/
def graphFromFiles (files : List (String × String)) : List Node × List Edge :=
  let kept := files.filter (fun f => keepPath f.1)
  let paths := sortPaths (kept.map (fun f => f.1))
  let nodes := assignNodes paths
  let raw := edgesFromContents nodes kept
  let oriented := orientSpecEdges nodes raw
  let edges := keepAcyclic nodes oriented
  (nodes, edges)

def encodeFiles (files : List (String × String)) : Option (List UInt8) :=
  let (nodes, edges) := graphFromFiles files
  encodeGraph nodes edges

def listToByteArray (xs : List UInt8) : ByteArray :=
  Id.run do
    let mut a := ByteArray.empty
    for b in xs do
      a := a.push b
    return a

def byteArrayToList (a : ByteArray) : List UInt8 :=
  (List.range a.size).map (fun i => a.get! i)

def skipWalkName (n : String) : Bool :=
  n == ".git" || n == ".lake" || n == "result" || n == ".direnv" ||
    n == "node_modules" || n.endsWith ".olean" || n.endsWith ".ilean" ||
    n == "lake-manifest.json"

partial def walkRel (root : System.FilePath) (rel : String) : IO (Array String) := do
  let dir := if rel.isEmpty then root else root / rel
  if !(← dir.pathExists) then
    return #[]
  if !(← dir.isDir) then
    return #[rel]
  let ents ← dir.readDir
  let mut out : Array String := #[]
  for e in ents do
    let name := e.fileName
    if skipWalkName name then
      continue
    let child := if rel.isEmpty then name else rel ++ "/" ++ name
    let p := root / child
    if ← p.isDir then
      let sub ← walkRel root child
      out := out ++ sub
    else if ← p.pathExists then
      out := out.push child
  return out

def collectSeedPaths (repo : System.FilePath) : IO (Array String) := do
  let mut out : Array String := #[]
  if ← repo.pathExists then
    let ents ← repo.readDir
    for e in ents do
      let name := e.fileName
      if isRootNumberedSpec name || isRootSiblingLean name then
        out := out.push name
  if ← (repo / "ref").isDir then
    out := out ++ (← walkRel repo "ref")
  if ← (repo / ".agents" / "skills").isDir then
    out := out ++ (← walkRel repo ".agents/skills")
  return out

def pathExistsRel (repo : System.FilePath) (p : String) : IO Bool := do
  if p.isEmpty then
    return false
  (repo / p).pathExists

def collectCited (repo : System.FilePath) (paths : Array String) :
    IO (Array String × List String) := do
  let mut out := paths
  let mut missing : List String := []
  let mut i : Nat := 0
  while i < out.size do
    let rel := out[i]!
    i := i + 1
    if contentsAreMarkdown rel then
      let fp := repo / rel
      if ← fp.pathExists then
        let content ← IO.FS.readFile fp
        for dest in citedPaths rel content do
          if unpublishedBasename (baseName dest) then
            pure ()
          else if ← pathExistsRel repo dest then
            if !out.toList.contains dest then
              out := out.push dest
          else if isRequiredCiteDest dest then
            if !missing.contains dest then
              missing := missing ++ [dest]
  return (out, missing)

def loadFiles (repo : System.FilePath) (paths : Array String) :
    IO (List (String × String)) := do
  let mut out : List (String × String) := []
  for rel in sortPaths paths.toList do
    let fp := repo / rel
    if ← fp.pathExists then
      if contentsAreMarkdown rel then
        let c ← IO.FS.readFile fp
        out := out ++ [(rel, c)]
      else
        out := out ++ [(rel, "")]
  return out

def buildRepoGraph (repo : System.FilePath) : IO (List Node × List Edge) := do
  let seed ← collectSeedPaths repo
  let (all, _) ← collectCited repo seed
  let files ← loadFiles repo all
  return graphFromFiles files

def writeGraph (path : System.FilePath) (nodes : List Node) (edges : List Edge) :
    IO (Except String Nat) := do
  match encodeGraph nodes edges with
  | none =>
    return .error (graphFailReason nodes edges)
  | some bs =>
    IO.FS.writeBinFile path (listToByteArray bs)
    return .ok bs.length

def readGraph (path : System.FilePath) : IO (Except String (List Node × List Edge)) := do
  if !(← path.pathExists) then
    return .error s!"missing file {path}"
  let ba ← IO.FS.readBinFile path
  match decodeGraph (byteArrayToList ba) with
  | none => return .error "decode failed (wrong magic, cycle, or truncated)"
  | some g => return .ok g

def writeRepo (repo outPath : System.FilePath) : IO (Except String Nat) := do
  if isRepoRootOutput repo outPath then
    return .error
      "refusing to write tech_tree.sstt into the repository root; pass -o with a path outside that root"
  let seed ← collectSeedPaths repo
  let (all, missing) ← collectCited repo seed
  match missing with
  | p :: _ =>
    return .error (missingCitedDestMessage p)
  | [] =>
    let files ← loadFiles repo all
    let (nodes, edges) := graphFromFiles files
    if !repoGraphHonest nodes then
      return .error
        "encoded graph is missing a published numbered specification or includes a withdrawn name"
    writeGraph outPath nodes edges

end Sstt
