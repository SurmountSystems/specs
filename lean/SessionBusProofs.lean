/-
  PROOFS for numbered specification 0015 Session Bus.

  This module is not the specification. It imports SessionBusSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import SessionBusSpec

namespace SessionBusProofs

open SessionBusSpec

theorem session_bus_spec_number_is_15 : sessionBusSpecNumber = 15 := rfl

theorem spec_number_is_15 : specNumber = 15 := rfl

theorem session_bus_spec_number_matches_spec_number :
    sessionBusSpecNumber = specNumber :=
  rfl

theorem spec_file_is_0015_session_bus :
    specFileName = "0015_Session_Bus.md" :=
  rfl

theorem product_name_is_session_bus : productName = "Session Bus" := rfl

theorem spec_is_not_0014 : specNumber ≠ 14 := by decide

theorem approve_default_is_off : approveDefault = false := rfl

theorem deny_default_is_off : denyDefault = false := rfl

theorem approve_and_deny_are_off_by_default :
    approveDefault = false ∧ denyDefault = false :=
  And.intro rfl rfl

theorem approve_off_by_default : approveOffByDefault = true := rfl

theorem deny_off_by_default : denyOffByDefault = true := rfl

theorem no_network_listener : networkListenerPresent = false := rfl

theorem socket_allows_same_uid : socketAllows .same = true := rfl

theorem socket_rejects_other_uid : socketAllows .other = false := rfl

theorem socket_is_same_uid_only : socketIsSameUidOnly = true := rfl

theorem transcript_returns_deltas : transcriptReturnsDeltas = true := rfl

theorem transcript_does_not_return_full_text :
    transcriptReturnsFullText = false :=
  rfl

theorem transcript_returns_deltas_only :
    transcriptReturnsDeltasOnly = true :=
  rfl

theorem socket_path_pattern :
    socketPathPattern = "$XDG_RUNTIME_DIR/grok-oss/<session>.sock" :=
  rfl

theorem socket_mode_is_0600 : socketMode = "0600" := rfl

theorem allow_act_defaults_false : allowActDefault = false := rfl

theorem allow_approve_defaults_false : allowApproveDefault = false := rfl

theorem approve_requires_both_keys :
    actTierRuns false false .approve = false ∧
      actTierRuns true false .approve = false ∧
      actTierRuns false true .approve = false ∧
      actTierRuns true true .approve = true := by
  decide

theorem deny_requires_both_keys :
    actTierRuns false false .deny = false ∧
      actTierRuns true false .deny = false ∧
      actTierRuns false true .deny = false ∧
      actTierRuns true true .deny = true := by
  decide

theorem interject_requires_allow_act_not_allow_approve :
    actTierRuns false false .interject = false ∧
      actTierRuns false true .interject = false ∧
      actTierRuns true false .interject = true ∧
      actTierRuns true true .interject = true := by
  decide

theorem queue_requires_allow_act_not_allow_approve :
    actTierRuns false false .queue = false ∧
      actTierRuns false true .queue = false ∧
      actTierRuns true false .queue = true ∧
      actTierRuns true true .queue = true := by
  decide

theorem readonly_rejects_act_tier :
    readonlyRejectsAct true .interject = true ∧
      readonlyRejectsAct true .queue = true ∧
      readonlyRejectsAct true .approve = true ∧
      readonlyRejectsAct true .deny = true := by
  decide

theorem readonly_does_not_reject_look_transcript_sessions_owns_subscribe :
    readonlyRejectsRead true .look = false ∧
      readonlyRejectsRead true .transcript = false ∧
      readonlyRejectsRead true .sessions = false ∧
      readonlyRejectsRead true .owns = false ∧
      readonlyRejectsRead true .subscribe = false := by
  decide

theorem so_peercred_is_required : soPeercredRequired = true := rfl

theorem directory_mode_is_0700 : directoryMode = "0700" := rfl

theorem socket_mode_alone_does_not_prove_the_peer :
    socketModeAloneProvesPeerUser = false :=
  rfl

theorem look_turn_count_is_3 : lookTurnCount = 3 := rfl

theorem permission_bits_and_peer_check :
    directoryMode = "0700" ∧ socketMode = "0600" ∧
      soPeercredRequired = true ∧
      socketModeAloneProvesPeerUser = false ∧
      networkListenerPresent = false ∧
      serverMayAddNetworkListener = false := by
  decide

theorem seq_follows_means_increasing (earlier later : Nat)
    (h : seqFollows earlier later = true) : earlier < later := by
  simp [seqFollows] at h
  exact of_decide_eq_true (decide_eq_true h)

theorem seq_examples_increase :
    seqFollows 1 2 = true ∧ seqFollows 2 2 = false ∧
      seqFollows 5 4 = false := by
  decide

theorem consecutive_seq_is_not_silent_loss :
    lossIsSilent 4 5 false = false := by
  decide

theorem skip_without_gap_is_silent_loss :
    lossIsSilent 4 6 false = true := by
  decide

theorem skip_with_gap_is_not_silent_loss :
    lossIsSilent 4 6 true = false := by
  decide

theorem gap_present_when_seq_skips (earlier later : Nat) (gapPresent : Bool)
    (hSkip : earlier + 1 < later)
    (hCover : gapCoversSkip earlier later gapPresent = true) :
    gapPresent = true := by
  simp [gapCoversSkip] at hCover
  have hNot : ¬ later <= earlier + 1 := (Nat.not_le).mpr hSkip
  simp [hNot] at hCover
  exact hCover

theorem output_class_defaults :
    contentClassAllowedByDefault .meta = true ∧
      contentClassAllowedByDefault .chat = true ∧
      contentClassAllowedByDefault .call = true ∧
      contentClassAllowedByDefault .output = false := by
  decide

theorem summary_is_default_detail :
    defaultDetailLevel = .summary ∧ summaryIsDefaultDetail = true ∧
      maxFieldDefaultTokens = 80 ∧ stepAddsOutput = false ∧
      fullAddsOutput = true := by
  decide

theorem origin_depth_bound_is_one : originDepthBound = 1 := rfl

theorem first_act_for_origin_is_allowed : actOriginAllowed 0 = true := rfl

theorem further_act_same_origin_is_refused :
    actOriginAllowed 1 = false ∧ actOriginAllowed 2 = false := by
  decide

theorem further_act_at_bound_is_refused (n : Nat)
    (h : originDepthBound <= n) : actOriginAllowed n = false := by
  cases n with
  | zero =>
    simp [originDepthBound] at h
  | succ _ =>
    rfl

theorem ring_budget_is_message_times_events :
    maxMessageBytes * ringEventCount = ringByteBudget := rfl

theorem subscriber_cap_is_8 : maxSubscribersPerSession = 8 := rfl

theorem toon_is_not_the_wire_format : toonIsWireFormat = false := rfl

theorem wire_schema_not_chosen : wireSchemaChosen = false := rfl

theorem transcript_is_deltas_from_a_turn_id :
    transcriptCursorIsSinceTurnId = true ∧
      transcriptReturnsDeltasOnly = true :=
  And.intro rfl rfl

theorem approval_subscribe_bound_is_under_one_second :
    approvalSubscribeExclusiveUpperBoundSeconds = 1 :=
  rfl

theorem bus_does_not_redact_tool_secrets : busRedactsToolSecrets = false := rfl

theorem client_command_is_grok_oss_bus : clientCommand = "grok-oss bus" :=
  rfl

theorem mcp_serve_command :
    mcpServeCommand = "grok-oss mcp-serve bus" :=
  rfl

theorem method_names :
    methodNames =
      ["sessions", "look", "transcript", "owns", "interject", "queue",
        "approve", "deny", "subscribe"] :=
  rfl

theorem max_field_default_is_80_tokens : maxFieldDefaultTokens = 80 := rfl

theorem summary_default_flag : summaryIsDefaultDetail = true := rfl

theorem bus_does_not_kill_sessions : busKillsSessions = false := rfl

theorem bus_does_not_reboot : busRebootsSession = false := rfl

theorem bus_does_not_restart_service : busRestartsService = false := rfl

theorem does_not_replace_acp : replacesAcp = false := rfl

theorem attached_agent_may_not_change_permissions :
    attachedAgentMayChangePermissions = false :=
  rfl

theorem attached_agent_may_not_change_config :
    attachedAgentMayChangeConfig = false :=
  rfl

theorem attached_agent_is_the_defined_term :
    attachedAgentIsDefinedTerm = true :=
  rfl

theorem readonly_effect_is_specified : readonlyEffectSpecified = true := rfl

theorem conforming_session_bus_program_not_claimed :
    conformingSessionBusProgramClaimed = false :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
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

theorem mash_conforming_session_bus_program_claimed_is_false :
    mashConformingSessionBusProgramClaimedIsFalse := by
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

theorem mash_network_listener_present_is_false :
    mashNetworkListenerPresentIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_other_uid_with_same_uid_only_is_false :
    mashOtherUidWithSameUidOnlyIsFalse := by
  intro h
  cases h with
  | intro hOnly hOther =>
    unfold socketIsSameUidOnly at hOnly
    rw [hOther] at hOnly
    exact Bool.noConfusion hOnly

theorem mash_full_text_with_deltas_only_is_false :
    mashFullTextWithDeltasOnlyIsFalse := by
  intro h
  cases h with
  | intro hDeltas hFull =>
    unfold transcriptReturnsDeltasOnly at hDeltas
    rw [hFull] at hDeltas
    exact Bool.noConfusion hDeltas

theorem mash_approve_on_and_off_by_default_is_false :
    mashApproveOnAndOffByDefaultIsFalse := by
  intro h
  cases h with
  | intro hOn hOff =>
    unfold approveOffByDefault at hOff
    rw [hOn] at hOff
    exact Bool.noConfusion hOff

theorem mash_deny_on_and_off_by_default_is_false :
    mashDenyOnAndOffByDefaultIsFalse := by
  intro h
  cases h with
  | intro hOn hOff =>
    unfold denyOffByDefault at hOff
    rw [hOn] at hOff
    exact Bool.noConfusion hOff

theorem mash_bus_kills_sessions_is_false :
    mashBusKillsSessionsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_bus_reboots_session_is_false :
    mashBusRebootsSessionIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_bus_restarts_service_is_false :
    mashBusRestartsServiceIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_replaces_acp_is_false : mashReplacesAcpIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_outside_agent_changes_permissions_is_false :
    mashAttachedAgentChangesPermissionsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_outside_agent_changes_config_is_false :
    mashAttachedAgentChangesConfigIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_lean_proof_is_the_spec_is_false :
    mashLeanProofIsTheSpecIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_markdown_substitutes_for_encodings_is_false :
    mashMarkdownSubstitutesForEncodingsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_readonly_effect_specified_is_false :
    mashReadonlyEffectSpecifiedIsFalse := by
  intro h
  unfold mashReadonlyEffectSpecified at h
  have still : readonlyInterjectStillRuns = false := by decide
  rw [still] at h
  exact Bool.noConfusion h

theorem mash_markdown_file_is_conforming_program_is_false :
    mashMarkdownFileIsConformingProgramIsFalse := by
  intro h
  cases h

theorem mash_assigns_0015_to_fargo_is_false :
    mashAssigns0015ToFargoIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_anunnaki_file_at_0015_exists_is_false :
    mashAnunnakiFileAt0015ExistsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_work_streams_claimed_done_is_false :
    mashWorkStreamsClaimedDoneIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_earlier_shipped_version_claimed_is_false :
    mashEarlierShippedVersionClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_attach_starts_second_session_is_false :
    mashAttachStartsSecondSessionIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_scrapes_the_screen_is_false :
    mashScrapesTheScreenIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_steer_methods_claimed_implemented_is_false :
    mashSteerMethodsClaimedImplementedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_spec_check_is_meaning_checker_is_false :
    mashSpecCheckIsMeaningCheckerIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem markdown_is_not_the_program : markdownIsNotTheProgram = true := rfl

theorem required_conformance_holds : requiredConformanceHolds = true := by
  native_decide

theorem session_bus_server_is_not_l0 :
    sessionBusServerIsL0 = false := rfl

theorem session_bus_server_is_not_a_layer :
    sessionBusServerIsLayer = false := rfl

theorem master_control_program_is_an_attached_client :
    masterControlProgramIsAttachedClient = true := rfl

theorem acts_never_target_an_l3 :
    actAddressAllowed .l3 = false ∧ actAddressAllowed .l1 = true ∧
      actAddressAllowed .watchedL2 = true := by
  decide

theorem inherited_sandbox_does_not_widen_l1 :
    inheritedSandboxWidensL1 = false ∧
      bitsWiden inheritedL2Sandbox l1Sandbox = false := by
  decide

theorem only_l1_owns_a_session_socket :
    onlyL1OwnsSessionSocket = true ∧ l2OwnsSessionSocket = false ∧
      l3OwnsSessionSocket = false := by
  decide

end SessionBusProofs
