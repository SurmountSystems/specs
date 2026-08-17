/-
  spec_check - Lean entry point for Surmount numbered-spec form rules and spelling.

  Usage:
    spec_check [path ...]
    With no paths, scans repository-root numbered specs (NNNN_*.md) under
    REPO_ROOT (or cwd). Project-wide trailing whitespace and tab indent are
    enforced by pure Nix (nix/whitespace.nix), not by this binary.

  American English spelling uses aspell (en_US) when checking numbered specs.
  Skip with SPECS_SPELLING=0 or SPECS_SKIP_SPELLING=1. Flake check and
  nix develop put aspellWithDicts on PATH.

  Why Lean for form/spelling vs pure Nix for tree-wide whitespace: see
  README.md section 7.2.1 and AGENTS.md "Why Lean vs pure Nix".

  Exit 0 on success, 1 on rule failures, 2 on usage errors.
-/

import SpecCheck

open SpecCheck

def usage : String :=
  "Usage: spec_check [path ...]\n" ++
  "\n" ++
  "Enforce Surmount mechanical form rules on numbered specs (root NNNN_*.md):\n" ++
  "  pure ASCII; no bullet lists outside code fences; no excess kebab case;\n" ++
  "  RFC 2119 citation required; no trailing whitespace; tab-only leading\n" ++
  "  indent; no hard-wrapped prose.\n" ++
  "  American English spelling via aspell (en_US) when aspell is on PATH.\n" ++
  "\n" ++
  "With no paths, discovers root numbered specs only (same naming scheme).\n" ++
  "UNLICENSE.md / LICENSE* get ASCII and whitespace only when passed explicitly\n" ++
  "(no style/RFC/spelling). Project-wide whitespace is pure Nix checks.whitespace.\n" ++
  "Environment: REPO_ROOT overrides the default discovery root.\n" ++
  "  SPECS_SPELLING=0 or SPECS_SKIP_SPELLING=1 skips spelling silently.\n"

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
      collectRootNumberedSpecs repo
    else
      pure (args.toArray.map (fun s => (⟨s⟩ : System.FilePath)))

  if paths.isEmpty then
    IO.eprintln "spec_check: no files to check"
    return 0

  let skipSpell ← spellingSkipRequested
  let hasNumbered := paths.any fun p => isNumberedSpecName (baseName p.toString)
  let aspell? : Option AspellHome ←
    if skipSpell || !hasNumbered then
      pure none
    else
      match (← prepareAspellHome repo) with
      | .error msg =>
        IO.eprintln msg
        pure none
      | .ok home => pure (some home)

  -- When spelling is required (numbered specs, not skipped) but setup failed, exit 2.
  if !skipSpell && hasNumbered then
    match aspell? with
    | none => return 2
    | some _ => pure ()

  let mut failCount : Nat := 0
  let mut fileCount : Nat := 0
  for p in paths do
    fileCount := fileCount + 1
    let diags ← checkPath repo p aspell?
    for d in diags do
      IO.eprintln (Diag.format d)
      failCount := failCount + 1

  if failCount > 0 then
    IO.eprintln s!"spec_check: {failCount} issue(s) found"
    return 1
  else
    IO.println s!"spec_check: OK ({fileCount} file(s))"
    return 0
