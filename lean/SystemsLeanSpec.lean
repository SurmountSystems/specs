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
import FormalVibeficationSpec

namespace SystemsLean

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

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
  | .erased => (0 : Fin 3)
  | .once => (1 : Fin 3)
  | .unrestricted => (2 : Fin 3)

def Multiplicity.ofFin : Fin 3 → Multiplicity
  | ⟨0, _⟩ => .erased
  | ⟨1, _⟩ => .once
  | ⟨2, _⟩ => .unrestricted

def Multiplicity.all : List Multiplicity :=
  [.erased, .once, .unrestricted]

inductive OnceDiscipline where
  | linear
  | affine
  deriving DecidableEq, Repr, BEq

def Multiplicity.onceDisciplines : List OnceDiscipline :=
  [.linear, .affine]

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

/-!
  Clause 3.4 and 4.1 item 3: multiplicity 0 is erased at compile time and
  MUST NOT appear in the freestanding product.
-/

def Multiplicity.appearsInFreestandingProduct : Multiplicity → Bool
  | .erased => false
  | .once => true
  | .unrestricted => true

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

def llvmIrRequiredForConformance : Bool := false

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

/-!
  Clause 3.7 and 4.2 item 5: residual honesty.
  A named residual is required if the product is not fully freestanding.
-/

def residualHonesty (fullyFreestanding : Bool) (namedResidual : Option String) : Bool :=
  match namedResidual with
  | none => fullyFreestanding
  | some name => fullyFreestanding || !name.isEmpty

def wireOrResidualHonesty (w : FreestandingWire) (namedResidual : Option String) : Bool :=
  residualHonesty w.ok namedResidual

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

def specsRepoPinsLean4 : Bool := false

def specsRepoPinsIdris2 : Bool := false

def specsRepoPinsCompCert : Bool := false

def specsRepoPinsRust : Bool := false

/-!
  Clause 3.9 and 4.2 item 6: CompCert verified compilation is a required
  core validation step. The tool is `ccomp` applied to the freestanding C
  emit. Residual naming does not substitute. A hypothetical conforming
  fixture may set verified compilation true. The live product does not
  claim that step is done.
-/

/-- CompCert command named in Clause 3.9 and Clause 4.2 item 6. -/
def requiredCompCertTool : String := "ccomp"

structure CompCertValidation where
  tool : String
  emit : EmissionTarget
  verifiedCompilation : Bool
  deriving DecidableEq, Repr, BEq

/-- The required step names `ccomp` of the freestanding C emit. -/
def CompCertValidation.usesCcompOfFreestandingC (v : CompCertValidation) : Bool :=
  (v.tool == requiredCompCertTool) && (v.emit == .freestandingC)

def CompCertValidation.ok (v : CompCertValidation) : Bool :=
  v.usesCcompOfFreestandingC && v.verifiedCompilation

def compCertUsesCcomp : Bool :=
  requiredCompCertTool == "ccomp"

/-- Hypothetical conforming fixture: the required step holds. -/
def compCertPerformed : CompCertValidation :=
  { tool := "ccomp"
    emit := .freestandingC
    verifiedCompilation := true }

def compCertMissing : CompCertValidation :=
  { tool := "ccomp"
    emit := .freestandingC
    verifiedCompilation := false }

/-- Wrong compiler is not CompCert `ccomp` of the freestanding C emit. -/
def compCertWrongTool : CompCertValidation :=
  { tool := "gcc"
    emit := .freestandingC
    verifiedCompilation := true }

/-- LLVM IR as the emit is not the required freestanding C step. -/
def compCertWrongEmit : CompCertValidation :=
  { tool := "ccomp"
    emit := .llvmIR
    verifiedCompilation := true }

/-- Live product honesty: the required CompCert step is not claimed done. -/
def compCertVerifiedCompilationClaimedDone : Bool := false

def mashCompCertVerifiedCompilationClaimedDone : Prop :=
  compCertVerifiedCompilationClaimedDone = true

def mashCompCertVerifiedCompilationClaimedDoneIsFalse : Prop :=
  mashCompCertVerifiedCompilationClaimedDone → False

/--
  Clause 4.2 item 6 is `ccomp` of the freestanding C emit.
  CompCertTSO, gcc, LLVM, and cc do not satisfy that step.
-/
def compCertTsoSatisfiesClause42Item6 : Bool := false

def mashCompCertTsoSatisfiesClause42Item6 : Prop :=
  compCertTsoSatisfiesClause42Item6 = true

def mashCompCertTsoSatisfiesClause42Item6IsFalse : Prop :=
  mashCompCertTsoSatisfiesClause42Item6 → False

/-!
  Clause 3.10 and 4.2 item 7: bootstrapping a Slake compiler that fully typechecks
  is a required core validation step. A subset typecheck is not
  enough. Emitting C without that typecheck is not enough. Residual naming
  does not substitute. Conforming bootstrap typecheck includes theorems.
  A claim that the freestanding product hosts itself from generated C is
  a distinct claim and does not satisfy this step by itself.
-/

structure SlakeBootstrapTypecheck where
  bootstrapped : Bool
  fullyTypechecks : Bool
  includesTheorems : Bool
  deriving DecidableEq, Repr, BEq

def SlakeBootstrapTypecheck.ok (b : SlakeBootstrapTypecheck) : Bool :=
  b.bootstrapped && b.fullyTypechecks && b.includesTheorems

/-- Clause 4.2 item 7: conforming bootstrap typecheck includes theorems. -/
def bootstrapTypecheckIncludesTheorems : Bool := true

def bootstrapTypecheckDone : SlakeBootstrapTypecheck :=
  { bootstrapped := true, fullyTypechecks := true, includesTheorems := true }

def bootstrapMissing : SlakeBootstrapTypecheck :=
  { bootstrapped := false, fullyTypechecks := false, includesTheorems := false }

def bootstrapSubsetOnly : SlakeBootstrapTypecheck :=
  { bootstrapped := true, fullyTypechecks := false, includesTheorems := false }

def typecheckWithoutBootstrap : SlakeBootstrapTypecheck :=
  { bootstrapped := false, fullyTypechecks := true, includesTheorems := true }

/-- Typecheck without theorems is not a conforming bootstrap. -/
def bootstrapWithoutTheorems : SlakeBootstrapTypecheck :=
  { bootstrapped := true, fullyTypechecks := true, includesTheorems := false }

/-- Live product honesty: the required bootstrap typecheck is not claimed done. -/
def slakeBootstrapTypecheckClaimedDone : Bool := false

def mashSlakeBootstrapTypecheckClaimedDone : Prop :=
  slakeBootstrapTypecheckClaimedDone = true

def mashSlakeBootstrapTypecheckClaimedDoneIsFalse : Prop :=
  mashSlakeBootstrapTypecheckClaimedDone → False

/--
  Clause 4.2 item 7 last sentence: hosting from generated C does not
  satisfy the bootstrap typecheck step.
-/
def selfHostFromGeneratedCSatisfiesTypecheck : Bool := false

def mashSelfHostFromCSatisfiesBootstrap : Prop :=
  selfHostFromGeneratedCSatisfiesTypecheck = true

def mashSelfHostFromCSatisfiesBootstrapIsFalse : Prop :=
  mashSelfHostFromCSatisfiesBootstrap → False

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
  | .idris2 => (0 : Fin 3)
  | .lean4IncludingSystemsLean => (1 : Fin 3)
  | .pureNix => (2 : Fin 3)

def NovelLanguage.ofFin : Fin 3 → NovelLanguage
  | ⟨0, _⟩ => .idris2
  | ⟨1, _⟩ => .lean4IncludingSystemsLean
  | ⟨2, _⟩ => .pureNix

inductive ProductPath where
  | novel : NovelLanguage → ProductPath
  | freeFloatingShell : ProductPath
  deriving DecidableEq, Repr, BEq

def ProductPath.permitted : ProductPath → Bool
  | .novel _ => true
  | .freeFloatingShell => false

def allPathsPermitted (paths : List ProductPath) : Bool :=
  paths.all ProductPath.permitted

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

def allNamedStackTargeting : List NamedComponentClaim :=
  [ namedStackClaim .beastdbCore true
    , namedStackClaim .leanMachine true
    , namedStackClaim .ssssSafetyCritical true
    , namedStackClaim .fixOSVision true ]

def beastdbCannotTarget : List NamedComponentClaim :=
  [ namedStackClaim .beastdbCore false ]

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

def productWrongCompCertTool : ClaimedProduct :=
  { canonicalProduct with compCert := compCertWrongTool }

def productWrongCompCertEmit : ClaimedProduct :=
  { canonicalProduct with compCert := compCertWrongEmit }

def productBootstrapWithoutTheorems : ClaimedProduct :=
  { canonicalProduct with bootstrapTypecheck := bootstrapWithoutTheorems }

/-!
  Spec document identity: this spec is 0002; SSSSS is specified in
  0004_SSSSS.md (not 0002, not 0003). beastdb is specified in 0003_beastdb.md.
  Recursive Self Improvement is specified in 0006_RSI.md and is not a
  compiler requirement of this document. Lean Machine is specified in
  0013_Lean_Machine.md.
-/

def systemsLeanSpecNumber : Nat := SpecRegistry.systemsLeanSpecNumber

def ssssSpecNumber : Nat := SpecRegistry.ssssSpecNumber

def beastdbSpecNumber : Nat := SpecRegistry.beastdbSpecNumber

def beastdbSpecFileName : String := "0003_beastdb.md"

def rsiSpecNumber : Nat := SpecRegistry.rsiSpecNumber

/-- Clause 4.4 item 3: RSI is practice for specifications and agents, not a compiler requirement of 0002. -/
def rsiIsCompilerRequirement : Bool := false

def leanMachineSpecNumber : Nat := SpecRegistry.leanMachineSpecNumber

def leanMachineSpecFileName : String := "0013_Lean_Machine.md"

/-- Clause 4.3 item 2: CompCert retains its original license. It is not Unlicense. -/
def compCertIsUnlicense : Bool := false

/-- Clause 1.2: spec encodings of meaning are not a second markdown form checker. -/
def specCheckIsMeaningSpecEncoding : Bool := false

/-- Clause 6.3: byte identity of emit is required for a conforming product. -/
def byteIdentityRequiredForConformingProduct : Bool := true

/-- Clause 6.3: byte identity of emit is not claimed true of the live product. -/
def byteIdentityOfEmitClaimedTrue : Bool := false

/-- Clause 6: Systems Lean and Slake work is ongoing and is not ready for use. -/
def systemsLeanAndSlakeReadyForUse : Bool := false

/-- Clause 6: this document must not be read as claiming Systems Lean or Slake never started. -/
def systemsLeanAndSlakeNeverStarted : Bool := false

/-- Clause 4.3 item 2: agent skill packs must not live under the product tree `ref/`. -/
def skillPacksUnderProductRef : Bool := false

/-- Clause 4.3 item 4: pure Nix is required for build and packaging of novel components. -/
def pureNixRequiredForNovelPackaging : Bool := true

/--
  Live claimed done flags must stay false and must not equal the
  hypothetical conforming fixture CompCert and bootstrap Bools.
-/
def liveClaimedDoneEqualsCanonicalFixture : Bool :=
  (compCertVerifiedCompilationClaimedDone == canonicalProduct.compCert.ok) &&
    (slakeBootstrapTypecheckClaimedDone == canonicalProduct.bootstrapTypecheck.ok)

/-!
  Formal Vibefication science cycle (specification 0008). This meaning
  model requires hypothesis, model, theory, proof, tests, and corollary
  experiments. Tests are necessary and are not sufficient.
-/

def requiresScienceCycle : Bool := true

def testsWithoutModelFixture : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.testsWithoutModelFixture

def modelAndProofsWithoutExperimentsFixture : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

def completeScienceFixture : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.completeScienceFixture

def conformingScience (e : FormalVibeficationSpec.ScienceEffort) : Bool :=
  FormalVibeficationSpec.conformingScience e

def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

def testsWithoutModelDoesNotConform : Prop :=
  conformingScience testsWithoutModelFixture = false

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  conformingScience modelAndProofsWithoutExperimentsFixture = false

def completeScienceConforms : Prop :=
  conformingScience completeScienceFixture = true

/-!
  Clause 3.11 through 3.48 and Clause 4.5: Safe judgments.
  This module encodes names and Bool fixtures. It does not contain theorems.
-/

inductive SafeMem where
  | holds
  deriving DecidableEq, Repr, BEq

inductive SafeThr where
  | holds
  deriving DecidableEq, Repr, BEq

inductive SafeLayout where
  | holds
  deriving DecidableEq, Repr, BEq

inductive KernelModelOk where
  | holds
  deriving DecidableEq, Repr, BEq

inductive SafeKernel where
  | holds
  deriving DecidableEq, Repr, BEq

inductive CompCertFragment where
  | holds
  deriving DecidableEq, Repr, BEq

inductive CompCertRefines where
  | holds
  deriving DecidableEq, Repr, BEq

/-- Inhabiting `holds` is not a claim that a real emit was refined. -/
def compCertRefinesClaimedDone : Bool := false

def mashCompCertRefinesClaimedDone : Prop :=
  compCertRefinesClaimedDone = true

def mashCompCertRefinesClaimedDoneIsFalse : Prop :=
  mashCompCertRefinesClaimedDone → False

inductive SafeCompCert where
  | holds
  deriving DecidableEq, Repr, BEq

/-- SafeCompCert implies SafeKernel. Clause 3.18 and Clause 4.5 item 1. -/
def safeCompCertImpliesSafeKernel : SafeCompCert → SafeKernel :=
  fun _ => .holds

/-- The converse is False. SafeKernel does not imply SafeCompCert. -/
def safeKernelImpliesSafeCompCert : Bool := false

def mashSafeKernelImpliesSafeCompCert : Prop :=
  safeKernelImpliesSafeCompCert = true

def mashSafeKernelImpliesSafeCompCertIsFalse : Prop :=
  mashSafeKernelImpliesSafeCompCert → False

inductive RejectJudgment where
  | holds
  deriving DecidableEq, Repr, BEq

inductive FaultJudgment where
  | holds
  deriving DecidableEq, Repr, BEq

inductive StepState where
  | ok
  | fault
  deriving DecidableEq, Repr, BEq

/--
  Clause 3.22 companion fragment for `TyperSound`.
  Constructors are sample programs, not the product `typer`.
  Systems Lean remains not ready for use.
-/
inductive TyperFragment where
  /-- `CopyBits` of Bits: companion `typer` accepts; Step stays `ok`. -/
  | copyBitsOfBits
  /-- `UniqueBlock` `MoveOwner`: companion `typer` accepts; Step stays `ok`. -/
  | uniqueBlockMoveOwner
  /-- `UniqueBlock` `CopyHandle` without alias protocol: Reject; Step would Fault. -/
  | uniqueBlockCopyHandleNoProtocol
  /-- Heap omega as owner: Reject; Step would Fault. -/
  | heapOmegaAsOwner
  deriving DecidableEq, Repr, BEq

/-- True when the companion `typer` accepts. False is Reject before emit. -/
def typerAccepts : TyperFragment → Bool
  | .copyBitsOfBits => true
  | .uniqueBlockMoveOwner => true
  | .uniqueBlockCopyHandleNoProtocol => false
  | .heapOmegaAsOwner => false

/-- Companion Step on the fragment. Rejected programs would reach Fault. -/
def typerStep : TyperFragment → StepState
  | .copyBitsOfBits => .ok
  | .uniqueBlockMoveOwner => .ok
  | .uniqueBlockCopyHandleNoProtocol => .fault
  | .heapOmegaAsOwner => .fault

/--
  Clause 3.22: if the companion `typer` accepts, Step does not reach Fault.
  This is not a claim that the product `typer` is done.
-/
def typerSoundImplication : Prop :=
  ∀ p, typerAccepts p = true → typerStep p ≠ StepState.fault

def typerSoundNamed : Bool := true

/--
  Companion fragment implication is proved. Product `typer` is not done.
  Full product `TyperSound` still lags (Clause 6.4). A hole is not success.
-/
def typerSoundImplicationProved : Bool := true

def panicFreeNamed : Bool := true

def panicFreeAotNamed : Bool := true

/--
  Companion fragment implication is proved. The product AOT path is not
  done. A hole is not success.
-/
def panicFreeAotImplicationProved : Bool := true

def panicFreeImpliesSafeMem : Bool := false

/-!
  Clause 3.23 and Clause 3.24: PanicFree and the named PanicFreeAOT
  implication on a companion fragment. Allocation failure and a hardware
  fault are not panics. PanicFreeAOT is not TyperSound. The product AOT
  path is not done.
-/

inductive PanicFreeFragment where
  /-- PanicFree holds. Execution does not panic. -/
  | typedPathNoPanic
  /-- PanicFree does not hold. Execution would panic. -/
  | reachableUnwrap
  /-- PanicFree may still hold. Allocation failure is not a panic. -/
  | allocationFailure
  /-- PanicFree may still hold. A hardware fault is not a panic. -/
  | hardwareFault
  deriving DecidableEq, Repr, BEq

def panicFreeHolds : PanicFreeFragment → Bool
  | .typedPathNoPanic => true
  | .reachableUnwrap => false
  | .allocationFailure => true
  | .hardwareFault => true

inductive PanicOutcome where
  | ok
  | panic
  | allocFail
  | hardwareFault
  deriving DecidableEq, Repr, BEq

def panicFreeExec : PanicFreeFragment → PanicOutcome
  | .typedPathNoPanic => .ok
  | .reachableUnwrap => .panic
  | .allocationFailure => .allocFail
  | .hardwareFault => .hardwareFault

/--
  Clause 3.24: if PanicFree holds, execution does not reach a panic.
  Companion fragment only. The product AOT path is not done.
-/
def panicFreeAotImplication : Prop :=
  ∀ p, panicFreeHolds p = true → panicFreeExec p ≠ PanicOutcome.panic

inductive UniqueBlock where
  | holds
  deriving DecidableEq, Repr, BEq

inductive CopyHandle where
  | holds
  deriving DecidableEq, Repr, BEq

def uniqueBlockDefaultRcHeader : Bool := false

def uniqueBlockCopyHandleWithoutProtocolAccepted : Bool := false

def mashUniqueBlockCopyHandleNoProtocol : Prop :=
  uniqueBlockCopyHandleWithoutProtocolAccepted = true

def mashUniqueBlockCopyHandleNoProtocolIsFalse : Prop :=
  mashUniqueBlockCopyHandleNoProtocol → False

inductive Secret where
  | holds
  deriving DecidableEq, Repr, BEq

inductive ObjectCow where
  | holds
  deriving DecidableEq, Repr, BEq

inductive PageCow where
  | holds
  deriving DecidableEq, Repr, BEq

/-- Clause 3.40: the PageCow copy is one 4096 byte page. -/
def pageCowCopyBytes : Nat := 4096

/-- Clause 3.40: the PageCow sector is 4096 bytes. -/
def pageCowSectorBytes : Nat := 4096

/-- Clause 3.40: a larger hardware page is allowed for the one client. -/
def pageCowLargerHardwarePageAllowed : Bool := true

/-- That larger hardware page is not a second copy. The copy stays one 4096 byte page. -/
def pageCowLargerPageIsSecondCopy : Bool := false

def secretObjectCowAccepted : Bool := false

def mashSecretObjectCow : Prop :=
  secretObjectCowAccepted = true

def mashSecretObjectCowIsFalse : Prop :=
  mashSecretObjectCow → False

def secretPageCowAccepted : Bool := false

def mashSecretPageCow : Prop :=
  secretPageCowAccepted = true

def mashSecretPageCowIsFalse : Prop :=
  mashSecretPageCow → False

def compCertFragmentContainerOfAccepted : Bool := false

def mashCompCertFragmentContainerOf : Prop :=
  compCertFragmentContainerOfAccepted = true

def mashCompCertFragmentContainerOfIsFalse : Prop :=
  mashCompCertFragmentContainerOf → False

def panicFreeReachableUnwrapAccepted : Bool := false

def mashPanicFreeReachableUnwrap : Prop :=
  panicFreeReachableUnwrapAccepted = true

def mashPanicFreeReachableUnwrapIsFalse : Prop :=
  mashPanicFreeReachableUnwrap → False

def compCertFragmentInlineAsmAccepted : Bool := false

def mashCompCertFragmentInlineAsm : Prop :=
  compCertFragmentInlineAsmAccepted = true

def mashCompCertFragmentInlineAsmIsFalse : Prop :=
  mashCompCertFragmentInlineAsm → False

def linkFaceExportsUniqueBlockAsBitsAccepted : Bool := false

def mashLinkFaceExportsUniqueBlockAsBits : Prop :=
  linkFaceExportsUniqueBlockAsBitsAccepted = true

def mashLinkFaceExportsUniqueBlockAsBitsIsFalse : Prop :=
  mashLinkFaceExportsUniqueBlockAsBits → False

def languageOmegaOnHeapOwnerAccepted : Bool := false

def mashLanguageOmegaOnHeapOwner : Prop :=
  languageOmegaOnHeapOwnerAccepted = true

def mashLanguageOmegaOnHeapOwnerIsFalse : Prop :=
  mashLanguageOmegaOnHeapOwner → False

def uniqueOnlyPosixForkAccepted : Bool := false

def mashUniqueOnlyPosixFork : Prop :=
  uniqueOnlyPosixForkAccepted = true

def mashUniqueOnlyPosixForkIsFalse : Prop :=
  mashUniqueOnlyPosixFork → False

def safeMemNonAtomicDataRaceAccepted : Bool := false

def mashSafeMemNonAtomicDataRace : Prop :=
  safeMemNonAtomicDataRaceAccepted = true

def mashSafeMemNonAtomicDataRaceIsFalse : Prop :=
  mashSafeMemNonAtomicDataRace → False

def lockFreeFreeWithoutReclamationAccepted : Bool := false

def mashLockFreeFreeWithoutReclamation : Prop :=
  lockFreeFreeWithoutReclamationAccepted = true

def mashLockFreeFreeWithoutReclamationIsFalse : Prop :=
  mashLockFreeFreeWithoutReclamation → False

def rwLockSharedAndExclusiveAccepted : Bool := false

def mashRwLockSharedAndExclusive : Prop :=
  rwLockSharedAndExclusiveAccepted = true

def mashRwLockSharedAndExclusiveIsFalse : Prop :=
  mashRwLockSharedAndExclusive → False

def copyHandleLockTokenAccepted : Bool := false

def mashCopyHandleLockToken : Prop :=
  copyHandleLockTokenAccepted = true

def mashCopyHandleLockTokenIsFalse : Prop :=
  mashCopyHandleLockToken → False

def casUniqueBlockPointerAccepted : Bool := false

def mashCasUniqueBlockPointer : Prop :=
  casUniqueBlockPointerAccepted = true

def mashCasUniqueBlockPointerIsFalse : Prop :=
  mashCasUniqueBlockPointer → False

def casNonAtomicCellAccepted : Bool := false

def mashCasNonAtomicCell : Prop :=
  casNonAtomicCellAccepted = true

def mashCasNonAtomicCellIsFalse : Prop :=
  mashCasNonAtomicCell → False

def threadSharedIsProcessShared : Bool := false

def mashThreadSharedIsProcessShared : Prop :=
  threadSharedIsProcessShared = true

def mashThreadSharedIsProcessSharedIsFalse : Prop :=
  mashThreadSharedIsProcessShared → False

def posixForkIsForkJoin : Bool := false

def mashPosixForkIsForkJoin : Prop :=
  posixForkIsForkJoin = true

def mashPosixForkIsForkJoinIsFalse : Prop :=
  mashPosixForkIsForkJoin → False

def posixForkIsBorrowOrOwned : Bool := false

def mashPosixForkIsBorrowOrOwned : Prop :=
  posixForkIsBorrowOrOwned = true

def mashPosixForkIsBorrowOrOwnedIsFalse : Prop :=
  mashPosixForkIsBorrowOrOwned → False

def secretCopyIntoNonSecretAccepted : Bool := false

def mashSecretCopyIntoNonSecret : Prop :=
  secretCopyIntoNonSecretAccepted = true

def mashSecretCopyIntoNonSecretIsFalse : Prop :=
  mashSecretCopyIntoNonSecret → False

def secretDontForkPosixForkAccepted : Bool := false

def mashSecretDontForkPosixFork : Prop :=
  secretDontForkPosixForkAccepted = true

def mashSecretDontForkPosixForkIsFalse : Prop :=
  mashSecretDontForkPosixFork → False

def onceImpliesUniqueBlock : Bool := false

def mashOnceImpliesUniqueBlock : Prop :=
  onceImpliesUniqueBlock = true

def mashOnceImpliesUniqueBlockIsFalse : Prop :=
  mashOnceImpliesUniqueBlock → False

def syscallDurabilityIsBeastdbAcid : Bool := false

def mashSyscallDurabilityIsBeastdbAcid : Prop :=
  syscallDurabilityIsBeastdbAcid = true

def mashSyscallDurabilityIsBeastdbAcidIsFalse : Prop :=
  mashSyscallDurabilityIsBeastdbAcid → False

def beastdbPropsConsWithoutAttachAccepted : Bool := false

def mashBeastdbPropsConsWithoutAttach : Prop :=
  beastdbPropsConsWithoutAttachAccepted = true

def mashBeastdbPropsConsWithoutAttachIsFalse : Prop :=
  mashBeastdbPropsConsWithoutAttach → False

def tsxIsBeastdbAcid : Bool := false

def mashTsxIsBeastdbAcid : Prop :=
  tsxIsBeastdbAcid = true

def mashTsxIsBeastdbAcidIsFalse : Prop :=
  mashTsxIsBeastdbAcid → False

/-- Clause 6.4 item 80: grok-oss is not SafeC. -/
def grokOssIsSafeC : Bool := false

def mashGrokOssIsSafeC : Prop :=
  grokOssIsSafeC = true

def mashGrokOssIsSafeCIsFalse : Prop :=
  mashGrokOssIsSafeC → False

/-- Clause 6.4 item 76: the page cache is not RCU, and RCU is not the page cache. -/
def pageCacheIsRcu : Bool := false

def mashPageCacheIsRcu : Prop :=
  pageCacheIsRcu = true

def mashPageCacheIsRcuIsFalse : Prop :=
  mashPageCacheIsRcu → False

/-- Clause 3.47, Clause 4.5 item 9, and Clause 6.4 item 70: a crate that finished only Gate A is not Safe. -/
def gateACrateIsSafe : Bool := false

def mashGateACrateIsSafe : Prop :=
  gateACrateIsSafe = true

def mashGateACrateIsSafeIsFalse : Prop :=
  mashGateACrateIsSafe → False

/-- Clause 6.4 item 29: CHERI or MTE tagging does not replace UniqueBlock. -/
def hardwareTagReplacesUniqueBlock : Bool := false

def mashHardwareTagReplacesUniqueBlock : Prop :=
  hardwareTagReplacesUniqueBlock = true

def mashHardwareTagReplacesUniqueBlockIsFalse : Prop :=
  mashHardwareTagReplacesUniqueBlock → False

/-- Clause 6.4 item 66: automatic vectorization is not a SIMD proof. -/
def autovectorizationIsSimdProof : Bool := false

def mashAutovectorizationIsSimdProof : Prop :=
  autovectorizationIsSimdProof = true

def mashAutovectorizationIsSimdProofIsFalse : Prop :=
  mashAutovectorizationIsSimdProof → False

/-- Clause 6.4 item 41: a theorem named Perfect or ProvablyPerfect is not accepted. One fixture covers both banned names. -/
def perfectTheoremNameAccepted : Bool := false

def mashPerfectTheoremName : Prop :=
  perfectTheoremNameAccepted = true

def mashPerfectTheoremNameIsFalse : Prop :=
  mashPerfectTheoremName → False

/-- Clause 6.4 item 49: a typed link input is not claimed proved. -/
def typedLinkInputClaimedProved : Bool := false

def mashTypedLinkInputClaimedProved : Prop :=
  typedLinkInputClaimedProved = true

def mashTypedLinkInputClaimedProvedIsFalse : Prop :=
  mashTypedLinkInputClaimedProved → False

/-- Clause 6.4 item 49: Cons on every export is not claimed proved. -/
def consOnEveryExportClaimedProved : Bool := false

def mashConsOnEveryExportClaimedProved : Prop :=
  consOnEveryExportClaimedProved = true

def mashConsOnEveryExportClaimedProvedIsFalse : Prop :=
  mashConsOnEveryExportClaimedProved → False

/-- Clause 6.4 item 48: the memcpy equation is not a present theorem. -/
def memcpyEquationPresentTheorem : Bool := false

def mashMemcpyEquationPresentTheorem : Prop :=
  memcpyEquationPresentTheorem = true

def mashMemcpyEquationPresentTheoremIsFalse : Prop :=
  mashMemcpyEquationPresentTheorem → False

/-- Clause 6.4 items 42 and 46: AtomicCell, AtomicTxn, UsesLock, and LockHandled are named and are not present theories. -/
def namedResidualIdentifiersPresentTheories : Bool := false

def mashNamedResidualIdentifiersPresentTheories : Prop :=
  namedResidualIdentifiersPresentTheories = true

def mashNamedResidualIdentifiersPresentTheoriesIsFalse : Prop :=
  mashNamedResidualIdentifiersPresentTheories → False

def namedResidualIdentifiers : List String :=
  ["AtomicCell", "AtomicTxn", "UsesLock", "LockHandled"]

inductive PassingMode where
  | copyBits
  | moveOwner
  | loanShared
  | loanMut
  | copyHandle
  deriving DecidableEq, Repr, BEq

def PassingMode.toFin : PassingMode → Fin 5
  | .copyBits => (0 : Fin 5)
  | .moveOwner => (1 : Fin 5)
  | .loanShared => (2 : Fin 5)
  | .loanMut => (3 : Fin 5)
  | .copyHandle => (4 : Fin 5)

def PassingMode.ofFin : Fin 5 → PassingMode
  | ⟨0, _⟩ => .copyBits
  | ⟨1, _⟩ => .moveOwner
  | ⟨2, _⟩ => .loanShared
  | ⟨3, _⟩ => .loanMut
  | ⟨4, _⟩ => .copyHandle

inductive SafeProfile where
  | hostedLinuxLibc
  | libcOnly
  | fargoLlvm
  | freestandingKernel
  deriving DecidableEq, Repr, BEq

def heapOmegaAsOwnerRejected : Bool := true

def bitsTrivialIsCopyBits : Bool := true

def heapOmegaRejectCollapsedIntoBitsTrivial : Bool := false

def fargoHasSpecNumber : Bool := false

inductive FargoGate where
  | a
  | b
  | c
  | d
  | e
  | f
  deriving DecidableEq, Repr, BEq

def fargoGatesAreCorrespondenceObligations : Bool := true

def llvmCcPathCalledCompCertProved : Bool := false

def slakePrimaryEmitIsFreestandingC : Bool := true

def hostedLinuxLibcReplacesPrimaryEmit : Bool := false

def safeCtOnByDefault : Bool := false

def lockFreeMeansMutexAbsent : Bool := false

def lockFreeMeansCompareAndSwap : Bool := false

def acidIsCompareAndSwap : Bool := false

def beastdbAcidOwnedBySpec0003 : Bool := true

def posixForkIsPageCow : Bool := true

def posixForkIsObjectCow : Bool := false

def correspondenceRequiredBeforeIsomorphism : Bool := true

/-- Clause 3.47: Fargo gates A through F. Adding a seventh constructor breaks Fin 6. -/
def FargoGate.toFin : FargoGate → Fin 6
  | .a => (0 : Fin 6)
  | .b => (1 : Fin 6)
  | .c => (2 : Fin 6)
  | .d => (3 : Fin 6)
  | .e => (4 : Fin 6)
  | .f => (5 : Fin 6)

def FargoGate.ofFin : Fin 6 → FargoGate
  | ⟨0, _⟩ => .a
  | ⟨1, _⟩ => .b
  | ⟨2, _⟩ => .c
  | ⟨3, _⟩ => .d
  | ⟨4, _⟩ => .e
  | ⟨5, _⟩ => .f

/-- Clause 3.52: correspondence maps are statements, not an isomorphism theorem. -/
inductive RustJudgment where
  | sample
  deriving DecidableEq, Repr, BEq

inductive SafeCJudgment where
  | sample
  deriving DecidableEq, Repr, BEq

def correspondsNamed : Bool := true

def toSafeC : RustJudgment → Option SafeCJudgment
  | .sample => none

def toRust : SafeCJudgment → Option RustJudgment
  | .sample => none

def correspondenceMapsAreStatements : Bool := true

def isomorphismTheoremNameAccepted : Bool := false

def mashIsomorphismTheoremName : Prop :=
  isomorphismTheoremNameAccepted = true

def mashIsomorphismTheoremNameIsFalse : Prop :=
  mashIsomorphismTheoremName → False

/-- Clause 3.53: named C UbClass constructors. The product Fault table is not complete. -/
inductive UbClass where
  | signedOverflow
  | uninitAutomatic
  | useAfterFree
  | doubleFree
  | oobPointer
  | dataRace
  | strictAliasing
  | restrictViolation
  | invalidFree
  | unsequencedSideEffect
  | shiftExponentOutOfRange
  | nullDeref
  | pointerProvenance
  | gnuVlaOrStatementExpr
  | memcpyOverlap
  | reallocOldPointer
  deriving DecidableEq, Repr, BEq

def UbClass.toFin : UbClass → Fin 16
  | .signedOverflow => (0 : Fin 16)
  | .uninitAutomatic => (1 : Fin 16)
  | .useAfterFree => (2 : Fin 16)
  | .doubleFree => (3 : Fin 16)
  | .oobPointer => (4 : Fin 16)
  | .dataRace => (5 : Fin 16)
  | .strictAliasing => (6 : Fin 16)
  | .restrictViolation => (7 : Fin 16)
  | .invalidFree => (8 : Fin 16)
  | .unsequencedSideEffect => (9 : Fin 16)
  | .shiftExponentOutOfRange => (10 : Fin 16)
  | .nullDeref => (11 : Fin 16)
  | .pointerProvenance => (12 : Fin 16)
  | .gnuVlaOrStatementExpr => (13 : Fin 16)
  | .memcpyOverlap => (14 : Fin 16)
  | .reallocOldPointer => (15 : Fin 16)

def toFault : UbClass → Option FaultJudgment
  | _ => none

def fromCNamed : Bool := true

def ubClassProductTableComplete : Bool := false

/-- Clause 3.54: a pin of an address does not survive PosixFork. -/
def pinSurvivesPosixFork : Bool := false

def mashPinSurvivesPosixFork : Prop :=
  pinSurvivesPosixFork = true

def mashPinSurvivesPosixForkIsFalse : Prop :=
  mashPinSurvivesPosixFork → False

/-- Clause 4.5 item 16: glibc malloc is not UniqueBlock against untyped C. -/
def glibcMallocIsUniqueBlockUntyped : Bool := false

def mashGlibcMallocUntypedUniqueBlock : Prop :=
  glibcMallocIsUniqueBlockUntyped = true

def mashGlibcMallocUntypedUniqueBlockIsFalse : Prop :=
  mashGlibcMallocUntypedUniqueBlock → False

/-- Clause 4.5 item 12: a file that lacks a Mutex is not LockFree. -/
def mutexFreeFileIsLockFree : Bool := false

def mashMutexFreeFileIsLockFree : Prop :=
  mutexFreeFileIsLockFree = true

def mashMutexFreeFileIsLockFreeIsFalse : Prop :=
  mashMutexFreeFileIsLockFree → False

/-- Clause 3.57: twenty three Reject fixtures. Pass fixtures stay residual. -/
def rejectFixtureCount : Nat := 23

def safeCLakePackageShippedInThisRepo : Bool := false

def number0015Assigned : Bool := false

/-- Clause 6.4 item 90: Holy Lean, SafeC, and Lean Machine are not one module. -/
def holyLeanSafeCLeanMachineOneModule : Bool := false

def mashHolyLeanSafeCLeanMachine : Prop :=
  holyLeanSafeCLeanMachineOneModule = true

def mashHolyLeanSafeCLeanMachineIsFalse : Prop :=
  mashHolyLeanSafeCLeanMachine → False

/-- Clause 6.4 items 4 and 5: this document does not create a numbered SafeC file. -/
def createsNumberedSafeCFile : Bool := false

/-- SafeC is not its own published specification number. Clause 6.4 item 5. -/
def safeCIsOwnPublishedSpecNumber : Bool := false

def mashSafeCIsOwnPublishedSpecNumber : Prop :=
  safeCIsOwnPublishedSpecNumber = true

def mashSafeCIsOwnPublishedSpecNumberIsFalse : Prop :=
  mashSafeCIsOwnPublishedSpecNumber → False

/-- SafeC is carried by Systems Lean, specification 0002.
    Number 0015 stays unassigned. fargo stays unnumbered. -/
def safeCCarriedBySystemsLean : Bool :=
  systemsLeanSpecNumber == 2 &&
    !safeCIsOwnPublishedSpecNumber &&
    !number0015Assigned &&
    !SpecRegistry.fargoAssigned

/-- Sampled v28 tokens that MUST appear in 0002 markdown (or residual). Nearby different words do not count. -/
def v28SilenceTokens : List String :=
  [ "Perfect"
  , "ProvablyPerfect"
  , "AtomicCell"
  , "AtomicTxn"
  , "UsesLock"
  , "LockHandled"
  , "LinkFace"
  , "Props"
  , "memcpy equation"
  , "shift exponent out of range"
  , "sleanify observation list"
  , "Slake is not its own repository"
  , "Rust atomic types map to AtomicCell"
  , "default trait object fat pointer fields"
  , "CAS on UniqueBlock pointer Reject"
  , "CAS on non-AtomicCell Reject"
  ]

def v28SilenceTokenCount : Nat := 16

def v28SilenceTokensNamedIn (hay : String) : Bool :=
  v28SilenceTokens.all (fun t => hay.contains t)


/-- Remaining silent v28 phrases that MUST appear in 0002 markdown. Nearby different words do not count. -/
def v28RemainingSilenceTokens : List String :=
  [ "framing, locks, FDs, and UAF"
  , "residual means no model yet"
  , "C representation padding first"
  , "not all of rustc"
  , "Linux once and smp helpers"
  , "every lock name is named"
  , "Phase 0 pair"
  , "glossary as inductives"
  , "glossary words do not clash"
  ]

def v28RemainingSilenceTokenCount : Nat := 9

def v28RemainingSilenceTokensNamedIn (hay : String) : Bool :=
  v28RemainingSilenceTokens.all (fun t => hay.contains t)

/-!
  SafeC depth. Clause 6.4 item 3, Clause 1, Clause 3.21, Clause 3.40,
  Clause 3.46, and Clause 4.5 item 5. Encodings only. Proofs are separate.
-/

/-- A ref pin freezes an external text and proofs are built from that text. -/
def refPinFreezesExternalText : Bool := true

/-- The emit standard is freestanding ISO C. The pin file is absent. -/
def emitStandardIsFreestandingIsoC : Bool := true

/-- The pin file is absent because the license forbids storing the PDF. -/
def isoCPinFileAbsentLicenseForbids : Bool := true

/-- ISO catalog number for ISO/IEC 9899:2024. -/
def isoCCatalogNumber : Nat := 82075

/-- Edition of ISO/IEC 9899:2024. -/
def isoCEdition : Nat := 5

/-- One client is in scope. Ten thousand and ten million concurrent clients are not. -/
def oneClientInScope : Bool := true

def tenThousandConcurrentClientsInScope : Bool := false

def tenMillionConcurrentClientsInScope : Bool := false

/-- Meeting the one client aim is not claimed. -/
def oneClientAimMet : Bool := false

def linuxKernelMemoryModelRequired : Bool := true

def cMemoryModelRequired : Bool := true

def cxxMemoryModelRequired : Bool := true

/-- One LLVM IR that Rust and Linux kernel C both accept for layout and virtual tables. -/
def llvmIrMemoryAndVtableCompatible : Bool := true

def systemsLeanFirstClassOnThatIr : Bool := true

/-- This document does not invent an LLVM version number. -/
def llvmVersionInvented : Bool := false

/-- A running kernel is not claimed verified. -/
def runningKernelVerified : Bool := false

structure LiveUpdateLayout where
  updatedCodeConsistent : Bool
  programsInFlightConsistent : Bool
  deriving DecidableEq, Repr

def liveUpdateLayoutsConsistent (u : LiveUpdateLayout) : Bool :=
  u.updatedCodeConsistent && u.programsInFlightConsistent

/-- A restart is required only when the two layouts do not both stay consistent. -/
def restartRequired (u : LiveUpdateLayout) : Bool :=
  !liveUpdateLayoutsConsistent u

/-- iris-lean is not required and is not a dependency. -/
def irisLeanRequired : Bool := false

/-- The typer target on the companion fragment is this document's Step. -/
def typerMatchTarget : TyperFragment → StepState :=
  typerStep

/-- When a profile turns SafeCt on, timing does not depend on Secret. -/
def safeCtTimingCarriesSecret : Bool := false

/-- When a profile turns SafeCt on, cache behavior does not depend on Secret. -/
def safeCtCacheCarriesSecret : Bool := false

/-- When a profile turns SafeCt on, page faults do not depend on Secret. -/
def safeCtPageFaultCarriesSecret : Bool := false

/-- The three channels depend on Secret only when a carry flag is true. -/
def safeCtChannelsDependOnSecret : Bool :=
  safeCtTimingCarriesSecret || safeCtCacheCarriesSecret ||
    safeCtPageFaultCarriesSecret

/-- Failure to be constant time is not the SafeCt switch. -/
def notConstantTimeIsSafeCtSwitch : Bool := false

/-- A canonical public GitHub organization is out of scope for this one client system. -/
def canonicalPublicGitHubOrgInScope : Bool := false

/-- Clause 3.35 and Clause 6.4 item 20. SeqLock is named. Lock order is not claimed. -/
def seqLockNamed : Bool := true

def futexIsAtomicOnProcessSharedOrKernelWord : Bool := true

def lockOrderClaimed : Bool := false

/-- Clause 6.4 item 32. -/
def pthreadUnlockIsSafeKernel : Bool := true

def unlockWithoutHoldReject : Bool := true

/-- Clause 6.4 items 58, 64, 67, 73, 81, and 84. -/
def mapModesSharedPrivateAnonNamed : Bool := true

def swmrAndMwmrAreStructureModes : Bool := true

def c11AndCxxDataRaceRejectOrFault : Bool := true

def checkBytesBeforeView : Bool := true

def consLayersOnNamedJudgments : Bool := true

def copyHandleWithoutProtocolIsUafClass : Bool := true

def compCertExcludedUbClassRejectBeforeCcomp : Bool := true

def consAndUbClassImplyConstantTime : Bool := false

def sleanifySkillShipped : Bool := false

def leanMachineReadyForUse : Bool := false

def v28PackageNamesHostedAsDefault : Bool := true

def integerOverflowSplitNamed : Bool := true

def safeClaimWithSignedOverflowIsConsClash : Bool := true

def phase0PairIsLockTokenAndAffineUnlock : Bool := true

def reproduceStep1NamesArtifactKinds : Bool := true

def inconsistencyReportPackageModuleCreatedHere : Bool := false

/-- Clause 3 and Clause 6.4. Remaining v28 glossary rules captured in prose. -/
def systemsLeanFollowsShapeOfRust : Bool := true

def makeMutDenotesObjectCow : Bool := true

def uniqueBlockRequiresEveryPageUnique : Bool := true

def freestandingSectionNamed : Bool := true

def glossaryWordAddedBeforeUse : Bool := true

def reachablePanicIsReject : Bool := true

def listEntryIsSafeKernel : Bool := true

def blockRegionKindsNamed : Bool := true

def immortalStorageNeverFreed : Bool := true

def arenaChildFreeIsReject : Bool := true

def addressWordNamesBlock : Bool := true

def seqLockReadersSnapshotAndRetry : Bool := true

def referenceCountOnlyAsCountedProtocol : Bool := true

def abaToolsNamed : Bool := true

def checkBytesIsNotSerde : Bool := true

def dataRaceHasNoHappensBefore : Bool := true

def tcbShrinkReplacesSameAbi : Bool := true

def layoutPinRecordsWidths : Bool := true

def clientsMustNotObserveLeakedExclusion : Bool := true

end SystemsLean
