/-
  Command line writer and reader of .sstt files.

  Usage:
    sstt_write -o path
    sstt_write --decode path
    sstt_write --self-check -o path

  Environment: REPO_ROOT overrides the default discovery root (cwd).
  When REPO_ROOT is set, --decode requires the published numbered
  specification set. Without REPO_ROOT, --decode of an arbitrary file
  does not. With no -o, the writer writes tech_tree.sstt under a new
  temporary directory. It refuses to write tech_tree.sstt into the
  repository root.
-/

import Sstt

open Sstt

def usage : String :=
  "Usage: sstt_write -o path\n" ++
  "       sstt_write --decode path\n" ++
  "       sstt_write --self-check -o path\n" ++
  "\n" ++
  "Write a .sstt file from numbered specifications, sibling Lean\n" ++
  "encodings, ref/ pins, SOURCE.md notes, project skills, and other\n" ++
  "cited files in this repository. Numbered spec citation is stored as\n" ++
  "an edge from the lower spec number to the higher. Decode checks magic\n" ++
  "SSTECHTREE01 and rejects a cyclic encoded graph. Self-check writes,\n" ++
  "reads the file back, and fails when published numbered specification\n" ++
  "nodes do not match the registry or a withdrawn name is a node.\n" ++
  "When REPO_ROOT is set, --decode applies the same published numbered\n" ++
  "specification set check. Without REPO_ROOT, --decode of an arbitrary\n" ++
  "file does not require that set. Wrong magic and a cyclic encoded\n" ++
  "graph still fail.\n" ++
  "With no -o, output is tech_tree.sstt under a new temporary directory.\n" ++
  "The writer refuses to write tech_tree.sstt into the repository root.\n" ++
  "Environment: REPO_ROOT overrides the default discovery root.\n"

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def writeOut (repo outPath : System.FilePath) : IO UInt32 := do
  match ← writeRepo repo outPath with
  | .error msg =>
    IO.eprintln s!"sstt_write: {msg}"
    return 1
  | .ok n =>
    IO.println s!"sstt_write: wrote {n} bytes to {outPath}"
    return 0

def decodePath (p : System.FilePath) : IO UInt32 := do
  match ← readGraph p with
  | .error msg =>
    IO.eprintln s!"sstt_write: {msg}"
    return 1
  | .ok (nodes, edges) =>
    let repoRoot ← IO.getEnv "REPO_ROOT"
    if decodeHonestyFails repoRoot nodes then
      IO.eprintln
        "sstt_write: decode succeeded but published numbered specification nodes do not match the registry"
      return 1
    IO.println s!"sstt_write: decoded {nodes.length} nodes {edges.length} edges"
    return 0

def selfCheck (repo outPath : System.FilePath) : IO UInt32 := do
  match ← writeRepo repo outPath with
  | .error msg =>
    IO.eprintln s!"sstt_write: {msg}"
    return 1
  | .ok n =>
    match ← readGraph outPath with
    | .error msg =>
      IO.eprintln s!"sstt_write: {msg}"
      return 1
    | .ok (nodes, edges) =>
      if !repoGraphHonest nodes then
        IO.eprintln
          "sstt_write: decode succeeded but published numbered specification nodes do not match the registry"
        return 1
      let specN := (numberedSpecNodes nodes).length
      IO.println
        s!"sstt_write: self-check wrote {n} bytes to {outPath}, decoded {nodes.length} nodes {edges.length} edges, {specN} published numbered specifications"
      return 0

def writeDefaultTemp (repo : System.FilePath) : IO UInt32 := do
  let tmp ← IO.FS.createTempDir
  writeOut repo (tmp / defaultOutputFileName)

def main (args : List String) : IO UInt32 := do
  if args.contains "-h" || args.contains "--help" then
    IO.println usage
    return 0
  match args with
  | ["--decode", p] => decodePath ⟨p⟩
  | ["-o", p] =>
    let repo ← resolveRepoRoot
    writeOut repo ⟨p⟩
  | ["--self-check", "-o", p] =>
    let repo ← resolveRepoRoot
    selfCheck repo ⟨p⟩
  | ["--self-check"] =>
    IO.eprintln "sstt_write: --self-check requires -o path (not the repository root)"
    return 2
  | [] =>
    let repo ← resolveRepoRoot
    writeDefaultTemp repo
  | _ =>
    IO.eprintln usage
    return 2
