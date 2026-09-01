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

end LeanMachineProofs
