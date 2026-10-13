/-
  PROOFS for RSI collision tags (0006_RSI.md Clause 3.25).

  This module is not the specification. It imports encodings from
  Vocabulary.lean and establishes those propositions.
  Numbered markdown remains the contract humans read.
-/

import Vocabulary
import CateProofs
import SpecRegistry
import SystemsLean

namespace Vocabulary

theorem systems_lean_prose : systemsLean.proseName = "Systems Lean" := rfl

theorem slake_prose : slake.proseName = "Slake" := rfl

theorem lake_package_id : lakePackageId.id = "SystemsLean" := rfl

theorem systems_lean_prose_ne_slake :
    systemsLean.proseName ≠ slake.proseName := by
  decide

theorem lake_package_id_ne_language_prose :
    lakePackageId.id ≠ systemsLean.proseName := by
  decide

theorem lake_package_id_ne_slake :
    lakePackageId.id ≠ slake.proseName := by
  decide

theorem lake_package_id_is_not_second_language :
    lakePackageIdIsSecondLanguageName = false :=
  rfl

theorem rsi_markdown_path : rsiMarkdown.path = "0006_RSI.md" := rfl

theorem rsi_meaning_module : rsiMeaning.moduleName = "Rsi" := rfl

theorem spec_check_binary : specCheckBin.binaryName = "spec_check" := rfl

theorem meaning_model_is_not_form_checker :
    meaningModelIsFormChecker = false :=
  rfl

theorem spec_markdown_is_not_meaning_model :
    specMarkdownIsMeaningModel = false :=
  rfl

theorem spec_markdown_is_not_form_checker :
    specMarkdownIsFormChecker = false :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

theorem markdown_path_ne_meaning_module :
    rsiMarkdown.path ≠ rsiMeaning.moduleName := by
  decide

theorem markdown_path_ne_form_checker :
    rsiMarkdown.path ≠ specCheckBin.binaryName := by
  decide

theorem meaning_module_ne_form_checker :
    rsiMeaning.moduleName ≠ specCheckBin.binaryName := by
  decide

theorem remaining_work_on_disk :
    remainingWork.completeSentencesOnDisk = true :=
  rfl

theorem systems_lean_residual_is_named_blocker :
    systemsLeanResidual.blockerName = "managed Lean runtime" :=
  rfl

theorem product_residual_free_is_release_claim :
    productResidualFree.freestandingReleaseHasNoManagedLeanLeftover = true :=
  rfl

theorem product_residual_free_does_not_clear_remaining_work :
    productResidualFreeClearsRemainingWork = false :=
  rfl

theorem remaining_work_is_not_freestanding_blocker :
    remainingWorkIsNamedFreestandingBlocker = false :=
  rfl

theorem remaining_work_is_not_product_residual_free :
    remainingWorkIsProductResidualFree = false :=
  rfl

theorem ml_training_not_stored_here : mlTraining.storedInThisRepo = false :=
  rfl

theorem meaning_model_is_not_ml_training :
    meaningModelIsMlTrainingRun = false :=
  rfl

theorem leftover_unstack_owned_by_cate :
    leftoverUnstackSpecNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem leftover_unstack_not_owned_by_rsi :
    leftoverUnstackSpecNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem rsi_does_not_replace_leftover_unstack :
    rsiReplacesLeftoverUnstack = false :=
  rfl

theorem leftover_unstack_still_nonconforming :
    Cate.HyphenRepair.leftoverUnstack.conforming = false :=
  Cate.leftover_unstack_nonconforming

theorem omega_prose_is_ascii_word : omegaProse.word = "omega" := rfl

theorem omega_lean_constructor_is_unrestricted :
    omegaConstructor.name = "unrestricted" :=
  rfl

theorem omega_prose_ne_constructor_name :
    omegaProse.word ≠ omegaConstructor.name := by
  decide

theorem unrestricted_prose_is_omega :
    proseOfMultiplicity .unrestricted = omegaProse.word :=
  rfl

theorem unrestricted_is_systems_lean_omega :
    (SystemsLean.Multiplicity.unrestricted : SystemsLean.Multiplicity) =
      .unrestricted :=
  rfl

theorem scripture_not_required (product : String) :
    (scriptureFor product).required = false :=
  rfl

theorem scripture_not_required_for_slake : scriptureSlake.required = false :=
  rfl

theorem scripture_not_required_for_beastdb :
    scriptureBeastdb.required = false :=
  rfl

theorem scripture_not_required_for_sssss : scriptureSssss.required = false :=
  rfl

theorem parallel_disjoint_conforming :
    DisjointStreamRun.parallel.conforming = true :=
  rfl

theorem serial_disjoint_not_conforming :
    DisjointStreamRun.serial.conforming = false :=
  rfl

theorem serializing_disjoint_writes_does_not_conform :
    serializingDisjointWritesConforms = false :=
  rfl

theorem parallel_disjoint_writes_conform :
    parallelDisjointWritesConforms = true :=
  rfl

theorem failing_test_then_product_conforming :
    ContractProofOrder.failingTestThenProduct.conforming = true :=
  rfl

theorem product_then_reshape_test_not_conforming :
    ContractProofOrder.productThenReshapeTest.conforming = false :=
  rfl

theorem failing_test_then_product_conforms :
    failingTestThenProductConforms = true :=
  rfl

theorem product_then_reshape_test_does_not_conform :
    productThenReshapeTestConforms = false :=
  rfl

theorem rsi_id_file : rsiId.fileName = "0006_RSI.md" := rfl

theorem cate_id_file : cateId.fileName = "0005_CATE.md" := rfl

theorem rsi_spec_number_is_six : SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem cate_spec_number_is_five : SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem rsi_is_not_cate :
    SpecRegistry.rsiSpecNumber ≠ SpecRegistry.cateSpecNumber := by
  decide

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

theorem mash_collision_tags_spec_and_proof_is_false :
    mashCollisionTagsSpecAndProofIsFalse := by
  intro h
  exact Bool.noConfusion h

end Vocabulary
