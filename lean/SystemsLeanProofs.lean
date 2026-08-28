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


end SystemsLean
