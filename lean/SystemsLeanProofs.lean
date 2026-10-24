/-
  PROOFS for numbered specification 0002 Systems Lean.

  This module is not the specification. It imports SystemsLeanSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import SystemsLeanSpec
import SpecRegistry

namespace SystemsLean

theorem Multiplicity.ofFin_toFin (m : Multiplicity) :
    Multiplicity.ofFin m.toFin = m := by
  cases m <;> rfl

theorem Multiplicity.toFin_ofFin (i : Fin 3) :
    (Multiplicity.ofFin i).toFin = i := by
  match i with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl

/-- Closed list used by tests. `toFin` is the real fourth constructor guard. -/
theorem multiplicity_all_three : Multiplicity.all.length = 3 := rfl

/-- Every multiplicity is one of the three constructors in Clause 4.1 item 1. -/
theorem multiplicity_cases (m : Multiplicity) :
    m = .erased ∨ m = .once ∨ m = .unrestricted := by
  cases m with
  | erased => exact Or.inl rfl
  | once => exact Or.inr (Or.inl rfl)
  | unrestricted => exact Or.inr (Or.inr rfl)

/-- Clause 3.5: multiplicity 1 is linear or affine, not a third discipline. -/
theorem once_is_linear_or_affine :
    Multiplicity.onceDisciplines.length = 2 := rfl

theorem resource_tag_is_one_of_three_multiplicities (t : ResourceTag) :
    t.multiplicity = .erased ∨ t.multiplicity = .once ∨
      t.multiplicity = .unrestricted := by
  cases t with
  | erased => exact Or.inl rfl
  | linear => exact Or.inr (Or.inl rfl)
  | affine => exact Or.inr (Or.inl rfl)
  | unrestricted => exact Or.inr (Or.inr rfl)

theorem linear_is_multiplicity_one :
    ResourceTag.linear.multiplicity = .once := rfl

theorem affine_is_multiplicity_one :
    ResourceTag.affine.multiplicity = .once := rfl

theorem once_discipline_is_multiplicity_one (d : OnceDiscipline) :
    d.toResourceTag.multiplicity = .once := by
  cases d <;> rfl

theorem erased_zero_uses_ok : ResourceTag.erased.usesOk 0 = true := by decide

theorem erased_one_use_not_ok : ResourceTag.erased.usesOk 1 = false := by decide

theorem linear_one_use_ok : ResourceTag.linear.usesOk 1 = true := by decide

theorem linear_zero_uses_not_ok : ResourceTag.linear.usesOk 0 = false := by
  decide

theorem linear_two_uses_not_ok : ResourceTag.linear.usesOk 2 = false := by
  decide

theorem affine_zero_uses_ok : ResourceTag.affine.usesOk 0 = true := by decide

theorem affine_one_use_ok : ResourceTag.affine.usesOk 1 = true := by decide

theorem affine_two_uses_not_ok : ResourceTag.affine.usesOk 2 = false := by
  decide

theorem unrestricted_zero_uses_ok :
    ResourceTag.unrestricted.usesOk 0 = true := by decide

theorem unrestricted_two_uses_ok :
    ResourceTag.unrestricted.usesOk 2 = true := by decide

theorem unrestricted_any_uses (n : Nat) :
    ResourceTag.unrestricted.usesOk n = true := rfl

theorem erased_ok_iff_zero (n : Nat) :
    ResourceTag.erased.usesOk n = true ↔ n = 0 := by
  unfold ResourceTag.usesOk
  exact decide_eq_true_iff

theorem linear_ok_iff_one (n : Nat) :
    ResourceTag.linear.usesOk n = true ↔ n = 1 := by
  unfold ResourceTag.usesOk
  exact decide_eq_true_iff

theorem affine_ok_iff_at_most_one (n : Nat) :
    ResourceTag.affine.usesOk n = true ↔ n = 0 ∨ n = 1 := by
  unfold ResourceTag.usesOk
  exact decide_eq_true_iff

theorem multiplicity_zero_not_on_wire :
    Multiplicity.appearsInFreestandingProduct .erased = false := rfl

theorem multiplicity_once_may_be_on_wire :
    Multiplicity.appearsInFreestandingProduct .once = true := rfl

theorem multiplicity_omega_may_be_on_wire :
    Multiplicity.appearsInFreestandingProduct .unrestricted = true := rfl

theorem primary_emission_is_freestanding_c :
    EmissionTarget.primary = .freestandingC := rfl

/--
  Clause 4.2 item 3: LLVM IR is optional later. Conformance does not
  require it (Clause 5 last paragraph).
-/
theorem llvm_ir_not_required :
    llvmIrRequiredForConformance = false := rfl

theorem clean_wire_ok : cleanWire.ok = true := by decide

theorem gc_on_wire_not_ok : gcWire.ok = false := by decide

theorem managed_runtime_on_wire_not_ok : managedRuntimeWire.ok = false := by
  decide

theorem erased_multiplicity_on_wire_not_ok : erasedOnWire.ok = false := by
  decide

theorem slake_must_be_systems_lean :
    slakeCanonical.conforming = true := by decide

theorem slake_not_other_language :
    slakeOtherLanguage.conforming = false := by decide

theorem slake_with_optional_llvm_still_conforming :
    slakeWithLlvm.conforming = true := by decide

theorem slake_primary_llvm_not_conforming :
    slakePrimaryLlvm.conforming = false := by decide

theorem llvm_path_ignored_by_slake_conforming (s : SlakeProduct) :
    ({ s with llvmPathPresent := !s.llvmPathPresent } : SlakeProduct).conforming =
      s.conforming := rfl

theorem residual_ok_when_freestanding :
    residualHonesty true none = true := by decide

theorem residual_fails_when_silent :
    residualHonesty false none = false := by decide

theorem residual_ok_when_named :
    residualHonesty false (some "managed Lean runtime leftover") = true := by
  decide

theorem residual_empty_name_not_honest :
    residualHonesty false (some "") = false := by decide

/--
  Clause 5 item 2: freestanding wire well formed, or residual honesty
  when the wire is not fully freestanding.
-/
theorem clean_wire_needs_no_residual :
    wireOrResidualHonesty cleanWire none = true := by decide

theorem gc_wire_silent_fails_clause5_item2 :
    wireOrResidualHonesty gcWire none = false := by decide

/-- Garbage collection on the wire is not a well formed freestanding wire,
    but a named residual still satisfies Clause 5 item 2. -/
theorem gc_wire_named_residual_satisfies_clause5_item2 :
    gcWire.ok = false ∧
      wireOrResidualHonesty gcWire (some "garbage collection") = true := by
  decide

theorem managed_runtime_named_residual_satisfies_clause5_item2 :
    managedRuntimeWire.ok = false ∧
      wireOrResidualHonesty managedRuntimeWire (some "managed Lean runtime") =
        true := by
  decide

theorem erased_on_wire_named_residual_satisfies_clause5_item2 :
    erasedOnWire.ok = false ∧
      wireOrResidualHonesty erasedOnWire (some "erased multiplicity leaked") =
        true := by
  decide

theorem product_ref_layout_canonical_ok :
    productRefLayoutCanonical.ok = true := by decide

theorem product_ref_layout_wrong_idris_not_ok :
    productRefLayoutWrongIdris.ok = false := by decide

/-- This specifications repository does not pin these trees under its own ref/. -/
theorem specs_repo_does_not_pin_lean4 : specsRepoPinsLean4 = false := rfl

theorem specs_repo_does_not_pin_idris2 : specsRepoPinsIdris2 = false := rfl

theorem specs_repo_does_not_pin_compcert : specsRepoPinsCompCert = false := rfl

theorem specs_repo_does_not_pin_rust : specsRepoPinsRust = false := rfl

theorem compcert_performed_ok : compCertPerformed.ok = true := by decide

theorem compcert_missing_not_ok : compCertMissing.ok = false := by decide

theorem bootstrap_typecheck_done_ok :
    bootstrapTypecheckDone.ok = true := by decide

theorem bootstrap_missing_not_ok :
    bootstrapMissing.ok = false := by decide

theorem bootstrap_subset_not_ok :
    bootstrapSubsetOnly.ok = false := by decide

theorem typecheck_without_bootstrap_not_ok :
    typecheckWithoutBootstrap.ok = false := by decide

theorem NovelLanguage.ofFin_toFin (l : NovelLanguage) :
    NovelLanguage.ofFin l.toFin = l := by
  cases l <;> rfl

theorem novel_language_card_three :
    ( [NovelLanguage.idris2, .lean4IncludingSystemsLean, .pureNix] : List NovelLanguage
    ).length = 3 := rfl

/-- Shell is modeled as a distinct forbidden path, not a fourth novel language. -/
theorem shell_forbidden_for_novel_paths :
    ProductPath.permitted .freeFloatingShell = false := rfl

theorem idris_permitted :
    ProductPath.permitted (.novel .idris2) = true := rfl

theorem lean_including_systems_lean_permitted :
    ProductPath.permitted (.novel .lean4IncludingSystemsLean) = true := rfl

theorem pure_nix_permitted :
    ProductPath.permitted (.novel .pureNix) = true := rfl

theorem shell_in_path_list_not_permitted :
    allPathsPermitted [.freeFloatingShell] = false := by decide

theorem three_novel_languages_permitted :
    allPathsPermitted
      [.novel .idris2, .novel .lean4IncludingSystemsLean, .novel .pureNix] =
      true := by
  decide

theorem novel_is_unlicense : hygiene .novel = .unlicense := rfl

theorem upstream_keeps_original : hygiene .upstream = .originalUpstream := rfl

/-- What a product tree actually did with licenses and `ref/` layout. -/
theorem hygiene_ok_matches_required_mapping :
    hygieneOk.novelLicense = hygiene .novel ∧
      hygieneOk.upstreamLicense = hygiene .upstream := by
  constructor <;> rfl

theorem hygiene_ok_holds : hygieneOk.ok = true := by decide

theorem hygiene_novel_must_be_unlicense :
    hygieneNovelNotUnlicense.ok = false := by decide

theorem hygiene_upstream_must_keep_original :
    hygieneUpstreamRelicensed.ok = false := by decide

theorem hygiene_upstream_must_live_under_ref :
    hygieneUpstreamNotUnderRef.ok = false := by decide

theorem named_claim_ok_when_targeting (c : StackComponent) :
    (namedStackClaim c true).ok = true := by
  cases c <;> decide

theorem named_claim_fails_when_cannot_target (c : StackComponent) :
    (namedStackClaim c false).ok = false := by
  cases c <;> decide

theorem no_clause44_claim_need_not_target :
    ({ component := .beastdbCore
       claimsClause44 := false
       canTargetSlake := false } : NamedComponentClaim).ok = true := by
  decide

theorem all_named_stack_targeting_ok :
    allStackClaimsOk allNamedStackTargeting = true := by decide

theorem beastdb_cannot_target_fails_clause5_item5 :
    allStackClaimsOk beastdbCannotTarget = false := by decide

theorem canonical_product_conforms :
    canonicalProduct.conforms = true := by decide

theorem clause5_gc_silent_does_not_conform :
    productGcSilent.conforms = false := by decide

theorem clause5_gc_named_residual_conforms :
    gcWire.ok = false ∧ productGcNamed.conforms = true := by decide

theorem clause5_linear_used_twice_does_not_conform :
    productLinearUsedTwice.conforms = false := by decide

theorem clause5_erased_used_once_does_not_conform :
    productErasedUsedOnce.conforms = false := by decide

theorem clause5_affine_used_twice_does_not_conform :
    productAffineUsedTwice.conforms = false := by decide

theorem clause5_shell_path_does_not_conform :
    productShellPath.conforms = false := by decide

theorem clause5_bad_hygiene_does_not_conform :
    productBadHygiene.conforms = false := by decide

theorem clause5_cannot_target_slake_does_not_conform :
    productCannotTargetSlake.conforms = false := by decide

theorem clause5_other_language_does_not_conform :
    productOtherLanguage.conforms = false := by decide

theorem clause5_optional_llvm_still_conforms :
    productWithOptionalLlvm.conforms = true := by decide

theorem clause5_primary_llvm_does_not_conform :
    productPrimaryLlvm.conforms = false := by decide

theorem llvm_ir_not_a_conformance_conjunct :
    llvmIrRequiredForConformance = false ∧
      productWithOptionalLlvm.conforms = canonicalProduct.conforms := by
  decide

theorem clause5_missing_compcert_does_not_conform :
    productMissingCompCert.conforms = false := by decide

theorem clause5_missing_bootstrap_typecheck_does_not_conform :
    productMissingBootstrapTypecheck.conforms = false := by decide

theorem clause5_subset_typecheck_does_not_conform :
    productSubsetTypecheck.conforms = false := by decide

theorem clause5_typecheck_without_bootstrap_does_not_conform :
    productTypecheckWithoutBootstrap.conforms = false := by decide

theorem clause5_wrong_product_ref_layout_does_not_conform :
    productWrongRefLayout.conforms = false := by decide

theorem clause5_named_residual_does_not_excuse_missing_compcert :
    productNamedResidualMissingCompCert.item2 = true ∧
      productNamedResidualMissingCompCert.item6 = false ∧
      productNamedResidualMissingCompCert.conforms = false := by
  decide

theorem clause5_named_residual_does_not_excuse_missing_bootstrap :
    productNamedResidualMissingBootstrap.item2 = true ∧
      productNamedResidualMissingBootstrap.item7 = false ∧
      productNamedResidualMissingBootstrap.conforms = false := by
  decide

theorem systems_lean_is_spec_0002 : systemsLeanSpecNumber = 2 := rfl

theorem ssss_is_not_spec_0002 : ssssSpecNumber ≠ systemsLeanSpecNumber := by
  decide

theorem ssss_is_not_spec_0003 : ssssSpecNumber ≠ 3 := by decide

theorem ssss_is_0004 : ssssSpecNumber = 4 := rfl

theorem beastdb_is_spec_0003 : beastdbSpecNumber = 3 := rfl

theorem beastdb_specified_in_0003_beastdb :
    beastdbSpecFileName = "0003_beastdb.md" := rfl

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem tests_without_model_does_not_conform :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

theorem required_compcert_tool_is_ccomp :
    requiredCompCertTool = "ccomp" := rfl

theorem compcert_uses_ccomp : compCertUsesCcomp = true := rfl

theorem compcert_performed_uses_ccomp_of_freestanding_c :
    compCertPerformed.usesCcompOfFreestandingC = true := by decide

theorem compcert_wrong_tool_not_ok : compCertWrongTool.ok = false := by decide

theorem compcert_wrong_emit_not_ok : compCertWrongEmit.ok = false := by decide

theorem compcert_verified_compilation_not_claimed_done :
    compCertVerifiedCompilationClaimedDone = false := rfl

theorem bootstrap_typecheck_includes_theorems :
    bootstrapTypecheckIncludesTheorems = true := rfl

theorem bootstrap_done_includes_theorems :
    bootstrapTypecheckDone.includesTheorems = true := rfl

theorem bootstrap_without_theorems_not_ok :
    bootstrapWithoutTheorems.ok = false := by decide

theorem slake_bootstrap_typecheck_not_claimed_done :
    slakeBootstrapTypecheckClaimedDone = false := rfl

theorem mash_compcert_verified_compilation_claimed_done_is_false :
    mashCompCertVerifiedCompilationClaimedDoneIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_slake_bootstrap_typecheck_claimed_done_is_false :
    mashSlakeBootstrapTypecheckClaimedDoneIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_compcert_tso_satisfies_clause42_item6_is_false :
    mashCompCertTsoSatisfiesClause42Item6IsFalse := by
  intro h
  exact Bool.noConfusion h

theorem compcert_refines_not_claimed_done :
    compCertRefinesClaimedDone = false := rfl

theorem mash_compcert_refines_claimed_done_is_false :
    mashCompCertRefinesClaimedDoneIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem self_host_from_generated_c_does_not_satisfy_typecheck :
    selfHostFromGeneratedCSatisfiesTypecheck = false := rfl

theorem mash_self_host_from_c_satisfies_bootstrap_is_false :
    mashSelfHostFromCSatisfiesBootstrapIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem clause5_wrong_compcert_tool_does_not_conform :
    productWrongCompCertTool.conforms = false := by decide

theorem clause5_wrong_compcert_emit_does_not_conform :
    productWrongCompCertEmit.conforms = false := by decide

theorem clause5_bootstrap_without_theorems_does_not_conform :
    productBootstrapWithoutTheorems.conforms = false := by decide

theorem rsi_is_spec_0006 : rsiSpecNumber = 6 := rfl

theorem rsi_is_not_a_compiler_requirement :
    rsiIsCompilerRequirement = false := rfl

theorem lean_machine_is_spec_0013 : leanMachineSpecNumber = 13 := rfl

theorem lean_machine_specified_in_0013_lean_machine :
    leanMachineSpecFileName = "0013_Lean_Machine.md" := rfl

theorem compcert_is_not_unlicense : compCertIsUnlicense = false := rfl

theorem spec_check_is_not_meaning_spec_encoding :
    specCheckIsMeaningSpecEncoding = false := rfl

theorem byte_identity_required_for_conforming_product :
    byteIdentityRequiredForConformingProduct = true := rfl

theorem byte_identity_of_emit_not_claimed_true :
    byteIdentityOfEmitClaimedTrue = false := rfl

theorem systems_lean_and_slake_not_ready_for_use :
    systemsLeanAndSlakeReadyForUse = false := rfl

theorem systems_lean_and_slake_did_start :
    systemsLeanAndSlakeNeverStarted = false := rfl

theorem skill_packs_not_under_product_ref :
    skillPacksUnderProductRef = false := rfl

theorem pure_nix_required_for_novel_packaging :
    pureNixRequiredForNovelPackaging = true := rfl

theorem live_claimed_done_must_not_equal_canonical_fixture :
    liveClaimedDoneEqualsCanonicalFixture = false := by decide

theorem live_claimed_done_differs_from_canonical_compcert :
    compCertVerifiedCompilationClaimedDone ≠ canonicalProduct.compCert.ok := by
  decide

theorem live_claimed_done_differs_from_canonical_bootstrap :
    slakeBootstrapTypecheckClaimedDone ≠ canonicalProduct.bootstrapTypecheck.ok := by
  decide

theorem SafeCompCert_implies_SafeKernel (c : SafeCompCert) :
    safeCompCertImpliesSafeKernel c = SafeKernel.holds :=
  rfl

theorem mash_safe_kernel_implies_safe_compcert_is_false :
    mashSafeKernelImpliesSafeCompCertIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_unique_block_copy_handle_no_protocol_is_false :
    mashUniqueBlockCopyHandleNoProtocolIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_secret_object_cow_is_false :
    mashSecretObjectCowIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_secret_page_cow_is_false :
    mashSecretPageCowIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_compcert_fragment_container_of_is_false :
    mashCompCertFragmentContainerOfIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_panic_free_reachable_unwrap_is_false :
    mashPanicFreeReachableUnwrapIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_compcert_fragment_inline_asm_is_false :
    mashCompCertFragmentInlineAsmIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_link_face_exports_unique_block_as_bits_is_false :
    mashLinkFaceExportsUniqueBlockAsBitsIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_language_omega_on_heap_owner_is_false :
    mashLanguageOmegaOnHeapOwnerIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_unique_only_posix_fork_is_false :
    mashUniqueOnlyPosixForkIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_safe_mem_non_atomic_data_race_is_false :
    mashSafeMemNonAtomicDataRaceIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_lock_free_free_without_reclamation_is_false :
    mashLockFreeFreeWithoutReclamationIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_rw_lock_shared_and_exclusive_is_false :
    mashRwLockSharedAndExclusiveIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_copy_handle_lock_token_is_false :
    mashCopyHandleLockTokenIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_cas_unique_block_pointer_is_false :
    mashCasUniqueBlockPointerIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_cas_non_atomic_cell_is_false :
    mashCasNonAtomicCellIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_thread_shared_is_process_shared_is_false :
    mashThreadSharedIsProcessSharedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_posix_fork_is_fork_join_is_false :
    mashPosixForkIsForkJoinIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_posix_fork_is_borrow_or_owned_is_false :
    mashPosixForkIsBorrowOrOwnedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_secret_copy_into_non_secret_is_false :
    mashSecretCopyIntoNonSecretIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_secret_dont_fork_posix_fork_is_false :
    mashSecretDontForkPosixForkIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_once_implies_unique_block_is_false :
    mashOnceImpliesUniqueBlockIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_syscall_durability_is_beastdb_acid_is_false :
    mashSyscallDurabilityIsBeastdbAcidIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_beastdb_props_cons_without_attach_is_false :
    mashBeastdbPropsConsWithoutAttachIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_tsx_is_beastdb_acid_is_false :
    mashTsxIsBeastdbAcidIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_grok_oss_is_safe_c_is_false :
    mashGrokOssIsSafeCIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_page_cache_is_rcu_is_false :
    mashPageCacheIsRcuIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_gate_a_crate_is_safe_is_false :
    mashGateACrateIsSafeIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_hardware_tag_replaces_unique_block_is_false :
    mashHardwareTagReplacesUniqueBlockIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_autovectorization_is_simd_proof_is_false :
    mashAutovectorizationIsSimdProofIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_perfect_theorem_name_is_false :
    mashPerfectTheoremNameIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem typer_sound_named : typerSoundNamed = true := rfl

/-- Companion fragment only. Product `typer` is not done. -/
theorem typer_sound_implication_proved :
    typerSoundImplicationProved = true := rfl

/--
  Clause 3.22 companion `TyperSound` on `TyperFragment`.
  Accepted programs Step `ok`. Rejected programs do not satisfy the premise.
  Product `typer` is not done. Systems Lean remains not ready for use.
-/
theorem typer_sound_implication : typerSoundImplication := by
  intro p hAcc
  cases p with
  | copyBitsOfBits =>
    intro hFault
    nomatch hFault
  | uniqueBlockMoveOwner =>
    intro hFault
    nomatch hFault
  | uniqueBlockCopyHandleNoProtocol =>
    exact Bool.noConfusion hAcc
  | heapOmegaAsOwner =>
    exact Bool.noConfusion hAcc

theorem typer_accepts_copy_bits_of_bits :
    typerAccepts .copyBitsOfBits = true := rfl

theorem typer_accepts_unique_block_move_owner :
    typerAccepts .uniqueBlockMoveOwner = true := rfl

theorem typer_rejects_unique_block_copy_handle_no_protocol :
    typerAccepts .uniqueBlockCopyHandleNoProtocol = false := rfl

theorem typer_rejects_heap_omega_as_owner_fragment :
    typerAccepts .heapOmegaAsOwner = false := rfl

theorem typer_step_copy_bits_of_bits_ok :
    typerStep .copyBitsOfBits = StepState.ok := rfl

theorem typer_step_unique_block_move_owner_ok :
    typerStep .uniqueBlockMoveOwner = StepState.ok := rfl

theorem typer_step_copy_handle_no_protocol_would_fault :
    typerStep .uniqueBlockCopyHandleNoProtocol = StepState.fault := rfl

theorem typer_step_heap_omega_as_owner_would_fault :
    typerStep .heapOmegaAsOwner = StepState.fault := rfl

/-- At least one accepted program and at least one rejected program. -/
theorem typer_sound_implication_not_vacuous :
    (∃ p, typerAccepts p = true ∧ typerStep p ≠ StepState.fault) ∧
      ∃ p, typerAccepts p = false :=
  ⟨⟨.copyBitsOfBits, rfl, fun h => nomatch h⟩,
    ⟨.uniqueBlockCopyHandleNoProtocol, rfl⟩⟩

theorem panic_free_named : panicFreeNamed = true := rfl

theorem panic_free_aot_named : panicFreeAotNamed = true := rfl

theorem panic_free_aot_implication_proved :
    panicFreeAotImplicationProved = true := rfl

/--
  Companion fragment: if PanicFree holds, execution does not panic.
  The product AOT path is not done.
-/
theorem panic_free_aot_implication : panicFreeAotImplication := by
  intro p h
  cases p with
  | typedPathNoPanic =>
    intro contra
    cases contra
  | reachableUnwrap =>
    cases h
  | allocationFailure =>
    intro contra
    cases contra
  | hardwareFault =>
    intro contra
    cases contra

theorem panic_free_holds_typed_path_no_panic :
    panicFreeHolds .typedPathNoPanic = true := rfl

theorem panic_free_exec_typed_path_no_panic_not_panic :
    panicFreeExec .typedPathNoPanic ≠ PanicOutcome.panic := by
  intro h
  cases h

theorem panic_free_does_not_hold_reachable_unwrap :
    panicFreeHolds .reachableUnwrap = false := rfl

theorem panic_free_exec_reachable_unwrap_is_panic :
    panicFreeExec .reachableUnwrap = PanicOutcome.panic := rfl

theorem panic_free_holds_allocation_failure :
    panicFreeHolds .allocationFailure = true := rfl

theorem panic_free_exec_allocation_failure_not_panic :
    panicFreeExec .allocationFailure ≠ PanicOutcome.panic := by
  intro h
  cases h

theorem panic_free_holds_hardware_fault :
    panicFreeHolds .hardwareFault = true := rfl

theorem panic_free_exec_hardware_fault_not_panic :
    panicFreeExec .hardwareFault ≠ PanicOutcome.panic := by
  intro h
  cases h

/-- At least one holding program and at least one program that is not PanicFree. -/
theorem panic_free_aot_implication_not_vacuous :
    (∃ p, panicFreeHolds p = true ∧ panicFreeExec p ≠ PanicOutcome.panic) ∧
      ∃ p, panicFreeHolds p = false :=
  ⟨⟨.typedPathNoPanic, rfl, fun h => nomatch h⟩, ⟨.reachableUnwrap, rfl⟩⟩

theorem panic_free_does_not_follow_from_safe_mem :
    panicFreeImpliesSafeMem = false := rfl

theorem unique_block_has_no_default_rc_header :
    uniqueBlockDefaultRcHeader = false := rfl

theorem heap_omega_as_owner_rejected :
    heapOmegaAsOwnerRejected = true := rfl

theorem heap_omega_reject_not_collapsed_into_bits_trivial :
    heapOmegaRejectCollapsedIntoBitsTrivial = false := rfl

theorem fargo_has_no_spec_number :
    fargoHasSpecNumber = false := rfl

theorem llvm_cc_path_not_called_compcert_proved :
    llvmCcPathCalledCompCertProved = false := rfl

theorem slake_primary_emit_is_freestanding_c :
    slakePrimaryEmitIsFreestandingC = true := rfl

theorem hosted_linux_libc_does_not_replace_primary_emit :
    hostedLinuxLibcReplacesPrimaryEmit = false := rfl

theorem safe_ct_off_by_default :
    safeCtOnByDefault = false := rfl

theorem lock_free_is_not_mutex_absent :
    lockFreeMeansMutexAbsent = false := rfl

theorem lock_free_is_not_compare_and_swap :
    lockFreeMeansCompareAndSwap = false := rfl

theorem acid_is_not_compare_and_swap :
    acidIsCompareAndSwap = false := rfl

theorem beastdb_acid_owned_by_spec_0003 :
    beastdbAcidOwnedBySpec0003 = true := rfl

theorem posix_fork_is_page_cow :
    posixForkIsPageCow = true := rfl

theorem page_cow_copy_bytes :
    pageCowCopyBytes = 4096 := rfl

theorem page_cow_copy_is_ordinary_4kb_page :
    pageCowCopyBytes = 4 * 1024 ∧
      pageCowCopyBytes = 4096 ∧
      pageCowCopyBytes ≠ 1024 ∧
      pageCowCopyBytes ≠ 4 * 1000 := by
  decide

theorem page_cow_copy_lines_up_with_4kb_sector :
    pageCowSectorBytes = pageCowCopyBytes ∧
      pageCowSectorBytes = 4096 ∧
      pageCowSectorBytes ≠ 512 := by
  decide

theorem page_cow_larger_hardware_page_for_one_client :
    pageCowCopyBytes = 4096 ∧
      pageCowLargerHardwarePageAllowed = true ∧
      pageCowLargerPageIsSecondCopy = false := by
  decide

theorem posix_fork_is_not_object_cow :
    posixForkIsObjectCow = false := rfl

theorem correspondence_required_before_isomorphism :
    correspondenceRequiredBeforeIsomorphism = true := rfl

theorem passing_mode_roundtrip (m : PassingMode) :
    PassingMode.ofFin (PassingMode.toFin m) = m := by
  cases m <;> rfl

theorem mash_typed_link_input_claimed_proved_is_false :
    mashTypedLinkInputClaimedProvedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_cons_on_every_export_claimed_proved_is_false :
    mashConsOnEveryExportClaimedProvedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_memcpy_equation_present_theorem_is_false :
    mashMemcpyEquationPresentTheoremIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_named_residual_identifiers_present_theories_is_false :
    mashNamedResidualIdentifiersPresentTheoriesIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem fargo_gate_roundtrip (g : FargoGate) :
    FargoGate.ofFin (FargoGate.toFin g) = g := by
  cases g <;> rfl

theorem correspondence_maps_are_statements :
    correspondenceMapsAreStatements = true := rfl

theorem corresponds_is_named :
    correspondsNamed = true := rfl

theorem to_safe_c_on_sample_is_none :
    toSafeC RustJudgment.sample = none := rfl

theorem to_rust_on_sample_is_none :
    toRust SafeCJudgment.sample = none := rfl

theorem mash_isomorphism_theorem_name_is_false :
    mashIsomorphismTheoremNameIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_pin_survives_posix_fork_is_false :
    mashPinSurvivesPosixForkIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_glibc_malloc_untyped_unique_block_is_false :
    mashGlibcMallocUntypedUniqueBlockIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_mutex_free_file_is_lock_free_is_false :
    mashMutexFreeFileIsLockFreeIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem ub_class_product_table_not_complete :
    ubClassProductTableComplete = false := rfl

theorem safe_c_lake_package_not_shipped_here :
    safeCLakePackageShippedInThisRepo = false := rfl

theorem number_0015_unassigned :
    number0015Assigned = false := rfl

theorem mash_safe_c_is_own_published_spec_number_is_false :
    mashSafeCIsOwnPublishedSpecNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem safe_c_is_not_own_published_spec_number :
    safeCIsOwnPublishedSpecNumber = false := rfl

theorem creates_numbered_safe_c_file :
    createsNumberedSafeCFile = false := rfl

theorem safe_c_has_no_spec_number_and_no_numbered_file :
    safeCIsOwnPublishedSpecNumber = false ∧
      number0015Assigned = false ∧
      createsNumberedSafeCFile = false :=
  ⟨rfl, rfl, rfl⟩

theorem safe_c_carried_by_systems_lean :
    safeCCarriedBySystemsLean = true := rfl

theorem mash_holy_lean_safec_lean_machine_is_false :
    mashHolyLeanSafeCLeanMachineIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem ref_pin_freezes_external_text :
    refPinFreezesExternalText = true := rfl

theorem emit_standard_is_freestanding_iso_c :
    emitStandardIsFreestandingIsoC = true := rfl

theorem iso_c_pin_file_absent_because_license_forbids :
    isoCPinFileAbsentLicenseForbids = true ∧
      isoCCatalogNumber = 82075 ∧
      isoCEdition = 5 := by
  decide

theorem one_client_not_ten_thousand_or_ten_million :
    oneClientInScope = true ∧
      tenThousandConcurrentClientsInScope = false ∧
      tenMillionConcurrentClientsInScope = false ∧
      oneClientAimMet = false := by
  decide

theorem memory_models_and_llvm_ir :
    linuxKernelMemoryModelRequired = true ∧
      cMemoryModelRequired = true ∧
      cxxMemoryModelRequired = true ∧
      llvmIrMemoryAndVtableCompatible = true ∧
      systemsLeanFirstClassOnThatIr = true ∧
      llvmVersionInvented = false ∧
      runningKernelVerified = false := by
  decide

/--
  When the memory layout of updated system code and of programs in flight
  stays consistent, a restart is not required. This is not a claim that a
  running kernel was verified.
-/
theorem live_update_consistent_layout_needs_no_restart (u : LiveUpdateLayout)
    (h : liveUpdateLayoutsConsistent u = true) :
    restartRequired u = false := by
  unfold restartRequired
  rw [h]
  decide

theorem iris_lean_not_required :
    irisLeanRequired = false := rfl

theorem typer_match_target_is_document_step :
    typerMatchTarget = typerStep := rfl

/-- Fragment case from `typer_sound_implication`. The product typer may still lag. -/
theorem typer_match_target_fragment (p : TyperFragment)
    (h : typerAccepts p = true) :
    typerMatchTarget p ≠ StepState.fault :=
  typer_sound_implication p h

/-- Silence leaves SafeCt off. The channels do not depend on Secret. Constant time failure is not that switch. -/
theorem safe_ct_channels_do_not_carry_secret :
    safeCtOnByDefault = false ∧
      safeCtTimingCarriesSecret = false ∧
      safeCtCacheCarriesSecret = false ∧
      safeCtPageFaultCarriesSecret = false ∧
      safeCtChannelsDependOnSecret = false ∧
      notConstantTimeIsSafeCtSwitch = false := by
  decide

theorem canonical_public_github_org_out_of_scope :
    canonicalPublicGitHubOrgInScope = false := rfl

theorem safec_depth_consistent :
    refPinFreezesExternalText = true ∧
      emitStandardIsFreestandingIsoC = true ∧
      isoCPinFileAbsentLicenseForbids = true ∧
      oneClientInScope = true ∧
      tenThousandConcurrentClientsInScope = false ∧
      tenMillionConcurrentClientsInScope = false ∧
      oneClientAimMet = false ∧
      linuxKernelMemoryModelRequired = true ∧
      cMemoryModelRequired = true ∧
      cxxMemoryModelRequired = true ∧
      llvmIrMemoryAndVtableCompatible = true ∧
      systemsLeanFirstClassOnThatIr = true ∧
      llvmVersionInvented = false ∧
      runningKernelVerified = false ∧
      irisLeanRequired = false ∧
      canonicalPublicGitHubOrgInScope = false ∧
      safeCtTimingCarriesSecret = false ∧
      safeCtCacheCarriesSecret = false ∧
      safeCtPageFaultCarriesSecret = false ∧
      safeCtChannelsDependOnSecret = false ∧
      notConstantTimeIsSafeCtSwitch = false ∧
      pageCowCopyBytes = 4096 ∧
      pageCowLargerHardwarePageAllowed = true ∧
      pageCowLargerPageIsSecondCopy = false ∧
      compCertVerifiedCompilationClaimedDone = false ∧
      slakeBootstrapTypecheckClaimedDone = false ∧
      byteIdentityRequiredForConformingProduct = true ∧
      byteIdentityOfEmitClaimedTrue = false := by
  decide

theorem v28_closed_rules_consistent :
    seqLockNamed = true ∧
      futexIsAtomicOnProcessSharedOrKernelWord = true ∧
      lockOrderClaimed = false ∧
      pthreadUnlockIsSafeKernel = true ∧
      unlockWithoutHoldReject = true ∧
      mapModesSharedPrivateAnonNamed = true ∧
      swmrAndMwmrAreStructureModes = true ∧
      c11AndCxxDataRaceRejectOrFault = true ∧
      checkBytesBeforeView = true ∧
      consLayersOnNamedJudgments = true ∧
      copyHandleWithoutProtocolIsUafClass = true ∧
      compCertExcludedUbClassRejectBeforeCcomp = true ∧
      consAndUbClassImplyConstantTime = false ∧
      sleanifySkillShipped = false ∧
      leanMachineReadyForUse = false ∧
      v28PackageNamesHostedAsDefault = true ∧
      hostedLinuxLibcReplacesPrimaryEmit = false ∧
      integerOverflowSplitNamed = true ∧
      safeClaimWithSignedOverflowIsConsClash = true ∧
      phase0PairIsLockTokenAndAffineUnlock = true ∧
      reproduceStep1NamesArtifactKinds = true ∧
      inconsistencyReportPackageModuleCreatedHere = false ∧
      runningKernelVerified = false := by
  decide

theorem v28_glossary_rules_consistent :
    systemsLeanFollowsShapeOfRust = true ∧
      makeMutDenotesObjectCow = true ∧
      uniqueBlockRequiresEveryPageUnique = true ∧
      freestandingSectionNamed = true ∧
      glossaryWordAddedBeforeUse = true ∧
      reachablePanicIsReject = true ∧
      listEntryIsSafeKernel = true ∧
      blockRegionKindsNamed = true ∧
      immortalStorageNeverFreed = true ∧
      arenaChildFreeIsReject = true ∧
      addressWordNamesBlock = true ∧
      seqLockReadersSnapshotAndRetry = true ∧
      referenceCountOnlyAsCountedProtocol = true ∧
      abaToolsNamed = true ∧
      checkBytesIsNotSerde = true ∧
      dataRaceHasNoHappensBefore = true ∧
      tcbShrinkReplacesSameAbi = true ∧
      layoutPinRecordsWidths = true ∧
      clientsMustNotObserveLeakedExclusion = true ∧
      runningKernelVerified = false ∧
      irisLeanRequired = false := by
  decide

theorem block_unique_when_owner_count_is_one (b : BlockInProcess)
    (h : b.ownerCount = 1) : b.isUnique = true := by
  unfold BlockInProcess.isUnique
  rw [h]
  rfl

theorem loan_is_not_an_owner (b : BlockInProcess) (n : Nat) :
    (b.addLoans n).ownerCount = b.ownerCount ∧
      (b.addLoans n).isUnique = b.isUnique ∧
      (b.addInteriorLoan).ownerCount = b.ownerCount ∧
      (b.addInteriorLoan).interiorLoanCount = b.interiorLoanCount + 1 := by
  exact ⟨rfl, rfl, rfl, rfl⟩

theorem move_owner_source_does_not_remain
    (source : BlockInProcess) (receiverOwners : Nat)
    (h : source.isUnique = true) :
    source.isUnique = true ∧
      (moveOwnerFromUnique source receiverOwners).1.ownerCount = 0 ∧
      (moveOwnerFromUnique source receiverOwners).1.isUnique = false ∧
      (moveOwnerFromUnique source receiverOwners).2 = receiverOwners + 1 ∧
      (moveOwnerFromUnique source receiverOwners).1.processId = source.processId ∧
      (moveOwnerFromUnique source receiverOwners).1.loanCount = source.loanCount := by
  exact ⟨h, rfl, rfl, rfl, rfl, rfl⟩

theorem copy_handle_owner_without_protocol_rejected :
    copyHandleOwnerAccepted false OwnerHandle.holds = false ∧
      copyHandleOwnerAccepted false OwnerHandle.holds =
        uniqueBlockCopyHandleWithoutProtocolAccepted ∧
      copyHandleExtraOwner 1 = 2 ∧
      copyHandleOwnerAccepted true OwnerHandle.holds = true := by
  decide

theorem owner_count_is_not_a_header_field :
    ownerCountIsHeaderField = false ∧
      exactOwnerCountOnHeaderClaimed = false ∧
      uniqueBlockDefaultRcHeader = false := by
  decide

theorem free_rejects_when_count_says_another_owner (b : BlockInProcess)
    (h : Nat.blt 1 b.ownerCount = true) :
    freeIsReject b = true := by
  unfold freeIsReject
  rw [h]
  rfl

theorem free_rejects_when_interior_loan_live (b : BlockInProcess)
    (h : (b.interiorLoanCount != 0) = true) :
    freeIsReject b = true := by
  unfold freeIsReject
  rw [h]
  rw [Bool.or_true]

theorem free_two_owners_rejected :
    freeIsReject
      { processId := 0, ownerCount := 2, loanCount := 0, interiorLoanCount := 0 } =
      true :=
  free_rejects_when_count_says_another_owner _ (by decide)

theorem free_unique_with_interior_loan_rejected :
    freeIsReject
      { processId := 0, ownerCount := 1, loanCount := 1, interiorLoanCount := 1 } =
      true :=
  free_rejects_when_interior_loan_live _ (by decide)

theorem free_unique_block_without_interior_loan_not_rejected :
    freeIsReject
      { processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 } =
      false := by
  decide

theorem data_race_is_not_safe_thr (a b : ThrEvent) (h : isDataRace a b = true) :
    safeThrHoldsOnPair a b = false ∧ safeThrAllowsDataRace = false := by
  constructor
  · unfold safeThrHoldsOnPair
    rw [h]
    rfl
  · rfl

theorem data_race_has_no_happens_before_edge (a b : ThrEvent)
    (h : isDataRace a b = true) :
    a.happensBeforeEdge = false ∧ b.happensBeforeEdge = false ∧
      dataRaceHasNoHappensBefore = true := by
  unfold isDataRace at h
  have right {x y : Bool} (hx : (x && y) = true) : y = true := by
    cases x with
    | true => exact hx
    | false => cases hx
  have left {x y : Bool} (hx : (x && y) = true) : x = true := by
    cases x with
    | true => rfl
    | false => cases hx
  -- isDataRace is notAtomic && (noHappensBefore && samePlace)
  have noHbAndPlace := right h
  have noHb := left noHbAndPlace
  exact ⟨(beq_iff_eq).mp (left noHb), (beq_iff_eq).mp (right noHb), rfl⟩

theorem happens_before_edge_blocks_data_race (a b : ThrEvent)
    (h : a.happensBeforeEdge = true) :
    isDataRace a b = false ∧ dataRaceHasNoHappensBefore = true := by
  refine ⟨?_, rfl⟩
  simp only [isDataRace, h, Bool.and_false, Bool.false_and, Bool.true_beq]

theorem other_happens_before_edge_blocks_data_race (a b : ThrEvent)
    (h : b.happensBeforeEdge = true) :
    isDataRace a b = false ∧ dataRaceHasNoHappensBefore = true := by
  refine ⟨?_, rfl⟩
  simp only [isDataRace, h, Bool.and_false, Bool.false_and, Bool.true_beq]

theorem atomic_cell_event_is_not_data_race (a b : ThrEvent) (hAt : a.atomic = true) :
    isDataRace a b = false := by
  unfold isDataRace
  rw [hAt]
  have notAtomic : ((true == false) && (b.atomic == false)) = false := rfl
  rw [notAtomic]
  rfl

theorem atomic_cell_sample_is_not_a_data_race :
    isDataRace atomicCellWrite plainRaceRead = false :=
  atomic_cell_event_is_not_data_race atomicCellWrite plainRaceRead rfl

theorem sample_pair_is_a_data_race :
    isDataRace plainRaceWrite plainRaceRead = true ∧
      safeMemNonAtomicDataRaceAccepted = false := by
  decide

theorem sample_race_is_not_safe_thr :
    safeThrHoldsOnPair plainRaceWrite plainRaceRead = false ∧
      safeThrAllowsDataRace = false :=
  data_race_is_not_safe_thr plainRaceWrite plainRaceRead sample_pair_is_a_data_race.1

theorem sample_race_derives_safe_mem_mash :
    mashSafeMemNonAtomicDataRaceIsFalse := by
  have h := sample_pair_is_a_data_race
  have _race : isDataRace plainRaceWrite plainRaceRead = true := h.1
  exact mash_safe_mem_non_atomic_data_race_is_false

theorem atomic_program_order_does_not_verify_kernel :
    atomicCellProgramOrder earlierAtomicCell laterAtomicCell = true ∧
      programOrderProvesMainlineLinux = false ∧
      atomicProgramOrderProvesRunningKernel = false ∧
      runningKernelVerified = false ∧
      linuxKernelMemoryModelRequired = true := by
  decide

theorem official_compcert_does_not_prove_threads (c : SafeCompCert) :
    officialCompCertProvesThreads = false ∧
      safeCompCertImpliesThreadProof = false ∧
      safeCompCertImpliesSafeKernel c = SafeKernel.holds := by
  exact ⟨rfl, rfl, rfl⟩

theorem safe_thr_stays_on_the_safe_kernel_side :
    safeThrRequiredForSafeKernel = true ∧
      safeThrIsCompCertThreadProof = false ∧
      SafeKernelConjuncts.holds kernelWithSafeThr = true ∧
      SafeKernelConjuncts.holds kernelMissingSafeThr = false := by
  decide

theorem lock_free_is_the_three_part_claim :
    LockFreeOp.holds lockFreeSample = true ∧
      lockFreeMeansMutexAbsent = false ∧
      lockFreeMeansCompareAndSwap = false ∧
      lockFreeIsWaitFree = false ∧
      lockFreeIsObstructionFree = false ∧
      lockFreeProofsClaimedDone = false := by
  decide

theorem wait_free_and_obstruction_free_are_not_lock_free :
    WaitFreeOp.holds waitFreeSample = true ∧
      ObstructionFreeOp.holds obstructionFreeSample = true ∧
      LockFreeOp.holds lockFreeMissingSpec = false ∧
      lockFreeIsWaitFree = false ∧
      lockFreeIsObstructionFree = false := by
  decide

theorem lock_free_free_without_reclamation_matches_fixture :
    reclamationFreeAccepted freeNoReclamation = false ∧
      reclamationFreeAccepted freeNoReclamation =
        lockFreeFreeWithoutReclamationAccepted ∧
      lockFreeProofsClaimedDone = false := by
  decide

theorem lock_free_free_without_reclamation_keeps_mash :
    mashLockFreeFreeWithoutReclamationIsFalse := by
  have h := lock_free_free_without_reclamation_matches_fixture
  have _rejected : reclamationFreeAccepted freeNoReclamation = false := h.1
  exact mash_lock_free_free_without_reclamation_is_false

theorem channel_move_owner_removes_sender (receiverBefore : Nat) :
    (moveOwnerChannel 1 receiverBefore).senderOwnersAfter = 0 ∧
      (moveOwnerChannel 1 receiverBefore).receiverOwnersAfter = receiverBefore + 1 ∧
      (moveOwnerChannel 1 receiverBefore).cargo = ChannelCargo.moveOwner := by
  exact ⟨rfl, rfl, rfl⟩

theorem channel_copy_bits_adds_no_owner (sender receiver : Nat) :
    (copyBitsChannel sender receiver).receiverOwnersAfter =
        (copyBitsChannel sender receiver).receiverOwnersBefore ∧
      (copyBitsChannel sender receiver).senderOwnersAfter =
        (copyBitsChannel sender receiver).senderOwnersBefore ∧
      (copyBitsChannel sender receiver).cargo = ChannelCargo.copyBits := by
  exact ⟨rfl, rfl, rfl⟩

theorem channel_traffic_is_not_posix_fork :
    ForkJoin.holds oneProcessForkJoin = true ∧
      channelIsPosixFork = false ∧
      channelIsForkJoinTraffic = true ∧
      channelImplementationClaimed = false ∧
      posixForkIsForkJoin = false ∧
      posixForkCreatesAnotherProcess = true := by
  decide

theorem misaligned_explicit_packed_rejected :
    explicitPackedRejected misalignedExplicitPacked = true ∧
      explicitPackedRejected undocumentedExplicitPacked = true ∧
      explicitPackedRejected alignedExplicitPacked = false ∧
      autovectorizationIsSimdProof = false := by
  decide

theorem explicit_packed_op_is_not_atomic_cell :
    alignedExplicitPacked.atomicLocation = false ∧
      explicitPackedIsAtomicCell = false ∧
      autovectorizationIsSimdProof = false := by
  decide

theorem explicit_packed_keeps_autovectorization_mash :
    mashAutovectorizationIsSimdProofIsFalse := by
  have h := explicit_packed_op_is_not_atomic_cell
  have _notCell : explicitPackedIsAtomicCell = false := h.2.1
  exact mash_autovectorization_is_simd_proof_is_false

theorem cache_secret_violation_only_when_safe_ct_on :
    cacheCarriesSecretRejected false true = false ∧
      cacheCarriesSecretRejected true true = true ∧
      cacheCarriesSecretRejected true false = false ∧
      safeCtOnByDefault = false ∧
      safeCtCacheCarriesSecret = false ∧
      notConstantTimeIsSafeCtSwitch = false := by
  decide

theorem explicit_packed_is_not_automatic_and_not_atomic_location :
    explicitPackedIsAutomatic = false ∧
      explicitPackedIsAtomicLocation = false ∧
      packedOpcodeCatalogClaimedDone = false ∧
      explicitPackedIsAtomicCell = false ∧
      autovectorizationIsSimdProof = false ∧
      explicitPackedRejected alignedExplicitPacked = false ∧
      explicitPackedRejected misalignedExplicitPacked = true := by
  decide

theorem atomic_program_order_is_not_lkmm_proof :
    atomicCellProgramOrder earlierAtomicCell laterAtomicCell = true ∧
      atomicProgramOrderProvesLkmm = false ∧
      programOrderProvesMainlineLinux = false ∧
      linuxKernelMemoryModelRequired = true ∧
      runningKernelVerified = false := by
  decide

end SystemsLean
