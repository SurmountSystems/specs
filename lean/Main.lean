/-
  spec_check - Lean entry point for Surmount spec spec mechanical form rules.

  Usage:
    spec_check [path ...]
    With no paths, scans root numbered specs NNNN_*.md under REPO_ROOT (or cwd).

  Exit 0 on success, 1 on rule failures, 2 on usage errors.
-/

import SpecCheck

open SpecCheck

def usage : String :=
  "Usage: spec_check [path ...]\n" ++
  "\n" ++
  "Enforce Surmount spec spec mechanical form rules on markdown files:\n" ++
  "  pure ASCII; no bullet lists outside code fences; no excess kebab case;\n" ++
  "  RFC 2119 citation required for in-scope NNNN_*.md specs;\n" ++
  "  no trailing whitespace; tab-only leading indent; no hard-wrapped prose\n" ++
  "  in numbered specs.\n" ++
  "\n" ++
  "With no paths, scans repository-root numbered specs only:\n" ++
  "  basename must match ^[0-9]{4}_[A-Za-z0-9_]+\\.md$\n" ++
  "  (for example 0000_spec.md). README, UNLICENSE, AGENTS are not scanned.\n" ++
  "UNLICENSE.md / LICENSE* are excluded from style and RFC checks (ASCII only)\n" ++
  "when passed explicitly.\n" ++
  "Environment: REPO_ROOT overrides the default discovery root.\n"

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def main (args : List String) : IO UInt32 := do
  if args.contains "-h" || args.contains "--help" then
    IO.println usage
    return 0

  let repo ← resolveRepoRoot
  let paths : Array System.FilePath ← do
    if args.isEmpty then
      collectDefaultFiles repo
    else
      pure (args.toArray.map (fun s => (⟨s⟩ : System.FilePath)))

  if paths.isEmpty then
    IO.eprintln "spec_check: no markdown files to check"
    return 0

  let mut failCount : Nat := 0
  let mut fileCount : Nat := 0
  for p in paths do
    fileCount := fileCount + 1
    let diags ← checkPath p
    for d in diags do
      IO.eprintln (Diag.format d)
      failCount := failCount + 1

  if failCount > 0 then
    IO.eprintln s!"spec_check: {failCount} issue(s) found"
    return 1
  else
    IO.println s!"spec_check: OK ({fileCount} file(s))"
    return 0
