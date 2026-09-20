/-
  PROOFS for numbered specification 0005 Concise American Technical
  English.

  This module is not the specification. It imports CateSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import CateSpec
import SpecRegistry

namespace Cate

theorem cate_is_0005 : specNumber = 5 := rfl

/-- Fails if the model still numbers CATE as 0006. -/
theorem cate_is_not_0006 : specNumber ≠ 6 := by decide

theorem cate_file_is_0005_cate : specFileName = "0005_CATE.md" := rfl

theorem cate_is_not_0000 : specNumber ≠ 0 := by decide

theorem cate_is_not_rsi :
    specNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem cate_is_new_stack_number : cateIsNewStackNumber = true := rfl

theorem cate_owns_vocabulary_catalog : ownsVocabularyCatalog = true := rfl

theorem vocabulary_number_is_cate :
    SpecRegistry.vocabularySpecNumber = specNumber :=
  rfl

theorem number_nine_is_pdoss :
    SpecRegistry.unlicenseSpecNumber = 9 :=
  rfl

theorem number_nine_is_not_withdrawn : numberNineWithdrawn = false := rfl

theorem mash_unpublished_0009
    (h : SpecRegistry.allEntries.any (fun e => e.number == 9) = false) : False := by
  have hYes := SpecRegistry.number_9_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem rsi_is_0006 :
    SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem carbonado_is_not_0005 :
    SpecRegistry.carbonadoAssignedNumber ≠ some 5 := by
  decide

theorem carbonado_is_not_0006 :
    SpecRegistry.carbonadoAssignedNumber ≠ some 6 := by
  decide

theorem leftover_unstack_nonconforming :
    HyphenRepair.leftoverUnstack.conforming = false :=
  rfl

theorem rephrased_hyphen_conforming :
    HyphenRepair.rephrasedOrdinaryEnglish.conforming = true :=
  rfl

theorem leftover_unstack_phrase_count :
    leftoverUnstackPhrases.length = 5 :=
  rfl

theorem leftover_unstack_phrases_are :
    leftoverUnstackPhrases =
      ["non markdown", "must like", "LF only", "lock free tries",
        "fully type checking"] :=
  rfl

theorem leftover_constructors_map_to_floor_list :
    leftoverUnstackPhraseConstructors.map LeftoverUnstackPhrase.surface =
      leftoverUnstackPhrases :=
  rfl

theorem leftover_lock_free_tries_fails_floor :
    leftoverUnstackFloorConforms leftoverLockFreeTriesProse = false :=
  by native_decide

theorem leftover_non_markdown_fails_floor :
    containsLeftoverUnstackPhrase leftoverNonMarkdownProse = true :=
  by native_decide

theorem leftover_must_like_fails_floor :
    containsLeftoverUnstackPhrase leftoverMustLikeProse = true :=
  by native_decide

theorem leftover_lf_only_fails_floor :
    containsLeftoverUnstackPhrase leftoverLfOnlyProse = true :=
  by native_decide

theorem leftover_fully_type_checking_fails_floor :
    containsLeftoverUnstackPhrase leftoverFullyTypeCheckingProse = true :=
  by native_decide

theorem high_assurance_meets_floor :
    leftoverUnstackFloorConforms allowedHighAssuranceProse = true :=
  by native_decide

theorem three_bit_meets_floor :
    leftoverUnstackFloorConforms allowedThreeBitProse = true :=
  by native_decide

theorem time_series_meets_floor :
    leftoverUnstackFloorConforms allowedTimeSeriesProse = true :=
  by native_decide

theorem high_assurance_is_allowed_spaced :
    containsAllowedSpacedPhrase allowedHighAssuranceProse = true :=
  by native_decide

theorem rephrased_lock_tries_meets_floor :
    leftoverUnstackFloorConforms rephrasedLockTriesProse = true :=
  by native_decide

theorem mash_leftover_unstack_as_conforming
    (h : leftoverUnstackFloorConforms leftoverLockFreeTriesProse = true) :
    False := by
  have hNo : leftoverUnstackFloorConforms leftoverLockFreeTriesProse = false :=
    by native_decide
  rw [hNo] at h
  exact Bool.noConfusion h

theorem hyphen_delete_lock_free_tries_is_leftover :
    hyphenDeleteIsLeftoverUnstack "lock-free tries" "lock free tries" = true :=
  by native_decide

theorem rephrase_lock_free_tries_is_not_leftover :
    hyphenDeleteIsLeftoverUnstack "lock-free tries"
        "tries that do not use locks" = false :=
  by native_decide

theorem leftover_unstack_floor_is_not_complete_english :
    leftoverUnstackFloorIsCompleteEnglish = false :=
  rfl

theorem lean_spec_encodings_use_leftover_unstack_floor :
    leanSpecEncodingsUseLeftoverUnstackFloor = true :=
  rfl

theorem allowed_spaced_phrase_count :
    allowedSpacedPhrases.length = 3 :=
  rfl

theorem residual_silence_nonconforming :
    residualSilent.conforming = false :=
  rfl

theorem residual_written_conforming :
    residualWritten.conforming = true :=
  rfl

theorem residual_nothing_to_name_conforming :
    residualNothingToName.conforming = true :=
  rfl

theorem spec_0000_exempt_from_planned_residual_heading :
    plannedTokenRequiresResidualHeading 0 = false :=
  rfl

theorem spec_0001_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 1 = true :=
  rfl

theorem spec_0003_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 3 = true :=
  rfl

theorem spec_0005_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 5 = true :=
  rfl

theorem spec_0006_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 6 = true :=
  rfl

theorem planned_without_heading_fails : plannedWithoutHeadingFails :=
  rfl

theorem planned_with_heading_ok : plannedWithHeadingOk :=
  rfl

theorem spec_0000_planned_without_heading_ok :
    spec0000PlannedWithoutHeadingOk :=
  rfl

theorem no_planned_no_heading_ok :
    noPlannedNoHeading.conforming = true :=
  rfl

theorem residual_heading_six :
    isResidualHeadingTitle "## 6. Residual" = true :=
  rfl

theorem residual_heading_plain :
    isResidualHeadingTitle "## Residual" = true :=
  rfl

theorem half_label_is_not_residual_heading :
    isResidualHeadingTitle "Keep or replace coined labels?" = false :=
  rfl

theorem new_phrase_without_definition_not_conforming :
    NewPhraseInQuestion.introducedWithoutDefinition.conforming = false :=
  rfl

theorem new_phrase_defined_in_same_sentence_conforming :
    NewPhraseInQuestion.definedInSameSentence.conforming = true :=
  rfl

theorem half_label_question_incomplete :
    halfLabelQuestion.complete = false :=
  rfl

theorem complete_question_ok :
    completeQuestion.complete = true :=
  rfl

theorem spec_markdown_is_the_contract :
    specMarkdownIsContract = true :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

theorem no_invented_conforming_product :
    cateAllowsInventedConformingProduct = false :=
  rfl

theorem iso_24495_not_clause_12_pin :
    iso24495IsClause12Pin = false :=
  rfl

theorem federal_plain_language_not_clause_12_pin :
    federalPlainLanguageIsClause12Pin = false :=
  rfl

theorem cate_does_not_replace_rfc_2119 :
    cateReplacesRfc2119 = false :=
  rfl

theorem independent_streams_are_parallel :
    independentWorkStreamsRunInParallel = true :=
  rfl

theorem disjoint_write_sets_not_serialized :
    serializeDisjointWriteSets = false :=
  rfl

theorem encode_self_improves_in_same_effort :
    encodeProcessSelfImprovesInSameEffort = true :=
  rfl

theorem chat_reminder_is_not_encode_proof :
    chatReminderCountsAsEncodeProof = false :=
  rfl

theorem scc_includes_cocomo_when_size_asked :
    sccOmitsCocomoWhenSizeAsked = false :=
  rfl

theorem cocomo_is_not_a_real_schedule :
    cocomoIsRealSchedule = false :=
  rfl

theorem no_git_mutate_unless_asked :
    gitMutateUnlessOperatorAsked = false :=
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

end Cate
