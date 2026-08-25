/-
  Runtime checks for the SSSSS meaning model (0004_SSSSS.md).
  Theorems in Sssss.lean already fail to typecheck if the model is
  widened (hashing as primary identity, Systems Lean numbered 0003,
  SSSSS numbered 0003). This executable re-checks the decidable facts
  so a silent `sorry` or a Bool regression prints FAIL lines, matching
  spec_check_tests style.
-/

import Sssss
import SpecRegistry

open Sssss
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
    expectEqNat "SSSSS is specification 0004" specNumber 4,
    expectEqString "spec file is 0004_SSSSS.md" specFileName "0004_SSSSS.md",
    expectEqString "product short name is SSSSS" productName "SSSSS",
    expectEqNat "Systems Lean is specification 0002" systemsLeanSpecNumber 2,
    expectEqNat "beastdb is specification 0003" beastdbSpecNumber 3,
    expectTrue "SSSSS is not specification 0002" (ssssSpecNumber != 2),
    expectTrue "SSSSS is not specification 0003" (ssssSpecNumber != 3),
    expectEqNat "fargo is planned as 0005" fargoPlannedSpecNumber 5,
    expectFalse "Carbonado is not assigned" carbonadoAssigned,
    expectFalse "this spec does not claim an implementation exists"
      specClaimsImplementationExists,
    expectFalse "television canon is not required for conformance"
      televisionCanonRequiredForConformance,
    expectFalse "Lean Machine has no numbered specification" leanMachineHasNumberedSpec,
    expectFalse "this spec does not require fargo" fargoRequiredByThisSpec,
    expectTrue "sequential identity is ok"
      (IdentityKind.ok .sequentialInteger),
    expectFalse "hashing as primary identity is not ok"
      (IdentityKind.ok .hashDigest),
    expectEqNat "LanguageID bit width is 64" languageIdBitWidth 64,
    expectEqNat "WordID bit width is 64" wordIdBitWidth 64,
    expectEqNat "LanguageID capacity is 2^64" languageIdCapacity (2 ^ 64),
    expectEqNat "WordID capacity is 2^64" wordIdCapacity (2 ^ 64),
    expectTrue "empty runs encode to no tokens" encodeEmptyOk,
    expectTrue "LanguageID prefix omitted when language is unchanged"
      prefixOmittedWhenUnchangedOk,
    expectTrue "LanguageID prefix emitted when language changes"
      prefixEmittedWhenChangedOk,
    expectEqNat "exactly three provenance tags" Provenance.all.length 3,
    expectTrue "canonical Rosetta sequential identity is ok"
      (rosettaCanonical.identityOk .sequentialInteger),
    expectFalse "Rosetta hash identity is not ok"
      (rosettaCanonical.identityOk .hashDigest),
    expectTrue "emit uses inverse WordID lookup" emitUsesRosettaOk,
    expectTrue "missing mapping does not invent a WordID"
      missingMappingEmitsNothingOk,
    expectFalse "emit does not use hash identity" emitUsesHashIdentity,
    expectTrue "reduced neural proposal is acceptable" neuralReduced.acceptable,
    expectFalse "unreduced neural proposal is not acceptable"
      neuralNotReduced.acceptable,
    expectFalse "Lean proving a neural proposal is not a MUST conjunct"
      leanProveBeforeAuthoritativeRequiredForConformance,
    expectTrue "provisional natural language translation is ok"
      nlProvisional.ok,
    expectTrue "Lean proven natural language translation is ok" nlProven.ok,
    expectFalse "unmarked natural language translation is not ok"
      nlUnmarked.ok,
    expectFalse "natural language translation is not required"
      naturalLanguageRequiredForConformance,
    expectTrue "correct Systems Lean file name is ok"
      (systemsLeanFileOk "0002_Systems_Lean.md"),
    expectFalse "wrong Systems Lean file name 0003_systems_lean is not ok"
      (systemsLeanFileOk "0003_systems_lean.md"),
    expectTrue "canonical durable beastdb claim is ok" durableCanonical.ok,
    expectFalse "durable state not in beastdb is not ok" durableWrongStore.ok,
    expectTrue "canonical claim for components that are safety critical is ok" safetyCanonical.ok,
    expectFalse "garbage collection on the wire for components that are safety critical is not ok"
      safetyGc.ok,
    expectFalse "missing CompCert is not ok" safetyMissingCompCert.ok,
    expectFalse "missing Slake bootstrap is not ok" safetyMissingBootstrap.ok,
    expectFalse "subset only Slake typecheck is not ok"
      safetySubsetTypecheck.ok,
    expectFalse "named residual does not substitute for CompCert"
      safetyResidualSubstitutes.ok,
    expectTrue "canonical representation is ok" representationCanonical.ok,
    expectFalse "hashed representation is not ok" representationHashed.ok,
    expectTrue "canonical product conforms" canonicalProduct.conforms,
    expectFalse "hashing as primary identity does not conform"
      productHashed.conforms,
    expectFalse "hashing as Rosetta identity does not conform"
      productHashedRosetta.conforms,
    expectFalse "wrong Systems Lean file name does not conform"
      productWrongSystemsLeanFile.conforms,
    expectFalse "unreduced neural proposal does not conform"
      productUnreducedNeural.conforms,
    expectFalse "unmarked natural language translation does not conform"
      productUnmarkedNl.conforms,
    expectTrue "provisional natural language translation still conforms"
      productProvisionalNl.conforms,
    expectFalse "missing CompCert does not conform"
      productMissingCompCert.conforms,
    expectFalse "residual substitute does not conform"
      productResidualSubstitutes.conforms,
    expectFalse "wrong durable store does not conform"
      productWrongStore.conforms,
    expectNonEmpty "stale 0003_SSSSS token fails"
      (scanContent "0002_Systems_Lean.md"
        "planned file name `0003_SSSSS.md` is stale.\n"),
    expectEmpty "published 0004_SSSSS token passes"
      (scanContent "0004_SSSSS.md"
        "This specification is number 0004. File 0004_SSSSS.md.\n"),
    expectNonEmpty "stale 0003_systems_lean token fails"
      (scanContent "0004_SSSSS.md" "see 0003_systems_lean.md for language.\n"),
    expectEmpty "correct 0002_Systems_Lean token passes"
      (scanContent "0004_SSSSS.md"
        "Systems Lean is specified in 0002_Systems_Lean.md.\n"),
    expectNonEmpty "unassigned 0006 filename token fails"
      (scanContent "0004_SSSSS.md" "do not cite 0006_carbonado.md\n"),
    expectNonEmpty "identity sentence with wrong number fails"
      (scanContent "0004_SSSSS.md"
        "This specification is number 0003.\n"),
    expectNonEmpty "missing published 0004 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md"]),
    expectEmpty "all published basenames including 0004 pass"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md"]),
    expectNonEmpty "planned fargo file present fails"
      (findingsForPlannedPresent ["0005_fargo.md"]),
    expectTrue "registry numbers are unique" (!hasDupNumbers),
    expectTrue "registry file names are unique" (!hasDupFilenames)
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
