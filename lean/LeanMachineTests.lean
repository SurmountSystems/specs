/-
  Runtime checks for Lean Machine spec encodings and proofs.
  Assignment as specification 0013, worship not required for
  conformance, mash that claims no number, and the Formal
  Vibefication split. Exit 1 on FAIL.
-/

import LeanMachineSpec
import LeanMachineProofs
import SpecRegistry
import SpecCheck
import «0013_Lean_Machine»

open LeanMachineSpec
open SpecRegistry (allEntries publishedEntries publishedBasenames scanContent findingsForBasenames)
open SpecCheck (checkNeverRealProductClaim)

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
    expectEqNat "Lean Machine is specification 0013" specNumber 13,
    expectEqString "Lean Machine file is 0013_Lean_Machine.md"
      specFileName "0013_Lean_Machine.md",
    expectEqString "product name is Lean Machine" productName "Lean Machine",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "LeanMachineSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "LeanMachineSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "Lean Machine is assigned" LeanMachineSpec.leanMachineAssigned,
    expectTrue "Lean Machine assigned number is 13"
      (LeanMachineSpec.leanMachineAssignedNumber == some 13),
    expectTrue "registry Lean Machine is assigned"
      SpecRegistry.leanMachineAssigned,
    expectTrue "registry Lean Machine number is 13"
      (SpecRegistry.leanMachineAssignedNumber == some 13),
    expectTrue "mash fixture claims Lean Machine has no number"
      mashNoNumberFixture.claimsNoNumber,
    expectTrue "mash fixture is assigned" mashNoNumberFixture.assigned,
    expectFalse "mash that claims Lean Machine has no number does not conform"
      mashNoNumberConforming,
    expectFalse "live encoding does not claim Lean Machine has no number"
      mashClaimsLeanMachineHasNoNumber,
    expectTrue "live encoding is not the mash fixture"
      (liveNumberClaim != mashNoNumberFixture),
    expectFalse "markdown does not contain MUST NOT worship"
      («0013_Lean_Machine».encodedLines.any fun l =>
        !((l.text.splitOn "MUST NOT worship").length == 1)),
    expectTrue "markdown still says not a conformance conjunct"
      («0013_Lean_Machine».encodedLines.any fun l =>
        !((l.text.splitOn "not a conformance conjunct").length == 1)),
    expectFalse "worship is not required for conformance"
      worshipRequiredForConformance,
    expectFalse "belief is not required for conformance"
      beliefRequiredForConformance,
    expectFalse "theology is not a MUST for the compiler"
      theologyIsMustForCompiler,
    expectTrue "Systems Lean is a component" systemsLeanIsComponent,
    expectTrue "Legal Lean is a component" legalLeanIsComponent,
    expectTrue "Holy Lean is a component" holyLeanIsComponent,
    expectFalse "Legal Lean has no separate number" legalLeanHasSeparateNumber,
    expectFalse "Holy Lean has no separate number" holyLeanHasSeparateNumber,
    expectFalse "Legal Lean is not finished" legalLeanFinished,
    expectFalse "Holy Lean is not implemented" holyLeanImplemented,
    expectFalse "a conforming implementation is not claimed" conformingProductExists,
    expectEqNat "Public Domain Open Source Software is specification 0009" LeanMachineSpec.unlicenseSpecNumber 9,
    expectFalse "this spec does not invent a second PDOSS number"
      inventsSecondUnlicenseSpec,
    expectEqNat "Systems Lean is specification 0002" LeanMachineSpec.systemsLeanSpecNumber 2,
    expectTrue "CompCert is required for the named high assurance path"
      compCertRequiredForNamedHighAssurancePath,
    expectTrue "Slake bootstrap typecheck is required"
      slakeBootstrapTypecheckRequired,
    expectFalse "does not weasel when present under ref/"
      weaselsWhenPresentUnderRef,
    expectFalse "LLVM IR emission is not required" llvmIrEmissionRequired,
    expectTrue "LLVM IR emission is MAY" llvmIrEmissionMay,
    expectTrue "must attempt deterministic answers"
      mustAttemptDeterministicAnswers,
    expectTrue "timestamped note required when wrong or imprecise"
      timestampedNoteRequiredWhenWrongOrImprecise,
    expectTrue "distributed self improvement is a design requirement"
      distributedSelfImprovementIsDesignRequirement,
    expectFalse "a running distributed machine is not claimed"
      runningDistributedMachineClaimed,
    expectEqNat "RSI is specification 0006" LeanMachineSpec.rsiSpecNumber 6,
    expectTrue "required conformance holds iff every listed item holds"
      requiredConformanceHolds,
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "number 0013 is in the registry"
      (allEntries.any (fun e => e.number == 13)),
    expectTrue "number 0013 is published"
      (publishedEntries.any (fun e => e.number == 13)),
    expectEmpty "correct 0013 token passes"
      (scanContent "0013_Lean_Machine.md"
        "This specification is number 0013. File 0013_Lean_Machine.md.\n"),
    expectNonEmpty "wrong 0013 filename token fails"
      (scanContent "0013_Lean_Machine.md"
        "do not cite 0013_unused.md\n"),
    expectNonEmpty "withdrawn 0005_fargo token fails"
      (scanContent "0013_Lean_Machine.md"
        "do not create `0005_fargo.md`.\n"),
    expectNonEmpty "residual must not say Lean Machine never started"
      (checkNeverRealProductClaim "0013_Lean_Machine.md"
        "A conforming Lean Machine does not exist.\n"),
    expectEmpty "honesty BAN is not a never-real assertion"
      (checkNeverRealProductClaim "0013_Lean_Machine.md"
        "Authors MUST NOT write that beastdb never started or does not exist.\n"),
    expectEmpty "numbered Vocabulary file does not exist is allowed"
      (checkNeverRealProductClaim "0013_Lean_Machine.md"
        "A numbered Vocabulary file does not exist.\n"),
    expectEmpty "all published basenames including 0013 pass"
      (findingsForBasenames publishedBasenames),
    expectFalse "products are not claimed ready for use"
      productsClaimedReadyForUse,
    expectFalse "products are not claimed never started"
      productsClaimedNeverStarted,
    expectTrue "sibling line encodings are required"
      siblingLineEncodingsRequired,
    expectTrue "sibling proofs are separate modules"
      siblingProofsAreSeparateModules,
    expectFalse "tests without a model do not conform"
      testsOnlyConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsConforms,
    expectTrue "complete science cycle conforms"
      completeScienceConformsHere,
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient
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
    IO.println s!"lean_machine_tests: {runCases.length} passed"
    return 0
  else
    IO.eprintln s!"lean_machine_tests: {failed} failed"
    return 1
