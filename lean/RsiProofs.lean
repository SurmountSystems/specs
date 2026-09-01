/-
  PROOFS for numbered specification 0006 Recursive Self Improvement.

  This module is not the specification. It imports RsiSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import RsiSpec
import CateProofs
import VocabularyCollisionProofs
import SpecRegistry
import SystemsLean
import Vocabulary

namespace Rsi

theorem spec_is_0006 : specNumber = 6 := rfl

theorem spec_file_is_0006_rsi : specFileName = "0006_RSI.md" := rfl

theorem product_name_is_rsi : productName = "RSI" := rfl

theorem cate_is_0005 : cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

/-- Fails if the model still numbers CATE as 0006. -/
theorem cate_is_not_0006 : cateSpecNumber ≠ 6 :=
  SpecRegistry.cate_is_not_0006

theorem cate_file_is_0005_cate : cateFileName = "0005_CATE.md" := rfl

theorem cate_matches_registry :
    cateSpecNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem cate_is_not_this_spec : cateSpecNumber ≠ specNumber := by
  decide

theorem cate_is_not_rsi_number : cateSpecNumber ≠ 6 :=
  SpecRegistry.cate_is_not_0006

theorem fargo_is_not_spec_0005 :
    SpecRegistry.fargoAssigned = false :=
  SpecRegistry.fargo_not_assigned

theorem fargo_number_none :
    SpecRegistry.fargoAssignedNumber = none :=
  SpecRegistry.fargo_number_none

/-- Surmount Systems System Prompt is named, not specified. -/
theorem sssp_not_specified : ssspSpecified = false := rfl

theorem sssp_unnumbered : ssspHasNumberedSpec = false := rfl

theorem sssp_number_none : ssspAssignedNumber = none := rfl

/-- Clause 4.1: durable tools before a disposable job. -/
theorem tools_before_one_off :
    JobApproach.disposableOnce.conforming = false :=
  rfl

theorem durable_tool_conforming :
    JobApproach.improveDurableTool.conforming = true :=
  rfl

theorem repeating_job_rejects_disposable :
    JobApproach.requiredWhenRepeats true .disposableOnce = false :=
  rfl

theorem repeating_job_requires_durable :
    JobApproach.requiredWhenRepeats true .improveDurableTool = true :=
  rfl

/-- Leftover unstack remains nonconforming (CATE). -/
theorem leftover_unstack_still_fails :
    Cate.HyphenRepair.leftoverUnstack.conforming = false :=
  Cate.leftover_unstack_nonconforming

/-- Local leftover unstack model, independent of CATE host numbering. -/
theorem local_leftover_unstack_fails :
    LeftoverUnstackRepair.leftoverUnstack.conforming = false :=
  rfl

theorem local_rephrased_hyphen_conforms :
    LeftoverUnstackRepair.rephrasedOrdinaryEnglish.conforming = true :=
  rfl

/-- Language purity is not ideology. -/
theorem language_purity_is_not_ideology :
    languagePurityIsIdeology = false :=
  rfl

/-- bash or Python as Nix check policy is forbidden. -/
theorem no_bash_python_nix_check_policy :
    bashOrPythonAsNixCheckPolicy = false :=
  rfl

/-- Clause 4.2: stronger tool that can state the theorem is not skipped. -/
theorem no_skip_stronger_tool :
    skipStrongerToolBecauseWeakerIsFamiliar = false :=
  rfl

/-- Clause 4.3: failing test first. -/
theorem failing_test_first_conforming :
    ProofOrder.failingTestThenProduct.conforming = true :=
  rfl

theorem product_then_test_not_conforming :
    ProofOrder.productThenTest.conforming = false :=
  rfl

theorem no_reshape_test_without_contract_change :
    reshapeTestToPassWithoutContractChange = false :=
  rfl

/-- Clause 4.4: stop and ask; do not guess. -/
theorem stop_and_ask_conforming :
    AmbiguityResponse.stopAndAsk.conforming = true :=
  rfl

theorem guess_and_continue_not_conforming :
    AmbiguityResponse.guessAndContinue.conforming = false :=
  rfl

/-- RSI does not claim a model retrains itself in this repository. -/
theorem rsi_is_not_model_retrain :
    rsiMeansModelRetrainsInThisRepo = false :=
  rfl

/-- Clause 4.6: the loop, not a training run stored in this tree. -/
theorem rsi_loop_conforming :
    RsiMeaning.loopOfToolsAndResidual.conforming = true :=
  rfl

theorem rsi_retrain_not_conforming :
    RsiMeaning.modelRetrainsInThisRepo.conforming = false :=
  rfl

/-- Scripture is not a conformance item for Slake, beastdb, or SSSSS. -/
theorem scripture_not_required_for_slake :
    scriptureRequiredForSlake = false :=
  rfl

theorem scripture_not_required_for_beastdb :
    scriptureRequiredForBeastdb = false :=
  rfl

theorem scripture_not_required_for_sssss :
    scriptureRequiredForSssss = false :=
  rfl

theorem scripture_not_proven_cosmology :
    scriptureIsProvenCosmology = false :=
  rfl

/-- bitmask trees are out of scope as product. -/
theorem bitmask_core_out_of_scope : bitmaskCoreInScope = false := rfl

theorem bitmask_next_out_of_scope : bitmaskNextInScope = false := rfl

theorem rgb_product_out_of_scope : rgbProductInScope = false := rfl

/-- This document is not a bitmask specification. -/
theorem rsi_is_not_bitmask_spec : rsiIsBitmaskSpec = false := rfl

/-- RSI does not restate Lean Machine. This is not a claim that Lean Machine is unnumbered. -/
theorem rsi_does_not_restate_lean_machine :
    leanMachineSpecified = false :=
  rfl

theorem lean_machine_has_numbered_specification :
    leanMachineHasNumberedSpecification = true :=
  rfl

theorem leftover_unnumbered_meaning_is_false :
    leftoverUnnumberedMeaning = false :=
  rfl

theorem holy_lean_not_specified : holyLeanSpecified = false := rfl

theorem legal_lean_not_specified : legalLeanSpecified = false := rfl

theorem bio_lean_not_specified : bioLeanSpecified = false := rfl

theorem lean_machine_shared_pattern_not_specified :
    leanMachineSharedPatternSpecified = false :=
  rfl

/-- Carbonado remains unassigned. Number 0005 is CATE. Number 0006 is RSI. -/
theorem carbonado_unassigned :
    SpecRegistry.carbonadoAssigned = false :=
  SpecRegistry.carbonado_not_assigned

theorem carbonado_is_not_cate : carbonadoIsCate = false := rfl

theorem cate_number_is_five_and_carbonado_unassigned :
    cateSpecNumber = 5 ∧ SpecRegistry.carbonadoAssigned = false :=
  And.intro cate_is_0005 carbonado_unassigned

/-- This specification does not claim every agent already conforms. -/
theorem no_invented_conforming_agents :
    specClaimsEveryAgentConforms = false :=
  rfl

/-- Unstated heuristics are not allowed. -/
theorem unstated_heuristic_not_ok : unstatedHeuristicOk = false := rfl

theorem no_pad_unknown_as_finding :
    padUnknownWithGuessAsFinding = false :=
  rfl

/-- Remaining work lives on disk, not only in chat. -/
theorem residual_on_disk_conforming :
    ResidualHome.diskCompleteSentences.conforming = true :=
  rfl

theorem chat_only_residual_not_conforming :
    ResidualHome.chatOnly.conforming = false :=
  rfl

/-- When a project already requires a remote builder, laptop rustc is not the proof. -/
theorem no_laptop_rustc_when_remote_required :
    rustCompileTestsOnLaptopWhenRemoteRequired = false :=
  rfl

theorem stop_when_remote_unresponsive :
    stopWhenRemoteBuilderUnresponsive = true :=
  rfl

/-- Clause 4.7: parallel independent streams on disjoint writes. -/
theorem serialize_independent_not_conforming :
    StreamSchedule.serializeIndependent.conforming = false :=
  rfl

theorem parallel_disjoint_conforming :
    StreamSchedule.parallelDisjoint.conforming = true :=
  rfl

theorem disjoint_writes_may_run_parallel :
    WriteSets.disjoint.mayRunInParallel = true :=
  rfl

theorem overlapping_writes_not_parallel :
    WriteSets.overlapping.mayRunInParallel = false :=
  rfl

/-- Cancel a healthy live stream only when the operator said stop. -/
theorem no_cancel_healthy_live_stream :
    cancelHealthyLiveStreamWithoutOperatorStop = false :=
  rfl

/-- Clause 4.11: meaning model proving follows project /lean4. -/
theorem meaning_model_proof_follows_lean4_skill :
    meaningModelProofFollowsLean4Skill = true :=
  rfl

theorem lake_package_has_no_mathlib :
    lakePackageHasMathlib = false :=
  rfl

theorem no_sorry_in_shipped_theorems :
    sorryInShippedTheorems = false :=
  rfl

theorem systems_lean_prose_ne_slake :
    Vocabulary.systemsLean.proseName ≠ Vocabulary.slake.proseName :=
  Vocabulary.systems_lean_prose_ne_slake

theorem lake_package_id_is_not_language_name :
    Vocabulary.lakePackageId.id ≠ Vocabulary.systemsLean.proseName :=
  Vocabulary.lake_package_id_ne_language_prose

theorem lake_package_id_is_not_slake :
    Vocabulary.lakePackageId.id ≠ Vocabulary.slake.proseName :=
  Vocabulary.lake_package_id_ne_slake

theorem lake_package_id_is_not_second_language :
    Vocabulary.lakePackageIdIsSecondLanguageName = false :=
  Vocabulary.lake_package_id_is_not_second_language

theorem spec_markdown_is_not_meaning_model :
    Vocabulary.specMarkdownIsMeaningModel = false :=
  Vocabulary.spec_markdown_is_not_meaning_model

theorem spec_markdown_is_not_form_checker :
    Vocabulary.specMarkdownIsFormChecker = false :=
  Vocabulary.spec_markdown_is_not_form_checker

theorem meaning_model_is_not_form_checker :
    Vocabulary.meaningModelIsFormChecker = false :=
  Vocabulary.meaning_model_is_not_form_checker

theorem remaining_work_is_not_systems_lean_residual :
    Vocabulary.remainingWorkIsNamedFreestandingBlocker = false :=
  Vocabulary.remaining_work_is_not_freestanding_blocker

theorem remaining_work_is_not_product_residual_free :
    Vocabulary.remainingWorkIsProductResidualFree = false :=
  Vocabulary.remaining_work_is_not_product_residual_free

theorem product_residual_free_does_not_clear_rsi_remaining_work :
    Vocabulary.productResidualFreeClearsRemainingWork = false :=
  Vocabulary.product_residual_free_does_not_clear_remaining_work

theorem remaining_work_matches_residual_home :
    Vocabulary.remainingWork.completeSentencesOnDisk =
      ResidualHome.diskCompleteSentences.conforming :=
  rfl

theorem meaning_model_is_not_ml_training :
    Vocabulary.meaningModelIsMlTrainingRun = false :=
  Vocabulary.meaning_model_is_not_ml_training

theorem rsi_loop_is_not_ml_training :
    RsiMeaning.modelRetrainsInThisRepo.conforming =
      Vocabulary.meaningModelIsMlTrainingRun :=
  rfl

theorem leftover_unstack_owner_is_cate :
    Vocabulary.leftoverUnstackSpecNumber = cateSpecNumber :=
  rfl

theorem leftover_unstack_owner_is_not_rsi :
    Vocabulary.leftoverUnstackSpecNumber ≠ specNumber := by
  decide

theorem rsi_does_not_replace_leftover_unstack :
    Vocabulary.rsiReplacesLeftoverUnstack = false :=
  Vocabulary.rsi_does_not_replace_leftover_unstack

theorem omega_prose_is_ascii_word :
    Vocabulary.omegaProse.word = "omega" :=
  Vocabulary.omega_prose_is_ascii_word

theorem omega_lean_constructor_is_unrestricted :
    Vocabulary.omegaConstructor.name = "unrestricted" :=
  Vocabulary.omega_lean_constructor_is_unrestricted

theorem omega_prose_is_not_lean_constructor :
    Vocabulary.omegaProse.word ≠ Vocabulary.omegaConstructor.name :=
  Vocabulary.omega_prose_ne_constructor_name

theorem unrestricted_prose_is_omega :
    Vocabulary.proseOfMultiplicity SystemsLean.Multiplicity.unrestricted =
      "omega" :=
  rfl

theorem vocab_scripture_not_required_for_slake :
    Vocabulary.scriptureSlake.required = scriptureRequiredForSlake :=
  rfl

theorem vocab_scripture_not_required_for_beastdb :
    Vocabulary.scriptureBeastdb.required = scriptureRequiredForBeastdb :=
  rfl

theorem vocab_scripture_not_required_for_sssss :
    Vocabulary.scriptureSssss.required = scriptureRequiredForSssss :=
  rfl

theorem vocab_parallel_matches_stream_schedule :
    Vocabulary.parallelDisjointWritesConforms =
      StreamSchedule.parallelDisjoint.conforming :=
  rfl

theorem vocab_serialize_matches_stream_schedule :
    Vocabulary.serializingDisjointWritesConforms =
      StreamSchedule.serializeIndependent.conforming :=
  rfl

theorem vocab_disjoint_serial_does_not_conform :
    Vocabulary.DisjointStreamRun.serial.conforming = false :=
  Vocabulary.serial_disjoint_not_conforming

theorem vocab_failing_test_matches_proof_order :
    Vocabulary.failingTestThenProductConforms =
      ProofOrder.failingTestThenProduct.conforming :=
  rfl

theorem vocab_reshape_matches_rsi_bool :
    Vocabulary.productThenReshapeTestConforms =
      reshapeTestToPassWithoutContractChange :=
  rfl

theorem vocab_product_then_reshape_does_not_conform :
    Vocabulary.ContractProofOrder.productThenReshapeTest.conforming = false :=
  Vocabulary.product_then_reshape_test_not_conforming

theorem vocab_rsi_id_is_0006 :
    Vocabulary.rsiId.fileName = specFileName :=
  rfl

theorem vocab_cate_id_is_0005 :
    Vocabulary.cateId.fileName = cateFileName :=
  rfl

theorem vocab_rsi_is_six_cate_is_five :
    SpecRegistry.rsiSpecNumber = 6 ∧ SpecRegistry.cateSpecNumber = 5 :=
  And.intro Vocabulary.rsi_spec_number_is_six Vocabulary.cate_spec_number_is_five


end Rsi
