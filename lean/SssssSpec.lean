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
import FormalVibeficationSpec

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

/-- Clause 6.3 and Clause 6.4: SSSSS is real and incomplete. It is not ready for use. -/
def sssssReadyForUse : Bool := false

def mashSssssReadyForUse : Prop :=
  sssssReadyForUse = true

def mashSssssReadyForUseIsFalse : Prop :=
  mashSssssReadyForUse → False

/-- Clause 6.3: this document must not be read as claiming SSSSS never started. -/
def sssssNeverStarted : Bool := false

def mashSssssNeverStarted : Prop :=
  sssssNeverStarted = true

def mashSssssNeverStartedIsFalse : Prop :=
  mashSssssNeverStarted → False

/-- Clause 6.4 item 1: sequential language runs are a requirement, not done work. -/
def sequentialIdentityImplemented : Bool := false

/-- Clause 6.4 item 2: the hashing ban is a requirement, not a proof that an engine already obeys it. -/
def hashingBanProvesEngineObeys : Bool := false

def mashHashingBanProvesEngineObeys : Prop :=
  hashingBanProvesEngineObeys = true

def mashHashingBanProvesEngineObeysIsFalse : Prop :=
  mashHashingBanProvesEngineObeys → False

/-- Clause 4.7 and Clause 6.6: the neurosymbolic harness is specified and is not a shipped product. -/
def neurosymbolicHarnessShipped : Bool := false

def mashNeurosymbolicHarnessShipped : Prop :=
  neurosymbolicHarnessShipped = true

def mashNeurosymbolicHarnessShippedIsFalse : Prop :=
  mashNeurosymbolicHarnessShipped → False

def televisionCanonRequiredForConformance : Bool := false

def leanMachineHasNumberedSpec : Bool := true

def leanMachineAssignedNumber : Option Nat := some 13

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

/-- Sequential LanguageID is well formed only when the value is below 2^64. -/
def LanguageId.wellFormed (id : LanguageId) : Bool :=
  id.value < languageIdCapacity

/-- Sequential WordID is well formed only when the value is below 2^64. -/
def WordId.wellFormed (id : WordId) : Bool :=
  id.value < wordIdCapacity

def languageIdInRange : LanguageId := ⟨0⟩

def languageIdOutOfRange : LanguageId := ⟨languageIdCapacity⟩

def wordIdInRange : WordId := ⟨0⟩

def wordIdOutOfRange : WordId := ⟨wordIdCapacity⟩

/-- A digest MAY exist as an index. It MUST NOT replace sequential stored identity. -/
structure AuxiliaryDigestIndex where
  usedAsStoredIdentifier : Bool
  deriving DecidableEq, Repr, BEq

def AuxiliaryDigestIndex.ok (a : AuxiliaryDigestIndex) : Bool :=
  !a.usedAsStoredIdentifier

def auxiliaryIndexAllowed : AuxiliaryDigestIndex :=
  { usedAsStoredIdentifier := false }

def mashAuxiliaryReplacesSequential : AuxiliaryDigestIndex :=
  { usedAsStoredIdentifier := true }

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

/-- Clause 4.3 item 7: missing mapping fails or emits a named hole. -/
inductive EmitOutcome where
  | word (id : WordId)
  | namedHole (source : WordId)
  | failToken (source : WordId)
  deriving DecidableEq, Repr, BEq

inductive MissingMappingPolicy where
  | emitNamedHole
  | failToken
  deriving DecidableEq, Repr, BEq

structure PipelineConfig where
  vocab : List VocabEntry
  relations : List RosettaEdge
  onMissing : MissingMappingPolicy
  deriving DecidableEq, Repr, BEq

def lookupTarget (rels : List RosettaEdge) (langA : LanguageId) (w : WordId)
    (langB : LanguageId) : Option WordId :=
  match rels.find? (fun e =>
      e.languageA == langA && e.wordA == w && e.languageB == langB) with
  | some e => some e.wordB
  | none => none

def missingOutcome (policy : MissingMappingPolicy) (w : WordId) : EmitOutcome :=
  match policy with
  | .emitNamedHole => .namedHole w
  | .failToken => .failToken w

/-- Inverse WordID lookup under the target LanguageID. Missing maps fail or emit a named hole. -/
def emit (c : PipelineConfig) (source : List StreamToken)
    (target : LanguageId) : List EmitOutcome :=
  Id.run do
    let mut lang : Option LanguageId := none
    let mut out : List EmitOutcome := []
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
          | some b => out := out ++ [.word b]
          | none => out := out ++ [missingOutcome c.onMissing w]
    return out

def pipelineCanonical : PipelineConfig :=
  { vocab :=
      [{ language := ⟨0⟩, word := ⟨1⟩, surface := "src" },
        { language := ⟨1⟩, word := ⟨10⟩, surface := "tgt" }]
    relations := [rosettaCanonical]
    onMissing := .emitNamedHole }

def pipelineFailOnMissing : PipelineConfig :=
  { pipelineCanonical with onMissing := .failToken }

def pipelineSource : List StreamToken :=
  [.languagePrefix ⟨0⟩, .word ⟨1⟩]

def emitUsesRosettaOk : Bool :=
  emit pipelineCanonical pipelineSource ⟨1⟩ == [.word ⟨10⟩]

def missingMappingSource : List StreamToken :=
  [.languagePrefix ⟨0⟩, .word ⟨99⟩]

def missingMappingEmitsNamedHoleOk : Bool :=
  emit pipelineCanonical missingMappingSource ⟨1⟩ == [.namedHole ⟨99⟩]

def missingMappingFailsOk : Bool :=
  emit pipelineFailOnMissing missingMappingSource ⟨1⟩ == [.failToken ⟨99⟩]

/-- Hashing as primary identity is never an emit path in this model. -/
def emitUsesHashIdentity : Bool := false

def EmitOutcome.inventsHashIdentity : EmitOutcome → Bool
  | .word _ => false
  | .namedHole _ => false
  | .failToken _ => false

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
  Clause 4.6: durable state in beastdb; Systems Lean core; inherit 0002.
  `ccomp` is one metric. It is optional. It is not the only metric.
  The bootstrap typecheck stays required for components that are safety
  critical or freestanding. Residual honesty does not make `ccomp` done.
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
    (!c.compCert.verifiedCompilation || c.compCert.ok) &&
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

/-!
  Clause 4.7: neurosymbolic integration when a product claims the
  harness interface. Predicates use ordinary names. This module has
  no theorems. Lean Machine is specification 0013.
-/

/--
  Clause 4.7 DRY: work is not repeated. The neural path MUST NOT spend
  work on an action the symbolic interface can already complete.
-/
structure HarnessAction where
  symbolicCanComplete : Bool
  neuralSpend : Bool
  deriving DecidableEq, Repr, BEq

def workIsRepeated (a : HarnessAction) : Bool :=
  a.symbolicCanComplete && a.neuralSpend

def HarnessAction.conforming (a : HarnessAction) : Bool :=
  !workIsRepeated a

def mashSpendNeuralWhenSymbolicCanAction : HarnessAction :=
  { symbolicCanComplete := true, neuralSpend := true }

def canonicalHarnessAction : HarnessAction :=
  { symbolicCanComplete := true, neuralSpend := false }

def neuralWhenSymbolicCannotAction : HarnessAction :=
  { symbolicCanComplete := false, neuralSpend := true }

/-- Mash: repeated work is claimed conforming. -/
def mashSpendNeuralWhenSymbolicCan : Prop :=
  workIsRepeated mashSpendNeuralWhenSymbolicCanAction = true ∧
    mashSpendNeuralWhenSymbolicCanAction.conforming = true

def mashSpendNeuralWhenSymbolicCanIsFalse : Prop :=
  mashSpendNeuralWhenSymbolicCan → False

instance : Decidable mashSpendNeuralWhenSymbolicCan :=
  inferInstanceAs (Decidable
    (workIsRepeated mashSpendNeuralWhenSymbolicCanAction = true ∧
      mashSpendNeuralWhenSymbolicCanAction.conforming = true))

instance : Decidable mashSpendNeuralWhenSymbolicCanIsFalse :=
  inferInstanceAs (Decidable (mashSpendNeuralWhenSymbolicCan → False))

structure IntegrationClaim where
  integrationClaimed : Bool
  symbolicInterfaceExposed : Bool
  symbolicInterfaceDeterministic : Bool
  neuralUsedOnlyWhenSymbolicCannot : Bool
  toolImprovementReducedToSequentialIntegers : Bool
  trainingNotSubstituteForToolImprovement : Bool
  writtenInSystemsLean : Bool
  deriving Repr, DecidableEq, BEq

/--
  Conforming claimed integration holds only when the named predicates
  hold, including Clause 4.7 item 1 (symbolic interface exposed) and
  item 2 (implemented in Systems Lean).
  A claimed mash that uses the neural path while the symbolic
  interface can complete is not conforming. A claimed neural-gated
  mash that is not implemented in Systems Lean is not conforming.
  A claimed mash that does not expose the symbolic interface is not
  conforming.
-/
def IntegrationClaim.conformingIntegration (c : IntegrationClaim) : Bool :=
  c.integrationClaimed &&
    c.symbolicInterfaceExposed &&
    c.symbolicInterfaceDeterministic &&
    c.neuralUsedOnlyWhenSymbolicCannot &&
    c.toolImprovementReducedToSequentialIntegers &&
    c.trainingNotSubstituteForToolImprovement &&
    c.writtenInSystemsLean

def canonicalIntegration : IntegrationClaim :=
  { integrationClaimed := true
    symbolicInterfaceExposed := true
    symbolicInterfaceDeterministic := true
    neuralUsedOnlyWhenSymbolicCannot := true
    toolImprovementReducedToSequentialIntegers := true
    trainingNotSubstituteForToolImprovement := true
    writtenInSystemsLean := true }

def mashNeuralWhileSymbolicCan : IntegrationClaim :=
  { canonicalIntegration with
    neuralUsedOnlyWhenSymbolicCannot := false }

def translationOnlyNoHarness : IntegrationClaim :=
  { canonicalIntegration with integrationClaimed := false }

def integrationTrainingSubstitutes : IntegrationClaim :=
  { canonicalIntegration with
    trainingNotSubstituteForToolImprovement := false }

def integrationUnreducedToolImprovement : IntegrationClaim :=
  { canonicalIntegration with
    toolImprovementReducedToSequentialIntegers := false }

def integrationSymbolicNotDeterministic : IntegrationClaim :=
  { canonicalIntegration with
    symbolicInterfaceDeterministic := false }

def mashClaimedNeuralGatedNotSystemsLean : IntegrationClaim :=
  { canonicalIntegration with
    writtenInSystemsLean := false }

def mashSymbolicNotExposed : IntegrationClaim :=
  { canonicalIntegration with
    symbolicInterfaceExposed := false }

structure ClaimedProduct where
  representation : RepresentationClaim
  identityOnRosetta : IdentityKind
  durable : DurableStateClaim
  safety : SafetyCriticalClaim
  neuralAcceptedWithoutReduction : Bool
  nl : Option NaturalLanguageTranslation
  systemsLeanFile : String
  integration : Option IntegrationClaim
  deriving Repr

/--
  Clause 5 item 6: no integration claim still conforms. A claimed
  integration must satisfy conformingIntegration.
-/
def ClaimedProduct.conforms (p : ClaimedProduct) : Bool :=
  p.representation.ok &&
    IdentityKind.ok p.identityOnRosetta &&
    p.durable.ok &&
    p.safety.ok &&
    !p.neuralAcceptedWithoutReduction &&
    (match p.nl with
      | none => true
      | some t => t.ok) &&
    systemsLeanFileOk p.systemsLeanFile &&
    (match p.integration with
      | none => true
      | some c => c.conformingIntegration)

def canonicalProduct : ClaimedProduct :=
  { representation := representationCanonical
    identityOnRosetta := .sequentialInteger
    durable := durableCanonical
    safety := safetyCanonical
    neuralAcceptedWithoutReduction := false
    nl := none
    systemsLeanFile := "0002_Systems_Lean.md"
    integration := none }

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

def productClaimedNotSystemsLean : ClaimedProduct :=
  { canonicalProduct with
    integration := some mashClaimedNeuralGatedNotSystemsLean }

def productCanonicalIntegration : ClaimedProduct :=
  { canonicalProduct with
    integration := some canonicalIntegration }

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
  Clause 4.8: delta reconciliation. The Supercompiler is a symbolic
  set of rules. Lean proofs show those rules and their concepts stay
  consistent. The same input goes to the Lean symbolic rules and to
  the reference compiler. Byte identity of emit is pursued and is not
  claimed to already hold. A neural step does not accept a rule
  without a Lean consistency proof. An objective of both is allowed.
  An objective of either security or performance is allowed. Security
  alone is not the only permitted objective. Performance alone is not
  the only permitted objective. Delta reconciliation is not one
  reference compiler. The compilers named in specification 0002 are in
  the set. The set is not closed. A quirk list is not specified yet.
  The weight formula is not specified yet.
-/

/-- Clause 4.8: the Supercompiler is a symbolic set of rules. -/
def supercompilerIsSymbolicRuleSet : Bool := true

/-- Clause 4.8: Lean proofs show the rules and their concepts stay consistent. -/
def leanProofsKeepRulesConsistent : Bool := true

/-- Clause 4.8: the loop does not claim byte identity of emit already holds. -/
def deltaLoopByteIdentityHolds : Bool := false

def mashDeltaLoopByteIdentityHolds : Prop :=
  deltaLoopByteIdentityHolds = true

def mashDeltaLoopByteIdentityHoldsIsFalse : Prop :=
  mashDeltaLoopByteIdentityHolds → False

/-- Clause 4.8: the neural step does not accept a rule without a Lean consistency proof. -/
def neuralAcceptsRuleWithoutLeanProof : Bool := false

def mashNeuralAcceptsRuleWithoutLeanProof : Prop :=
  neuralAcceptsRuleWithoutLeanProof = true

def mashNeuralAcceptsRuleWithoutLeanProofIsFalse : Prop :=
  mashNeuralAcceptsRuleWithoutLeanProof → False

/-- Clause 4.8 objectives. Security, performance, and both are each allowed. -/
inductive ReconciliationObjective where
  | security
  | performance
  | both
  deriving DecidableEq, Repr, BEq

def objectiveAllowed : ReconciliationObjective → Bool
  | .security => true
  | .performance => true
  | .both => true

/-- An objective of either security or performance is allowed. -/
def eitherObjectiveAllowed : Bool :=
  objectiveAllowed .security && objectiveAllowed .performance

/-- Security alone as the only permitted objective. That claim is not accepted. -/
def securityAloneIsOnlyPermittedObjective : Bool := false

def mashSecurityAloneMust : Prop :=
  securityAloneIsOnlyPermittedObjective = true

def mashSecurityAloneMustIsFalse : Prop :=
  mashSecurityAloneMust → False

/-- Performance alone as the only permitted objective. That claim is not accepted. -/
def performanceAloneIsOnlyPermittedObjective : Bool := false

def mashPerformanceAloneMust : Prop :=
  performanceAloneIsOnlyPermittedObjective = true

def mashPerformanceAloneMustIsFalse : Prop :=
  mashPerformanceAloneMust → False

/-!
  Clause 4.8 major compilers. Not one reference compiler. The five
  compilers named in specification 0002 are in the set. The set is not
  closed. A quirk list is not specified yet. Being a reference target
  does not satisfy specification 0002 Clause 4.2 item 6. Specifications
  0002, 0004, 0006, and 0007 complement each other. None replaces another.
  Security and performance are not the same priority.
-/

inductive MajorCompiler where
  | ccomp
  | compCertTso
  | gcc
  | llvm
  | cc
  deriving DecidableEq, Repr, BEq

def majorCompilerInSet : MajorCompiler → Bool
  | .ccomp => true
  | .compCertTso => true
  | .gcc => true
  | .llvm => true
  | .cc => true

/-- Claiming there is exactly one reference compiler. That claim is false. -/
def exactlyOneReferenceCompiler : Bool := false

def mashExactlyOneReferenceCompiler : Prop :=
  exactlyOneReferenceCompiler = true

def mashExactlyOneReferenceCompilerIsFalse : Prop :=
  mashExactlyOneReferenceCompiler → False

def majorCompilerSetClosed : Bool := false

def quirkListSpecified : Bool := false

/-- Being a reference target does not by itself satisfy Clause 4.2 item 6. -/
def beingAReferenceTargetSatisfiesClause42Item6 : Bool := false

def spec0004ReplacesSpec0002 : Bool := false

def mashSpec0004ReplacesSpec0002 : Prop :=
  spec0004ReplacesSpec0002 = true

def mashSpec0004ReplacesSpec0002IsFalse : Prop :=
  mashSpec0004ReplacesSpec0002 → False

def spec0006ReplacesSpec0004 : Bool := false

def mashSpec0006ReplacesSpec0004 : Prop :=
  spec0006ReplacesSpec0004 = true

def mashSpec0006ReplacesSpec0004IsFalse : Prop :=
  mashSpec0006ReplacesSpec0004 → False

def specsComplementEachOther : Bool := true

def securityAndPerformanceSamePriority : Bool := false

end Sssss
