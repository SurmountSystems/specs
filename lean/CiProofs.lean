/-
  PROOFS for numbered specification 0007 Continuous Integration.

  This module is not the specification. It imports CiSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import CiSpec
import SpecRegistry
import MdLine
import «0007_CI»
import «0002_Systems_Lean»

namespace Ci

theorem spec_is_0007 : specNumber = 7 := rfl

theorem spec_file_is_0007_ci : specFileName = "0007_CI.md" := rfl

theorem product_name_is_ci : productName = "CI" := rfl

theorem ci_is_not_0005 : specNumber ≠ SpecRegistry.cateSpecNumber := by
  decide

theorem ci_is_not_0006 : specNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem cate_is_0005 : SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem rsi_is_0006 : SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem fargo_not_assigned : SpecRegistry.fargoAssigned = false :=
  SpecRegistry.fargo_not_assigned

theorem fargo_is_not_spec_0007 :
    SpecRegistry.fargoAssigned = false ∧ specNumber = 7 :=
  And.intro fargo_not_assigned spec_is_0007

theorem fargo_unspecified_here : fargoSpecifiedHere = false := rfl

/-- Surmount Systems System Prompt is named, not specified. -/
theorem sssp_not_specified : ssspSpecified = false := rfl

theorem this_repo_named_gate :
    thisRepoNamedGate =
      "nix flake check \"path:$PWD\" --print-build-logs" :=
  rfl

theorem commit_on_red_does_not_conform :
    commitOnRed.conforming = false :=
  rfl

theorem commit_on_green_conforms :
    commitOnGreen.conforming = true :=
  rfl

theorem residual_does_not_replace_red_gate :
    residualInsteadOfGreen.conforming = false :=
  rfl

theorem residual_named_as_substitute_is_red_replace :
    residualReplacesRedGate residualInsteadOfGreen = true :=
  rfl

theorem unsigned_without_exception_does_not_conform :
    unsignedConforming .unsigned noException = false :=
  rfl

theorem operator_signed_conforms :
    unsignedConforming .operatorSigned noException = true :=
  rfl

theorem named_exception_allows_unsigned :
    unsignedConforming .unsigned namedException = true :=
  rfl

theorem general_skip_does_not_apply :
    DualTreeException.applies generalSkip = false :=
  rfl

theorem unsigned_as_general_skip_does_not_conform :
    unsignedConforming .unsigned generalSkip = false :=
  rfl

theorem agents_must_not_create_commit_objects :
    agentsMayCreateCommitObjects = false :=
  rfl

theorem pre_commit_is_not_operator_signature :
    preCommitSubstitutesForOperatorSignature = false :=
  rfl

theorem this_repo_does_not_claim_unsigned_exception :
    thisRepoClaimsUnsignedException = false :=
  rfl

theorem specs_repo_layers_are_separate :
    specsRepoKeepsLayersSeparate = true :=
  rfl

theorem numbered_markdown_neq_meaning_model :
    StackLayer.numberedMarkdown ≠ StackLayer.meaningModel := by
  decide

theorem numbered_markdown_neq_product :
    StackLayer.numberedMarkdown ≠ StackLayer.productImplementation := by
  decide

theorem meaning_model_neq_product :
    StackLayer.meaningModel ≠ StackLayer.productImplementation := by
  decide

theorem spec_markdown_is_the_contract :
    specMarkdownIsContract = true :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

theorem lean4_surfaces_inconsistency :
    lean4SurfacesLogicalInconsistency = true :=
  rfl

theorem specs_repo_does_not_unify_layers :
    ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl = false :=
  rfl

theorem systems_lean_product_unifies_layers :
    ProductHome.systemsLeanProductTree.unifiesSpecProofImpl = true :=
  rfl

theorem no_dump_theorems_into_numbered_markdown :
    dumpTheoremsIntoNumberedMarkdown = false :=
  rfl

theorem byte_identity_required :
    byteIdentity.requiredForSystemsLeanSlakeProduct = true :=
  rfl

theorem byte_identity_not_claimed_true :
    byteIdentity.claimedTrue = false :=
  rfl

theorem byte_identity_honest :
    byteIdentity.honest = true :=
  rfl

theorem emit_equals_elf_not_proved :
    emitEqualsElfProved = false :=
  rfl

theorem reality_check_required :
    sssssBeastDbReality.requiredForSssssBeastDbStack = true :=
  rfl

theorem reality_check_not_claimed_done :
    sssssBeastDbReality.claimedDone = false :=
  rfl

theorem reality_check_honest :
    sssssBeastDbReality.honest = true :=
  rfl

theorem rust_fargo_process_unspecified :
    rustElevationProcessSpecifiedHere = false :=
  rfl

/-- Clause 3.10 body. Sibling markdown line 115. Array index 114. -/
abbrev clause310ByteIdentityLine : MdLine :=
  «0007_CI».encodedLines[114]!

/-- Clause 4.7 item 2. Sibling markdown line 177. Array index 176. -/
abbrev clause47Item2ByteIdentityLine : MdLine :=
  «0007_CI».encodedLines[176]!

/-- Clause 6.3 body. Sibling markdown line 481. Array index 480. -/
abbrev clause63ByteIdentityLine : MdLine :=
  «0002_Systems_Lean».encodedLines[480]!

/-- True when `needle` occurs in `hay`. -/
def mentionsPhrase (needle hay : String) : Bool :=
  (hay.splitOn needle).length > 1

/--
  Clause 3.10 on one sibling line: exact byte match among emitted C,
  headers, archives, shared objects, LLVM IR, ELF, and other intermediates
  is required, is not claimed true, is pursued by delta reconciliation,
  and a FastC mark does not waive the match.
-/
def clause310ReadsByteIdentityNotClaimedTrue (s : String) : Bool :=
  mentionsPhrase "Exact match of bytes (and of each file as a file) among emitted C, headers, archives, shared objects, LLVM IR, `ELF`, and other intermediates" s &&
    mentionsPhrase "Byte identity is a requirement on such a product and is not claimed true" s &&
    mentionsPhrase "This document does not claim that match already holds" s &&
    mentionsPhrase "Byte identity of emit remains required for a conforming product and is not claimed true" s &&
    mentionsPhrase "The match is pursued by delta reconciliation" s &&
    mentionsPhrase "A `FastC` mark does not waive the match" s

/--
  Clause 4.7 item 2 on one sibling line: the requirement is not claimed
  true, this document does not claim that the match already holds, delta
  reconciliation pursues the match, and a FastC mark does not waive it.
-/
def clause47Item2ReadsByteIdentityNotClaimedTrue (s : String) : Bool :=
  mentionsPhrase "That requirement is a requirement on the product and is not claimed true" s &&
    mentionsPhrase "It is not a claim that the match already holds" s &&
    mentionsPhrase "Byte identity of emit remains required for a conforming product and is not claimed true" s &&
    mentionsPhrase "The match is pursued by delta reconciliation" s &&
    mentionsPhrase "A `FastC` mark does not waive the match" s

/--
  Clause 6.3 on one sibling line: a FastC mark does not make byte identity
  of emit true, and a FastSafeC mark does not waive byte identity of emit.
-/
def clause63ReadsByteIdentityNotYetTrue (s : String) : Bool :=
  mentionsPhrase "does not make byte identity of emit true" s &&
    mentionsPhrase "A `FastSafeC` mark does not waive byte identity of emit" s

/--
  How the live byte identity sentences are read.
  `alreadyTrue` is the claim those sentences deny.
-/
inductive ByteIdentityClaimReading where
  | notClaimedTrue
  | alreadyTrue
  deriving DecidableEq, Repr, BEq

/--
  One reading of Clause 3.10, Clause 4.7 item 2, and Clause 6.3.
  `notClaimedTrue` only when those sibling lines still carry those words.
  This reader does not return `alreadyTrue`. Absent words yield `none`.
-/
def readLiveByteIdentityClaim
    (clause310 clause47 clause63 : MdLine) : Option ByteIdentityClaimReading :=
  if clause310.number == 115 && clause47.number == 177 && clause63.number == 481 &&
      clause310ReadsByteIdentityNotClaimedTrue clause310.text &&
      clause47Item2ReadsByteIdentityNotClaimedTrue clause47.text &&
      clause63ReadsByteIdentityNotYetTrue clause63.text then
    some .notClaimedTrue
  else
    none

/-- The claim that byte identity is already true, read off the sibling lines. -/
def byteIdentityAlreadyTrueAsCurrentFact : Prop :=
  readLiveByteIdentityClaim clause310ByteIdentityLine clause47Item2ByteIdentityLine
      clause63ByteIdentityLine =
    some .alreadyTrue

def byteIdentityAlreadyTrueAsCurrentFactIsFalse : Prop :=
  byteIdentityAlreadyTrueAsCurrentFact → False

/-- True only when those sibling lines are read as byte identity already true. -/
def byteIdentityCountedAlreadyTrue : Bool :=
  readLiveByteIdentityClaim clause310ByteIdentityLine clause47Item2ByteIdentityLine
      clause63ByteIdentityLine ==
    some .alreadyTrue

set_option maxHeartbeats 800000
set_option maxRecDepth 10000

/--
  Live Clause 3.10 and Clause 4.7 item 2 say byte identity among emitted C,
  headers, archives, shared objects, LLVM IR, ELF, and other intermediates
  is required, is not claimed true, is pursued by delta reconciliation, and
  a FastC mark does not waive the match. Live Clause 6.3 says a FastC mark
  does not make byte identity of emit true and a FastSafeC mark does not
  waive it. Treating byte identity as already true yields False.
  The `native_decide` step reads those sibling lines. Removing the wording
  that byte identity is not claimed true, or the Clause 6.3 wording that a
  FastC mark does not make byte identity of emit true, makes the reading
  `none`, so this proof no longer closes.
-/
theorem mash_byte_identity_claimed_true_is_false :
    byteIdentityAlreadyTrueAsCurrentFactIsFalse := by
  intro h
  unfold byteIdentityAlreadyTrueAsCurrentFact at h
  have live :
      readLiveByteIdentityClaim
        «0007_CI».encodedLines[114]!
        «0007_CI».encodedLines[176]!
        «0002_Systems_Lean».encodedLines[480]! =
        some .notClaimedTrue := by
    native_decide
  rw [live] at h
  injection h with eq
  injection eq

/-- A FastC waiver of byte identity yields False. The flag is the existing claimed-true flag. -/
def claimingFastCWaivesByteIdentityYieldsFalse :
    mashFastCWaivesByteIdentityIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem fastc_mark_does_not_waive_byte_identity :
    byteIdentity.requiredForSystemsLeanSlakeProduct = true ∧
      byteIdentity.claimedTrue = false :=
  And.intro rfl rfl

theorem mash_unsigned_as_general_skip_is_false :
    mashUnsignedAsGeneralSkipIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_this_repo_claims_unsigned_exception_is_false :
    mashThisRepoClaimsUnsignedExceptionIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_reality_check_claimed_done_is_false :
    mashRealityCheckClaimedDoneIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem no_invented_ci_product :
    conformingCiProductClaimed = false :=
  rfl

theorem pdoss_is_0009 : pdossSpecNumber = 9 := rfl

theorem unlicense_remains_the_license :
    unlicenseRemainsTheLicense = true :=
  rfl

theorem ci_is_not_0009 : specNumber ≠ pdossSpecNumber := by
  decide

theorem spec_encodings_state_what_must_be_true :
    specEncodingsStateWhatMustBeTrue = true :=
  rfl

theorem proofs_live_in_separate_module :
    proofsLiveInSeparateModule = true :=
  rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem layers_pairwise_distinct : layersPairwiseDistinct := by
  dsimp [layersPairwiseDistinct]
  decide

theorem mashed_is_nonconforming : mashedIsNonconformingThisRepo :=
  rfl

theorem separate_modules_conform : separateModulesConformThisRepo := by
  dsimp [separateModulesConformThisRepo]
  decide

theorem spec_encoding_fixture_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem proof_fixture_conforms :
    conformingThisRepo proofFixture = true :=
  rfl

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse := by
  intro h
  cases h

theorem flake_check_is_product_implementation :
    ImplementationKind.flakeCheck.isProductImplementation = true :=
  rfl

theorem lake_test_is_product_implementation :
    ImplementationKind.lakeTest.isProductImplementation = true :=
  rfl

theorem github_actions_is_product_implementation :
    ImplementationKind.githubActionsWorkflow.isProductImplementation = true :=
  rfl

theorem flake_check_is_not_second_markdown_linter :
    ImplementationKind.flakeCheck.isSecondMarkdownLinter = false :=
  rfl

theorem lake_test_is_not_second_markdown_linter :
    ImplementationKind.lakeTest.isSecondMarkdownLinter = false :=
  rfl

theorem github_actions_is_not_second_markdown_linter :
    ImplementationKind.githubActionsWorkflow.isSecondMarkdownLinter = false :=
  rfl

theorem implementation_is_third_layer :
    implementationIsThirdLayer = true :=
  rfl

theorem implementation_is_not_second_markdown_linter :
    implementationIsSecondMarkdownLinter = false :=
  rfl

theorem named_gate_is_nix_flake_check :
    namedGateIsNixFlakeCheck = true :=
  rfl

theorem write_shell_application_checkers_not_allowed :
    writeShellApplicationCheckersAllowed = false :=
  rfl

theorem write_shell_application_is_not_named_gate :
    writeShellApplicationIsNamedGate = false :=
  rfl

theorem spec_check_is_markdown_form : specCheckIsMarkdownForm = true :=
  rfl

theorem spec_check_is_not_meaning_encoding :
    specCheckIsMeaningSpecEncoding = false :=
  rfl

theorem lean_spec_check_is_form :
    FormAuthority.leanSpecCheck.isForm = true :=
  rfl

theorem pure_nix_whitespace_is_form :
    FormAuthority.pureNixWhitespace.isForm = true :=
  rfl

theorem lean_spec_check_is_not_meaning_as_form_authority :
    FormAuthority.leanSpecCheck.isMeaningEncoding = false :=
  rfl

theorem pure_nix_whitespace_is_not_meaning :
    FormAuthority.pureNixWhitespace.isMeaningEncoding = false :=
  rfl

theorem lean_spec_check_neq_pure_nix_whitespace :
    FormAuthority.leanSpecCheck ≠ FormAuthority.pureNixWhitespace := by
  decide

theorem dual_whitespace_coverage_required :
    dualWhitespaceCoverageRequired = true :=
  rfl

theorem push_on_red_does_not_conform :
    pushOnRed.conforming = false :=
  rfl

theorem push_on_green_conforms :
    pushOnGreen.conforming = true :=
  rfl

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_only_does_not_conform : testsWithoutModelDoesNotConform :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

theorem reference_side_is_major_compilers :
    referenceSideIsMajorCompilers = true :=
  rfl

theorem ci_five_named_compilers_are_in_the_set :
    ciMajorCompilerInSet .ccomp = true ∧
      ciMajorCompilerInSet .compCertTso = true ∧
      ciMajorCompilerInSet .gcc = true ∧
      ciMajorCompilerInSet .llvm = true ∧
      ciMajorCompilerInSet .cc = true :=
  ⟨rfl, rfl, rfl, rfl, rfl⟩

theorem ci_reference_target_does_not_satisfy_clause42_item6 :
    ciReferenceTargetSatisfiesClause42Item6 = false :=
  rfl

end Ci
