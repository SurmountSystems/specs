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

theorem product_name_is_lowercase : productName = "beastdb" := rfl

theorem product_name_has_no_capitals :
    (productName.toList.all fun c => !('A' ≤ c && c ≤ 'Z')) = true := by
  decide

theorem library_is_libbeastdb : libraryName = "libbeastdb" := rfl

theorem library_is_lib_plus_product :
    libraryName = "lib" ++ productName := rfl

theorem spec_is_0003 : specNumber = 3 := rfl

theorem spec_is_not_0002 : specNumber ≠ 2 := by decide

theorem spec_is_not_0004 : specNumber ≠ 4 := by decide

theorem spec_file_is_0003_beastdb : specFileName = "0003_beastdb.md" := rfl

theorem systems_lean_is_0002 :
    SpecRegistry.systemsLeanSpecNumber = 2 :=
  SpecRegistry.systems_lean_is_0002

theorem ssss_is_0004 :
    SpecRegistry.ssssSpecNumber = 4 :=
  SpecRegistry.ssss_is_0004

theorem ssss_is_not_0003 :
    SpecRegistry.ssssSpecNumber ≠ 3 :=
  SpecRegistry.ssss_is_not_spec_0003

theorem rsi_is_0006 :
    SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem cate_is_0005 :
    SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem fargo_is_not_spec_0005 :
    SpecRegistry.fargoAssigned = false :=
  SpecRegistry.fargo_not_assigned

theorem carbonado_unassigned :
    SpecRegistry.carbonadoAssigned = false :=
  SpecRegistry.carbonado_not_assigned

/-- This specification does not claim a conforming implementation exists. -/
def specClaimsImplementationExists : Bool := false

theorem no_implementation_claimed :
    specClaimsImplementationExists = false := rfl

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

theorem language_canonical_ok : languageCanonical.ok = true := by decide

theorem language_wrong_name_not_ok : languageWrongName.ok = false := by decide

theorem language_wrong_library_not_ok : languageWrongLibrary.ok = false := by
  decide

theorem language_subset_typecheck_not_ok :
    languageSubsetTypecheck.ok = false := by
  decide

theorem language_missing_bootstrap_not_ok :
    languageMissingBootstrap.ok = false := by
  decide

theorem language_missing_compcert_not_ok :
    languageMissingCompCert.ok = false := by
  decide

theorem language_gc_wire_not_ok : languageGcWire.ok = false := by decide

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

theorem multi_writer_not_required :
    multiWriterRequiredForConformance = false := rfl

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

theorem concurrency_canonical_ok :
    concurrencyCanonical.requiredOk = true := by decide

theorem concurrency_with_optional_multi_writer_still_ok :
    concurrencyWithMultiWriter.requiredOk = true := by decide

theorem concurrency_optional_flag_ignored
    (c : ConcurrencyClaim) :
    ({ c with multiWriterDisjointLeaves := !c.multiWriterDisjointLeaves } :
        ConcurrencyClaim).requiredOk =
      c.requiredOk :=
  rfl

theorem concurrency_no_acid_not_ok : concurrencyNoAcid.requiredOk = false := by
  decide

theorem concurrency_locked_trie_not_ok :
    concurrencyLockedTrie.requiredOk = false := by
  decide

theorem concurrency_no_swmr_not_ok : concurrencyNoSwmr.requiredOk = false := by
  decide

theorem concurrency_no_fence_not_ok : concurrencyNoFence.requiredOk = false := by
  decide

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

theorem layout_canonical_ok : layoutCanonical.ok = true := by decide

theorem layout_no_mmap_not_ok : layoutNoMmap.ok = false := by decide

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

theorem SchemaMode.ofFin_toFin (m : SchemaMode) :
    SchemaMode.ofFin m.toFin = m := by
  cases m <;> rfl

def SchemaMode.all : List SchemaMode :=
  [.predefined, .inferred]

theorem exactly_two_schema_modes : SchemaMode.all.length = 2 := rfl

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

theorem schema_canonical_ok : schemaCanonical.ok = true := by decide

theorem schema_optional_not_ok : schemaOptional.ok = false := by decide

theorem schema_one_mode_not_ok : schemaOneMode.ok = false := by decide

theorem schema_unproven_migration_not_ok :
    schemaUnprovenMigration.ok = false := by
  decide

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

theorem fargo_permitted :
    CompatibilityPath.permitted .fargo = true := rfl

theorem traditional_ffi_forbidden :
    CompatibilityPath.permitted .traditionalForeignFunctionInterface = false :=
  rfl

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

theorem access_canonical_ok : accessCanonical.ok = true := by decide

theorem access_traditional_ffi_not_ok :
    accessTraditionalFfi.ok = false := by decide

theorem access_no_vector_not_ok : accessNoVector.ok = false := by decide

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

theorem stack_role_canonical_ok : stackRoleCanonical.ok = true := by decide

theorem stack_role_not_required_not_ok :
    stackRoleNotRequired.ok = false := by decide

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

theorem scope_canonical_ok : scopeCanonical.ok = true := by decide

theorem scope_network_not_ok : scopeNetwork.ok = false := by decide

theorem scope_not_local_not_ok : scopeNotLocal.ok = false := by decide

def carbonadoInScope : Bool := false

theorem carbonado_out_of_scope : carbonadoInScope = false := rfl

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

theorem canonical_product_conforms :
    canonicalProduct.conforms = true := by decide

theorem subset_typecheck_does_not_conform :
    productSubsetTypecheck.conforms = false := by decide

theorem traditional_ffi_does_not_conform :
    productTraditionalFfi.conforms = false := by decide

theorem schemaless_does_not_conform :
    productSchemaless.conforms = false := by decide

theorem network_claims_do_not_conform :
    productNetwork.conforms = false := by decide

theorem wrong_name_does_not_conform :
    productWrongName.conforms = false := by decide

theorem no_acid_does_not_conform :
    productNoAcid.conforms = false := by decide

theorem optional_multi_writer_still_conforms :
    productOptionalMultiWriter.conforms = true := by decide

end BeastDb
