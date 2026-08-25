/-
  Companion Lean model of selected claims from 0002_Systems_Lean.md.

  This module is not the specification. The numbered markdown is the contract
  that humans read. spec_check remains the form checker (ASCII, tabs, RFC 2119,
  spelling). These declarations encode meaning so an inconsistent model is a
  type error or a failing test.

  The spec spells the unrestricted multiplicity as the ASCII word omega.
  This model names that constructor `unrestricted` so it does not clash
  with Lean's `omega` tactic.
-/

import SpecRegistry

namespace SystemsLean

/-!
  Clause 3 and Clause 4.1: Quantitative Type Theory multiplicities are
  exactly 0 (erased), 1 (linear or affine), and omega (unrestricted).
-/

inductive Multiplicity where
  /-- Spec multiplicity 0: erased at compile time. -/
  | erased
  /-- Spec multiplicity 1: linear or affine (exactly once or at most once). -/
  | once
  /-- Spec multiplicity omega: unrestricted use. -/
  | unrestricted
  deriving DecidableEq, Repr, BEq

/--
  Bijection with `Fin 3`. Adding a fourth multiplicity constructor makes
  `toFin` fail to compile (non exhaustive). Widening `Fin 3` is a deliberate
  spec change and breaks `multiplicity_card`.
-/
def Multiplicity.toFin : Multiplicity → Fin 3
  | .erased => ⟨0, by decide⟩
  | .once => ⟨1, by decide⟩
  | .unrestricted => ⟨2, by decide⟩

def Multiplicity.ofFin : Fin 3 → Multiplicity
  | ⟨0, _⟩ => .erased
  | ⟨1, _⟩ => .once
  | ⟨2, _⟩ => .unrestricted

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
def Multiplicity.all : List Multiplicity :=
  [.erased, .once, .unrestricted]

theorem multiplicity_all_three : Multiplicity.all.length = 3 := rfl

/-- Every multiplicity is one of the three constructors in Clause 4.1 item 1. -/
theorem multiplicity_cases (m : Multiplicity) :
    m = .erased ∨ m = .once ∨ m = .unrestricted := by
  cases m with
  | erased => exact Or.inl rfl
  | once => exact Or.inr (Or.inl rfl)
  | unrestricted => exact Or.inr (Or.inr rfl)

/-- Clause 3.5: multiplicity 1 is linear or affine, not a third discipline. -/
inductive OnceDiscipline where
  | linear
  | affine
  deriving DecidableEq, Repr, BEq

def Multiplicity.onceDisciplines : List OnceDiscipline :=
  [.linear, .affine]

theorem once_is_linear_or_affine :
    Multiplicity.onceDisciplines.length = 2 := rfl

/-!
  Clause 3.4, 3.5, 3.6, and 4.1 item 2: finite runtime use counts.

  This is not a Quantitative Type Theory checker and does not invent
  extra multiplicities. It records how many runtime uses each of the
  three spec multiplicities (and, for multiplicity 1, linear vs affine)
  may have.
-/

inductive ResourceTag where
  /-- Multiplicity 0: erased at compile time; runtime uses must be 0. -/
  | erased
  /-- Multiplicity 1, linear: runtime uses must be exactly 1. -/
  | linear
  /-- Multiplicity 1, affine: runtime uses must be 0 or 1 (at most once). -/
  | affine
  /-- Multiplicity omega: any Nat of runtime uses is allowed. -/
  | unrestricted
  deriving DecidableEq, Repr, BEq

def ResourceTag.multiplicity : ResourceTag → Multiplicity
  | .erased => .erased
  | .linear => .once
  | .affine => .once
  | .unrestricted => .unrestricted

def OnceDiscipline.toResourceTag : OnceDiscipline → ResourceTag
  | .linear => .linear
  | .affine => .affine

/-- Allowed runtime uses for this tag (Clause 3.4 through 3.6). -/
def ResourceTag.usesOk : ResourceTag → Nat → Bool
  | .erased, n => decide (n = 0)
  | .linear, n => decide (n = 1)
  | .affine, n => decide (n = 0 ∨ n = 1)
  | .unrestricted, _ => true

structure Usage where
  tag : ResourceTag
  runtimeUses : Nat
  deriving DecidableEq, Repr, BEq

def Usage.ok (u : Usage) : Bool :=
  u.tag.usesOk u.runtimeUses

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

/-!
  Clause 3.4 and 4.1 item 3: multiplicity 0 is erased at compile time and
  MUST NOT appear in the freestanding product.
-/

def Multiplicity.appearsInFreestandingProduct : Multiplicity → Bool
  | .erased => false
  | .once => true
  | .unrestricted => true

theorem multiplicity_zero_not_on_wire :
    Multiplicity.appearsInFreestandingProduct .erased = false := rfl

theorem multiplicity_once_may_be_on_wire :
    Multiplicity.appearsInFreestandingProduct .once = true := rfl

theorem multiplicity_omega_may_be_on_wire :
    Multiplicity.appearsInFreestandingProduct .unrestricted = true := rfl

/-!
  Clause 3.3 and 4.2 items 2 and 4: freestanding product wire.
-/

inductive PayloadKind where
  | binary
  | cSource
  deriving DecidableEq, Repr, BEq

inductive EmissionTarget where
  | freestandingC
  | llvmIR
  deriving DecidableEq, Repr, BEq

/-- Clause 4.2 item 2: primary emission is freestanding C. -/
def EmissionTarget.primary : EmissionTarget := .freestandingC

theorem primary_emission_is_freestanding_c :
    EmissionTarget.primary = .freestandingC := rfl

/--
  Clause 4.2 item 3: LLVM IR is optional later. Conformance does not
  require it (Clause 5 last paragraph).
-/
def llvmIrRequiredForConformance : Bool := false

theorem llvm_ir_not_required :
    llvmIrRequiredForConformance = false := rfl

structure FreestandingWire where
  payload : PayloadKind
  hasManagedLeanRuntime : Bool
  hasGarbageCollection : Bool
  mentionsErasedMultiplicity : Bool
  deriving DecidableEq, Repr, BEq

/-- Well formed wire: no managed Lean runtime, no GC, no multiplicity 0. -/
def FreestandingWire.ok (w : FreestandingWire) : Bool :=
  !w.hasManagedLeanRuntime && !w.hasGarbageCollection && !w.mentionsErasedMultiplicity

def cleanWire : FreestandingWire :=
  { payload := .cSource
    hasManagedLeanRuntime := false
    hasGarbageCollection := false
    mentionsErasedMultiplicity := false }

def gcWire : FreestandingWire :=
  { payload := .cSource
    hasManagedLeanRuntime := false
    hasGarbageCollection := true
    mentionsErasedMultiplicity := false }

def managedRuntimeWire : FreestandingWire :=
  { payload := .binary
    hasManagedLeanRuntime := true
    hasGarbageCollection := false
    mentionsErasedMultiplicity := false }

def erasedOnWire : FreestandingWire :=
  { payload := .cSource
    hasManagedLeanRuntime := false
    hasGarbageCollection := false
    mentionsErasedMultiplicity := true }

theorem clean_wire_ok : cleanWire.ok = true := by decide

theorem gc_on_wire_not_ok : gcWire.ok = false := by decide

theorem managed_runtime_on_wire_not_ok : managedRuntimeWire.ok = false := by
  decide

theorem erased_multiplicity_on_wire_not_ok : erasedOnWire.ok = false := by
  decide

/-!
  Clause 4.2 item 1: Slake is written in Systems Lean.
-/

inductive ImplementationLanguage where
  | systemsLean
  | other
  deriving DecidableEq, Repr, BEq

structure SlakeProduct where
  writtenIn : ImplementationLanguage
  primaryEmission : EmissionTarget
  llvmPathPresent : Bool
  deriving Repr

/--
  Clause 4.2 items 1 and 2: written in Systems Lean, primary emission is
  freestanding C. LLVM IR presence is ignored here (optional).
-/
def SlakeProduct.conforming (s : SlakeProduct) : Bool :=
  s.writtenIn == .systemsLean && s.primaryEmission == .freestandingC

def slakeCanonical : SlakeProduct :=
  { writtenIn := .systemsLean
    primaryEmission := .freestandingC
    llvmPathPresent := false }

def slakeWithLlvm : SlakeProduct :=
  { writtenIn := .systemsLean
    primaryEmission := .freestandingC
    llvmPathPresent := true }

def slakeOtherLanguage : SlakeProduct :=
  { writtenIn := .other
    primaryEmission := .freestandingC
    llvmPathPresent := false }

def slakePrimaryLlvm : SlakeProduct :=
  { writtenIn := .systemsLean
    primaryEmission := .llvmIR
    llvmPathPresent := true }

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

/-!
  Clause 3.7 and 4.2 item 5: residual honesty.
  A named residual is required if the product is not fully freestanding.
-/

def residualHonesty (fullyFreestanding : Bool) (namedResidual : Option String) : Bool :=
  match namedResidual with
  | none => fullyFreestanding
  | some name => fullyFreestanding || !name.isEmpty

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
def wireOrResidualHonesty (w : FreestandingWire) (namedResidual : Option String) : Bool :=
  residualHonesty w.ok namedResidual

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

/-!
  Clause 4.3 item 2: product tree `ref/` directory names as they exist
  in the Systems Lean product tree. Not this specifications repository's
  `ref/`.
-/

structure ProductRefLayout where
  idris2Dir : String
  lean4Dir : String
  compCertDir : String
  rustDir : String
  deriving DecidableEq, Repr, BEq

def ProductRefLayout.ok (l : ProductRefLayout) : Bool :=
  (l.idris2Dir == "Idris2") &&
    (l.lean4Dir == "lean4") &&
    (l.compCertDir == "CompCert") &&
    (l.rustDir == "rust")

def productRefLayoutCanonical : ProductRefLayout :=
  { idris2Dir := "Idris2"
    lean4Dir := "lean4"
    compCertDir := "CompCert"
    rustDir := "rust" }

def productRefLayoutWrongIdris : ProductRefLayout :=
  { productRefLayoutCanonical with idris2Dir := "idris2" }

theorem product_ref_layout_canonical_ok :
    productRefLayoutCanonical.ok = true := by decide

theorem product_ref_layout_wrong_idris_not_ok :
    productRefLayoutWrongIdris.ok = false := by decide

/-- This specifications repository does not pin these trees under its own ref/. -/
def specsRepoPinsLean4 : Bool := false

def specsRepoPinsIdris2 : Bool := false

def specsRepoPinsCompCert : Bool := false

def specsRepoPinsRust : Bool := false

theorem specs_repo_does_not_pin_lean4 : specsRepoPinsLean4 = false := rfl

theorem specs_repo_does_not_pin_idris2 : specsRepoPinsIdris2 = false := rfl

theorem specs_repo_does_not_pin_compcert : specsRepoPinsCompCert = false := rfl

theorem specs_repo_does_not_pin_rust : specsRepoPinsRust = false := rfl

/-!
  Clause 3.9 and 4.2 item 6: CompCert verified compilation is a required
  core validation step. Residual naming does not substitute.
-/

structure CompCertValidation where
  verifiedCompilation : Bool
  deriving DecidableEq, Repr, BEq

def CompCertValidation.ok (v : CompCertValidation) : Bool :=
  v.verifiedCompilation

def compCertPerformed : CompCertValidation :=
  { verifiedCompilation := true }

def compCertMissing : CompCertValidation :=
  { verifiedCompilation := false }

theorem compcert_performed_ok : compCertPerformed.ok = true := by decide

theorem compcert_missing_not_ok : compCertMissing.ok = false := by decide

/-!
  Clause 3.10 and 4.2 item 7: bootstrapping a Slake compiler that fully typechecks
  is a required core validation step. A subset typecheck is not
  enough. Emitting C without that typecheck is not enough. Residual naming
  does not substitute.
-/

structure SlakeBootstrapTypecheck where
  bootstrapped : Bool
  fullyTypechecks : Bool
  deriving DecidableEq, Repr, BEq

def SlakeBootstrapTypecheck.ok (b : SlakeBootstrapTypecheck) : Bool :=
  b.bootstrapped && b.fullyTypechecks

def bootstrapTypecheckDone : SlakeBootstrapTypecheck :=
  { bootstrapped := true, fullyTypechecks := true }

def bootstrapMissing : SlakeBootstrapTypecheck :=
  { bootstrapped := false, fullyTypechecks := false }

def bootstrapSubsetOnly : SlakeBootstrapTypecheck :=
  { bootstrapped := true, fullyTypechecks := false }

def typecheckWithoutBootstrap : SlakeBootstrapTypecheck :=
  { bootstrapped := false, fullyTypechecks := true }

theorem bootstrap_typecheck_done_ok :
    bootstrapTypecheckDone.ok = true := by decide

theorem bootstrap_missing_not_ok :
    bootstrapMissing.ok = false := by decide

theorem bootstrap_subset_not_ok :
    bootstrapSubsetOnly.ok = false := by decide

theorem typecheck_without_bootstrap_not_ok :
    typecheckWithoutBootstrap.ok = false := by decide

/-!
  Clause 4.3 item 3: novel work is at most Idris 2, Lean 4 (including
  Systems Lean), and pure Nix. Free floating shell is not in this set.
-/

inductive NovelLanguage where
  | idris2
  | lean4IncludingSystemsLean
  | pureNix
  deriving DecidableEq, Repr, BEq

def NovelLanguage.toFin : NovelLanguage → Fin 3
  | .idris2 => ⟨0, by decide⟩
  | .lean4IncludingSystemsLean => ⟨1, by decide⟩
  | .pureNix => ⟨2, by decide⟩

def NovelLanguage.ofFin : Fin 3 → NovelLanguage
  | ⟨0, _⟩ => .idris2
  | ⟨1, _⟩ => .lean4IncludingSystemsLean
  | ⟨2, _⟩ => .pureNix

theorem NovelLanguage.ofFin_toFin (l : NovelLanguage) :
    NovelLanguage.ofFin l.toFin = l := by
  cases l <;> rfl

theorem novel_language_card_three :
    ( [NovelLanguage.idris2, .lean4IncludingSystemsLean, .pureNix] : List NovelLanguage
    ).length = 3 := rfl

/-- Shell is modeled as a distinct forbidden path, not a fourth novel language. -/
inductive ProductPath where
  | novel : NovelLanguage → ProductPath
  | freeFloatingShell : ProductPath
  deriving DecidableEq, Repr, BEq

def ProductPath.permitted : ProductPath → Bool
  | .novel _ => true
  | .freeFloatingShell => false

def allPathsPermitted (paths : List ProductPath) : Bool :=
  paths.all ProductPath.permitted

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

/-!
  Clause 4.3 items 1 and 2: novel Unlicense; upstream under ref/ keeps
  original license.
-/

inductive SourceKind where
  | novel
  | upstream
  deriving DecidableEq, Repr, BEq

inductive LicenseTreatment where
  | unlicense
  | originalUpstream
  deriving DecidableEq, Repr, BEq

def hygiene (kind : SourceKind) : LicenseTreatment :=
  match kind with
  | .novel => .unlicense
  | .upstream => .originalUpstream

theorem novel_is_unlicense : hygiene .novel = .unlicense := rfl

theorem upstream_keeps_original : hygiene .upstream = .originalUpstream := rfl

/-- What a product tree actually did with licenses and `ref/` layout. -/
structure HygieneClaim where
  novelLicense : LicenseTreatment
  upstreamLicense : LicenseTreatment
  upstreamLivesUnderRef : Bool
  deriving DecidableEq, Repr, BEq

/-- Clause 5 item 3 / Clause 4.3 items 1 and 2. -/
def HygieneClaim.ok (h : HygieneClaim) : Bool :=
  h.novelLicense == .unlicense &&
    h.upstreamLicense == .originalUpstream &&
    h.upstreamLivesUnderRef

def hygieneOk : HygieneClaim :=
  { novelLicense := .unlicense
    upstreamLicense := .originalUpstream
    upstreamLivesUnderRef := true }

def hygieneNovelNotUnlicense : HygieneClaim :=
  { novelLicense := .originalUpstream
    upstreamLicense := .originalUpstream
    upstreamLivesUnderRef := true }

def hygieneUpstreamRelicensed : HygieneClaim :=
  { novelLicense := .unlicense
    upstreamLicense := .unlicense
    upstreamLivesUnderRef := true }

def hygieneUpstreamNotUnderRef : HygieneClaim :=
  { novelLicense := .unlicense
    upstreamLicense := .originalUpstream
    upstreamLivesUnderRef := false }

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

/-!
  Clause 4.4: named high assurance components must be able to target Slake
  when they claim that clause. SSSSS pieces that are safety critical belong to
  0004_SSSSS.md, not to 0002. beastdb is specified in 0003_beastdb.md.

  Targeting is a claim, not a constantly true function of the component
  name. A component that claims Clause 4.4 and cannot target Slake is
  nonconforming (Clause 5 item 5).
-/

inductive StackComponent where
  | beastdbCore
  | leanMachine
  | ssssSafetyCritical
  | fixOSVision
  deriving DecidableEq, Repr, BEq

structure NamedComponentClaim where
  component : StackComponent
  claimsClause44 : Bool
  canTargetSlake : Bool
  deriving DecidableEq, Repr, BEq

/-- Clause 5 item 5: claiming Clause 4.4 requires targeting Slake. -/
def NamedComponentClaim.ok (c : NamedComponentClaim) : Bool :=
  if c.claimsClause44 then c.canTargetSlake else true

def namedStackClaim (c : StackComponent) (canTarget : Bool) : NamedComponentClaim :=
  { component := c
    claimsClause44 := true
    canTargetSlake := canTarget }

def allStackClaimsOk (claims : List NamedComponentClaim) : Bool :=
  claims.all NamedComponentClaim.ok

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

def allNamedStackTargeting : List NamedComponentClaim :=
  [ namedStackClaim .beastdbCore true
    , namedStackClaim .leanMachine true
    , namedStackClaim .ssssSafetyCritical true
    , namedStackClaim .fixOSVision true ]

def beastdbCannotTarget : List NamedComponentClaim :=
  [ namedStackClaim .beastdbCore false ]

theorem all_named_stack_targeting_ok :
    allStackClaimsOk allNamedStackTargeting = true := by decide

theorem beastdb_cannot_target_fails_clause5_item5 :
    allStackClaimsOk beastdbCannotTarget = false := by decide

/-!
  Clause 5: one conformance predicate for a claimed Systems Lean / Slake
  product. Optional LLVM IR is not a conjunct. CompCert verified
  compilation and Slake bootstrap typecheck are conjuncts.
-/

structure ClaimedProduct where
  usages : List Usage
  slake : SlakeProduct
  wire : FreestandingWire
  namedResidual : Option String
  hygieneClaim : HygieneClaim
  productRefLayout : ProductRefLayout
  novelPaths : List ProductPath
  stackClaims : List NamedComponentClaim
  compCert : CompCertValidation
  bootstrapTypecheck : SlakeBootstrapTypecheck
  deriving Repr

/-- Clause 5 item 1: only three multiplicities, and use counts respect
    erased / linear / affine / unrestricted (Clause 3 and 4.1 item 2). -/
def ClaimedProduct.item1 (p : ClaimedProduct) : Bool :=
  (Multiplicity.all.length == 3) && p.usages.all Usage.ok

/-- Clause 5 item 2: well formed freestanding wire, or residual honesty. -/
def ClaimedProduct.item2 (p : ClaimedProduct) : Bool :=
  wireOrResidualHonesty p.wire p.namedResidual

/-- Clause 5 item 3: novel Unlicense, upstream original under product `ref/`
    with the directory names in Clause 4.3. -/
def ClaimedProduct.item3 (p : ClaimedProduct) : Bool :=
  p.hygieneClaim.ok && p.productRefLayout.ok

/-- Clause 5 item 4: only the three novel languages; no shell scripts that float free of Nix. -/
def ClaimedProduct.item4 (p : ClaimedProduct) : Bool :=
  allPathsPermitted p.novelPaths

/-- Clause 5 item 5: Clause 4.4 claims can target Slake. -/
def ClaimedProduct.item5 (p : ClaimedProduct) : Bool :=
  allStackClaimsOk p.stackClaims

/-- Clause 5 item 6 / Clause 4.2 item 6: CompCert verified compilation. -/
def ClaimedProduct.item6 (p : ClaimedProduct) : Bool :=
  p.compCert.ok

/-- Clause 5 item 7 / Clause 4.2 item 7: bootstrapped Slake that fully typechecks. -/
def ClaimedProduct.item7 (p : ClaimedProduct) : Bool :=
  p.bootstrapTypecheck.ok

def ClaimedProduct.conforms (p : ClaimedProduct) : Bool :=
  p.item1 && p.item2 && p.slake.conforming && p.item3 && p.item4 && p.item5 &&
    p.item6 && p.item7

def canonicalUsages : List Usage :=
  [ { tag := .erased, runtimeUses := 0 }
    , { tag := .linear, runtimeUses := 1 }
    , { tag := .affine, runtimeUses := 0 }
    , { tag := .affine, runtimeUses := 1 }
    , { tag := .unrestricted, runtimeUses := 7 } ]

def canonicalNovelPaths : List ProductPath :=
  [.novel .idris2, .novel .lean4IncludingSystemsLean, .novel .pureNix]

def canonicalProduct : ClaimedProduct :=
  { usages := canonicalUsages
    slake := slakeCanonical
    wire := cleanWire
    namedResidual := none
    hygieneClaim := hygieneOk
    productRefLayout := productRefLayoutCanonical
    novelPaths := canonicalNovelPaths
    stackClaims := allNamedStackTargeting
    compCert := compCertPerformed
    bootstrapTypecheck := bootstrapTypecheckDone }

def productGcSilent : ClaimedProduct :=
  { canonicalProduct with wire := gcWire, namedResidual := none }

def productGcNamed : ClaimedProduct :=
  { canonicalProduct with
    wire := gcWire
    namedResidual := some "garbage collection" }

def productLinearUsedTwice : ClaimedProduct :=
  { canonicalProduct with
    usages := [{ tag := .linear, runtimeUses := 2 }] }

def productErasedUsedOnce : ClaimedProduct :=
  { canonicalProduct with
    usages := [{ tag := .erased, runtimeUses := 1 }] }

def productAffineUsedTwice : ClaimedProduct :=
  { canonicalProduct with
    usages := [{ tag := .affine, runtimeUses := 2 }] }

def productShellPath : ClaimedProduct :=
  { canonicalProduct with novelPaths := [.freeFloatingShell] }

def productBadHygiene : ClaimedProduct :=
  { canonicalProduct with hygieneClaim := hygieneNovelNotUnlicense }

def productCannotTargetSlake : ClaimedProduct :=
  { canonicalProduct with stackClaims := beastdbCannotTarget }

def productOtherLanguage : ClaimedProduct :=
  { canonicalProduct with slake := slakeOtherLanguage }

def productWithOptionalLlvm : ClaimedProduct :=
  { canonicalProduct with slake := slakeWithLlvm }

def productPrimaryLlvm : ClaimedProduct :=
  { canonicalProduct with slake := slakePrimaryLlvm }

def productMissingCompCert : ClaimedProduct :=
  { canonicalProduct with compCert := compCertMissing }

def productMissingBootstrapTypecheck : ClaimedProduct :=
  { canonicalProduct with bootstrapTypecheck := bootstrapMissing }

def productSubsetTypecheck : ClaimedProduct :=
  { canonicalProduct with bootstrapTypecheck := bootstrapSubsetOnly }

def productTypecheckWithoutBootstrap : ClaimedProduct :=
  { canonicalProduct with bootstrapTypecheck := typecheckWithoutBootstrap }

def productWrongRefLayout : ClaimedProduct :=
  { canonicalProduct with productRefLayout := productRefLayoutWrongIdris }

/-- Named residual on the wire does not excuse a missing CompCert step. -/
def productNamedResidualMissingCompCert : ClaimedProduct :=
  { canonicalProduct with
    wire := gcWire
    namedResidual := some "garbage collection"
    compCert := compCertMissing }

/-- Named residual on the wire does not excuse a subset only typecheck. -/
def productNamedResidualMissingBootstrap : ClaimedProduct :=
  { canonicalProduct with
    wire := gcWire
    namedResidual := some "garbage collection"
    bootstrapTypecheck := bootstrapSubsetOnly }

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

/-!
  Spec document identity: this spec is 0002; SSSSS is specified in
  0004_SSSSS.md (not 0002, not 0003). beastdb is specified in 0003_beastdb.md.
-/

def systemsLeanSpecNumber : Nat := SpecRegistry.systemsLeanSpecNumber

def ssssSpecNumber : Nat := SpecRegistry.ssssSpecNumber

def beastdbSpecNumber : Nat := SpecRegistry.beastdbSpecNumber

def beastdbSpecFileName : String := "0003_beastdb.md"

theorem systems_lean_is_spec_0002 : systemsLeanSpecNumber = 2 := rfl

theorem ssss_is_not_spec_0002 : ssssSpecNumber ≠ systemsLeanSpecNumber := by
  decide

theorem ssss_is_not_spec_0003 : ssssSpecNumber ≠ 3 := by decide

theorem ssss_is_0004 : ssssSpecNumber = 4 := rfl

theorem beastdb_is_spec_0003 : beastdbSpecNumber = 3 := rfl

theorem beastdb_specified_in_0003_beastdb :
    beastdbSpecFileName = "0003_beastdb.md" := rfl

end SystemsLean
