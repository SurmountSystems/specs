/-
  Restatements of residual claims. Readers can find the falsifiable
  checks here. Proofs cite ResidualClaims. There is no program entry.
-/

import ResidualClaims

namespace ResidualClaimsTests

theorem compcert_verified_compilation_is_not_claimed_done :
    ResidualClaims.compCertVerifiedCompilationClaimedDone = false :=
  ResidualClaims.compcert_verified_compilation_is_not_claimed_done

theorem residual_compcert_matches_systems_lean :
    ResidualClaims.compCertVerifiedCompilationClaimedDone =
      SystemsLean.compCertVerifiedCompilationClaimedDone :=
  ResidualClaims.residual_compcert_matches_systems_lean

theorem slake_bootstrap_typecheck_is_not_claimed_done :
    ResidualClaims.slakeBootstrapTypecheckClaimedDone = false :=
  ResidualClaims.slake_bootstrap_typecheck_is_not_claimed_done

theorem residual_slake_bootstrap_matches_systems_lean :
    ResidualClaims.slakeBootstrapTypecheckClaimedDone =
      SystemsLean.slakeBootstrapTypecheckClaimedDone :=
  ResidualClaims.residual_slake_bootstrap_matches_systems_lean

theorem byte_identity_of_emit_is_not_claimed :
    ResidualClaims.byteIdentityOfEmitClaimed = false :=
  ResidualClaims.byte_identity_of_emit_is_not_claimed

theorem three_byte_identity_flags_are_one_claim :
    SystemsLean.byteIdentityOfEmitClaimedTrue =
        ResidualClaims.byteIdentityOfEmitClaimed ∧
      Ci.byteIdentity.claimedTrue =
        ResidualClaims.byteIdentityOfEmitClaimed ∧
      SpecRegistry.byteIdentityClaimedTrue =
        ResidualClaims.byteIdentityOfEmitClaimed :=
  ResidualClaims.three_byte_identity_flags_are_one_claim

theorem byte_identity_match_is_required_and_not_claimed_true :
    Ci.byteIdentity.requiredForSystemsLeanSlakeProduct = true ∧
      SystemsLean.byteIdentityRequiredForConformingProduct = true ∧
      Ci.byteIdentity.claimedTrue = false ∧
      SystemsLean.byteIdentityOfEmitClaimedTrue = false ∧
      SpecRegistry.byteIdentityClaimedTrue = false ∧
      Surmount.readLiveByteIdentity
        Surmount.ciClause310ByteIdentityLine
        Surmount.ciClause47Item2ByteIdentityLine
        Surmount.systemsClause63ByteIdentityLine =
        some Surmount.ByteIdentityLiveReading.notClaimedTrue ∧
      Ci.readLiveByteIdentityClaim
        Ci.clause310ByteIdentityLine
        Ci.clause47Item2ByteIdentityLine
        Ci.clause63ByteIdentityLine =
        some Ci.ByteIdentityClaimReading.notClaimedTrue :=
  ResidualClaims.byte_identity_match_is_required_and_not_claimed_true

theorem byte_identity_locks_are_not_catalog_rows :
    InconsistencyReport.claimInCatalog
        "read_live_byte_identity_is_not_claimed_true" = false ∧
      InconsistencyReport.claimInCatalog
        "read_live_byte_identity_claim_is_not_claimed_true" = false :=
  ResidualClaims.byte_identity_locks_are_not_catalog_rows

theorem conforming_anunnaki_encoder_is_not_claimed :
    ResidualClaims.conformingAnunnakiEncoderClaimed = false :=
  ResidualClaims.conforming_anunnaki_encoder_is_not_claimed

theorem residual_anunnaki_encoder_matches_spec :
    ResidualClaims.conformingAnunnakiEncoderClaimed =
      AnunnakiSpec.conformingEncoderClaimed :=
  ResidualClaims.residual_anunnaki_encoder_matches_spec

theorem conforming_session_bus_program_is_not_claimed :
    ResidualClaims.conformingSessionBusProgramClaimed = false :=
  ResidualClaims.conforming_session_bus_program_is_not_claimed

theorem residual_session_bus_program_matches_spec :
    ResidualClaims.conformingSessionBusProgramClaimed =
      SessionBusSpec.conformingSessionBusProgramClaimed :=
  ResidualClaims.residual_session_bus_program_matches_spec

theorem forbidden_basenames_are_exactly :
    ResidualClaims.forbiddenNumberedBasenames =
      ["0005_fargo.md", "0009_Unlicense.md", "0009_VOCABULARY.md",
        "0011_Unlicense.md", "0015_Anunnaki_Encoding.md"] :=
  ResidualClaims.forbidden_basenames_are_exactly

theorem forbidden_basename_count :
    ResidualClaims.forbiddenNumberedBasenames.length = 5 :=
  ResidualClaims.forbidden_basename_count

theorem forbidden_contains_0005_fargo_md :
    "0005_fargo.md" ∈ ResidualClaims.forbiddenNumberedBasenames :=
  ResidualClaims.forbidden_contains_0005_fargo_md

theorem forbidden_contains_0009_unlicense_md :
    "0009_Unlicense.md" ∈ ResidualClaims.forbiddenNumberedBasenames :=
  ResidualClaims.forbidden_contains_0009_unlicense_md

theorem forbidden_contains_0009_vocabulary_md :
    "0009_VOCABULARY.md" ∈ ResidualClaims.forbiddenNumberedBasenames :=
  ResidualClaims.forbidden_contains_0009_vocabulary_md

theorem forbidden_contains_0011_unlicense_md :
    "0011_Unlicense.md" ∈ ResidualClaims.forbiddenNumberedBasenames :=
  ResidualClaims.forbidden_contains_0011_unlicense_md

theorem forbidden_contains_0015_anunnaki_encoding_md :
    "0015_Anunnaki_Encoding.md" ∈ ResidualClaims.forbiddenNumberedBasenames :=
  ResidualClaims.forbidden_contains_0015_anunnaki_encoding_md

theorem fargo_has_no_assigned_spec_number :
    ResidualClaims.fargoAssignedSpecNumber = none :=
  ResidualClaims.fargo_has_no_assigned_spec_number

theorem carbonado_has_no_assigned_spec_number :
    ResidualClaims.carbonadoAssignedSpecNumber = none :=
  ResidualClaims.carbonado_has_no_assigned_spec_number

theorem carbonado_numbered_specification_must_not_exist :
    ResidualClaims.carbonadoNumberedSpecExists = false :=
  ResidualClaims.carbonado_numbered_specification_must_not_exist

theorem page_copy_is_one_4096_byte_page :
    ResidualClaims.pageCopyBytes = 4096 :=
  ResidualClaims.page_copy_is_one_4096_byte_page

theorem residual_page_copy_matches_page_cow :
    ResidualClaims.pageCopyBytes = SystemsLean.pageCowCopyBytes :=
  ResidualClaims.residual_page_copy_matches_page_cow

theorem residual_does_not_name_another_page_size :
    ResidualClaims.namesAnotherPageSize = false :=
  ResidualClaims.residual_does_not_name_another_page_size

theorem larger_hardware_page_is_not_a_second_copy :
    SystemsLean.pageCowLargerPageIsSecondCopy = false ∧
      ResidualClaims.pageCopyBytes = 4096 :=
  ResidualClaims.larger_hardware_page_is_not_a_second_copy

theorem specification_0014_does_not_publish_an_instruction_listing :
    ResidualClaims.anunnakiInstructionListingPublished = false :=
  ResidualClaims.specification_0014_does_not_publish_an_instruction_listing

theorem residual_instruction_listing_matches_anunnaki :
    ResidualClaims.anunnakiInstructionListingPublished =
      AnunnakiSpec.instructionListingPublished :=
  ResidualClaims.residual_instruction_listing_matches_anunnaki

theorem further_safec_level_names_are_not_specified :
    ResidualClaims.furtherSafeCLevelNamesSpecified = false :=
  ResidualClaims.further_safec_level_names_are_not_specified

theorem residual_further_safec_levels_match_systems_lean :
    ResidualClaims.furtherSafeCLevelNamesSpecified =
      SystemsLean.furtherSafeCLevelNamesSpecified :=
  ResidualClaims.residual_further_safec_levels_match_systems_lean

theorem fastc_block_syntax_is_not_specified :
    ResidualClaims.fastCBlockSyntaxSpecified = false :=
  ResidualClaims.fastc_block_syntax_is_not_specified

theorem residual_fastc_block_syntax_matches_systems_lean :
    ResidualClaims.fastCBlockSyntaxSpecified =
      SystemsLean.fastCBlockSyntaxSpecified :=
  ResidualClaims.residual_fastc_block_syntax_matches_systems_lean

theorem weight_formula_is_not_specified :
    ResidualClaims.weightFormulaSpecified = false :=
  ResidualClaims.weight_formula_is_not_specified

theorem quirk_list_is_not_specified :
    ResidualClaims.quirkListSpecified = false :=
  ResidualClaims.quirk_list_is_not_specified

theorem residual_quirk_list_matches_sssss :
    ResidualClaims.quirkListSpecified = Sssss.quirkListSpecified :=
  ResidualClaims.residual_quirk_list_matches_sssss

theorem decompiler_name_is_not_specified :
    ResidualClaims.decompilerNameSpecified = false :=
  ResidualClaims.decompiler_name_is_not_specified

theorem llvm_version_is_not_specified :
    ResidualClaims.llvmVersionSpecified = false :=
  ResidualClaims.llvm_version_is_not_specified

theorem residual_llvm_version_matches_systems_lean :
    ResidualClaims.llvmVersionSpecified = SystemsLean.llvmVersionInvented :=
  ResidualClaims.residual_llvm_version_matches_systems_lean

theorem lock_poisoning_proof_is_not_claimed :
    ResidualClaims.lockPoisoningProofClaimed = false :=
  ResidualClaims.lock_poisoning_proof_is_not_claimed

theorem lock_poisoning_waiter_effect_is_not_specified :
    ResidualClaims.lockPoisoningWaiterEffectSpecified = false :=
  ResidualClaims.lock_poisoning_waiter_effect_is_not_specified

theorem leak_island_contents_are_not_specified :
    ResidualClaims.leakIslandContentsSpecified = false :=
  ResidualClaims.leak_island_contents_are_not_specified

end ResidualClaimsTests
