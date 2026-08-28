/-
  Runtime checks for the CI meaning model (0007_CI.md).
  Theorems in CiProofs.lean already fail to typecheck if the model is widened
  (CI numbered 0005 or 0006, unsigned without exception treated as
  conforming, commit on red treated as conforming, layers mashed,
  byte identity claimed true, emit = ELF treated as proved).
  This executable re-checks the decidable facts so a silent Bool
  regression prints FAIL lines, matching spec_check_tests style.
-/

import Ci
import SpecRegistry

open Ci
open SpecRegistry

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

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

def runCases : List Case :=
  [
    expectEqNat "CI is specification 0007" specNumber 7,
    expectEqString "spec file is 0007_CI.md" specFileName "0007_CI.md",
    expectEqString "product short name is CI" productName "CI",
    expectTrue "CI live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "CI live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "CI is not specification 0005" (specNumber != cateSpecNumber),
    expectTrue "CI is not specification 0006" (specNumber != rsiSpecNumber),
    expectEqNat "CATE is specification 0005" cateSpecNumber 5,
    expectFalse "CATE is not specification 0006" (cateSpecNumber == 6),
    expectEqNat "RSI is specification 0006" rsiSpecNumber 6,
    expectFalse "fargo is not assigned" fargoAssigned,
    expectTrue "fargo is not specification 0007"
      (!fargoAssigned && specNumber == 7),
    expectFalse "fargo is not specified here" fargoSpecifiedHere,
    expectFalse "SSSP is not specified" ssspSpecified,
    expectEqString "this repository named gate"
      thisRepoNamedGate
      "nix flake check \"path:$PWD\" --print-build-logs",
    expectFalse "commit on red does not conform" commitOnRed.conforming,
    expectTrue "commit on green conforms" commitOnGreen.conforming,
    expectFalse "residual does not replace a red gate"
      residualInsteadOfGreen.conforming,
    expectTrue "naming residual on red is the forbidden substitute"
      (residualReplacesRedGate residualInsteadOfGreen),
    expectFalse "unsigned without exception does not conform"
      (unsignedConforming .unsigned noException),
    expectTrue "operator signed conforms"
      (unsignedConforming .operatorSigned noException),
    expectTrue "named two tree exception allows unsigned"
      (unsignedConforming .unsigned namedException),
    expectFalse "treating the exception as a general skip does not apply"
      (DualTreeException.applies generalSkip),
    expectFalse "unsigned as a general skip does not conform"
      (unsignedConforming .unsigned generalSkip),
    expectFalse "agents must not create commit objects"
      agentsMayCreateCommitObjects,
    expectFalse "pre-commit is not the operator signature"
      preCommitSubstitutesForOperatorSignature,
    expectFalse "this repository does not claim the unsigned exception"
      thisRepoClaimsUnsignedException,
    expectTrue "this repository keeps layers separate"
      specsRepoKeepsLayersSeparate,
    expectTrue "numbered markdown is not the meaning model"
      (StackLayer.numberedMarkdown != StackLayer.meaningModel),
    expectTrue "numbered markdown is not product implementation"
      (StackLayer.numberedMarkdown != StackLayer.productImplementation),
    expectTrue "meaning model is not product implementation"
      (StackLayer.meaningModel != StackLayer.productImplementation),
    expectTrue "spec markdown is the contract" specMarkdownIsContract,
    expectFalse "meaning proofs are not a second form checker"
      meaningProofsAreSecondFormChecker,
    expectTrue "Lean 4 surfaces logical inconsistency"
      lean4SurfacesLogicalInconsistency,
    expectFalse "this specifications repository does not unify the three layers"
      ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl,
    expectTrue "Systems Lean product path unifies the three layers"
      ProductHome.systemsLeanProductTree.unifiesSpecProofImpl,
    expectFalse "theorems are not dumped into numbered markdown"
      dumpTheoremsIntoNumberedMarkdown,
    expectTrue "byte identity is required for the product"
      byteIdentity.requiredForSystemsLeanSlakeProduct,
    expectFalse "byte identity is not claimed true" byteIdentity.claimedTrue,
    expectTrue "byte identity residual is honest" byteIdentity.honest,
    expectFalse "emit equal to ELF is not a proved identity"
      emitEqualsElfProved,
    expectTrue "SSSSS and beastdb reality check is required"
      sssssBeastDbReality.requiredForSssssBeastDbStack,
    expectFalse "reality check is not claimed done"
      sssssBeastDbReality.claimedDone,
    expectTrue "reality check residual is honest" sssssBeastDbReality.honest,
    expectFalse "Rust elevation process is not specified here"
      rustElevationProcessSpecifiedHere,
    expectFalse "a conforming CI product is not claimed"
      conformingCiProductClaimed,
    expectEmpty "correct 0007_CI token passes"
      (scanContent "0007_CI.md"
        "This specification is number 0007. File 0007_CI.md.\n"),
    expectNonEmpty "identity sentence with wrong number fails"
      (scanContent "0007_CI.md"
        "This specification is number 0006.\n"),
    expectNonEmpty "missing published 0007 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md", "0005_CATE.md",
          "0006_RSI.md"]),
    expectEmpty "all published basenames including 0007 pass"
      (findingsForBasenames publishedBasenames)
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  if failed == 0 then
    IO.println s!"All {runCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {runCases.length} tests failed."
    return 1
