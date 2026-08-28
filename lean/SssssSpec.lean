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

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def specClaimsImplementationExists : Bool := false

def televisionCanonRequiredForConformance : Bool := false

def leanMachineHasNumberedSpec : Bool := false

def leanMachineAssignedNumber : Option Nat := none

def fargoRequiredByThisSpec : Bool := false

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

def languageIdBitWidth : Nat := 64

def wordIdBitWidth : Nat := 64

def languageIdCapacity : Nat := 2 ^ 64

def wordIdCapacity : Nat := 2 ^ 64

def assignWordId (next : Nat) : WordId :=
  ⟨next⟩

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

def missingMappingSource : List StreamToken :=
  [.languagePrefix ⟨0⟩, .word ⟨99⟩]

def missingMappingEmitsNothingOk : Bool :=
  emit pipelineCanonical missingMappingSource ⟨1⟩ == []

/-- Hashing as primary identity is never an emit path in this model. -/
def emitUsesHashIdentity : Bool := false

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

def leanProveBeforeAuthoritativeRequiredForConformance : Bool := false

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

def naturalLanguageRequiredForConformance : Bool := false

/-!
  Clause 4.6: durable state in beastdb; Systems Lean core; inherit 0002
  CompCert and bootstrap typecheck for components that are safety critical or freestanding.
  Residual honesty does not substitute.
-/

def systemsLeanFileCorrect : String := "0002_Systems_Lean.md"

def systemsLeanFileOk (s : String) : Bool :=
  s == "0002_Systems_Lean.md"

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

end Sssss
