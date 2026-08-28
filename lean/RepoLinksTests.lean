/-
  Hermetic tests for markdown path links in this repository.
  Missing in-repository path fails. Remote URLs and fragment only
  targets are skipped. Exit 1 on FAIL.
-/

import RepoLinks

open RepoLinks

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEmpty {α : Type} [Repr α] (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected empty, got {repr xs}" }

def expectNonEmpty {α : Type} (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := false, detail := "expected diagnostics, got none" }
  else
    { name := name, ok := true }

def existsKnown (p : String) : Bool :=
  p == "0000_spec.md" || p == "0005_CATE.md" || p == "ref/rfc2119" ||
    p == "README.md" || p == "lean/Surmount.lean"

def runCases : List Case :=
  [
    expectTrue "http is skipped" (isHttp "https://proofofkeags.com/x"),
    expectTrue "http scheme skipped" (isHttp "http://example.com"),
    expectFalse "relative path is not http" (isHttp "0000_spec.md"),
    expectTrue "fragment only is skipped" (skipTarget "#scope"),
    expectFalse "path plus fragment is not skipped"
      (skipTarget "0000_spec.md#scope"),
    expectTrue "strip fragment keeps path"
      (stripFragment "0000_spec.md#scope" == "0000_spec.md"),
    expectTrue "resolve relative to root file"
      (resolveTarget "0000_spec.md" "0005_CATE.md" == "0005_CATE.md"),
    expectTrue "resolve ref path"
      (resolveTarget "0000_spec.md" "ref/rfc2119" == "ref/rfc2119"),
    expectTrue "resolve sibling lean"
      (resolveTarget "0000_spec.md" "0000_spec.lean" == "0000_spec.lean"),
    expectEmpty "existing numbered spec link passes"
      (findingsForLinks "0000_spec.md"
        "see [CATE](0005_CATE.md).\n" existsKnown),
    expectEmpty "https link is skipped"
      (findingsForLinks "0000_spec.md"
        "see [x](https://proofofkeags.com/research/x).\n" existsKnown),
    expectEmpty "fragment only is skipped"
      (findingsForLinks "0000_spec.md" "see [x](#scope).\n" existsKnown),
    expectEmpty "path plus fragment of existing file passes"
      (findingsForLinks "0000_spec.md"
        "see [x](0005_CATE.md#scope).\n" existsKnown),
    expectEmpty "existing ref path passes"
      (findingsForLinks "0000_spec.md"
        "local path [rfc](ref/rfc2119).\n" existsKnown),
    expectNonEmpty "missing in-repo link fails"
      (findingsForLinks "0000_spec.md"
        "see [missing](no_such_file.md).\n" existsKnown),
    expectTrue "missing finding names the target"
      (match findingsForLinks "0000_spec.md"
          "see [missing](no_such_file.md).\n" existsKnown with
        | f :: _ =>
          (f.message.splitOn "no_such_file.md").length != 1
        | [] => false),
    expectEmpty "link inside a fence is ignored"
      (findingsForLinks "0000_spec.md"
        "```\n[x](no_such_file.md)\n```\n" existsKnown),
    expectEmpty "link form inside inline code is ignored"
      (findingsForLinks "0000_spec.md"
        "markdown links of the form `[text](target)`.\n" existsKnown)
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      IO.println s!"FAIL {c.name} {c.detail}"
  if failed == 0 then
    IO.println s!"repo_links_tests: {runCases.length} passed"
    return 0
  IO.eprintln s!"repo_links_tests: {failed} failed"
  return 1
