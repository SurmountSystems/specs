/-
  Runtime checks for Formal Vibefication spec encodings and proofs.
  Theorems in FormalVibeficationProofs.lean already fail to typecheck if
  the split is mashed. This executable re-checks the decidable facts so a
  silent Bool regression prints FAIL lines.
-/

import FormalVibeficationSpec
import FormalVibeficationProofs
import SpecRegistry

open FormalVibeficationSpec
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
    expectEqNat "Formal Vibefication is specification 0008" specNumber 8,
    expectEqString "Formal Vibefication file is 0008_Formal_Vibefication.md"
      specFileName "0008_Formal_Vibefication.md",
    expectEqString "product name is Formal Vibefication"
      productName "Formal Vibefication",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "FormalVibeficationSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "FormalVibeficationSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "human markdown is the contract humans read"
      humanMarkdownIsTheHumanContract,
    expectFalse "human markdown does not substitute for Lean spec encodings"
      humanMarkdownSubstitutesForLeanSpecEncoding,
    expectFalse "Lean proof is not the spec" leanProofIsTheSpec,
    expectTrue "spec_check is markdown form" specCheckIsMarkdownForm,
    expectFalse "spec_check is not a meaning spec encoding"
      specCheckIsMeaningSpecEncoding,
    expectTrue "spec encoding constructor is not the proof constructor"
      (Layer.leanSpecEncoding != Layer.leanProof),
    expectTrue "human markdown constructor is not the spec encoding constructor"
      (Layer.humanMarkdownContract != Layer.leanSpecEncoding),
    expectTrue "human markdown constructor is not the proof constructor"
      (Layer.humanMarkdownContract != Layer.leanProof),
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "mashed fixture hides the split" (hidesSplit mashedFixture),
    expectFalse "spec encoding fixture does not hide the split"
      (hidesSplit specEncodingFixture),
    expectTrue "spec encoding and proof fixtures have different module names"
      (specEncodingFixture.moduleName != proofFixture.moduleName),
    expectFalse "this specifications repository does not unify spec, proof, and implementation"
      Home.thisSpecificationsRepo.mayUnifySpecProofImpl,
    expectTrue "Systems Lean product tree may unify spec, proof, and implementation"
      Home.systemsLeanProductTree.mayUnifySpecProofImpl,
    expectTrue "Formal Vibefication number is in the registry"
      (allEntries.any (fun e => e.number == 8)),
    expectTrue "number 0009 is in the registry"
      (allEntries.any (fun e => e.number == 9)),
    expectTrue "number 0011 is in the registry"
      (allEntries.any (fun e => e.number == 11)),
    expectEmpty "correct 0008_Formal_Vibefication token passes"
      (scanContent "0008_Formal_Vibefication.md"
        "This specification is number 0008. File 0008_Formal_Vibefication.md.\n"),
    expectNonEmpty "wrong 0008 filename token fails"
      (scanContent "0008_Formal_Vibefication.md"
        "do not cite 0008_unused.md\n"),
    expectNonEmpty "wrong 0009 filename token fails"
      (scanContent "0008_Formal_Vibefication.md"
        "do not cite 0009_unused.md\n"),
    expectNonEmpty "withdrawn 0009_VOCABULARY token fails"
      (scanContent "0008_Formal_Vibefication.md"
        "do not create `0009_VOCABULARY.md`.\n"),
    expectNonEmpty "withdrawn 0009_VOCABULARY.md basename fails"
      (findingsForBasenames (publishedBasenames ++ ["0009_VOCABULARY.md"])),
    expectNonEmpty "wrong published 0008 basename fails"
      (findingsForBasenames (publishedBasenames ++ ["0008_unused.md"])),
    expectEmpty "all published basenames including 0008 pass"
      (findingsForBasenames publishedBasenames),
    expectTrue "essays are not an Unlicense grant" (!essaysAreUnlicenseGrant),
    expectTrue "essays are not vendored as Form 2" (!essaysMayBeVendoredAsForm2),
    expectFalse "products are not claimed ready for use"
      productsClaimedReadyForUse,
    expectFalse "products are not claimed never started"
      productsClaimedNeverStarted,
    expectTrue "sibling line encodings are required"
      siblingLineEncodingsRequired,
    expectTrue "sibling proofs are separate modules"
      siblingProofsAreSeparateModules,
    expectFalse "mashed sibling encodings do not conform"
      mashedSiblingEncodingAndProofsConform
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
