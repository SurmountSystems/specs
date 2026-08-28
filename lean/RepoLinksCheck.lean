/-
  repo_links_check - Lean entry point for markdown path links in this
  repository.

  Usage:
    repo_links_check
  Environment: REPO_ROOT overrides the default discovery root (cwd).

  Exit 0 on success, 1 on missing path targets, 2 on usage errors.
-/

import RepoLinks

open RepoLinks

def usage : String :=
  "Usage: repo_links_check\n" ++
  "\n" ++
  "Fail when a numbered specification or README.md contains a markdown\n" ++
  "path link [text](target) whose target does not exist in this\n" ++
  "repository. Skip http:// and https://. Fragment only targets are\n" ++
  "the same file. This floor does not parse every HTML href.\n" ++
  "Environment: REPO_ROOT overrides the default discovery root.\n"

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def main (args : List String) : IO UInt32 := do
  if args.contains "-h" || args.contains "--help" then
    IO.println usage
    return 0
  if !args.isEmpty then
    IO.eprintln usage
    return 2
  let repo ← resolveRepoRoot
  let findings ← checkRepo repo
  if findings.isEmpty then
    IO.println "repo_links_check: markdown path links resolve"
    return 0
  for f in findings do
    IO.eprintln (Finding.format f)
  IO.eprintln s!"repo_links_check: {findings.length} finding(s)"
  return 1
