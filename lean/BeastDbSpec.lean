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
import FormalVibeficationSpec

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
  Clause 3.6 and 4.2: ACID as four conjuncts in the meaning model.
  This is not a claim that product ACID proofs exist.
-/

structure AcidClaim where
  atomicity : Bool
  consistency : Bool
  isolation : Bool
  durability : Bool
  deriving DecidableEq, Repr, BEq

def AcidClaim.ok (c : AcidClaim) : Bool :=
  c.atomicity && c.consistency && c.isolation && c.durability

def acidCanonical : AcidClaim :=
  { atomicity := true
    consistency := true
    isolation := true
    durability := true }

def acidMissingIsolation : AcidClaim :=
  { acidCanonical with isolation := false }

/-!
  Clause 3.7 and 4.2 item 2: reader and writer progress does not depend on
  another thread releasing a mutex. The durable map MUST be that trie.
-/

structure TrieProgressClaim where
  durableMapIsTrie : Bool
  progressIndependentOfMutexRelease : Bool
  deriving DecidableEq, Repr, BEq

def TrieProgressClaim.ok (t : TrieProgressClaim) : Bool :=
  t.durableMapIsTrie && t.progressIndependentOfMutexRelease

def trieProgressCanonical : TrieProgressClaim :=
  { durableMapIsTrie := true
    progressIndependentOfMutexRelease := true }

def trieProgressMutexDependent : TrieProgressClaim :=
  { trieProgressCanonical with progressIndependentOfMutexRelease := false }

def trieProgressNotTrie : TrieProgressClaim :=
  { trieProgressCanonical with durableMapIsTrie := false }

/-!
  Clause 4.2: proven ACID, tries that do not use locks, SWMR required, more than
  one writer on disjoint leaves optional (MAY), fencing by generation required.
  Writers MUST NOT share a leaf when more than one writer is present.
-/

structure ConcurrencyClaim where
  provenAcid : Bool
  lockFreeTries : Bool
  swmr : Bool
  generationFenced : Bool
  multiWriterDisjointLeaves : Bool
  trie : TrieProgressClaim
  writersShareLeaf : Bool
  deriving DecidableEq, Repr, BEq

/-- Multi writer is ignored by the required conjuncts (MAY). Shared leaf fails. -/
def ConcurrencyClaim.requiredOk (c : ConcurrencyClaim) : Bool :=
  c.provenAcid && c.lockFreeTries && c.swmr && c.generationFenced &&
    c.trie.ok && !c.writersShareLeaf

def multiWriterRequiredForConformance : Bool := false

def concurrencyCanonical : ConcurrencyClaim :=
  { provenAcid := true
    lockFreeTries := true
    swmr := true
    generationFenced := true
    multiWriterDisjointLeaves := false
    trie := trieProgressCanonical
    writersShareLeaf := false }

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

def concurrencyMutexDependentTrie : ConcurrencyClaim :=
  { concurrencyCanonical with trie := trieProgressMutexDependent }

def concurrencySharedLeaf : ConcurrencyClaim :=
  { concurrencyCanonical with
      multiWriterDisjointLeaves := true
      writersShareLeaf := true }

def sharedLeafWritersDoNotConform : Prop :=
  concurrencySharedLeaf.requiredOk = false

/-!
  Clauses 3.14, 3.15, and 4.3 item 4: dense LanguageID and WordID in the store.
  Density here is store identity, not SSSSS 2^64 sequential assignment.
  A Unicode code point used as the primary key does not conform.
-/

inductive IdentifierKind where
  | dense
  | unicodeCodePoint
  deriving DecidableEq, Repr, BEq

def IdentifierKind.ok : IdentifierKind → Bool
  | .dense => true
  | .unicodeCodePoint => false

def denseIdentifierFixture : IdentifierKind := .dense

def unicodeCodePointPrimaryKeyFixture : IdentifierKind := .unicodeCodePoint

def unicodeCodePointIsNotPrimaryKey : Prop :=
  IdentifierKind.ok unicodeCodePointPrimaryKeyFixture = false

structure PersistIdentityClaim where
  languageIdKind : IdentifierKind
  wordIdKind : IdentifierKind
  persistLanguageId : Bool
  persistWordId : Bool
  deriving DecidableEq, Repr, BEq

def PersistIdentityClaim.ok (p : PersistIdentityClaim) : Bool :=
  p.languageIdKind.ok && p.wordIdKind.ok && p.persistLanguageId && p.persistWordId

def persistIdentityCanonical : PersistIdentityClaim :=
  { languageIdKind := denseIdentifierFixture
    wordIdKind := denseIdentifierFixture
    persistLanguageId := true
    persistWordId := true }

def persistIdentityUnicodePrimaryKey : PersistIdentityClaim :=
  { persistIdentityCanonical with
      languageIdKind := unicodeCodePointPrimaryKeyFixture
      wordIdKind := unicodeCodePointPrimaryKeyFixture }

/-!
  Clause 4.3: mmap, SIMD, zerocopy, LanguageID, WordID, Rosetta.
  A bounce buffer MUST NOT be required for a mapped read.
-/

def bounceBufferRequiredForMappedRead : Bool := false

/-- Clause 4.3 item 3 and Clause 6.4 item 6: a bounce buffer is not required for a mapped read. -/
def mashBounceBufferRequired : Prop :=
  bounceBufferRequiredForMappedRead = true

def mashBounceBufferRequiredIsFalse : Prop :=
  mashBounceBufferRequired → False

structure LayoutClaim where
  mmap : Bool
  simd : Bool
  zerocopy : Bool
  languageId : Bool
  wordId : Bool
  rosetta : Bool
  bounceBufferRequiredForMappedRead : Bool
  deriving DecidableEq, Repr, BEq

def LayoutClaim.ok (l : LayoutClaim) : Bool :=
  l.mmap && l.simd && l.zerocopy && l.languageId && l.wordId && l.rosetta &&
    !l.bounceBufferRequiredForMappedRead

def layoutCanonical : LayoutClaim :=
  { mmap := true
    simd := true
    zerocopy := true
    languageId := true
    wordId := true
    rosetta := true
    bounceBufferRequiredForMappedRead := false }

def layoutNoMmap : LayoutClaim :=
  { layoutCanonical with mmap := false }

def layoutBounceRequired : LayoutClaim :=
  { layoutCanonical with bounceBufferRequiredForMappedRead := true }

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
  acid : AcidClaim
  identity : PersistIdentityClaim
  layout : LayoutClaim
  schema : SchemaClaim
  access : AccessClaim
  stackRole : StackRoleClaim
  scope : ScopeClaim
  deriving Repr

def ClaimedProduct.conforms (p : ClaimedProduct) : Bool :=
  p.language.ok &&
    p.concurrency.requiredOk &&
    p.acid.ok &&
    p.identity.ok &&
    p.layout.ok &&
    p.schema.ok &&
    p.access.ok &&
    p.stackRole.ok &&
    p.scope.ok

def canonicalProduct : ClaimedProduct :=
  { language := languageCanonical
    concurrency := concurrencyCanonical
    acid := acidCanonical
    identity := persistIdentityCanonical
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

def productMissingIsolation : ClaimedProduct :=
  { canonicalProduct with acid := acidMissingIsolation }

def productUnicodePrimaryKey : ClaimedProduct :=
  { canonicalProduct with identity := persistIdentityUnicodePrimaryKey }

def productSharedLeaf : ClaimedProduct :=
  { canonicalProduct with concurrency := concurrencySharedLeaf }

def productMutexDependentTrie : ClaimedProduct :=
  { canonicalProduct with concurrency := concurrencyMutexDependentTrie }

def productBounceRequired : ClaimedProduct :=
  { canonicalProduct with layout := layoutBounceRequired }

/-!
  Clause 6.4 leftover: required product work is not done. Cons False
  fixtures name clashes this specification already states. Do not copy
  Systems Lean durability, Props, or TSX fixtures.
-/

def provenAcidDone : Bool := false

def triesWithoutLocksDone : Bool := false

def mmapDone : Bool := false

def schemaProofsDone : Bool := false

def fargoSpecified : Bool := false

/-- Clause 3.6 and Clause 6.4 item 1: marketing ACID is not proven ACID. -/
def marketingAcidIsProvenAcid : Bool := false

def mashMarketingAcidIsProvenAcid : Prop :=
  marketingAcidIsProvenAcid = true

def mashMarketingAcidIsProvenAcidIsFalse : Prop :=
  mashMarketingAcidIsProvenAcid → False

/-- Clause 3.7, Clause 4.2 item 2, and Clause 6.4 item 2: a trie whose progress waits on a mutual exclusion lock is not conforming. -/
def mutexTrieAccepted : Bool := false

def mashMutexTrie : Prop :=
  mutexTrieAccepted = true

def mashMutexTrieIsFalse : Prop :=
  mashMutexTrie → False

/-- Clause 3.12, Clause 4.4, and Clause 6.4 item 11: inferred schema is not a license to remain without a schema. -/
def inferredSchemaLeavesDataWithoutSchemaAccepted : Bool := false

def mashInferredSchemaLeavesDataWithoutSchema : Prop :=
  inferredSchemaLeavesDataWithoutSchemaAccepted = true

def mashInferredSchemaLeavesDataWithoutSchemaIsFalse : Prop :=
  mashInferredSchemaLeavesDataWithoutSchema → False

/-- Clause 4.5 item 5, Clause 6.4 item 14, and Clause 6.5 item 5: a traditional foreign function interface is not the interoperability path. -/
def traditionalFfiAsInteropPathAccepted : Bool := false

def mashTraditionalFfiAsInteropPath : Prop :=
  traditionalFfiAsInteropPathAccepted = true

def mashTraditionalFfiAsInteropPathIsFalse : Prop :=
  mashTraditionalFfiAsInteropPath → False

/-- Clause 6.3 item 3 and Clause 6.4 item 16: claiming that beastdb never started is not accepted. -/
def beastdbNeverStartedAccepted : Bool := false

def mashBeastdbNeverStarted : Prop :=
  beastdbNeverStartedAccepted = true

def mashBeastdbNeverStartedIsFalse : Prop :=
  mashBeastdbNeverStarted → False

/-- Clause 6.3 item 3 and Clause 6.4 item 16: claiming that beastdb is ready for use is not accepted. -/
def beastdbReadyForUseAccepted : Bool := false

def mashBeastdbReadyForUse : Prop :=
  beastdbReadyForUseAccepted = true

def mashBeastdbReadyForUseIsFalse : Prop :=
  mashBeastdbReadyForUse → False

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

end BeastDb
