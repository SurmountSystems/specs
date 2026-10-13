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

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

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
    expectEqNat "leanMachineSpecNumber is 13" leanMachineSpecNumber 13,
    expectTrue "a timestamped note names the question, the wrong or imprecise answer, and a clock time"
      (TimestampedNote.conforming noteWithClockTime),
    expectFalse "a note without a clock time does not conform to Clause 3.5"
      (TimestampedNote.conforming noteWithoutClockTime),
    expectFalse "a note that does not name the question does not conform"
      (TimestampedNote.conforming noteMissingQuestion),
    expectFalse "a note that does not name the wrong or imprecise answer does not conform"
      (TimestampedNote.conforming noteMissingAnswer),
    expectTrue "the live note with a clock time carries ticks"
      noteWithClockTime.clockTime.isSome,
    expectTrue "note storage is a product detail"
      noteStorageIsProductDetail,
    expectFalse "a shipped store for timestamped notes is not claimed"
      shippedNoteStoreClaimed,
    expectFalse "a missing timestamped note is not an acceptable substitute"
      mashMissingNoteSubstitute.conforming,
    expectTrue "writing a timestamped note when the answer is wrong or imprecise conforms"
      wroteNoteOnWrongAnswer.conforming,
    expectTrue "same question plus same notes yields the same encoded answer"
      (encodedAttempt determinismQuestion determinismNotes ==
        encodedAttempt determinismQuestion determinismNotes),
    expectTrue "two attempts with the same question and the same notes and the same answer conform"
      (AnswerAttempt.conformingPair sameInputSameAnswerA sameInputSameAnswerB),
    expectFalse "two attempts with the same question and the same notes but different answers do not conform"
      (AnswerAttempt.conformingPair mashNondeterministicA mashNondeterministicB),
    expectTrue "proof same_question_same_notes_same_answer is available"
      (match LeanMachineProofs.same_question_same_notes_same_answer with
        | _ => true),
    expectTrue "proof note_without_clock_time_does_not_conform is available"
      (match LeanMachineProofs.note_without_clock_time_does_not_conform with
        | _ => true),
    expectTrue "proof encoded_attempt_is_congruent is available"
      (match LeanMachineProofs.encoded_attempt_is_congruent with
        | _ => true),
    expectTrue "proof mash_nondeterministic_pair_does_not_conform is available"
      (match LeanMachineProofs.mash_nondeterministic_pair_does_not_conform with
        | _ => true),
    expectTrue "proof mash_missing_note_substitute_does_not_conform is available"
      (match LeanMachineProofs.mash_missing_note_substitute_does_not_conform with
        | _ => true),
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
      testsAloneAreSufficient,
    expectTrue "markdown names Cons False"
      («0013_Lean_Machine».encodedLines.any fun l =>
        !((l.text.splitOn "Cons False").length == 1)),
    expectConsFalse "worship as a conformance conjunct is not accepted"
      worshipRequiredForConformance
      mashWorshipRequiredForConformance
      mashWorshipRequiredForConformanceIsFalse
      rfl
      LeanMachineProofs.mash_worship_required_for_conformance_is_false,
    expectConsFalse "belief as a conformance conjunct is not accepted"
      beliefRequiredForConformance
      mashBeliefRequiredForConformance
      mashBeliefRequiredForConformanceIsFalse
      rfl
      LeanMachineProofs.mash_belief_required_for_conformance_is_false,
    expectConsFalse "theology as a MUST for the compiler is not accepted"
      theologyIsMustForCompiler
      mashTheologyIsMustForCompiler
      mashTheologyIsMustForCompilerIsFalse
      rfl
      LeanMachineProofs.mash_theology_is_must_for_compiler_is_false,
    expectConsFalse "Legal Lean as a separate stack number is not accepted"
      legalLeanHasSeparateNumber
      mashLegalLeanHasSeparateNumber
      mashLegalLeanHasSeparateNumberIsFalse
      rfl
      LeanMachineProofs.mash_legal_lean_has_separate_number_is_false,
    expectConsFalse "Holy Lean as a separate stack number is not accepted"
      holyLeanHasSeparateNumber
      mashHolyLeanHasSeparateNumber
      mashHolyLeanHasSeparateNumberIsFalse
      rfl
      LeanMachineProofs.mash_holy_lean_has_separate_number_is_false,
    expectConsFalse "Legal Lean as finished is not accepted"
      legalLeanFinished
      mashLegalLeanFinished
      mashLegalLeanFinishedIsFalse
      rfl
      LeanMachineProofs.mash_legal_lean_finished_is_false,
    expectConsFalse "Holy Lean as implemented is not accepted"
      holyLeanImplemented
      mashHolyLeanImplemented
      mashHolyLeanImplementedIsFalse
      rfl
      LeanMachineProofs.mash_holy_lean_implemented_is_false,
    expectConsFalse "a claimed conforming Lean Machine is not accepted"
      conformingProductExists
      mashConformingProductExists
      mashConformingProductExistsIsFalse
      rfl
      LeanMachineProofs.mash_conforming_product_exists_is_false,
    expectConsFalse "a running distributed machine as already existing is not accepted"
      runningDistributedMachineClaimed
      mashRunningDistributedMachineClaimed
      mashRunningDistributedMachineClaimedIsFalse
      rfl
      LeanMachineProofs.mash_running_distributed_machine_claimed_is_false,
    expectConsFalse "a mash of spec encodings and proofs is not accepted"
      (conformingThisRepo mashedFixture)
      mashSpecAndProofConforming
      mashSpecAndProofConformingIsFalse
      rfl
      LeanMachineProofs.mash_spec_and_proof_conforming_is_false,
    expectFalse "Holy Lean, SafeC, and Lean Machine as one module is not a conformance claim"
      holySafeCLeanMachineOneModule,
    expectTrue "proof holy_safe_c_lean_machine_one_module_is_not_true shows that mash Bool is not true"
      (match LeanMachineProofs.holy_safe_c_lean_machine_one_module_is_not_true with
        | _ => true)
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
