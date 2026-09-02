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

theorem no_invented_ci_product :
    conformingCiProductClaimed = false :=
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
