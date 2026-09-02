/-
  inconsistency_report - Lean entry point for the README table of
  proven logical inconsistencies in Lean meaning models.

  Usage:
    inconsistency_report
    inconsistency_report --write
  Environment: REPO_ROOT overrides the default discovery root (cwd).

  Default: fail when README.md is missing the table or the table is
  stale versus the catalog of proven False mash claims.
  --write: refresh the marked table in README.md.

  Exit 0 on success, 1 on drift, 2 on usage or IO errors.
-/

import InconsistencyReport

open InconsistencyReport

def usage : String :=
  "Usage: inconsistency_report [--write]\n" ++
    "\n" ++
    "Check that README.md contains a current table of proven logical\n" ++
    "inconsistencies in this repository's Lean meaning models.\n" ++
    "Default: fail when the table is missing or stale.\n" ++
    "--write refreshes the marked table in README.md.\n" ++
    "Environment: REPO_ROOT overrides the default discovery root.\n"

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def main (args : List String) : IO UInt32 := do
  if args.contains "-h" || args.contains "--help" then
    IO.println usage
    return 0
  let writeMode := args.contains "--write"
  let rest := args.filter (fun a => a != "--write")
  if !rest.isEmpty then
    IO.eprintln usage
    return 2
  let repo ← resolveRepoRoot
  let readmePath := repo / readmeFileName
  if !(← readmePath.pathExists) then
    IO.eprintln s!"inconsistency_report: missing {readmeFileName}"
    return 2
  let disk ← IO.FS.readFile readmePath
  if writeMode then
    let next := refreshReadme disk
    IO.FS.writeFile readmePath next
    IO.println s!"inconsistency_report: wrote table in {readmeFileName}"
    return 0
  if !readmeTableCurrent disk then
    match extractSection disk with
    | none =>
      IO.eprintln
        s!"inconsistency_report: {readmeFileName} is missing the proven logical inconsistency table"
      IO.eprintln "inconsistency_report: run inconsistency_report --write to refresh"
    | some body =>
      let diskLines := (stripOuterNewlines body).splitOn "\n"
      let genLines := generatedTable.splitOn "\n"
      match firstDiffLine diskLines genLines 1 with
      | none =>
        IO.eprintln s!"inconsistency_report: {readmeFileName} table is stale"
      | some (ln, a, b) =>
        IO.eprintln s!"inconsistency_report: {readmeFileName} table:{ln}: stale"
        IO.eprintln s!"  disk: {a}"
        IO.eprintln s!"  want: {b}"
      IO.eprintln "inconsistency_report: run inconsistency_report --write to refresh"
    return 1
  IO.println
    (s!"inconsistency_report: {provenClaims.length} proven False mash claims, table current")
  return 0
