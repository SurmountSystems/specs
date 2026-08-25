/-
  Companion Lean model of selected claims from 0004_SSSSS.md.

  This module is not the specification. The numbered markdown is the contract
  people read. spec_check remains the form checker (ASCII, tabs, RFC 2119,
  spelling). SpecRegistry remains the number and file name registry. These
  declarations encode meaning so an inconsistent model is a type error or a
  failing test.
-/

import SystemsLean
import SpecRegistry

namespace Sssss

open SystemsLean

def specNumber : Nat := SpecRegistry.ssssSpecNumber

def specFileName : String := "0004_SSSSS.md"

def productName : String := "SSSSS"

theorem spec_is_0004 : specNumber = 4 := rfl

theorem spec_file_is_0004_sssss : specFileName = "0004_SSSSS.md" := rfl

theorem product_name_is_sssss : productName = "SSSSS" := rfl

theorem systems_lean_is_0002 :
    SpecRegistry.systemsLeanSpecNumber = 2 :=
  SpecRegistry.systems_lean_is_0002

theorem beastdb_is_0003 :
    SpecRegistry.beastdbSpecNumber = 3 :=
  SpecRegistry.beastdb_is_0003

theorem ssss_is_not_0002 :
    SpecRegistry.ssssSpecNumber ≠ 2 :=
  SpecRegistry.ssss_is_not_spec_0002

theorem ssss_is_not_0003 :
    SpecRegistry.ssssSpecNumber ≠ 3 :=
  SpecRegistry.ssss_is_not_spec_0003

theorem fargo_planned_is_0005 :
    SpecRegistry.fargoPlannedSpecNumber = 5 :=
  SpecRegistry.fargo_planned_is_0005

theorem carbonado_unassigned :
    SpecRegistry.carbonadoAssigned = false :=
  SpecRegistry.carbonado_not_assigned

/-- This specification does not claim a conforming implementation exists. -/
def specClaimsImplementationExists : Bool := false

theorem no_implementation_claimed :
    specClaimsImplementationExists = false := rfl

/-- Clause 1.3: television canon is not a conformance item. -/
def televisionCanonRequiredForConformance : Bool := false

theorem cultural_marker_not_required :
    televisionCanonRequiredForConformance = false := rfl

/-- Lean Machine is named as substrate; it has no numbered specification. -/
def leanMachineHasNumberedSpec : Bool := false

def leanMachineAssignedNumber : Option Nat := none

theorem lean_machine_unnumbered :
    leanMachineHasNumberedSpec = false := rfl

theorem lean_machine_number_none :
    leanMachineAssignedNumber = none := rfl

/-- This specification does not require fargo. -/
def fargoRequiredByThisSpec : Bool := false

theorem fargo_not_required : fargoRequiredByThisSpec = false := rfl

/-!
  Clause 4.1: sequential LanguageID / WordID; hashing is not primary
  identity; LanguageID prefix only on change; capacity 2^64 x 2^64.
-/

structure LanguageId where
  value : Nat
  deriving DecidableEq, Repr, BEq

structure WordId where
  value : Nat
  deriving DecidableEq, Repr, BEq

inductive IdentityKind where
  | sequentialInteger
  | hashDigest
  deriving DecidableEq, Repr, BEq

def IdentityKind.ok : IdentityKind → Bool
  | .sequentialInteger => true
  | .hashDigest => false

theorem sequential_identity_ok :
    IdentityKind.ok .sequentialInteger = true := rfl

theorem hash_as_primary_identity_not_ok :
    IdentityKind.ok .hashDigest = false := rfl

def languageIdBitWidth : Nat := 64

def wordIdBitWidth : Nat := 64

def languageIdCapacity : Nat := 2 ^ 64

def wordIdCapacity : Nat := 2 ^ 64

theorem language_id_is_64_bit : languageIdBitWidth = 64 := rfl

theorem word_id_is_64_bit : wordIdBitWidth = 64 := rfl

theorem language_capacity_is_2_pow_64 :
    languageIdCapacity = 2 ^ 64 := rfl

theorem word_capacity_is_2_pow_64 : wordIdCapacity = 2 ^ 64 := rfl

theorem combined_capacity :
    languageIdCapacity * wordIdCapacity = (2 ^ 64) * (2 ^ 64) := rfl

/-- Next unused WordID is sequential, not a hash of surface text. -/
def assignWordId (next : Nat) : WordId :=
  ⟨next⟩

theorem assign_word_id_sequential (n : Nat) :
    (assignWordId n).value = n := rfl

structure LanguageRun where
  language : LanguageId
  words : List WordId
  deriving DecidableEq, Repr, BEq

inductive StreamToken where
  | languagePrefix (id : LanguageId)
  | word (id : WordId)
  deriving DecidableEq, Repr, BEq

/-- Serialize runs; emit LanguageID only at start and on language change. -/
def encodeRuns (runs : List LanguageRun) : List StreamToken :=
  Id.run do
    let mut out : List StreamToken := []
    let mut prev : Option LanguageId := none
    for r in runs do
      let needPrefix :=
        match prev with
        | none => true
        | some p => p != r.language
      if needPrefix then
        out := out ++ [.languagePrefix r.language]
      for w in r.words do
        out := out ++ [.word w]
      prev := some r.language
    return out

def runA : LanguageRun :=
  { language := ⟨0⟩, words := [⟨1⟩, ⟨2⟩] }

def runAContinued : LanguageRun :=
  { language := ⟨0⟩, words := [⟨3⟩] }

def runB : LanguageRun :=
  { language := ⟨1⟩, words := [⟨10⟩] }

def sameLanguageTwoRuns : List StreamToken :=
  encodeRuns [runA, runAContinued]

def changedLanguageRuns : List StreamToken :=
  encodeRuns [runA, runB]

/-- Empty input produces no tokens. Checked by `sssss_tests`. -/
def encodeEmptyOk : Bool :=
  encodeRuns [] == []

def prefixOmittedWhenUnchangedOk : Bool :=
  sameLanguageTwoRuns ==
    [.languagePrefix ⟨0⟩, .word ⟨1⟩, .word ⟨2⟩, .word ⟨3⟩]

def prefixEmittedWhenChangedOk : Bool :=
  changedLanguageRuns ==
    [.languagePrefix ⟨0⟩, .word ⟨1⟩, .word ⟨2⟩, .languagePrefix ⟨1⟩,
      .word ⟨10⟩]

/-!
  Clause 4.2: Rosetta relation shape and provenance tags.
-/

inductive Provenance where
  | neuralProposed
  | humanConfirmed
  | leanProven
  deriving DecidableEq, Repr, BEq

def Provenance.all : List Provenance :=
  [.neuralProposed, .humanConfirmed, .leanProven]

theorem exactly_three_provenance_tags : Provenance.all.length = 3 := rfl

inductive RelationType where
  | translation
  | synonymy
  | hypernymy
  | implementationDefined
  deriving DecidableEq, Repr, BEq

structure RosettaEdge where
  languageA : LanguageId
  wordA : WordId
  relation : RelationType
  languageB : LanguageId
  wordB : WordId
  provenance : Provenance
  deriving DecidableEq, Repr, BEq

def RosettaEdge.identityOk (_e : RosettaEdge) (kind : IdentityKind) : Bool :=
  IdentityKind.ok kind

def rosettaCanonical : RosettaEdge :=
  { languageA := ⟨0⟩
    wordA := ⟨1⟩
    relation := .translation
    languageB := ⟨1⟩
    wordB := ⟨10⟩
    provenance := .humanConfirmed }

theorem rosetta_sequential_ok :
    rosettaCanonical.identityOk .sequentialInteger = true := rfl

theorem rosetta_hash_identity_not_ok :
    rosettaCanonical.identityOk .hashDigest = false := rfl

/-!
  Clause 4.3: deterministic pipeline given the same vocabulary and
  relation set. Emit is a function of config, source, and target.
-/

structure VocabEntry where
  language : LanguageId
  word : WordId
  surface : String
  deriving DecidableEq, Repr, BEq

structure PipelineConfig where
  vocab : List VocabEntry
  relations : List RosettaEdge
  deriving DecidableEq, Repr, BEq

def lookupTarget (rels : List RosettaEdge) (langA : LanguageId) (w : WordId)
    (langB : LanguageId) : Option WordId :=
  match rels.find? (fun e =>
      e.languageA == langA && e.wordA == w && e.languageB == langB) with
  | some e => some e.wordB
  | none => none

/-- Inverse WordID lookup under the target LanguageID. Missing maps drop. -/
def emit (c : PipelineConfig) (source : List StreamToken)
    (target : LanguageId) : List WordId :=
  Id.run do
    let mut lang : Option LanguageId := none
    let mut out : List WordId := []
    for t in source do
      match t with
      | .languagePrefix id =>
        lang := some id
      | .word w =>
        match lang with
        | none =>
          pure ()
        | some a =>
          match lookupTarget c.relations a w target with
          | some b => out := out ++ [b]
          | none => pure ()
    return out

def pipelineCanonical : PipelineConfig :=
  { vocab :=
      [{ language := ⟨0⟩, word := ⟨1⟩, surface := "src" },
        { language := ⟨1⟩, word := ⟨10⟩, surface := "tgt" }]
    relations := [rosettaCanonical] }

def pipelineSource : List StreamToken :=
  [.languagePrefix ⟨0⟩, .word ⟨1⟩]

def emitUsesRosettaOk : Bool :=
  emit pipelineCanonical pipelineSource ⟨1⟩ == [⟨10⟩]

theorem same_config_same_emit
    (c1 c2 : PipelineConfig) (source : List StreamToken)
    (target : LanguageId) (h : c1 = c2) :
    emit c1 source target = emit c2 source target := by
  subst h
  rfl

def missingMappingSource : List StreamToken :=
  [.languagePrefix ⟨0⟩, .word ⟨99⟩]

def missingMappingEmitsNothingOk : Bool :=
  emit pipelineCanonical missingMappingSource ⟨1⟩ == []

/-- Hashing as primary identity is never an emit path in this model. -/
def emitUsesHashIdentity : Bool := false

theorem emit_does_not_use_hash_identity :
    emitUsesHashIdentity = false := rfl

/-!
  Clause 4.4: neural proposals MUST reduce to sequential integers
  before acceptance. Lean prove before authoritative is SHOULD, not MUST.
-/

structure NeuralProposal where
  reducedToSequentialIntegers : Bool
  deriving DecidableEq, Repr, BEq

def NeuralProposal.acceptable (p : NeuralProposal) : Bool :=
  p.reducedToSequentialIntegers

def neuralReduced : NeuralProposal :=
  { reducedToSequentialIntegers := true }

def neuralNotReduced : NeuralProposal :=
  { reducedToSequentialIntegers := false }

theorem neural_reduced_acceptable : neuralReduced.acceptable = true := by
  decide

theorem neural_not_reduced_not_acceptable :
    neuralNotReduced.acceptable = false := by
  decide

def leanProveBeforeAuthoritativeRequiredForConformance : Bool := false

theorem lean_prove_neural_is_should_not_must :
    leanProveBeforeAuthoritativeRequiredForConformance = false := rfl

/-!
  Clause 4.5: natural language translation MAY; MUST mark provisional
  unless Lean proven or high confidence.
-/

structure NaturalLanguageTranslation where
  leanProven : Bool
  highConfidence : Bool
  markedProvisional : Bool
  deriving DecidableEq, Repr, BEq

def NaturalLanguageTranslation.ok (t : NaturalLanguageTranslation) : Bool :=
  t.leanProven || t.highConfidence || t.markedProvisional

def nlProvisional : NaturalLanguageTranslation :=
  { leanProven := false, highConfidence := false, markedProvisional := true }

def nlProven : NaturalLanguageTranslation :=
  { leanProven := true, highConfidence := false, markedProvisional := false }

def nlHighConfidence : NaturalLanguageTranslation :=
  { leanProven := false, highConfidence := true, markedProvisional := false }

def nlUnmarked : NaturalLanguageTranslation :=
  { leanProven := false, highConfidence := false, markedProvisional := false }

theorem nl_provisional_ok : nlProvisional.ok = true := by decide

theorem nl_proven_ok : nlProven.ok = true := by decide

theorem nl_high_confidence_ok : nlHighConfidence.ok = true := by decide

theorem nl_unmarked_not_ok : nlUnmarked.ok = false := by decide

def naturalLanguageRequiredForConformance : Bool := false

theorem nl_optional :
    naturalLanguageRequiredForConformance = false := rfl

/-!
  Clause 4.6: durable state in beastdb; Systems Lean core; inherit 0002
  CompCert and bootstrap typecheck for components that are safety critical or freestanding.
  Residual honesty does not substitute.
-/

def systemsLeanFileCorrect : String := "0002_Systems_Lean.md"

def systemsLeanFileOk (s : String) : Bool :=
  s == "0002_Systems_Lean.md"

theorem systems_lean_file_correct :
    systemsLeanFileOk systemsLeanFileCorrect = true := rfl

theorem wrong_systems_lean_file_fails :
    systemsLeanFileOk "0003_systems_lean.md" = false := rfl

structure DurableStateClaim where
  usesBeastdb : Bool
  beastdbSpecFile : String
  deriving Repr

def DurableStateClaim.ok (d : DurableStateClaim) : Bool :=
  d.usesBeastdb && d.beastdbSpecFile == "0003_beastdb.md"

def durableCanonical : DurableStateClaim :=
  { usesBeastdb := true, beastdbSpecFile := "0003_beastdb.md" }

def durableWrongStore : DurableStateClaim :=
  { usesBeastdb := false, beastdbSpecFile := "0003_beastdb.md" }

def durableWrongFile : DurableStateClaim :=
  { usesBeastdb := true, beastdbSpecFile := "0003_systems_lean.md" }

theorem durable_canonical_ok : durableCanonical.ok = true := by decide

theorem durable_wrong_store_not_ok : durableWrongStore.ok = false := by
  decide

theorem durable_wrong_file_not_ok : durableWrongFile.ok = false := by decide

structure SafetyCriticalClaim where
  writtenInSystemsLean : Bool
  slake : SlakeProduct
  wire : FreestandingWire
  bootstrap : SlakeBootstrapTypecheck
  compCert : CompCertValidation
  residualSubstitutesForValidation : Bool
  deriving Repr

def SafetyCriticalClaim.ok (c : SafetyCriticalClaim) : Bool :=
  c.writtenInSystemsLean &&
    c.slake.conforming &&
    c.wire.ok &&
    c.bootstrap.ok &&
    c.compCert.ok &&
    !c.residualSubstitutesForValidation

def safetyCanonical : SafetyCriticalClaim :=
  { writtenInSystemsLean := true
    slake := slakeCanonical
    wire := cleanWire
    bootstrap := bootstrapTypecheckDone
    compCert := compCertPerformed
    residualSubstitutesForValidation := false }

def safetyGc : SafetyCriticalClaim :=
  { safetyCanonical with wire := gcWire }

def safetyMissingCompCert : SafetyCriticalClaim :=
  { safetyCanonical with compCert := compCertMissing }

def safetyMissingBootstrap : SafetyCriticalClaim :=
  { safetyCanonical with bootstrap := bootstrapMissing }

def safetySubsetTypecheck : SafetyCriticalClaim :=
  { safetyCanonical with bootstrap := bootstrapSubsetOnly }

def safetyResidualSubstitutes : SafetyCriticalClaim :=
  { safetyCanonical with
    compCert := compCertMissing
    residualSubstitutesForValidation := true }

theorem safety_canonical_ok : safetyCanonical.ok = true := by decide

theorem safety_gc_not_ok : safetyGc.ok = false := by decide

theorem safety_missing_compcert_not_ok :
    safetyMissingCompCert.ok = false := by
  decide

theorem safety_missing_bootstrap_not_ok :
    safetyMissingBootstrap.ok = false := by
  decide

theorem safety_subset_typecheck_not_ok :
    safetySubsetTypecheck.ok = false := by
  decide

theorem safety_residual_does_not_substitute :
    safetyResidualSubstitutes.ok = false := by
  decide

/-!
  Clause 5: one conformance predicate for a claimed SSSSS product.
-/

structure RepresentationClaim where
  identity : IdentityKind
  languageIdPrefixOnlyOnChange : Bool
  capacityOk : Bool
  deriving Repr

def RepresentationClaim.ok (r : RepresentationClaim) : Bool :=
  IdentityKind.ok r.identity && r.languageIdPrefixOnlyOnChange && r.capacityOk

def representationCanonical : RepresentationClaim :=
  { identity := .sequentialInteger
    languageIdPrefixOnlyOnChange := true
    capacityOk := true }

def representationHashed : RepresentationClaim :=
  { representationCanonical with identity := .hashDigest }

theorem representation_canonical_ok :
    representationCanonical.ok = true := by
  decide

theorem representation_hashed_not_ok :
    representationHashed.ok = false := by
  decide

structure ClaimedProduct where
  representation : RepresentationClaim
  identityOnRosetta : IdentityKind
  durable : DurableStateClaim
  safety : SafetyCriticalClaim
  neuralAcceptedWithoutReduction : Bool
  nl : Option NaturalLanguageTranslation
  systemsLeanFile : String
  deriving Repr

def ClaimedProduct.conforms (p : ClaimedProduct) : Bool :=
  p.representation.ok &&
    IdentityKind.ok p.identityOnRosetta &&
    p.durable.ok &&
    p.safety.ok &&
    !p.neuralAcceptedWithoutReduction &&
    (match p.nl with
      | none => true
      | some t => t.ok) &&
    systemsLeanFileOk p.systemsLeanFile

def canonicalProduct : ClaimedProduct :=
  { representation := representationCanonical
    identityOnRosetta := .sequentialInteger
    durable := durableCanonical
    safety := safetyCanonical
    neuralAcceptedWithoutReduction := false
    nl := none
    systemsLeanFile := "0002_Systems_Lean.md" }

def productHashed : ClaimedProduct :=
  { canonicalProduct with representation := representationHashed }

def productHashedRosetta : ClaimedProduct :=
  { canonicalProduct with identityOnRosetta := .hashDigest }

def productWrongSystemsLeanFile : ClaimedProduct :=
  { canonicalProduct with systemsLeanFile := "0003_systems_lean.md" }

def productUnreducedNeural : ClaimedProduct :=
  { canonicalProduct with neuralAcceptedWithoutReduction := true }

def productUnmarkedNl : ClaimedProduct :=
  { canonicalProduct with nl := some nlUnmarked }

def productProvisionalNl : ClaimedProduct :=
  { canonicalProduct with nl := some nlProvisional }

def productMissingCompCert : ClaimedProduct :=
  { canonicalProduct with safety := safetyMissingCompCert }

def productResidualSubstitutes : ClaimedProduct :=
  { canonicalProduct with safety := safetyResidualSubstitutes }

def productWrongStore : ClaimedProduct :=
  { canonicalProduct with durable := durableWrongStore }

theorem canonical_product_conforms :
    canonicalProduct.conforms = true := by decide

theorem hashing_primary_identity_does_not_conform :
    productHashed.conforms = false := by decide

theorem hashing_rosetta_identity_does_not_conform :
    productHashedRosetta.conforms = false := by decide

theorem wrong_systems_lean_file_does_not_conform :
    productWrongSystemsLeanFile.conforms = false := by decide

theorem unreduced_neural_does_not_conform :
    productUnreducedNeural.conforms = false := by decide

theorem unmarked_nl_does_not_conform :
    productUnmarkedNl.conforms = false := by decide

theorem provisional_nl_still_conforms :
    productProvisionalNl.conforms = true := by decide

theorem missing_compcert_does_not_conform :
    productMissingCompCert.conforms = false := by decide

theorem residual_substitute_does_not_conform :
    productResidualSubstitutes.conforms = false := by decide

theorem wrong_store_does_not_conform :
    productWrongStore.conforms = false := by decide

end Sssss
