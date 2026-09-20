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
  | .erased => ⟨0, by decide⟩
  | .once => ⟨1, by decide⟩
  | .unrestricted => ⟨2, by decide⟩

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
  | .idris2 => ⟨0, by decide⟩
  | .lean4IncludingSystemsLean => ⟨1, by decide⟩
  | .pureNix => ⟨2, by decide⟩

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

end SystemsLean
