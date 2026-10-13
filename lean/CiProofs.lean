/-
  PROOFS for numbered specification 0007 Continuous Integration.

  This module is not the specification. It imports CiSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import CiSpec
import SpecRegistry

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

theorem mash_byte_identity_claimed_true_is_false :
    mashByteIdentityClaimedTrueIsFalse := by
  intro h
  exact Bool.noConfusion h

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

end Ci
