/-
  Residual obligations from RESIDUAL.md that stay checkable if that
  markdown is not the only record. A later edit falsifies a claim by
  flipping a Bool or changing a Nat. This module does not define an
  inconsistency catalog and does not restate a living False theorem
  as a new catalog row.
-/

import InconsistencyReport

namespace ResidualClaims

/-- CompCert verified compilation is not claimed done. -/
def compCertVerifiedCompilationClaimedDone : Bool := false

theorem compcert_verified_compilation_is_not_claimed_done :
    compCertVerifiedCompilationClaimedDone = false := rfl

theorem residual_compcert_matches_systems_lean :
    compCertVerifiedCompilationClaimedDone =
      SystemsLean.compCertVerifiedCompilationClaimedDone := rfl

/-- The Slake bootstrap typecheck is not claimed done. -/
def slakeBootstrapTypecheckClaimedDone : Bool := false

theorem slake_bootstrap_typecheck_is_not_claimed_done :
    slakeBootstrapTypecheckClaimedDone = false := rfl

theorem residual_slake_bootstrap_matches_systems_lean :
    slakeBootstrapTypecheckClaimedDone =
      SystemsLean.slakeBootstrapTypecheckClaimedDone := rfl

/-- Byte identity of emit is not claimed. The three living flags are this one claim. -/
def byteIdentityOfEmitClaimed : Bool := false

theorem byte_identity_of_emit_is_not_claimed :
    byteIdentityOfEmitClaimed = false := rfl

theorem three_byte_identity_flags_are_one_claim :
    SystemsLean.byteIdentityOfEmitClaimedTrue = byteIdentityOfEmitClaimed ∧
      Ci.byteIdentity.claimedTrue = byteIdentityOfEmitClaimed ∧
      SpecRegistry.byteIdentityClaimedTrue = byteIdentityOfEmitClaimed :=
  ⟨rfl, rfl, rfl⟩

/--
  The byte identity match is still required and is not claimed true.
  The two sibling line locks read that fact. This is an obligation, not
  a False catalog row, and it does not add a second wrap of the retired
  denial.
-/
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
  ⟨rfl, rfl, rfl, rfl, rfl,
    Surmount.read_live_byte_identity_is_not_claimed_true,
    Ci.read_live_byte_identity_claim_is_not_claimed_true⟩

/-- The positive locks are not catalog rows. This module does not define a new catalog. -/
theorem byte_identity_locks_are_not_catalog_rows :
    InconsistencyReport.claimInCatalog
        "read_live_byte_identity_is_not_claimed_true" = false ∧
      InconsistencyReport.claimInCatalog
        "read_live_byte_identity_claim_is_not_claimed_true" = false := by
  native_decide

/-- A conforming Anunnaki encoder is not claimed. -/
def conformingAnunnakiEncoderClaimed : Bool := false

theorem conforming_anunnaki_encoder_is_not_claimed :
    conformingAnunnakiEncoderClaimed = false := rfl

theorem residual_anunnaki_encoder_matches_spec :
    conformingAnunnakiEncoderClaimed =
      AnunnakiSpec.conformingEncoderClaimed := rfl

/-- A conforming session bus program is not claimed. -/
def conformingSessionBusProgramClaimed : Bool := false

theorem conforming_session_bus_program_is_not_claimed :
    conformingSessionBusProgramClaimed = false := rfl

theorem residual_session_bus_program_matches_spec :
    conformingSessionBusProgramClaimed =
      SessionBusSpec.conformingSessionBusProgramClaimed := rfl

/-- Basenames this repository must not create. -/
def forbiddenNumberedBasenames : List String :=
  ["0005_fargo.md", "0009_Unlicense.md", "0009_VOCABULARY.md",
    "0011_Unlicense.md", "0015_Anunnaki_Encoding.md"]

theorem forbidden_basenames_are_exactly :
    forbiddenNumberedBasenames =
      ["0005_fargo.md", "0009_Unlicense.md", "0009_VOCABULARY.md",
        "0011_Unlicense.md", "0015_Anunnaki_Encoding.md"] := rfl

theorem forbidden_basename_count :
    forbiddenNumberedBasenames.length = 5 := rfl

theorem forbidden_contains_0005_fargo_md :
    "0005_fargo.md" ∈ forbiddenNumberedBasenames := by
  rw [forbidden_basenames_are_exactly]
  exact List.Mem.head _

theorem forbidden_contains_0009_unlicense_md :
    "0009_Unlicense.md" ∈ forbiddenNumberedBasenames := by
  rw [forbidden_basenames_are_exactly]
  exact List.Mem.tail _ (List.Mem.head _)

theorem forbidden_contains_0009_vocabulary_md :
    "0009_VOCABULARY.md" ∈ forbiddenNumberedBasenames := by
  rw [forbidden_basenames_are_exactly]
  exact List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _))

theorem forbidden_contains_0011_unlicense_md :
    "0011_Unlicense.md" ∈ forbiddenNumberedBasenames := by
  rw [forbidden_basenames_are_exactly]
  exact List.Mem.tail _ (List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _)))

theorem forbidden_contains_0015_anunnaki_encoding_md :
    "0015_Anunnaki_Encoding.md" ∈ forbiddenNumberedBasenames := by
  rw [forbidden_basenames_are_exactly]
  exact List.Mem.tail _
    (List.Mem.tail _ (List.Mem.tail _ (List.Mem.tail _ (List.Mem.head _))))

/-- fargo has no assigned specification number. -/
def fargoAssignedSpecNumber : Option Nat := none

theorem fargo_has_no_assigned_spec_number :
    fargoAssignedSpecNumber = none := rfl

/-- Carbonado has no assigned specification number. -/
def carbonadoAssignedSpecNumber : Option Nat := none

theorem carbonado_has_no_assigned_spec_number :
    carbonadoAssignedSpecNumber = none := rfl

/-- A Carbonado numbered specification must not exist. No number is assigned, so no basename is invented here. -/
def carbonadoNumberedSpecExists : Bool := false

theorem carbonado_numbered_specification_must_not_exist :
    carbonadoNumberedSpecExists = false := rfl

/-- The copy stays one page of 4096 bytes. -/
def pageCopyBytes : Nat := 4096

theorem page_copy_is_one_4096_byte_page :
    pageCopyBytes = 4096 := rfl

theorem residual_page_copy_matches_page_cow :
    pageCopyBytes = SystemsLean.pageCowCopyBytes := rfl

/-- This residual note does not name another page size. -/
def namesAnotherPageSize : Bool := false

theorem residual_does_not_name_another_page_size :
    namesAnotherPageSize = false := rfl

theorem larger_hardware_page_is_not_a_second_copy :
    SystemsLean.pageCowLargerPageIsSecondCopy = false ∧
      pageCopyBytes = 4096 :=
  ⟨rfl, rfl⟩

/-- Specification 0014 does not publish an instruction listing. No opcode names are stated here. -/
def anunnakiInstructionListingPublished : Bool := false

theorem specification_0014_does_not_publish_an_instruction_listing :
    anunnakiInstructionListingPublished = false := rfl

theorem residual_instruction_listing_matches_anunnaki :
    anunnakiInstructionListingPublished =
      AnunnakiSpec.instructionListingPublished := rfl

/-- Further SafeC level names besides FastSafeC stay unspecified. -/
def furtherSafeCLevelNamesSpecified : Bool := false

theorem further_safec_level_names_are_not_specified :
    furtherSafeCLevelNamesSpecified = false := rfl

theorem residual_further_safec_levels_match_systems_lean :
    furtherSafeCLevelNamesSpecified =
      SystemsLean.furtherSafeCLevelNamesSpecified := rfl

/-- FastC block syntax stays unspecified. This record does not invent that syntax. -/
def fastCBlockSyntaxSpecified : Bool := false

theorem fastc_block_syntax_is_not_specified :
    fastCBlockSyntaxSpecified = false := rfl

theorem residual_fastc_block_syntax_matches_systems_lean :
    fastCBlockSyntaxSpecified =
      SystemsLean.fastCBlockSyntaxSpecified := rfl

/-- The weight formula is not specified yet. No formula is stated here. -/
def weightFormulaSpecified : Bool := false

theorem weight_formula_is_not_specified :
    weightFormulaSpecified = false := rfl

/-- A quirk list is not specified yet. No quirk list is stated here. -/
def quirkListSpecified : Bool := false

theorem quirk_list_is_not_specified :
    quirkListSpecified = false := rfl

theorem residual_quirk_list_matches_sssss :
    quirkListSpecified = Sssss.quirkListSpecified := rfl

/-- The decompiler tool is not named yet. No decompiler name is stated here. -/
def decompilerNameSpecified : Bool := false

theorem decompiler_name_is_not_specified :
    decompilerNameSpecified = false := rfl

/-- An LLVM version number remains to be specified. No version is stated here. -/
def llvmVersionSpecified : Bool := false

theorem llvm_version_is_not_specified :
    llvmVersionSpecified = false := rfl

theorem residual_llvm_version_matches_systems_lean :
    llvmVersionSpecified = SystemsLean.llvmVersionInvented := rfl

/-- Lock poisoning is named, and the clause does not claim a poisoning proof. -/
def lockPoisoningProofClaimed : Bool := false

theorem lock_poisoning_proof_is_not_claimed :
    lockPoisoningProofClaimed = false := rfl

/-- What poisoning does to waiters remains to be specified. -/
def lockPoisoningWaiterEffectSpecified : Bool := false

theorem lock_poisoning_waiter_effect_is_not_specified :
    lockPoisoningWaiterEffectSpecified = false := rfl

/-- What a documented leak island contains remains to be specified. -/
def leakIslandContentsSpecified : Bool := false

theorem leak_island_contents_are_not_specified :
    leakIslandContentsSpecified = false := rfl

end ResidualClaims
