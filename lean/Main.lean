/-
  spec_check - Lean entry point for form rules and spelling on Surmount numbered specifications.

  Usage:
    spec_check [path ...]
    With no paths, scans numbered specifications at the repository root (NNNN_*.md) under
    REPO_ROOT (or cwd). Trailing whitespace and tab indent across the project are
    enforced by pure Nix (nix/whitespace.nix), not by this binary.

  American English spelling uses aspell (en_US) when checking numbered specifications.
  Skip with SPECS_SPELLING=0 or SPECS_SKIP_SPELLING=1. Flake check and
  nix develop put aspellWithDicts on PATH.

  Why Lean for form/spelling vs pure Nix for whitespace across the tree: see
  README.md section 7.2.1 and AGENTS.md "Why Lean vs pure Nix".

  Exit 0 on success, 1 on rule failures, 2 on usage errors.
-/

import SpecCheck
import SpecRegistry

open SpecCheck

def usage : String :=
  "Usage: spec_check [path ...]\n" ++
  "\n" ++
  "Enforce Surmount mechanical form rules on numbered specifications (root NNNN_*.md):\n" ++
  "  pure ASCII; no bullet lists outside code fences; no excess hyphenated tokens;\n" ++
  "  RFC 2119 citation required; no trailing whitespace; leading indent that uses\n" ++
  "  tabs only; no prose wrapped to a column.\n" ++
  "  American English spelling via aspell (en_US) when aspell is on PATH.\n" ++
  "  Number and file name registry: published specs match SpecRegistry;\n" ++
  "  published 0005_CATE.md, 0006_RSI.md, 0007_CI.md, 0008_Formal_Vibefication.md, 0009_PDOSS.md, and 0010_Surmount_Systems.md MUST exist;\n" ++
  "  stale 0005_fargo.md MUST fail; stale 0011_Unlicense.md MUST fail; withdrawn 0009_VOCABULARY.md MUST fail; withdrawn 0009_Unlicense.md MUST fail;\n" ++
  "  Carbonado is not assigned; beastdb capitalization MUST be lowercase.\n" ++
  "  CATE leftover unstack phrases in numbered spec prose (0005_CATE.md);\n" ++
  "  planned file tokens in numbered specs other than 0000 require a Residual heading.\n" ++
  "  numbered specs that name Keagan or proofofkeags must also contain proofofkeags.com.\n" ++
  "  residual must not say a named product never started.\n" ++
  "  extra honesty markdown: AGENTS.md, README.md, VOCABULARY.md.\n" ++
  "\n" ++
  "With no paths, discovers numbered specifications at the root only (same naming scheme).\n" ++
  "UNLICENSE.md / LICENSE* get ASCII and whitespace only when passed explicitly\n" ++
  "(no style/RFC/spelling). Whitespace across the project is pure Nix checks.whitespace.\n" ++
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

  -- When spelling is required (numbered specifications, not skipped) but setup failed, exit 2.
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

  -- Registry: always scan the repository root numbered set so drift of an
  -- extra planned file or a missing published file fails even when the
  -- caller passed a single path (pre-commit).
  let registry ← SpecRegistry.checkRepo repo
  for d in registry do
    IO.eprintln (SpecRegistry.Finding.format d)
    failCount := failCount + 1

  -- Residual honesty: never-real product claims. Always scan every root
  -- numbered specification plus extraHonestyMarkdownFileNames. That list
  -- is the same list WordStats reads. A missing file on that list fails.
  -- Absence of a retired root tracker does not fail this scan.
  let numberedHonesty ← collectRootNumberedSpecs repo
  for p in numberedHonesty do
    let name := baseName p.toString
    let bs ← IO.FS.readBinFile p
    if isPureAscii bs then
      let content := asciiToString bs
      for d in checkNeverRealProductClaim name content do
        IO.eprintln (Diag.format d)
        failCount := failCount + 1
  for name in SpecRegistry.extraHonestyMarkdownFileNames do
    let p := repo / name
    if !(← p.pathExists) then
      IO.eprintln s!"{name}: honesty scan file is missing from the extra markdown list"
      failCount := failCount + 1
    else
      let bs ← IO.FS.readBinFile p
      if isPureAscii bs then
        let content := asciiToString bs
        for d in checkNeverRealProductClaim name content do
          IO.eprintln (Diag.format d)
          failCount := failCount + 1

  if failCount > 0 then
    IO.eprintln s!"spec_check: {failCount} issue(s) found"
    return 1
  else
    IO.println s!"spec_check: OK ({fileCount} file(s))"
    return 0
