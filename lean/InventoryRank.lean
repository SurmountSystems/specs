/-
  Rank table for INVENTORY.md.

  Each row keeps the rank order written in that file. Ranks 1 through 8
  stay in that order. A row is a living catalog member when
  InconsistencyReport.catalog names the same file and theorem. A row is a
  positive lock when its False wrapper is already retired. Ranks 1 through
  4 are those locks. They are not catalog rows. Every other row stays in
  the table and is outside the catalog unless the catalog names it. A Bool
  flag equal to false is not added as a catalog row.

  The shrink list is the confident rows only. Assumed rows stay in the
  catalog and are not in that list. The highest confident row is
  mash_compcert_refines_claimed_done_is_false in
  lean/SystemsLeanProofs.lean. That proof reads the live Clause 3.17
  sentence. The next confident row is
  mash_self_host_from_c_satisfies_bootstrap_is_false in the same file.
  Encoded indexes 114 and 176 are the 0007_CI array slots (markdown lines
  115 and 177). Encoded index 480 is the 0002_Systems_Lean array slot
  (markdown line 481). Index 114 is not the blank line whose MdLine number
  field is 114. This module does not hardcode the catalog length.

  This module does not read files and does not shell out. The sibling
  lines are the encodings already elaborated by the package.
-/

import InconsistencyReport
import Surmount
import Ci
import CiProofs
import MdLine
import «0007_CI»
import «0002_Systems_Lean»

namespace InventoryRank

inductive Severity where
  | assuranceClaimedDone
  | licenseTestInverted
  | productCalledReady
  | productCalledAbsent
  | identityCollapsed
  | requirementHidden
  | localClash
  deriving DecidableEq, Repr, BEq

inductive RankRole where
  | livingCatalog
  | positiveLock
  | outsideCatalog
  deriving DecidableEq, Repr, BEq

structure RankRow where
  rank : Nat
  severity : Severity
  theoremName : String
  sourceFile : String
  deriving DecidableEq, Repr, BEq

def assuranceClaimedDone : Severity := .assuranceClaimedDone
def licenseTestInverted : Severity := .licenseTestInverted
def productCalledReady : Severity := .productCalledReady
def productCalledAbsent : Severity := .productCalledAbsent
def identityCollapsed : Severity := .identityCollapsed
def requirementHidden : Severity := .requirementHidden
def localClash : Severity := .localClash

def rankRow (rank : Nat) (severity : Severity) (theoremName sourceFile : String) : RankRow where
  rank := rank
  severity := severity
  theoremName := theoremName
  sourceFile := sourceFile

/-- INVENTORY.md table order. Do not reshuffle ranks 1 through 8. -/
def ranks : List RankRow := [
  rankRow 1 assuranceClaimedDone "read_live_compcert_rule_is_optional_metric_not_claimed_done" "lean/SystemsLeanProofs.lean",
  rankRow 2 assuranceClaimedDone "read_live_slake_bootstrap_is_not_claimed_done" "lean/SystemsLeanProofs.lean",
  rankRow 3 assuranceClaimedDone "read_live_byte_identity_is_not_claimed_true" "lean/Surmount.lean",
  rankRow 4 assuranceClaimedDone "read_live_byte_identity_claim_is_not_claimed_true" "lean/CiProofs.lean",
  rankRow 5 assuranceClaimedDone "mash_compcert_refines_claimed_done_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 6 assuranceClaimedDone "mash_self_host_from_c_satisfies_bootstrap_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 7 assuranceClaimedDone "mash_compcert_tso_satisfies_clause42_item6_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 8 assuranceClaimedDone "mash_safe_kernel_implies_safe_compcert_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 9 licenseTestInverted "mash_mit_meets_pdoss" "lean/UnlicenseProofs.lean",
  rankRow 10 licenseTestInverted "mash_apache_meets_pdoss" "lean/UnlicenseProofs.lean",
  rankRow 11 licenseTestInverted "mash_cc0_claimed_meets_pdoss_is_false" "lean/UnlicenseProofs.lean",
  rankRow 12 licenseTestInverted "mash_cc0_pinned_as_meeting_pdoss" "lean/UnlicenseProofs.lean",
  rankRow 13 licenseTestInverted "mash_cc0_pinned_is_false" "lean/UnlicenseProofs.lean",
  rankRow 14 licenseTestInverted "mash_unlicense_replaces_named_residual_licenses" "lean/UnlicenseProofs.lean",
  rankRow 15 productCalledReady "claiming_beastdb_ready_is_inconsistent" "lean/Surmount.lean",
  rankRow 16 productCalledReady "mash_beastdb_ready_for_use_is_false" "lean/BeastDbProofs.lean",
  rankRow 17 productCalledReady "mash_sssss_ready_for_use_is_false" "lean/SssssProofs.lean",
  rankRow 18 productCalledReady "mash_product_ready_for_use_is_false" "lean/MemexProofs.lean",
  rankRow 19 productCalledReady "mash_products_claimed_ready_is_false" "lean/SessionBusProofs.lean",
  rankRow 20 productCalledReady "mash_composition_as_product_readiness_is_false" "lean/Surmount.lean",
  rankRow 21 productCalledReady "mash_conforming_product_exists_is_false" "lean/LeanMachineProofs.lean",
  rankRow 22 productCalledReady "mash_conforming_encoder_claimed_is_false" "lean/AnunnakiProofs.lean",
  rankRow 23 productCalledReady "mash_conforming_session_bus_program_claimed_is_false" "lean/SessionBusProofs.lean",
  rankRow 24 productCalledReady "mash_reality_check_claimed_done_is_false" "lean/CiProofs.lean",
  rankRow 25 productCalledReady "mash_work_streams_claimed_done_is_false" "lean/SessionBusProofs.lean",
  rankRow 26 productCalledReady "mash_marketing_acid_is_proven_acid_is_false" "lean/BeastDbProofs.lean",
  rankRow 27 productCalledReady "mash_neurosymbolic_harness_shipped_is_false" "lean/SssssProofs.lean",
  rankRow 28 productCalledReady "mash_companion_lean_proves_crate_finished_is_false" "lean/MemexProofs.lean",
  rankRow 29 productCalledReady "mash_lake_writer_is_shipped_memex_is_false" "lean/MemexProofs.lean",
  rankRow 30 productCalledReady "mash_lake_writer_as_shipped_product_is_false" "lean/TechTreeProofs.lean",
  rankRow 31 productCalledReady "mash_legal_lean_finished_is_false" "lean/LeanMachineProofs.lean",
  rankRow 32 productCalledReady "mash_holy_lean_implemented_is_false" "lean/LeanMachineProofs.lean",
  rankRow 33 productCalledReady "mash_running_distributed_machine_claimed_is_false" "lean/LeanMachineProofs.lean",
  rankRow 34 productCalledReady "mash_steer_methods_claimed_implemented_is_false" "lean/SessionBusProofs.lean",
  rankRow 35 productCalledReady "mash_leftover_science_with_product_experiments" "lean/FormalVibeficationProofs.lean",
  rankRow 36 productCalledReady "mash_leftover_science_with_product_experiments_is_false" "lean/FormalVibeficationProofs.lean",
  rankRow 37 productCalledReady "mash_instruction_listing_published_is_false" "lean/AnunnakiProofs.lean",
  rankRow 38 productCalledReady "mash_earlier_shipped_version_claimed_is_false" "lean/SessionBusProofs.lean",
  rankRow 39 productCalledReady "mash_hashing_ban_proves_engine_obeys_is_false" "lean/SssssProofs.lean",
  rankRow 40 productCalledReady "mash_every_agent_already_conforms_is_false" "lean/CateProofs.lean",
  rankRow 41 productCalledReady "mash_spec_claims_every_agent_conforms_is_false" "lean/RsiProofs.lean",
  rankRow 42 productCalledReady "mash_clause_4_already_met_by_every_session_is_false" "lean/RsiProofs.lean",
  rankRow 43 productCalledReady "mash_cate_allows_invented_conforming_product_is_false" "lean/CateProofs.lean",
  rankRow 44 productCalledReady "mash_grok_oss_is_safe_c_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 45 productCalledReady "mash_gate_a_crate_is_safe_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 46 productCalledAbsent "claiming_published_session_bus_file_absent_yields_false" "lean/Surmount.lean",
  rankRow 47 productCalledAbsent "mash_beastdb_never_started_is_false" "lean/BeastDbProofs.lean",
  rankRow 48 productCalledAbsent "mash_sssss_never_started_is_false" "lean/SssssProofs.lean",
  rankRow 49 productCalledAbsent "mash_product_never_started_is_false" "lean/MemexProofs.lean",
  rankRow 50 productCalledAbsent "mash_products_never_started_is_false" "lean/SessionBusProofs.lean",
  rankRow 51 identityCollapsed "mash_homes_is_inconsistent" "lean/FormalVibeficationProofs.lean",
  rankRow 52 identityCollapsed "mash_layers_inconsistent" "lean/Surmount.lean",
  rankRow 53 identityCollapsed "mash_spec_and_proof" "lean/FormalVibeficationProofs.lean",
  rankRow 54 identityCollapsed "mash_spec_and_proof_is_false" "lean/FormalVibeficationProofs.lean",
  rankRow 55 identityCollapsed "mash_spec_and_proof" "lean/Surmount.lean",
  rankRow 56 identityCollapsed "product_unification_does_not_license_markdown_theorems" "lean/Surmount.lean",
  rankRow 57 identityCollapsed "mash_spec_and_proof" "lean/UnlicenseProofs.lean",
  rankRow 58 identityCollapsed "mash_spec_and_proof_is_false" "lean/UnlicenseProofs.lean",
  rankRow 59 identityCollapsed "mash_spec_and_proof_is_false" "lean/CiProofs.lean",
  rankRow 60 identityCollapsed "mash_spec_and_proof_is_false" "lean/AnunnakiProofs.lean",
  rankRow 61 identityCollapsed "mash_spec_and_proof_is_false" "lean/MemexProofs.lean",
  rankRow 62 identityCollapsed "mash_spec_and_proof_is_false" "lean/SessionBusProofs.lean",
  rankRow 63 identityCollapsed "mash_lean_proof_is_the_spec_is_false" "lean/SessionBusProofs.lean",
  rankRow 64 identityCollapsed "mash_markdown_substitutes_for_encodings_is_false" "lean/SessionBusProofs.lean",
  rankRow 65 identityCollapsed "mash_markdown_file_is_conforming_program_is_false" "lean/SessionBusProofs.lean",
  rankRow 66 identityCollapsed "mash_spec_and_proof_is_false" "lean/TechTreeProofs.lean",
  rankRow 67 identityCollapsed "mash_collision_tags_spec_and_proof_is_false" "lean/VocabularyCollisionProofs.lean",
  rankRow 68 identityCollapsed "mash_holy_lean_safec_lean_machine_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 69 identityCollapsed "holy_safe_c_lean_machine_one_module_is_not_true" "lean/LeanMachineProofs.lean",
  rankRow 70 identityCollapsed "mash_enki_and_anunnaki_are_one_object_is_false" "lean/AnunnakiProofs.lean",
  rankRow 71 identityCollapsed "mash_vocabulary_not_cate" "lean/Surmount.lean",
  rankRow 72 identityCollapsed "cate_number_disagreement_is_inconsistent" "lean/Surmount.lean",
  rankRow 73 identityCollapsed "surmount_number_disagreement_is_inconsistent" "lean/Surmount.lean",
  rankRow 74 identityCollapsed "mash_number_0015_is_this_specification_is_false" "lean/AnunnakiProofs.lean",
  rankRow 75 identityCollapsed "mash_assigns_0015_to_fargo_is_false" "lean/SessionBusProofs.lean",
  rankRow 76 identityCollapsed "mash_anunnaki_file_at_0015_exists_is_false" "lean/SessionBusProofs.lean",
  rankRow 77 identityCollapsed "mash_replaces_acp_is_false" "lean/SessionBusProofs.lean",
  rankRow 78 identityCollapsed "mash_enki_has_numbered_specification_is_false" "lean/AnunnakiProofs.lean",
  rankRow 79 identityCollapsed "mash_safe_c_is_own_published_spec_number_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 80 identityCollapsed "mash_legal_lean_has_separate_number_is_false" "lean/LeanMachineProofs.lean",
  rankRow 81 identityCollapsed "mash_holy_lean_has_separate_number_is_false" "lean/LeanMachineProofs.lean",
  rankRow 82 identityCollapsed "mash_carbonado_assigned_number_is_false" "lean/AnunnakiProofs.lean",
  rankRow 83 identityCollapsed "mash_rdps_assigned_number_is_false" "lean/AnunnakiProofs.lean",
  rankRow 84 identityCollapsed "mash_filter_script_assigned_number_is_false" "lean/AnunnakiProofs.lean",
  rankRow 85 identityCollapsed "mash_sssp_has_numbered_spec_is_false" "lean/RsiProofs.lean",
  rankRow 86 identityCollapsed "mash_this_document_creates_sssp_is_false" "lean/RsiProofs.lean",
  rankRow 87 identityCollapsed "mash_rsi_replaces_leftover_unstack_is_false" "lean/RsiProofs.lean",
  rankRow 88 identityCollapsed "mash_rsi_is_training_run_is_false" "lean/RsiProofs.lean",
  rankRow 89 identityCollapsed "mash_rsi_is_bitmask_spec_is_false" "lean/RsiProofs.lean",
  rankRow 90 identityCollapsed "mash_archive_is_sstt_is_false" "lean/MemexProofs.lean",
  rankRow 91 identityCollapsed "mash_magic_is_tech_tree_is_false" "lean/MemexProofs.lean",
  rankRow 92 identityCollapsed "mash_extension_is_sstt_is_false" "lean/MemexProofs.lean",
  rankRow 93 identityCollapsed "mash_load_sstt_makes_archive_sstt_is_false" "lean/MemexProofs.lean",
  rankRow 94 identityCollapsed "mash_crate_name_is_command_is_false" "lean/MemexProofs.lean",
  rankRow 95 identityCollapsed "mash_repo_unlicense_covers_crate_is_false" "lean/MemexProofs.lean",
  rankRow 96 identityCollapsed "mash_syscall_durability_is_beastdb_acid_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 97 identityCollapsed "mash_tsx_is_beastdb_acid_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 98 identityCollapsed "mash_page_cache_is_rcu_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 99 identityCollapsed "mash_thread_shared_is_process_shared_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 100 identityCollapsed "mash_posix_fork_is_fork_join_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 101 identityCollapsed "mash_posix_fork_is_borrow_or_owned_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 102 identityCollapsed "mash_meaning_proofs_are_second_form_checker_is_false" "lean/RsiProofs.lean",
  rankRow 103 identityCollapsed "mash_traditional_ffi_as_interop_path_is_false" "lean/BeastDbProofs.lean",
  rankRow 104 identityCollapsed "mash_science_steps" "lean/FormalVibeficationProofs.lean",
  rankRow 105 identityCollapsed "mash_science_steps_is_false" "lean/FormalVibeficationProofs.lean",
  rankRow 106 requirementHidden "mash_spec_and_proof_conforming_is_false" "lean/LeanMachineProofs.lean",
  rankRow 107 requirementHidden "leftover_unstack_as_conforming_is_inconsistent" "lean/Surmount.lean",
  rankRow 108 requirementHidden "mash_leftover_unstack_as_conforming" "lean/CateProofs.lean",
  rankRow 109 requirementHidden "mash_british_spelling_conforms_is_false" "lean/CateProofs.lean",
  rankRow 110 requirementHidden "mash_unsigned_as_general_skip_is_false" "lean/CiProofs.lean",
  rankRow 111 requirementHidden "mash_this_repo_claims_unsigned_exception_is_false" "lean/CiProofs.lean",
  rankRow 112 requirementHidden "mash_network_listener_present_is_false" "lean/SessionBusProofs.lean",
  rankRow 113 requirementHidden "mash_other_uid_with_same_uid_only_is_false" "lean/SessionBusProofs.lean",
  rankRow 114 requirementHidden "mash_outside_agent_changes_permissions_is_false" "lean/SessionBusProofs.lean",
  rankRow 115 requirementHidden "mash_outside_agent_changes_config_is_false" "lean/SessionBusProofs.lean",
  rankRow 116 requirementHidden "mash_bus_kills_sessions_is_false" "lean/SessionBusProofs.lean",
  rankRow 117 requirementHidden "mash_bus_reboots_session_is_false" "lean/SessionBusProofs.lean",
  rankRow 118 requirementHidden "mash_bus_restarts_service_is_false" "lean/SessionBusProofs.lean",
  rankRow 119 requirementHidden "mash_attach_starts_second_session_is_false" "lean/SessionBusProofs.lean",
  rankRow 120 requirementHidden "mash_scrapes_the_screen_is_false" "lean/SessionBusProofs.lean",
  rankRow 121 requirementHidden "mash_full_text_with_deltas_only_is_false" "lean/SessionBusProofs.lean",
  rankRow 122 requirementHidden "mash_readonly_effect_specified_is_false" "lean/SessionBusProofs.lean",
  rankRow 123 requirementHidden "omitting_0008_is_inconsistent" "lean/Surmount.lean",
  rankRow 124 requirementHidden "omitting_0009_is_inconsistent" "lean/Surmount.lean",
  rankRow 125 requirementHidden "mash_unpublished_0009" "lean/CateProofs.lean",
  rankRow 126 requirementHidden "omitting_0011_is_inconsistent" "lean/Surmount.lean",
  rankRow 127 requirementHidden "omitting_0012_is_inconsistent" "lean/Surmount.lean",
  rankRow 128 requirementHidden "mash_local_pdf_as_clause12_pin" "lean/FormalVibeficationProofs.lean",
  rankRow 129 requirementHidden "mash_local_pdf_as_clause12_pin_is_false" "lean/FormalVibeficationProofs.lean",
  rankRow 130 requirementHidden "mash_local_pdf_as_publisher_url" "lean/FormalVibeficationProofs.lean",
  rankRow 131 requirementHidden "mash_local_pdf_as_publisher_url_is_false" "lean/FormalVibeficationProofs.lean",
  rankRow 132 requirementHidden "mash_nationality_statutes_are_clause_12_pins" "lean/UnlicenseProofs.lean",
  rankRow 133 requirementHidden "mash_residual_attribution_contribution_accepted" "lean/UnlicenseProofs.lean",
  rankRow 134 requirementHidden "mash_copied_uint64_theorems_is_false" "lean/TechTreeProofs.lean",
  rankRow 135 requirementHidden "mash_chat_only_residual_is_false" "lean/RsiProofs.lean",
  rankRow 136 requirementHidden "mash_chat_reminder_as_durable_tool_is_false" "lean/RsiProofs.lean",
  rankRow 137 requirementHidden "mash_reshape_test_without_contract_change_is_false" "lean/RsiProofs.lean",
  rankRow 138 requirementHidden "mash_serialize_independent_is_false" "lean/RsiProofs.lean",
  rankRow 139 requirementHidden "mash_worship_required_for_conformance_is_false" "lean/LeanMachineProofs.lean",
  rankRow 140 requirementHidden "mash_belief_required_for_conformance_is_false" "lean/LeanMachineProofs.lean",
  rankRow 141 requirementHidden "mash_theology_is_must_for_compiler_is_false" "lean/LeanMachineProofs.lean",
  rankRow 142 requirementHidden "mash_bounce_buffer_required_is_false" "lean/BeastDbProofs.lean",
  rankRow 143 requirementHidden "mash_mutex_trie_is_false" "lean/BeastDbProofs.lean",
  rankRow 144 requirementHidden "mash_inferred_schema_leaves_data_without_schema_is_false" "lean/BeastDbProofs.lean",
  rankRow 145 requirementHidden "claimed_integration_that_uses_neural_while_symbolic_can" "lean/SssssProofs.lean",
  rankRow 146 requirementHidden "mash_claimed_neural_while_symbolic_can_is_false" "lean/SssssProofs.lean",
  rankRow 147 requirementHidden "mash_spend_neural_when_symbolic_can_is_false" "lean/SssssProofs.lean",
  rankRow 148 requirementHidden "mash_claimed_not_systems_lean_is_false_as_false" "lean/SssssProofs.lean",
  rankRow 149 requirementHidden "mash_auxiliary_replaces_sequential_is_false" "lean/SssssProofs.lean",
  rankRow 150 requirementHidden "mash_wait_on_finished_memex_command_is_false" "lean/MemexProofs.lean",
  rankRow 151 requirementHidden "mash_typed_link_input_claimed_proved_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 152 requirementHidden "mash_cons_on_every_export_claimed_proved_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 153 requirementHidden "mash_spelling_converter_claimed_is_false" "lean/AnunnakiProofs.lean",
  rankRow 154 requirementHidden "mash_producer_wired_into_product_tree_is_false" "lean/TechTreeProofs.lean",
  rankRow 155 requirementHidden "mash_memcpy_equation_present_theorem_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 156 requirementHidden "mash_named_residual_identifiers_present_theories_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 157 requirementHidden "mash_dialect_needs_own_language_id_is_false" "lean/AnunnakiProofs.lean",
  rankRow 158 requirementHidden "mash_contradiction_floor_is_every_sentence_pair_is_false" "lean/CateProofs.lean",
  rankRow 159 requirementHidden "mash_leftover_unstack_floor_as_complete_english_is_false" "lean/CateProofs.lean",
  rankRow 160 requirementHidden "mash_catalog_isomorphism_proves_definitions_complete_is_false" "lean/VocabularyProofs.lean",
  rankRow 161 requirementHidden "mash_duplicate_token_check_is_complete_ambiguity_checker_is_false" "lean/VocabularyProofs.lean",
  rankRow 162 requirementHidden "mash_spec_check_is_meaning_checker_is_false" "lean/SessionBusProofs.lean",
  rankRow 163 requirementHidden "mash_perfect_theorem_name_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 164 requirementHidden "mash_isomorphism_theorem_name_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 165 localClash "mash_safe_mem_non_atomic_data_race_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 166 localClash "sample_race_derives_safe_mem_mash" "lean/SystemsLeanProofs.lean",
  rankRow 167 localClash "mash_secret_copy_into_non_secret_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 168 localClash "mash_secret_dont_fork_posix_fork_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 169 localClash "mash_secret_object_cow_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 170 localClash "mash_secret_page_cow_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 171 localClash "mash_panic_free_reachable_unwrap_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 172 localClash "mash_unique_block_copy_handle_no_protocol_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 173 localClash "mash_link_face_exports_unique_block_as_bits_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 174 localClash "mash_glibc_malloc_untyped_unique_block_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 175 localClash "mash_hardware_tag_replaces_unique_block_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 176 localClash "mash_language_omega_on_heap_owner_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 177 localClash "mash_unique_only_posix_fork_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 178 localClash "mash_lock_free_free_without_reclamation_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 179 localClash "lock_free_free_without_reclamation_keeps_mash" "lean/SystemsLeanProofs.lean",
  rankRow 180 localClash "mash_mutex_free_file_is_lock_free_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 181 localClash "mash_cas_non_atomic_cell_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 182 localClash "mash_cas_unique_block_pointer_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 183 localClash "mash_rw_lock_shared_and_exclusive_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 184 localClash "mash_copy_handle_lock_token_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 185 localClash "mash_once_implies_unique_block_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 186 localClash "mash_pin_survives_posix_fork_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 187 localClash "mash_compcert_fragment_inline_asm_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 188 localClash "mash_compcert_fragment_container_of_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 189 localClash "mash_beastdb_props_cons_without_attach_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 190 localClash "mash_autovectorization_is_simd_proof_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 191 localClash "explicit_packed_keeps_autovectorization_mash" "lean/SystemsLeanProofs.lean",
  rankRow 192 localClash "mash_approve_on_and_off_by_default_is_false" "lean/SessionBusProofs.lean",
  rankRow 193 localClash "mash_deny_on_and_off_by_default_is_false" "lean/SessionBusProofs.lean",
  rankRow 194 assuranceClaimedDone "mash_delta_loop_byte_identity_holds_is_false" "lean/SssssProofs.lean",
  rankRow 195 assuranceClaimedDone "mash_reference_target_satisfies_clause42_item6_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 196 productCalledReady "mash_supercompiler_improvement_finished_is_false" "lean/RsiProofs.lean",
  rankRow 197 identityCollapsed "mash_exactly_one_reference_compiler_is_false" "lean/SssssProofs.lean",
  rankRow 198 identityCollapsed "mash_spec_0004_replaces_spec_0002_is_false" "lean/SssssProofs.lean",
  rankRow 199 identityCollapsed "mash_spec_0006_replaces_spec_0004_is_false" "lean/SssssProofs.lean",
  rankRow 200 identityCollapsed "mash_security_alone_must_is_false" "lean/SssssProofs.lean",
  rankRow 201 identityCollapsed "mash_performance_alone_must_is_false" "lean/SssssProofs.lean",
  rankRow 202 requirementHidden "mash_neural_accepts_rule_without_lean_proof_is_false" "lean/SssssProofs.lean",
  rankRow 203 requirementHidden "mash_safec_not_combined_with_fastc_must_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 204 requirementHidden "mash_safec_not_combined_with_fastc_cannot_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 205 requirementHidden "mash_fastsafec_must_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 206 identityCollapsed "mash_safec_cannot_combine_with_fastc_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 207 identityCollapsed "mash_fastsafec_is_not_overlap_of_safec_and_fastc_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 208 assuranceClaimedDone "mash_fastsafec_balance_already_finished_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 209 identityCollapsed "mash_fastsafec_replaces_safec_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 210 identityCollapsed "mash_fastsafec_replaces_fastc_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 211 requirementHidden "mash_fastsafec_cannot_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 212 requirementHidden "mash_ccomp_is_the_only_metric_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 213 requirementHidden "mash_unmarked_freestanding_must_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 214 requirementHidden "mash_unmarked_freestanding_cannot_include_ccomp_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 215 requirementHidden "mash_fastsafec_balance_rule_unspecified_or_open_question_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 216 requirementHidden "mash_unfinished_fastsafec_proof_means_rule_missing_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 217 requirementHidden "mash_drop_safe_judgments_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 218 requirementHidden "mash_drop_fastc_parallelism_proofs_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 219 requirementHidden "mash_drop_atomics_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 220 requirementHidden "mash_drop_threading_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 221 requirementHidden "mash_drop_proved_freedom_from_locks_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 222 requirementHidden "mash_drop_slake_typecheck_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 223 requirementHidden "mash_drop_byte_identity_of_emit_from_fastsafec_balance_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 224 requirementHidden "mash_optional_ccomp_means_forbidden_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 225 requirementHidden "mash_silence_selects_fastc_safec_or_fastsafec_is_false" "lean/SystemsLeanProofs.lean",
  rankRow 226 identityCollapsed "mash_spec_and_proof_is_false" "lean/HierarchicalSubagentsProofs.lean",
  rankRow 227 productCalledAbsent "claiming_published_hierarchical_subagents_file_absent_yields_false" "lean/Surmount.lean"
]

def compcertLockName : String :=
  "read_live_compcert_rule_is_optional_metric_not_claimed_done"

def slakeLockName : String :=
  "read_live_slake_bootstrap_is_not_claimed_done"

def compcertLockFile : String := "lean/SystemsLeanProofs.lean"

def slakeLockFile : String := "lean/SystemsLeanProofs.lean"

def byteIdentityLockName : String :=
  "read_live_byte_identity_is_not_claimed_true"

def byteIdentityClaimLockName : String :=
  "read_live_byte_identity_claim_is_not_claimed_true"

def byteIdentityLockFile : String := "lean/Surmount.lean"

def byteIdentityClaimLockFile : String := "lean/CiProofs.lean"

def isPositiveLockName (file name : String) : Bool :=
  (file == compcertLockFile && name == compcertLockName) ||
    (file == slakeLockFile && name == slakeLockName) ||
    (file == byteIdentityLockFile && name == byteIdentityLockName) ||
    (file == byteIdentityClaimLockFile && name == byteIdentityClaimLockName)

def inCatalog (file name : String) : Bool :=
  InconsistencyReport.catalog.any fun c => c.file == file && c.claim == name

def inConfident (file name : String) : Bool :=
  InconsistencyReport.confidentClaims.any fun c => c.file == file && c.claim == name

def inAssumed (file name : String) : Bool :=
  InconsistencyReport.assumedClaims.any fun c => c.file == file && c.claim == name

def roleOf (file name : String) : RankRole :=
  if isPositiveLockName file name then .positiveLock
  else if inCatalog file name then .livingCatalog
  else .outsideCatalog

def rowRole (r : RankRow) : RankRole :=
  roleOf r.sourceFile r.theoremName

def countPair (file name : String) : Nat :=
  (ranks.filter fun r => r.sourceFile == file && r.theoremName == name).length

/-- Every living catalog theorem name appears in the rank table once. -/
def catalogNamesOnce : Bool :=
  InconsistencyReport.catalog.all fun c => countPair c.file c.claim == 1

def livingRows : List RankRow :=
  ranks.filter fun r => rowRole r == .livingCatalog

def livingCount : Nat :=
  livingRows.length

/-- Lengths quoted as the catalog that this module rejects. 227 is the rank table length, not the catalog length. 225 remains a rejected length. -/
def staleCatalogLengths : List Nat := [77, 78, 168, 193, 202, 210, 214, 222, 225]

def ranksMatchIndex (i : Nat) : List RankRow → Bool
  | [] => true
  | r :: rest => r.rank == i && ranksMatchIndex (i + 1) rest

def rowsUnique : Bool :=
  ranks.all fun r => countPair r.sourceFile r.theoremName == 1

def severityCount (s : Severity) : Nat :=
  (ranks.filter fun r => r.severity == s).length

def minByRank : List RankRow → Option RankRow
  | [] => none
  | r :: rest =>
    match minByRank rest with
    | none => some r
    | some b => if r.rank ≤ b.rank then some r else some b

/-- Smallest rank among living catalog rows. That is the highest severity living row. -/
def highestLivingRow : Option RankRow :=
  minByRank livingRows

/-- Confident rows in rank order. Assumed rows are not in this list. -/
def shrinkRows : List RankRow :=
  ranks.filter fun r => inConfident r.sourceFile r.theoremName

/-- Smallest rank among confident rows. That is the shrink target. -/
def highestConfidentRow : Option RankRow :=
  minByRank shrinkRows

/-- Next confident row after the shrink target. Not the next rank if that rank is assumed. -/
def nextConfidentRow : Option RankRow :=
  match highestConfidentRow with
  | none => none
  | some h => minByRank (shrinkRows.filter fun r => Nat.blt h.rank r.rank)

def rankByNumber (n : Nat) : Option RankRow :=
  ranks.find? fun r => r.rank == n

def nextRankRow : Option RankRow :=
  highestLivingRow.bind fun r => rankByNumber (r.rank + 1)

def withoutClaim (file name : String) : List InconsistencyReport.ProvenClaim :=
  InconsistencyReport.catalog.filter fun c => !(c.file == file && c.claim == name)

/-- Encoded index of the 0007_CI Clause 3.10 sentence. Markdown line 115. -/
def ciEncodedIndex0 : Nat := 114

/-- Encoded index of the 0007_CI Clause 4.7 item 2 sentence. Markdown line 177. -/
def ciEncodedIndex1 : Nat := 176

/-- Encoded index of the 0002_Systems_Lean Clause 6.3 sentence. Markdown line 481. -/
def systemsLeanEncodedIndex : Nat := 480

def blockingReading : Option Surmount.ByteIdentityLiveReading :=
  Surmount.readLiveByteIdentity
    Surmount.ciClause310ByteIdentityLine
    Surmount.ciClause47Item2ByteIdentityLine
    Surmount.systemsClause63ByteIdentityLine

def blockingRequired : Bool :=
  blockingReading == some .notClaimedTrue

def blockingClaimedTrue : Bool :=
  blockingReading == some .alreadyEqualsElf

structure ShrinkBlocking where
  highestTheorem : String
  highestFile : String
  nextTheorem : String
  nextFile : String
  ciEncodedIndex0 : Nat
  ciEncodedIndex1 : Nat
  systemsLeanEncodedIndex : Nat
  liveReading : Option Surmount.ByteIdentityLiveReading
  byteIdentityRequired : Bool
  byteIdentityClaimedTrue : Bool
  deriving DecidableEq, Repr

/-- Highest confident row, the next confident row, and the live sentence reading. -/
def highestShrinkBlocking : ShrinkBlocking where
  highestTheorem := match highestConfidentRow with
    | some r => r.theoremName
    | none => ""
  highestFile := match highestConfidentRow with
    | some r => r.sourceFile
    | none => ""
  nextTheorem := match nextConfidentRow with
    | some r => r.theoremName
    | none => ""
  nextFile := match nextConfidentRow with
    | some r => r.sourceFile
    | none => ""
  ciEncodedIndex0 := ciEncodedIndex0
  ciEncodedIndex1 := ciEncodedIndex1
  systemsLeanEncodedIndex := systemsLeanEncodedIndex
  liveReading := blockingReading
  byteIdentityRequired := blockingRequired
  byteIdentityClaimedTrue := blockingClaimedTrue

def renderShrinkBlocking (s : ShrinkBlocking) : String :=
  s!"{s.highestTheorem} in {s.highestFile} is the highest confident row. Next confident row is {s.nextTheorem} in {s.nextFile}. Assumed rows are not in this shrink list. Byte identity is required and is not claimed true. Encoded indexes {s.ciEncodedIndex0}, {s.ciEncodedIndex1}, and {s.systemsLeanEncodedIndex}."

theorem rank_table_length : ranks.length = 227 := by
  native_decide

theorem ranks_match_index : ranksMatchIndex 1 ranks = true := by
  native_decide

theorem rows_unique : rowsUnique = true := by
  native_decide

theorem first_row :
    ranks[0]? = some (rankRow 1 assuranceClaimedDone compcertLockName compcertLockFile) := rfl

theorem second_row :
    ranks[1]? = some (rankRow 2 assuranceClaimedDone slakeLockName slakeLockFile) := rfl

theorem third_row :
    ranks[2]? = some (rankRow 3 assuranceClaimedDone
      byteIdentityLockName byteIdentityLockFile) := rfl

theorem fourth_row :
    ranks[3]? = some (rankRow 4 assuranceClaimedDone
      byteIdentityClaimLockName byteIdentityClaimLockFile) := rfl

theorem fifth_row :
    ranks[4]? = some (rankRow 5 assuranceClaimedDone
      "mash_compcert_refines_claimed_done_is_false" "lean/SystemsLeanProofs.lean") := rfl

theorem sixth_row :
    ranks[5]? = some (rankRow 6 assuranceClaimedDone
      "mash_self_host_from_c_satisfies_bootstrap_is_false" "lean/SystemsLeanProofs.lean") := rfl

theorem ranks_one_through_eight :
    (ranks.take 8).map (·.theoremName) = [
      compcertLockName,
      slakeLockName,
      byteIdentityLockName,
      byteIdentityClaimLockName,
      "mash_compcert_refines_claimed_done_is_false",
      "mash_self_host_from_c_satisfies_bootstrap_is_false",
      "mash_compcert_tso_satisfies_clause42_item6_is_false",
      "mash_safe_kernel_implies_safe_compcert_is_false"
    ] := by
  native_decide

theorem first_row_is_positive_lock :
    (ranks[0]?).map rowRole = some .positiveLock := by
  native_decide

theorem second_row_is_positive_lock :
    (ranks[1]?).map rowRole = some .positiveLock := by
  native_decide

theorem locks_are_not_living_roles :
    (ranks[0]?).map rowRole ≠ some .livingCatalog ∧
      (ranks[1]?).map rowRole ≠ some .livingCatalog := by
  native_decide

theorem positive_locks_absent_from_catalog :
    InconsistencyReport.claimInCatalog compcertLockName = false ∧
      InconsistencyReport.claimInCatalog slakeLockName = false := by
  native_decide

theorem retiring_compcert_lock_does_not_shrink :
    (withoutClaim compcertLockFile compcertLockName).length =
      InconsistencyReport.catalog.length := by
  native_decide

theorem retiring_slake_lock_does_not_shrink :
    (withoutClaim slakeLockFile slakeLockName).length =
      InconsistencyReport.catalog.length := by
  native_decide

theorem third_row_is_positive_lock :
    (ranks[2]?).map rowRole = some .positiveLock := by
  native_decide

theorem fourth_row_is_positive_lock :
    (ranks[3]?).map rowRole = some .positiveLock := by
  native_decide

theorem byte_identity_locks_are_not_living :
    (ranks[2]?).map rowRole ≠ some .livingCatalog ∧
      (ranks[3]?).map rowRole ≠ some .livingCatalog := by
  native_decide

theorem byte_identity_locks_absent_from_catalog :
    InconsistencyReport.claimInCatalog byteIdentityLockName = false ∧
      InconsistencyReport.claimInCatalog byteIdentityClaimLockName = false := by
  native_decide

theorem retiring_byte_identity_lock_does_not_shrink :
    (withoutClaim byteIdentityLockFile byteIdentityLockName).length =
      InconsistencyReport.catalog.length := by
  native_decide

theorem retiring_byte_identity_claim_lock_does_not_shrink :
    (withoutClaim byteIdentityClaimLockFile byteIdentityClaimLockName).length =
      InconsistencyReport.catalog.length := by
  native_decide

theorem catalog_names_once : catalogNamesOnce = true := by
  native_decide

/-- Living rows are the catalog rows. The length is the catalog length, not a copied numeral. -/
theorem living_catalog_length :
    livingCount = InconsistencyReport.catalog.length := by
  native_decide

theorem catalog_length_is_living :
    InconsistencyReport.catalog.length = livingCount :=
  Eq.symm living_catalog_length

theorem rank_count_is_not_living_count : ranks.length ≠ livingCount := by
  native_decide

theorem stale_lengths_are_not_76 :
    staleCatalogLengths.all (fun n => n != 76) = true := by
  decide

theorem stale_catalog_lengths_rejected :
    staleCatalogLengths.all (fun n => n != livingCount) = true := by
  native_decide

theorem severity_counts :
    severityCount assuranceClaimedDone = 11 ∧
      severityCount licenseTestInverted = 6 ∧
      severityCount productCalledReady = 32 ∧
      severityCount productCalledAbsent = 6 ∧
      severityCount identityCollapsed = 65 ∧
      severityCount requirementHidden = 78 ∧
      severityCount localClash = 29 := by
  native_decide

theorem role_matches_catalog :
    ranks.all (fun r =>
      (rowRole r == .livingCatalog) == inCatalog r.sourceFile r.theoremName) = true := by
  native_decide

theorem retiring_compcert_refines_shrinks :
    (withoutClaim "lean/SystemsLeanProofs.lean"
      "mash_compcert_refines_claimed_done_is_false").length =
      InconsistencyReport.catalog.length - 1 := by
  native_decide

theorem retiring_self_host_shrinks :
    (withoutClaim "lean/SystemsLeanProofs.lean"
      "mash_self_host_from_c_satisfies_bootstrap_is_false").length =
      InconsistencyReport.catalog.length - 1 := by
  native_decide

theorem compcert_refines_in_catalog :
    InconsistencyReport.hasClaim "lean/SystemsLeanProofs.lean"
      "mash_compcert_refines_claimed_done_is_false" = true := by
  native_decide

theorem self_host_in_catalog :
    InconsistencyReport.hasClaim "lean/SystemsLeanProofs.lean"
      "mash_self_host_from_c_satisfies_bootstrap_is_false" = true := by
  native_decide

theorem fifth_row_is_living :
    (ranks[4]?).map rowRole = some .livingCatalog := by
  native_decide

theorem sixth_row_is_living :
    (ranks[5]?).map rowRole = some .livingCatalog := by
  native_decide

theorem highest_living_is_fifth_row : highestLivingRow = ranks[4]? := by
  native_decide

theorem next_rank_is_sixth_row : nextRankRow = ranks[5]? := by
  native_decide

theorem shrink_rows_are_confident :
    shrinkRows.all (fun r => inConfident r.sourceFile r.theoremName) = true := by
  native_decide

theorem assumed_rows_absent_from_shrink_rows :
    shrinkRows.all (fun r => inAssumed r.sourceFile r.theoremName == false) = true := by
  native_decide

theorem shrink_rows_match_confident_count :
    shrinkRows.length = InconsistencyReport.confidentClaims.length := by
  native_decide

theorem highest_confident_is_fifth_row : highestConfidentRow = ranks[4]? := by
  native_decide

theorem next_confident_is_sixth_row : nextConfidentRow = ranks[5]? := by
  native_decide

theorem reference_target_is_not_a_shrink_row :
    shrinkRows.any (fun r =>
      r.theoremName == "mash_reference_target_satisfies_clause42_item6_is_false") = false := by
  native_decide

theorem clause310_slot :
    Surmount.ciClause310ByteIdentityLine = «0007_CI».encodedLines[ciEncodedIndex0]! := rfl

theorem clause47_slot :
    Surmount.ciClause47Item2ByteIdentityLine = «0007_CI».encodedLines[ciEncodedIndex1]! := rfl

theorem clause63_slot :
    Surmount.systemsClause63ByteIdentityLine = «0002_Systems_Lean».encodedLines[systemsLeanEncodedIndex]! := rfl

theorem denial_markdown_lines :
    Surmount.ciClause310ByteIdentityLine.number = 115 ∧
      Surmount.ciClause47Item2ByteIdentityLine.number = 177 ∧
      Surmount.systemsClause63ByteIdentityLine.number = 481 := by
  native_decide

set_option maxHeartbeats 800000 in
set_option maxRecDepth 10000 in
theorem blocking_reading_not_claimed_true :
    blockingReading = some Surmount.ByteIdentityLiveReading.notClaimedTrue := by
  native_decide

theorem blocking_required_true : blockingRequired = true := by
  unfold blockingRequired
  rw [blocking_reading_not_claimed_true]
  rfl

theorem blocking_claimed_true_false : blockingClaimedTrue = false := by
  unfold blockingClaimedTrue
  rw [blocking_reading_not_claimed_true]
  rfl

theorem ci_flags_agree :
    Ci.byteIdentity.requiredForSystemsLeanSlakeProduct = true ∧
      Ci.byteIdentity.claimedTrue = false :=
  And.intro Ci.byte_identity_required Ci.byte_identity_not_claimed_true

theorem shrink_names :
    highestShrinkBlocking.highestTheorem = "mash_compcert_refines_claimed_done_is_false" ∧
      highestShrinkBlocking.highestFile = "lean/SystemsLeanProofs.lean" ∧
      highestShrinkBlocking.nextTheorem = "mash_self_host_from_c_satisfies_bootstrap_is_false" ∧
      highestShrinkBlocking.nextFile = "lean/SystemsLeanProofs.lean" := by
  native_decide

theorem shrink_indexes :
    highestShrinkBlocking.ciEncodedIndex0 = 114 ∧
      highestShrinkBlocking.ciEncodedIndex1 = 176 ∧
      highestShrinkBlocking.systemsLeanEncodedIndex = 480 :=
  And.intro rfl (And.intro rfl rfl)

set_option maxHeartbeats 800000 in
set_option maxRecDepth 10000 in
theorem shrink_reading :
    highestShrinkBlocking.liveReading = some Surmount.ByteIdentityLiveReading.notClaimedTrue := by
  native_decide

theorem shrink_required :
    highestShrinkBlocking.byteIdentityRequired = true :=
  blocking_required_true

theorem shrink_not_claimed_true :
    highestShrinkBlocking.byteIdentityClaimedTrue = false :=
  blocking_claimed_true_false

theorem highest_shrink_blocking_fact :
    highestShrinkBlocking.highestTheorem = "mash_compcert_refines_claimed_done_is_false" ∧
      highestShrinkBlocking.highestFile = "lean/SystemsLeanProofs.lean" ∧
      highestShrinkBlocking.nextTheorem = "mash_self_host_from_c_satisfies_bootstrap_is_false" ∧
      highestShrinkBlocking.nextFile = "lean/SystemsLeanProofs.lean" ∧
      highestShrinkBlocking.ciEncodedIndex0 = 114 ∧
      highestShrinkBlocking.ciEncodedIndex1 = 176 ∧
      highestShrinkBlocking.systemsLeanEncodedIndex = 480 ∧
      highestShrinkBlocking.liveReading = some Surmount.ByteIdentityLiveReading.notClaimedTrue ∧
      highestShrinkBlocking.byteIdentityRequired = true ∧
      highestShrinkBlocking.byteIdentityClaimedTrue = false :=
  And.intro shrink_names.1
    (And.intro shrink_names.2.1
      (And.intro shrink_names.2.2.1
        (And.intro shrink_names.2.2.2
          (And.intro shrink_indexes.1
            (And.intro shrink_indexes.2.1
              (And.intro shrink_indexes.2.2
                (And.intro shrink_reading
                  (And.intro shrink_required shrink_not_claimed_true))))))))

end InventoryRank
