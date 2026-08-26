/-
  word_stats - Lean entry point for unique English word tracking.

  Usage:
    word_stats
    word_stats --write
  Environment: REPO_ROOT overrides the default discovery root (cwd).

  Default: fail when root WORD_STATS.md is missing or stale.
  --write: write WORD_STATS.md from the current scan.

  Exit 0 on success, 1 on drift, 2 on usage or IO errors.
-/

import WordStats

open WordStats

def usage : String :=
  "Usage: word_stats [--write]\n" ++
    "\n" ++
    "Track unique lowercased ASCII letter tokens in Surmount authored\n" ++
    "markdown against the CATE L_n catalog and RFC 2119 requirement\n" ++
    "keywords. Default: fail when WORD_STATS.md is missing or stale.\n" ++
    "--write writes WORD_STATS.md.\n" ++
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
  match (← generatedReport repo) with
  | .error msg =>
    IO.eprintln s!"word_stats: {msg}"
    return 2
  | .ok generated =>
    let reportPath := repo / reportFileName
    if writeMode then
      IO.FS.writeFile reportPath generated
      IO.println s!"word_stats: wrote {reportFileName}"
      return 0
    if !(← reportPath.pathExists) then
      IO.eprintln s!"word_stats: missing {reportFileName}; run word_stats --write"
      return 1
    let disk ← IO.FS.readFile reportPath
    if reportMatches disk generated then
      match (← statsForRepo repo) with
      | .error msg =>
        IO.eprintln s!"word_stats: {msg}"
        return 2
      | .ok s =>
        IO.println
          (s!"word_stats: {s.uniqueCount} unique, "
            ++ s!"{formatPercent (uniquePercentHundredths s)} proven unique, "
            ++ s!"{formatPercent (prevalencePercentHundredths s)} proven by prevalence")
        return 0
    let diskLines := disk.splitOn "\n"
    let genLines := generated.splitOn "\n"
    match firstDiffLine diskLines genLines 1 with
    | none =>
      IO.eprintln s!"word_stats: {reportFileName} is stale"
    | some (ln, a, b) =>
      IO.eprintln s!"word_stats: {reportFileName}:{ln}: stale"
      IO.eprintln s!"  disk: {a}"
      IO.eprintln s!"  want: {b}"
    IO.eprintln "word_stats: run word_stats --write to refresh"
    return 1
