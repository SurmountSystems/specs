/-
  PROOFS for numbered specification 0013 Lean Machine.

  This module is not the specification. It imports LeanMachineSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import LeanMachineSpec
import SpecRegistry

namespace LeanMachineProofs

open LeanMachineSpec

theorem spec_number_is_13 : specNumber = 13 := rfl

theorem spec_file_is_0013_lean_machine :
    specFileName = "0013_Lean_Machine.md" :=
  rfl

theorem product_name_is_lean_machine :
    productName = "Lean Machine" :=
  rfl

theorem spec_is_not_0012 : specNumber ≠ 12 := by decide

theorem spec_is_not_0011 : specNumber ≠ 11 := by decide

theorem spec_is_not_0009 : specNumber ≠ 9 := by decide

theorem spec_is_not_0005 : specNumber ≠ 5 := by decide

theorem assigned : leanMachineAssigned = true := rfl

theorem assigned_number_is_13 :
    leanMachineAssignedNumber = some 13 :=
  rfl

theorem mash_fixture_claims_no_number :
    mashNoNumberFixture.claimsNoNumber = true :=
  rfl

theorem mash_fixture_is_assigned :
    mashNoNumberFixture.assigned = true :=
  rfl

theorem mash_no_number_does_not_conform :
    mashNoNumberConforming = false :=
  rfl

theorem live_encoding_does_not_claim_no_number :
    mashClaimsLeanMachineHasNoNumber = false :=
  rfl

theorem live_encoding_is_not_the_mash :
    liveNumberClaim != mashNoNumberFixture :=
  by decide

theorem worship_not_required : worshipRequiredForConformance = false :=
  rfl

theorem belief_not_required : beliefRequiredForConformance = false :=
  rfl

theorem theology_not_must_for_compiler :
    theologyIsMustForCompiler = false :=
  rfl

theorem systems_lean_component : systemsLeanIsComponent = true := rfl

theorem legal_lean_component : legalLeanIsComponent = true := rfl

theorem holy_lean_component : holyLeanIsComponent = true := rfl

theorem legal_lean_no_separate_number :
    legalLeanHasSeparateNumber = false :=
  rfl

theorem holy_lean_no_separate_number :
    holyLeanHasSeparateNumber = false :=
  rfl

theorem legal_lean_not_finished : legalLeanFinished = false := rfl

theorem holy_lean_not_implemented : holyLeanImplemented = false :=
  rfl

/-- Not ready for use. This is not a claim that the product never started. -/
theorem no_conforming_product : conformingProductExists = false :=
  rfl

theorem unlicense_is_0009 : unlicenseSpecNumber = 9 := rfl

theorem no_second_unlicense : inventsSecondUnlicenseSpec = false :=
  rfl

theorem systems_lean_is_0002 : systemsLeanSpecNumber = 2 := rfl

theorem compcert_required :
    compCertRequiredForNamedHighAssurancePath = true :=
  rfl

theorem slake_bootstrap_required :
    slakeBootstrapTypecheckRequired = true :=
  rfl

theorem no_weasel_when_present_under_ref :
    weaselsWhenPresentUnderRef = false :=
  rfl

theorem llvm_ir_not_required : llvmIrEmissionRequired = false :=
  rfl

theorem llvm_ir_may : llvmIrEmissionMay = true := rfl

theorem deterministic_answers :
    mustAttemptDeterministicAnswers = true :=
  rfl

theorem timestamped_notes :
    timestampedNoteRequiredWhenWrongOrImprecise = true :=
  rfl

theorem lean_machine_spec_number_is_13 :
    leanMachineSpecNumber = 13 :=
  rfl

theorem note_with_clock_time_conforms : noteWithClockTimeConforms :=
  rfl

theorem note_without_clock_time_does_not_conform :
    noteWithoutClockTimeDoesNotConform :=
  rfl

theorem note_missing_question_does_not_conform :
    noteMissingQuestionDoesNotConform :=
  rfl

theorem note_missing_answer_does_not_conform :
    noteMissingAnswerDoesNotConform :=
  rfl

theorem note_with_clock_time_has_ticks :
    noteWithClockTime.clockTime.isSome = true :=
  rfl

theorem note_storage_is_product_detail :
    noteStorageIsProductDetail = true :=
  rfl

theorem shipped_note_store_not_claimed :
    shippedNoteStoreClaimed = false :=
  rfl

theorem mash_missing_note_substitute_does_not_conform :
    mashMissingNoteSubstituteDoesNotConform :=
  rfl

theorem wrote_note_on_wrong_answer_conforms :
    wroteNoteOnWrongAnswerConforms :=
  rfl

theorem same_question_same_notes_same_answer :
    sameQuestionSameNotesSameAnswer :=
  rfl

theorem encoded_attempt_is_congruent : encodedAttemptIsCongruent := by
  intro q1 q2 notes1 notes2 hq hn
  cases hq
  cases hn
  rfl

theorem mash_nondeterministic_pair_does_not_conform :
    mashNondeterministicPairDoesNotConform :=
  rfl

theorem same_input_same_answer_pair_conforms :
    AnswerAttempt.conformingPair sameInputSameAnswerA sameInputSameAnswerB = true :=
  rfl

theorem design_not_running_claim :
    distributedSelfImprovementIsDesignRequirement = true ∧
      runningDistributedMachineClaimed = false :=
  And.intro rfl rfl

theorem rsi_is_0006 : rsiSpecNumber = 6 := rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_agrees_registry :
    specNumber = 13 ∧ SpecRegistry.leanMachineAssignedNumber = some 13 :=
  And.intro rfl rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem separate_spec_encoding_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem separate_proof_conforms :
    conformingThisRepo proofFixture = true :=
  rfl

theorem mashed_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem mash_hides_split : hidesSplit mashedFixture = true := rfl

theorem mash_worship_required_for_conformance_is_false :
    mashWorshipRequiredForConformanceIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_belief_required_for_conformance_is_false :
    mashBeliefRequiredForConformanceIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_theology_is_must_for_compiler_is_false :
    mashTheologyIsMustForCompilerIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_legal_lean_has_separate_number_is_false :
    mashLegalLeanHasSeparateNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_holy_lean_has_separate_number_is_false :
    mashHolyLeanHasSeparateNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_legal_lean_finished_is_false :
    mashLegalLeanFinishedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_holy_lean_implemented_is_false :
    mashHolyLeanImplementedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_conforming_product_exists_is_false :
    mashConformingProductExistsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_running_distributed_machine_claimed_is_false :
    mashRunningDistributedMachineClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_spec_and_proof_conforming_is_false :
    mashSpecAndProofConformingIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem holy_safe_c_lean_machine_one_module_is_not_true :
    holySafeCLeanMachineOneModule = true → False := by
  intro h
  exact Bool.noConfusion h

theorem required_conformance_iff :
    requiredConformanceHolds = true :=
  rfl

theorem formal_vibefication_url :
    formalVibeficationUrl =
      "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html" :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem sibling_line_encodings_required :
    siblingLineEncodingsRequired = true :=
  rfl

theorem sibling_proofs_are_separate_modules :
    siblingProofsAreSeparateModules = true :=
  rfl

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_only_does_not_conform : testsOnlyConforms = false :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsConforms = false :=
  rfl

theorem complete_science_conforms_here :
    completeScienceConformsHere = true :=
  rfl

theorem tests_without_model_does_not_conform :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform_prop :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

end LeanMachineProofs
