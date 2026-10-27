/-
  PROOFS for numbered specification 0016 Hierarchical Subagents.

  This module is not the specification. It imports HierarchicalSubagentsSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import HierarchicalSubagentsSpec

namespace HierarchicalSubagentsProofs

open HierarchicalSubagentsSpec

theorem hierarchical_subagents_spec_number_is_16 :
    hierarchicalSubagentsSpecNumber = 16 := rfl

theorem spec_number_is_16 : specNumber = 16 := rfl

theorem spec_number_matches :
    hierarchicalSubagentsSpecNumber = specNumber :=
  rfl

theorem spec_file_is_0016 :
    specFileName = "0016_Hierarchical_Subagents.md" :=
  rfl

theorem product_name_is_hierarchical_subagents :
    productName = "Hierarchical Subagents" :=
  rfl

theorem spec_version_is_0_1_0 : specVersion = "0.1.0" := rfl

theorem spec_version_date_is_20261026 : specVersionDate = "20261026" := rfl

theorem spec_is_not_0015 : specNumber ≠ 15 := by decide

theorem spec_is_not_0014 : specNumber ≠ 14 := by decide

theorem spec_is_not_0013 : specNumber ≠ 13 := by decide

theorem spec_is_not_0008 : specNumber ≠ 8 := by decide

theorem spec_is_not_0005 : specNumber ≠ 5 := by decide

theorem crate_name_l0 : crateNameL0 = "surmount-coordinator-gui" := rfl

theorem call_name_l0 : callNameL0 = "grok-oss gui" := rfl

theorem l0_queues_prompts : l0QueuesPrompts = true := rfl

theorem l0_is_not_a_nested_agent : l0IsNestedAgent = false := rfl

theorem nested_agent_flags :
    isNestedAgent Layer.L0 = false ∧
      isNestedAgent Layer.L1 = true ∧
      isNestedAgent Layer.L2 = true ∧
      isNestedAgent Layer.L3 = true :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem l0_does_not_merge_into_pager_dashboard :
    l0MergesIntoPagerDashboard = false :=
  rfl

theorem call_name_is_informative : callNameIsInformative = true := rfl

theorem coordinator_means_l2_only : wordCoordinatorMeansL2Only = true := rfl

theorem specialist_means_l3_only : wordSpecialistMeansL3Only = true := rfl

theorem l3_is_not_called_coordinator : l3CalledCoordinator = false := rfl

theorem depth_l0 : depthIndex Layer.L0 = 0 := rfl

theorem depth_l1 : depthIndex Layer.L1 = 1 := rfl

theorem depth_l2 : depthIndex Layer.L2 = 2 := rfl

theorem depth_l3 : depthIndex Layer.L3 = 3 := rfl

/-- Clause 4.1. Every layer is one of the four constructors. There is no fifth. -/
theorem every_layer_is_one_of_four (layer : Layer) :
    layer = Layer.L0 ∨ layer = Layer.L1 ∨ layer = Layer.L2 ∨ layer = Layer.L3 := by
  cases layer with
  | L0 => exact Or.inl rfl
  | L1 => exact Or.inr (Or.inl rfl)
  | L2 => exact Or.inr (Or.inr (Or.inl rfl))
  | L3 => exact Or.inr (Or.inr (Or.inr rfl))

theorem l1_spawns_l2 : CanSpawn Layer.L1 Layer.L2 :=
  CanSpawn.l1SpawnsL2

theorem l2_spawns_l3 : CanSpawn Layer.L2 Layer.L3 :=
  CanSpawn.l2SpawnsL3

/-- Clause 4.6. L3 spawns nothing. -/
theorem l3_spawns_nothing (tgt : Layer) : ¬ CanSpawn Layer.L3 tgt := by
  intro h
  cases h

/-- L0 spawns nothing. L0 is not a nested agent and has no spawn introduction. -/
theorem l0_spawns_nothing (tgt : Layer) : ¬ CanSpawn Layer.L0 tgt := by
  intro h
  cases h

/-- L1 does not spawn L3 directly. The only L1 introduction is L2. -/
theorem l1_does_not_spawn_l3 : ¬ CanSpawn Layer.L1 Layer.L3 := by
  intro h
  cases h

theorem l2_does_not_spawn_l0 : ¬ CanSpawn Layer.L2 Layer.L0 := by
  intro h
  cases h

theorem l2_does_not_spawn_l1 : ¬ CanSpawn Layer.L2 Layer.L1 := by
  intro h
  cases h

theorem l2_does_not_spawn_l2 : ¬ CanSpawn Layer.L2 Layer.L2 := by
  intro h
  cases h

/--
  A spawn chain of three steps would name a fourth agent.
  There is no L4, and the third step has no introduction.
-/
theorem no_spawn_chain_of_three (a b c d : Layer) :
    ¬ (CanSpawn a b ∧ CanSpawn b c ∧ CanSpawn c d) := by
  intro h
  cases h with
  | intro hAB hRest =>
    cases hRest with
    | intro hBC hCD =>
      cases hAB with
      | l1SpawnsL2 =>
        cases hBC with
        | l2SpawnsL3 =>
          cases hCD
      | l2SpawnsL3 =>
        cases hBC

/-- Clause 4.1 and Clause 4.3. Each depth index is at most 3. -/
theorem depth_at_most_three (layer : Layer) : depthIndex layer ≤ 3 := by
  cases layer with
  | L0 => exact Nat.le_step (Nat.le_step (Nat.le_step (Nat.le_refl 0)))
  | L1 => exact Nat.le_step (Nat.le_step (Nat.le_refl 1))
  | L2 => exact Nat.le_step (Nat.le_refl 2)
  | L3 => exact Nat.le_refl 3

/-- A spawn step increases depth by exactly 1. -/
theorem spawn_increases_depth_by_one {src tgt : Layer}
    (h : CanSpawn src tgt) : depthIndex tgt = depthIndex src + 1 := by
  cases h with
  | l1SpawnsL2 => rfl
  | l2SpawnsL3 => rfl

theorem depth_model_holds : depthModel :=
  And.intro l1_spawns_l2
    (And.intro l2_spawns_l3
      (And.intro every_layer_is_one_of_four
        (And.intro l0_spawns_nothing
          (And.intro l3_spawns_nothing
            (And.intro l1_does_not_spawn_l3
              (And.intro l2_does_not_spawn_l0
                (And.intro l2_does_not_spawn_l1
                  (And.intro l2_does_not_spawn_l2
                    (And.intro no_spawn_chain_of_three
                      (And.intro depth_at_most_three
                        @spawn_increases_depth_by_one))))))))))

/-- Clause 4.2. The banned words do not satisfy the naming rule. -/
theorem parent_word_is_nonconforming :
    satisfiesNamingRule LayerWord.parent = false :=
  rfl

theorem child_word_is_nonconforming :
    satisfiesNamingRule LayerWord.child = false :=
  rfl

theorem coordinator_word_conforms :
    satisfiesNamingRule LayerWord.coordinator = true :=
  rfl

theorem specialist_word_conforms :
    satisfiesNamingRule LayerWord.specialist = true :=
  rfl

theorem layer_word_conforms : satisfiesNamingRule LayerWord.layer = true :=
  rfl

theorem does_not_compare_layers_to_process_trees :
    comparesLayersToProcessTrees = false :=
  rfl

theorem does_not_use_process_phrase_for_agent :
    usesProcessPhraseForAgent = false :=
  rfl

theorem handoff_report_conforms : handoffNameConforms HandoffName.report = true :=
  rfl

theorem handoff_join_does_not_conform :
    handoffNameConforms HandoffName.join = false :=
  rfl

/-- Optional. Not a required conjunct. -/
theorem may_name_fork_then_combine : mayNameForkThenCombine = true := rfl

theorem tool_work_runs_three_layers_deep :
    toolWorkRunsThreeLayersDeep = true :=
  rfl

theorem includes_implement_loops : includesImplementLoops = true := rfl

theorem fast_path_act_count_is_three : fastPathActCount = 3 := rfl

theorem fourth_fast_path_act_not_permitted :
    fourthFastPathActPermitted = false :=
  rfl

theorem one_line_edit_not_on_fast_path : oneLineEditOnFastPath = false := rfl

theorem fast_path_absent_from_l2_task_description :
    fastPathInL2TaskDescription = false :=
  rfl

theorem l1_does_not_edit_product_code : l1EditsProductCode = false := rfl

theorem l1_does_not_edit_docs : l1EditsDocs = false := rfl

theorem l1_duty_names :
    l1DutyNames =
      ["status", "spawn an L2", "wait", "read short reports", "board upsert"] :=
  rfl

theorem l0_has_no_tool_use (act : ToolAct) : ¬ ToolUse Layer.L0 act := by
  intro h
  cases h

/-- Clause 4.5. L2 has no tool use. -/
theorem l2_has_no_tool_use (act : ToolAct) : ¬ ToolUse Layer.L2 act := by
  intro h
  cases h

/-- Clause 4.4. L1 tool use is a fast path act, and that act is not an edit. -/
theorem l1_does_not_edit (act : ToolAct) (h : ToolUse Layer.L1 act) :
    isEdit act = false := by
  cases h with
  | l1FastPath _ => rfl

theorem l3_does_not_take_fast_path (fp : FastPathAct) :
    ¬ ToolUse Layer.L3 (ToolAct.fastPath fp) := by
  intro h
  cases h

/-- The one line edit is refused at every layer. It is not an allowed act. -/
theorem one_line_edit_is_refused (layer : Layer) :
    ¬ ToolUse layer ToolAct.refusedOneLineEdit := by
  intro h
  cases h

theorem fast_path_is_not_file_edit (fp : FastPathAct) :
    isEdit (ToolAct.fastPath fp) = false :=
  rfl

theorem fast_path_act_is_one_of_three (act : FastPathAct) :
    act = FastPathAct.hostCommand ∨
      act = FastPathAct.alreadyNamedPathRead ∨
      act = FastPathAct.quoteAskedReport := by
  cases act with
  | hostCommand => exact Or.inl rfl
  | alreadyNamedPathRead => exact Or.inr (Or.inl rfl)
  | quoteAskedReport => exact Or.inr (Or.inr rfl)

theorem l1_tool_use_is_fast_path (act : ToolAct) (h : ToolUse Layer.L1 act) :
    ∃ fp : FastPathAct, act = ToolAct.fastPath fp := by
  cases h with
  | l1FastPath fp => exact ⟨fp, rfl⟩

theorem tool_model_holds : toolModel :=
  And.intro l0_has_no_tool_use
    (And.intro l2_has_no_tool_use
      (And.intro l1_does_not_edit
        (And.intro l3_does_not_take_fast_path
          (And.intro one_line_edit_is_refused
            (And.intro fast_path_is_not_file_edit
              (And.intro fast_path_act_is_one_of_three
                l1_tool_use_is_fast_path))))))

theorem l2_does_not_grep : l2MayGrep = false := rfl

theorem l2_does_not_read_product_files : l2MayReadProductFiles = false := rfl

theorem l2_does_not_diagnose : l2MayDiagnose = false := rfl

theorem l2_does_not_edit : l2MayEdit = false := rfl

theorem l2_does_not_implement : l2MayImplement = false := rfl

theorem l2_does_not_review : l2MayReview = false := rfl

/-- Clause 4.5 item 3. Easy work stays on the L2 is nonconforming. -/
theorem easy_work_stays_on_l2_is_nonconforming :
    spawnRuleConforms SpawnRule.easyWorkStaysOnL2 = false :=
  rfl

/-- Clause 4.5 item 4. Spawn an L3 only when the slice is hard is nonconforming. -/
theorem spawn_l3_only_when_hard_is_nonconforming :
    spawnRuleConforms SpawnRule.spawnL3OnlyWhenHard = false :=
  rfl

theorem l2_coordinates_only_conforms :
    spawnRuleConforms SpawnRule.l2CoordinatesOnly = true :=
  rfl

theorem l2_compact_from_own_implement_tools_is_nonconforming :
    l2CompactsBecauseItRanImplementTools = false :=
  rfl

theorem clarification_target_is_l2 : clarificationTargetIsL2 = true := rfl

theorem l3_stays_undisturbed : l3StaysUndisturbed = true := rfl

theorem l3_may_implement : l3MayImplement = true := rfl

theorem l3_may_research : l3MayResearch = true := rfl

theorem l3_may_review : l3MayReview = true := rfl

theorem l3_does_not_coordinate : l3Coordinates = false := rfl

theorem l3_does_not_spawn_flag : l3Spawns = false := rfl

theorem report_home :
    reportHome = "~/.agents/reports/" :=
  rfl

theorem reports_not_written_in_repository :
    reportsWrittenInRepository = false :=
  rfl

theorem canonical_report_is_complete :
    reportContentsComplete canonicalReport = true :=
  rfl

theorem nested_work_waits_during_plan_write :
    nestedWorkMayStart PlanPhase.writingOrPresenting = false :=
  rfl

theorem nested_work_starts_after_approve :
    nestedWorkMayStart PlanPhase.afterApprove = true :=
  rfl

theorem disjoint_write_sets_run_parallel :
    disjointWriteSetsRunParallel = true :=
  rfl

theorem parallel_count_is_not_an_integer :
    parallelCountSetToInteger = false :=
  rfl

theorem shared_file_runs_in_sequence : sharedFileRunsInSequence = true := rfl

theorem l2_stays_listed_until_own_report :
    l2StaysListedUntilOwnReport = true :=
  rfl

/-- Clause 4.9 item 5. An exit after only spawning is not finished. -/
theorem exit_after_only_spawning_is_not_finished (wrote : Bool) :
    treatedAsFinished wrote true = false := by
  cases wrote <;> rfl

/-- Clause 4.9 item 6. An exit without a report is not finished. -/
theorem exit_without_l2_report_is_not_finished (onlySpawned : Bool) :
    treatedAsFinished false onlySpawned = false :=
  rfl

theorem long_build_one_l2 : longBuildDedicatedL2Count = 1 := rfl

theorem long_build_one_job : longBuildJobCount = 1 := rfl

theorem long_build_nice_19 : longBuildNice = 19 := rfl

theorem long_build_not_parallelized : longBuildParallelized = false := rfl

theorem long_build_not_terminated_early : longBuildTerminatedEarly = false :=
  rfl

theorem other_work_continues : otherWorkContinuesDuringLongBuild = true := rfl

/--
  Clause 4.11. Informative. These are not required conjuncts.
  No named enforcer is encoded as present.
-/
theorem sampling_cap_is_informative : samplingCapIsInformative = true := rfl

theorem sampling_enforcer_not_named : samplingEnforcerNamed = false := rfl

theorem nested_sampling_cap_label : nestedSamplingCapLabel = "200k" := rfl

theorem l1_catalog_window_label : l1CatalogWindowLabel = "500k" := rfl

theorem nested_sampling_cap_k : nestedSamplingCapK = 200 := rfl

theorem l1_catalog_window_k : l1CatalogWindowK = 500 := rfl

theorem refresh_context_used_is_not_enforcer :
    refreshContextUsedIsEnforcer = false :=
  rfl

theorem sampling_tests_not_claimed_run_from_here :
    samplingTestsClaimedRunFromHere = false :=
  rfl

theorem recorded_sampling_test_names :
    recordedNestedTestName =
        "nested_session_sampling_window_stays_200k_when_catalog_is_500k" ∧
      recordedL1TestName =
        "main_session_sampling_window_is_catalog_500k_even_when_economic_is_on" ∧
      refreshContextUsedName = "refresh_context_used" :=
  And.intro rfl (And.intro rfl rfl)

/--
  Clause 4.12. Without a report, the record is not finished,
  even when acceptance, the disk flag, or the test flag is true.
-/
theorem exit_without_report_is_not_finished (accepted owed test : Bool) :
    finished (recordWithoutReport accepted owed test) = false :=
  rfl

/-- Clause 4.12 item 2. One passing test is not the landing. -/
theorem passing_test_alone_is_not_finished :
    finished passingTestAlone = false :=
  rfl

theorem passing_test_alone_flag : passingTestAloneIsFinished = false := rfl

theorem finished_model_holds : finishedModel :=
  And.intro exit_without_report_is_not_finished
    (And.intro passing_test_alone_is_not_finished
      (And.intro exit_after_only_spawning_is_not_finished
        exit_without_l2_report_is_not_finished))

theorem remaining_work_goes_to_project_residual_home :
    remainingWorkGoesToProjectResidualHome = true :=
  rfl

theorem next_residual_step_is_highest_value :
    nextResidualStepIsHighestValue = true :=
  rfl

theorem does_not_recreate_inventory_or_residual :
    recreatesInventoryOrResidual = false :=
  rfl

theorem behavior_change_requires_failing_test_first :
    failingTestFirstRequired ChangeKind.behavior = true :=
  rfl

theorem non_behavior_change_does_not_require_failing_test_first :
    failingTestFirstRequired ChangeKind.notBehavior = false :=
  rfl

theorem repeated_instruction_is_process_defect :
    repeatedInstructionIsProcessDefect = true :=
  rfl

theorem chat_promise_is_not_repair : chatPromiseIsRepair = false := rfl

theorem durable_places_conform :
    repairPlaceConforms DurablePlace.agentsFile = true ∧
      repairPlaceConforms DurablePlace.skill = true ∧
      repairPlaceConforms DurablePlace.check = true ∧
      repairPlaceConforms DurablePlace.chatPromise = false :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem rsi_does_not_state_repetition_rule :
    rsiStatesRepetitionRule = false :=
  rfl

theorem rsi_says_chat_reminder_is_not_durable_tool :
    rsiSaysChatReminderIsNotDurableTool = true :=
  rfl

theorem does_not_restate_session_bus : restatesSessionBus = false := rfl

theorem session_bus_does_not_define_layers :
    sessionBusDefinesLayers = false :=
  rfl

theorem does_not_pretend_session_bus_defines_layers :
    pretendsSessionBusDefinesLayers = false :=
  rfl

theorem number_0016_is_not_session_bus : number0016IsSessionBus = false := rfl

theorem cited_spec_numbers :
    cateSpecNumber = 5 ∧
      rsiSpecNumber = 6 ∧
      ciSpecNumber = 7 ∧
      formalVibeficationSpecNumber = 8 ∧
      pdossSpecNumber = 9 ∧
      sessionBusSpecNumber = 15 :=
  And.intro rfl
    (And.intro rfl
      (And.intro rfl
        (And.intro rfl
          (And.intro rfl rfl))))

theorem does_not_replace_cited_specs :
    cateIsThisSpecification = false ∧
      rsiIsThisSpecification = false ∧
      formalVibeficationIsThisSpecification = false ∧
      pdossIsThisSpecification = false :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem ci_does_not_state_long_build_rule : ciStatesLongBuildRule = false :=
  rfl

theorem spec_check_is_not_meaning_checker : specCheckIsMeaningChecker = false :=
  rfl

theorem fargo_has_no_assigned_number : fargoAssignedNumber = false := rfl

theorem carbonado_has_no_assigned_number : carbonadoAssignedNumber = false :=
  rfl

theorem does_not_assign_0016_to_fargo : assigns0016ToFargo = false := rfl

theorem does_not_assign_0016_to_carbonado : assigns0016ToCarbonado = false :=
  rfl

theorem does_not_steal_0005_through_0015 :
    stealsNumbers0005Through0015 = false :=
  rfl

theorem does_not_invent_a_number_after_0016 :
    inventsNumberAfter0016 = false :=
  rfl

theorem does_not_choose_persona_file_reader :
    choosesPersonaFileReader = false :=
  rfl

theorem does_not_amend_other_repos : amendsOtherReposThatSayParent = false :=
  rfl

theorem does_not_amend_0000 : amends0000FirstPublication = false := rfl

theorem does_not_wire_lake_or_nix : wiresLakeOrNix = false := rfl

theorem conforming_program_not_claimed : conformingProgramClaimed = false :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false := rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem no_earlier_shipped_version : earlierShippedVersionClaimed = false :=
  rfl

theorem companion_files_not_claimed_already_present :
    companionFilesClaimedAlreadyPresent = false :=
  rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_marked_as_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false := rfl

theorem markdown_is_not_the_program : markdownIsNotTheProgram = true := rfl

theorem separate_spec_encoding_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem separate_proof_conforms : conformingThisRepo proofFixture = true :=
  rfl

theorem mashed_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem mash_hides_split : hidesSplit mashedFixture = true := rfl

theorem mashed_is_nonconforming : mashedIsNonconformingThisRepo := rfl

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse := by
  intro h
  cases h

theorem mash_conforming_program_claimed_is_false :
    mashConformingProgramClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_products_claimed_ready_is_false :
    mashProductsClaimedReadyIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_products_never_started_is_false :
    mashProductsNeverStartedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem required_facts_hold : requiredFacts := by
  unfold requiredFacts
  repeat (first | apply And.intro | rfl)

theorem required_predicates_hold : requiredPredicates :=
  And.intro required_facts_hold
    (And.intro depth_model_holds
      (And.intro tool_model_holds finished_model_holds))

theorem required_conformance_holds : requiredConformanceHolds = true := rfl

/--
  Clause 5. Required conformance holds if and only if the required
  predicates hold. Sampling figures are outside both sides.
-/
theorem required_conformance_iff :
    requiredConformanceHolds = true ↔ requiredPredicates :=
  Iff.intro (fun _ => required_predicates_hold) (fun _ => required_conformance_holds)

end HierarchicalSubagentsProofs
