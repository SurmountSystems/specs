/-
  Companion Lean model of selected claims from 0003_beastdb.md.

  This module is not the specification. The numbered markdown is the contract
  people read. spec_check remains the form checker (ASCII, tabs, RFC 2119,
  spelling). SpecRegistry remains the number and file name registry. These
  declarations encode meaning so an inconsistent model is a type error or a
  failing test.
-/

import SystemsLean
import SpecRegistry

namespace BeastDb

open SystemsLean

def productName : String := "beastdb"

def libraryName : String := "libbeastdb"

def specNumber : Nat := SpecRegistry.beastdbSpecNumber

def specFileName : String := "0003_beastdb.md"

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def specClaimsImplementationExists : Bool := false

/-!
  Clause 4.1: Systems Lean core, Slake freestanding library, bootstrap
  typecheck, CompCert. Subset typecheck is not enough.
-/

structure LanguageClaim where
  product : String
  library : String
  writtenInSystemsLean : Bool
  slake : SlakeProduct
  wire : FreestandingWire
  bootstrap : SlakeBootstrapTypecheck
  compCert : CompCertValidation
  deriving Repr

def LanguageClaim.ok (c : LanguageClaim) : Bool :=
  (c.product == productName) &&
    (c.library == libraryName) &&
    c.writtenInSystemsLean &&
    c.slake.conforming &&
    c.wire.ok &&
    c.bootstrap.ok &&
    c.compCert.ok

def languageCanonical : LanguageClaim :=
  { product := productName
    library := libraryName
    writtenInSystemsLean := true
    slake := slakeCanonical
    wire := cleanWire
    bootstrap := bootstrapTypecheckDone
    compCert := compCertPerformed }

def languageWrongName : LanguageClaim :=
  { languageCanonical with product := "BeastDB" }

def languageWrongLibrary : LanguageClaim :=
  { languageCanonical with library := "LibBeastDB" }

def languageSubsetTypecheck : LanguageClaim :=
  { languageCanonical with bootstrap := bootstrapSubsetOnly }

def languageMissingBootstrap : LanguageClaim :=
  { languageCanonical with bootstrap := bootstrapMissing }

def languageMissingCompCert : LanguageClaim :=
  { languageCanonical with compCert := compCertMissing }

def languageGcWire : LanguageClaim :=
  { languageCanonical with wire := gcWire }

/-!
  Clause 4.2: proven ACID, tries that do not use locks, SWMR required, more than
  one writer on disjoint leaves optional (MAY), fencing by generation required.
-/

structure ConcurrencyClaim where
  provenAcid : Bool
  lockFreeTries : Bool
  swmr : Bool
  generationFenced : Bool
  multiWriterDisjointLeaves : Bool
  deriving DecidableEq, Repr, BEq

/-- Multi writer is ignored by the required conjuncts (MAY). -/
def ConcurrencyClaim.requiredOk (c : ConcurrencyClaim) : Bool :=
  c.provenAcid && c.lockFreeTries && c.swmr && c.generationFenced

def multiWriterRequiredForConformance : Bool := false

def concurrencyCanonical : ConcurrencyClaim :=
  { provenAcid := true
    lockFreeTries := true
    swmr := true
    generationFenced := true
    multiWriterDisjointLeaves := false }

def concurrencyWithMultiWriter : ConcurrencyClaim :=
  { concurrencyCanonical with multiWriterDisjointLeaves := true }

def concurrencyNoAcid : ConcurrencyClaim :=
  { concurrencyCanonical with provenAcid := false }

def concurrencyLockedTrie : ConcurrencyClaim :=
  { concurrencyCanonical with lockFreeTries := false }

def concurrencyNoSwmr : ConcurrencyClaim :=
  { concurrencyCanonical with swmr := false }

def concurrencyNoFence : ConcurrencyClaim :=
  { concurrencyCanonical with generationFenced := false }

/-!
  Clause 4.3: mmap, SIMD, zerocopy, LanguageID, WordID, Rosetta.
-/

structure LayoutClaim where
  mmap : Bool
  simd : Bool
  zerocopy : Bool
  languageId : Bool
  wordId : Bool
  rosetta : Bool
  deriving DecidableEq, Repr, BEq

def LayoutClaim.ok (l : LayoutClaim) : Bool :=
  l.mmap && l.simd && l.zerocopy && l.languageId && l.wordId && l.rosetta

def layoutCanonical : LayoutClaim :=
  { mmap := true
    simd := true
    zerocopy := true
    languageId := true
    wordId := true
    rosetta := true }

def layoutNoMmap : LayoutClaim :=
  { layoutCanonical with mmap := false }

/-!
  Clause 4.4: schema mandatory, two modes, every migration proven.
-/

inductive SchemaMode where
  | predefined
  | inferred
  deriving DecidableEq, Repr, BEq

def SchemaMode.toFin : SchemaMode → Fin 2
  | .predefined => ⟨0, by decide⟩
  | .inferred => ⟨1, by decide⟩

def SchemaMode.ofFin : Fin 2 → SchemaMode
  | ⟨0, _⟩ => .predefined
  | ⟨1, _⟩ => .inferred

def SchemaMode.all : List SchemaMode :=
  [.predefined, .inferred]

structure SchemaClaim where
  mandatory : Bool
  predefined : Bool
  inferred : Bool
  inferredBecomesDeclared : Bool
  everyMigrationProven : Bool
  deriving DecidableEq, Repr, BEq

def SchemaClaim.ok (s : SchemaClaim) : Bool :=
  s.mandatory && s.predefined && s.inferred && s.inferredBecomesDeclared &&
    s.everyMigrationProven

def schemaCanonical : SchemaClaim :=
  { mandatory := true
    predefined := true
    inferred := true
    inferredBecomesDeclared := true
    everyMigrationProven := true }

def schemaOptional : SchemaClaim :=
  { schemaCanonical with mandatory := false }

def schemaOneMode : SchemaClaim :=
  { schemaCanonical with inferred := false }

def schemaUnprovenMigration : SchemaClaim :=
  { schemaCanonical with everyMigrationProven := false }

/-!
  Clause 4.5: ordered KV, time series, vector; fargo not traditional FFI.
-/

inductive CompatibilityPath where
  | fargo
  | traditionalForeignFunctionInterface
  deriving DecidableEq, Repr, BEq

def CompatibilityPath.permitted : CompatibilityPath → Bool
  | .fargo => true
  | .traditionalForeignFunctionInterface => false

structure AccessClaim where
  orderedKeyValue : Bool
  timeSeries : Bool
  vector : Bool
  compatibility : CompatibilityPath
  deriving Repr

def AccessClaim.ok (a : AccessClaim) : Bool :=
  a.orderedKeyValue && a.timeSeries && a.vector && a.compatibility.permitted

def accessCanonical : AccessClaim :=
  { orderedKeyValue := true
    timeSeries := true
    vector := true
    compatibility := .fargo }

def accessTraditionalFfi : AccessClaim :=
  { accessCanonical with compatibility := .traditionalForeignFunctionInterface }

def accessNoVector : AccessClaim :=
  { accessCanonical with vector := false }

/-!
  Clause 4.6: REQUIRED durable store for SSSSS; high assurance persistent
  storage targets libbeastdb.
-/

structure StackRoleClaim where
  requiredForSsss : Bool
  highAssuranceTargetsLib : Bool
  deriving DecidableEq, Repr, BEq

def StackRoleClaim.ok (s : StackRoleClaim) : Bool :=
  s.requiredForSsss && s.highAssuranceTargetsLib

def stackRoleCanonical : StackRoleClaim :=
  { requiredForSsss := true, highAssuranceTargetsLib := true }

def stackRoleNotRequired : StackRoleClaim :=
  { stackRoleCanonical with requiredForSsss := false }

/-!
  Clause 4.7: store that is local first; network / replication / HA / distribution out
  of scope. Carbonado is not assigned.
-/

structure ScopeClaim where
  localFirst : Bool
  claimsNetworkPeering : Bool
  claimsReplication : Bool
  claimsHighAvailability : Bool
  claimsDistribution : Bool
  deriving DecidableEq, Repr, BEq

/-- Local first is required. Network claims are out of scope for this spec. -/
def ScopeClaim.ok (s : ScopeClaim) : Bool :=
  s.localFirst &&
    !s.claimsNetworkPeering &&
    !s.claimsReplication &&
    !s.claimsHighAvailability &&
    !s.claimsDistribution

def scopeCanonical : ScopeClaim :=
  { localFirst := true
    claimsNetworkPeering := false
    claimsReplication := false
    claimsHighAvailability := false
    claimsDistribution := false }

def scopeNetwork : ScopeClaim :=
  { scopeCanonical with claimsNetworkPeering := true }

def scopeNotLocal : ScopeClaim :=
  { scopeCanonical with localFirst := false }

def carbonadoInScope : Bool := false

/-!
  Clause 5: one conformance predicate for a claimed beastdb product.
-/

structure ClaimedProduct where
  language : LanguageClaim
  concurrency : ConcurrencyClaim
  layout : LayoutClaim
  schema : SchemaClaim
  access : AccessClaim
  stackRole : StackRoleClaim
  scope : ScopeClaim
  deriving Repr

def ClaimedProduct.conforms (p : ClaimedProduct) : Bool :=
  p.language.ok &&
    p.concurrency.requiredOk &&
    p.layout.ok &&
    p.schema.ok &&
    p.access.ok &&
    p.stackRole.ok &&
    p.scope.ok

def canonicalProduct : ClaimedProduct :=
  { language := languageCanonical
    concurrency := concurrencyCanonical
    layout := layoutCanonical
    schema := schemaCanonical
    access := accessCanonical
    stackRole := stackRoleCanonical
    scope := scopeCanonical }

def productSubsetTypecheck : ClaimedProduct :=
  { canonicalProduct with language := languageSubsetTypecheck }

def productTraditionalFfi : ClaimedProduct :=
  { canonicalProduct with access := accessTraditionalFfi }

def productSchemaless : ClaimedProduct :=
  { canonicalProduct with schema := schemaOptional }

def productNetwork : ClaimedProduct :=
  { canonicalProduct with scope := scopeNetwork }

def productWrongName : ClaimedProduct :=
  { canonicalProduct with language := languageWrongName }

def productNoAcid : ClaimedProduct :=
  { canonicalProduct with concurrency := concurrencyNoAcid }

def productOptionalMultiWriter : ClaimedProduct :=
  { canonicalProduct with concurrency := concurrencyWithMultiWriter }

end BeastDb
