/-
  SPEC ENCODINGS for numbered specification 0008 Formal Vibefication
  (`0008_Formal_Vibefication.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in FormalVibeficationProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not prove that Slake emit already matches ELF. It does
  not prove that beastdb, SSSSS, Slake, or Continuous Integration are
  ready for use.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry

namespace FormalVibeficationSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0008. -/
def specNumber : Nat := 8

def specFileName : String := "0008_Formal_Vibefication.md"

def productName : String := "Formal Vibefication"

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

/-- Pairwise distinct layers, stated as a proposition. -/
def layersPairwiseDistinct : Prop :=
  Layer.humanMarkdownContract ≠ Layer.leanSpecEncoding ∧
    Layer.humanMarkdownContract ≠ Layer.leanProof ∧
    Layer.humanMarkdownContract ≠ Layer.productImplementation ∧
    Layer.leanSpecEncoding ≠ Layer.leanProof ∧
    Layer.leanSpecEncoding ≠ Layer.productImplementation ∧
    Layer.leanProof ≠ Layer.productImplementation

/-- Human markdown is the contract people read. It does not replace Lean encodings. -/
def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

def specCheckIsMarkdownForm : Bool := true

def specCheckIsMeaningSpecEncoding : Bool := false

/-- Layout of one Lean module relative to the split. -/
structure LeanModuleRole where
  moduleName : String
  containsSpecEncodings : Bool
  containsProofsOfThoseEncodings : Bool
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  deriving DecidableEq, Repr, BEq

/-- A mash that hides the split: encodings and their proofs in one module. -/
def hidesSplit (m : LeanModuleRole) : Bool :=
  m.containsSpecEncodings && m.containsProofsOfThoseEncodings

/-- Conforming for this specifications repository. -/
def conformingThisRepo (m : LeanModuleRole) : Bool :=
  !hidesSplit m &&
    (!m.containsSpecEncodings || (m.markedAsSpecEncoding && !m.markedAsProof)) &&
    (!m.containsProofsOfThoseEncodings || (m.markedAsProof && !m.markedAsSpecEncoding))

def specEncodingFixture : LeanModuleRole :=
  { moduleName := "FormalVibeficationSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "FormalVibeficationProofs"
    containsSpecEncodings := false
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := false
    markedAsProof := true }

/-- Fixture: spec encodings and proofs mashed in one module. -/
def mashedFixture : LeanModuleRole :=
  { moduleName := "MashedSpecAndProof"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := true
    markedAsProof := true }

/-- Stated: the mashed fixture does not conform here. -/
def mashedIsNonconformingThisRepo : Prop :=
  conformingThisRepo mashedFixture = false

/-- Stated: separate marked modules conform, and they are not the same file. -/
def separateModulesConformThisRepo : Prop :=
  conformingThisRepo specEncodingFixture = true ∧
    conformingThisRepo proofFixture = true ∧
    specEncodingFixture.moduleName ≠ proofFixture.moduleName

inductive Home where
  | thisSpecificationsRepo
  | systemsLeanProductTree
  deriving DecidableEq, Repr, BEq

def Home.mayUnifySpecProofImpl : Home → Bool
  | .thisSpecificationsRepo => false
  | .systemsLeanProductTree => true

/-- Treating the two homes as the same layer. -/
def mashHomes : Prop :=
  Home.thisSpecificationsRepo.mayUnifySpecProofImpl =
    Home.systemsLeanProductTree.mayUnifySpecProofImpl

/-- Stated: a mash of homes is inconsistent. -/
def mashHomesIsInconsistent : Prop :=
  mashHomes → False

/-- Stated: spec encoding is not the proof. -/
def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/-- thisRepoSeparates: encodings are not proofs and are not markdown form. -/
def thisRepoSeparates : Prop :=
  Layer.leanSpecEncoding ≠ Layer.leanProof ∧
    Layer.humanMarkdownContract ≠ Layer.leanSpecEncoding ∧
    Layer.humanMarkdownContract ≠ Layer.leanProof ∧
    Home.thisSpecificationsRepo.mayUnifySpecProofImpl = false

def productTreeUnifies : Prop :=
  Home.systemsLeanProductTree.mayUnifySpecProofImpl = true

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

def dontTrustVerifyUrl : String :=
  "https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html"

def essaysAreUnlicenseGrant : Bool := false

def essaysMayBeVendoredAsForm2 : Bool := false

def theoremsCoverExactlyWhatTheyState : Bool := true

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Number 0009 is Public Domain Open Source Software (PDOSS). Unlicense remains the license. The word catalog is owned by CATE. -/
def numberNineAssigned : Bool := true

/-- Every published numbered markdown has a sibling `NNNN_descriptive_name.lean` at the repository root. -/
def siblingLineEncodingsRequired : Bool := true

/-- Proofs of those encodings live in `lean/Proofs_NNNN.lean`, not in the sibling encoding. -/
def siblingProofsAreSeparateModules : Bool := true

/-- A mash of sibling line encodings and their proofs does not conform here. -/
def mashedSiblingEncodingAndProofsConform : Bool := false

def mashedSiblingIsNonconforming : Prop :=
  mashedSiblingEncodingAndProofsConform = false

/--
  One Formal Vibefication effort as a science cycle.
  Hypothesis, model, theory, proof, tests, and corollary experiments
  are the required set. Tests are necessary and are not sufficient.
-/
structure ScienceEffort where
  hasHypothesis : Bool
  hasModel : Bool
  hasTheory : Bool
  hasProof : Bool
  hasTests : Bool
  hasCorollaryExperiments : Bool
  deriving DecidableEq, Repr, BEq

/-- Product check: hypothesis, model, theory, proof, tests, and corollary experiments. -/
def conformingScience (e : ScienceEffort) : Bool :=
  e.hasHypothesis && e.hasModel && e.hasTheory && e.hasProof &&
    e.hasTests && e.hasCorollaryExperiments

/-- Fixture: executable tests and no Lean (or other formal) model. -/
def testsWithoutModelFixture : ScienceEffort :=
  { hasHypothesis := false
    hasModel := false
    hasTheory := false
    hasProof := false
    hasTests := true
    hasCorollaryExperiments := false }

/-- Fixture: model and proofs, and no observation of the running system. -/
def modelAndProofsWithoutExperimentsFixture : ScienceEffort :=
  { hasHypothesis := true
    hasModel := true
    hasTheory := true
    hasProof := true
    hasTests := true
    hasCorollaryExperiments := false }

/-- Fixture: hypothesis, model, theory, proof, tests, and corollary experiments. -/
def completeScienceFixture : ScienceEffort :=
  { hasHypothesis := true
    hasModel := true
    hasTheory := true
    hasProof := true
    hasTests := true
    hasCorollaryExperiments := true }

def testsAloneAreSufficient : Bool := false

def testsWithoutModelDoesNotConform : Prop :=
  conformingScience testsWithoutModelFixture = false

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  conformingScience modelAndProofsWithoutExperimentsFixture = false

def completeScienceConforms : Prop :=
  conformingScience completeScienceFixture = true

def testsWithoutModelFixtureHasTests : Prop :=
  testsWithoutModelFixture.hasTests = true

def testsWithoutModelFixtureHasNoModel : Prop :=
  testsWithoutModelFixture.hasModel = false

def modelAndProofsWithoutExperimentsFixtureHasModel : Prop :=
  modelAndProofsWithoutExperimentsFixture.hasModel = true

def modelAndProofsWithoutExperimentsFixtureHasProof : Prop :=
  modelAndProofsWithoutExperimentsFixture.hasProof = true

def modelAndProofsWithoutExperimentsFixtureHasNoExperiments : Prop :=
  modelAndProofsWithoutExperimentsFixture.hasCorollaryExperiments = false

/--
  Named science cycle steps as specification 0008 names them.
  Distinct constructors. A mash of two names as one constructor is False.
-/
inductive ScienceStep where
  | hypothesis
  | model
  | theory
  | proof
  | tests
  | corollaryExperiment
  deriving DecidableEq, Repr, BEq

/--
  A chain of science steps. Empty is the identity for composition.
  Concatenation composes two chains. This is not a mash of encodings and proofs.
-/
inductive ScienceCycle where
  | empty
  | cons : ScienceStep → ScienceCycle → ScienceCycle
  deriving DecidableEq, Repr, BEq

def ScienceCycle.append : ScienceCycle → ScienceCycle → ScienceCycle
  | .empty, c => c
  | .cons s rest, c => .cons s (rest.append c)

/-- Composition of two science cycles. Empty is identity. -/
def composeScience (a b : ScienceCycle) : ScienceCycle :=
  a.append b

def ScienceCycle.singleton (s : ScienceStep) : ScienceCycle :=
  .cons s .empty

def ScienceCycle.toList : ScienceCycle → List ScienceStep
  | .empty => []
  | .cons s rest => s :: rest.toList

def ScienceCycle.fromList : List ScienceStep → ScienceCycle
  | [] => .empty
  | s :: rest => .cons s (fromList rest)

def requiredScienceSteps : List ScienceStep :=
  [.hypothesis, .model, .theory, .proof, .tests, .corollaryExperiment]

def ScienceCycle.containsAllRequired (c : ScienceCycle) : Bool :=
  requiredScienceSteps.all (fun s => c.toList.contains s)

def ScienceCycle.toEffort (c : ScienceCycle) : ScienceEffort :=
  let xs := c.toList
  { hasHypothesis := xs.contains .hypothesis
    hasModel := xs.contains .model
    hasTheory := xs.contains .theory
    hasProof := xs.contains .proof
    hasTests := xs.contains .tests
    hasCorollaryExperiments := xs.contains .corollaryExperiment }

/-- First half of the cycle: hypothesis, then model, then theory. -/
def hypothesisThroughTheory : ScienceCycle :=
  composeScience (ScienceCycle.singleton .hypothesis)
    (composeScience (ScienceCycle.singleton .model)
      (ScienceCycle.singleton .theory))

/-- Second half of the cycle: proof, then tests, then corollary experiment. -/
def proofThroughExperiments : ScienceCycle :=
  composeScience (ScienceCycle.singleton .proof)
    (composeScience (ScienceCycle.singleton .tests)
      (ScienceCycle.singleton .corollaryExperiment))

/--
  The required Formal Vibefication science cycle as composition of the two
  halves. Not a mashed claim that one constructor is every step.
-/
def composedCycle : ScienceCycle :=
  composeScience hypothesisThroughTheory proofThroughExperiments

def testsOnlyCycle : ScienceCycle :=
  ScienceCycle.singleton .tests

/-- Treating hypothesis as if it were the model constructor. -/
def mashScienceSteps : Prop :=
  ScienceStep.hypothesis = ScienceStep.model

def mashScienceStepsIsFalse : Prop :=
  mashScienceSteps → False

def scienceStepsPairwiseDistinct : Prop :=
  ScienceStep.hypothesis ≠ ScienceStep.model ∧
    ScienceStep.hypothesis ≠ ScienceStep.theory ∧
    ScienceStep.hypothesis ≠ ScienceStep.proof ∧
    ScienceStep.hypothesis ≠ ScienceStep.tests ∧
    ScienceStep.hypothesis ≠ ScienceStep.corollaryExperiment ∧
    ScienceStep.model ≠ ScienceStep.theory ∧
    ScienceStep.model ≠ ScienceStep.proof ∧
    ScienceStep.model ≠ ScienceStep.tests ∧
    ScienceStep.model ≠ ScienceStep.corollaryExperiment ∧
    ScienceStep.theory ≠ ScienceStep.proof ∧
    ScienceStep.theory ≠ ScienceStep.tests ∧
    ScienceStep.theory ≠ ScienceStep.corollaryExperiment ∧
    ScienceStep.proof ≠ ScienceStep.tests ∧
    ScienceStep.proof ≠ ScienceStep.corollaryExperiment ∧
    ScienceStep.tests ≠ ScienceStep.corollaryExperiment

def scienceCycleAppendLeftId : Prop :=
  ∀ c, composeScience ScienceCycle.empty c = c

def scienceCycleAppendRightId : Prop :=
  ∀ c, composeScience c ScienceCycle.empty = c

def scienceCycleAppendAssoc : Prop :=
  ∀ a b c, composeScience (composeScience a b) c = composeScience a (composeScience b c)

def composedCycleEqualsRequiredList : Prop :=
  ScienceCycle.toList composedCycle = requiredScienceSteps

def composedCycleContainsAllRequired : Prop :=
  ScienceCycle.containsAllRequired composedCycle = true

def composedCycleConforms : Prop :=
  conformingScience (ScienceCycle.toEffort composedCycle) = true

def testsOnlyCycleDoesNotCompose : Prop :=
  ScienceCycle.containsAllRequired testsOnlyCycle = false

/--
  Science cycle composition: the composed cycle is the required list in
  order, that cycle is a conforming effort, a tests only chain is not,
  and mashing two named steps as one constructor is False.
-/
def scienceCycleComposes : Prop :=
  composedCycleEqualsRequiredList ∧
    composedCycleConforms ∧
    testsOnlyCycleDoesNotCompose ∧
    mashScienceStepsIsFalse

/--
  Leftover science cycle honesty: encodings of the cycle, and tests of
  those encodings, are not corollary experiments of the products named
  in this specification.
-/
def leftoverScienceCycleHonesty : Bool := true

def encodingTestsAreProductCorollaryExperiments : Bool := false

/-- Distinct constructors. Leftover encodings are not product experiments. -/
inductive ScienceHonestyLayer where
  | leftoverCycleEncodings
  | productCorollaryExperiments
  deriving DecidableEq, Repr, BEq

/-- Treating leftover cycle encodings as if product corollary experiments already ran. -/
def mashLeftoverScienceWithProductExperiments : Prop :=
  ScienceHonestyLayer.leftoverCycleEncodings =
    ScienceHonestyLayer.productCorollaryExperiments

def mashLeftoverScienceWithProductExperimentsIsFalse : Prop :=
  mashLeftoverScienceWithProductExperiments → False

/--
  Leftover Cons cycle: hypothesis, model, theory, proof, and tests, with
  no corollary experiment. This is not the tests only cycle.
-/
def leftoverCycleMissingExperiments : ScienceCycle :=
  .cons .hypothesis
    (.cons .model
      (.cons .theory
        (.cons .proof
          (.cons .tests .empty))))

def leftoverCycleMissingExperimentsDoesNotCompose : Prop :=
  ScienceCycle.containsAllRequired leftoverCycleMissingExperiments = false

def leftoverCycleMissingExperimentsHasNoCorollary : Prop :=
  (ScienceCycle.toEffort leftoverCycleMissingExperiments).hasCorollaryExperiments =
    false

def leftoverCycleIsNotTestsOnly : Prop :=
  leftoverCycleMissingExperiments ≠ testsOnlyCycle

/--
  Unpinned philosophy PDFs: local copies for readers, publisher URL, and
  a Clause 12 Form 2 pin are distinct. Local copies are not Form 2 pins
  and do not replace the publisher page.
-/
inductive PhilosophyArtifact where
  | publisherUrl
  | localPhilosophyPdf
  | clause12Form2Pin
  deriving DecidableEq, Repr, BEq

def localPhilosophyPdfPath : String := "ref/philosophy/proofofkeags/"

def localPhilosophyPdfHonestyPath : String :=
  "ref/philosophy/proofofkeags/SOURCE.md"

def philosophyPdfsAreClause12Form2Pins : Bool := false

def philosophyPdfsReplacePublisherUrl : Bool := false

/-- Treating local philosophy PDFs as a Clause 12 Form 2 pin. -/
def mashLocalPdfAsClause12Pin : Prop :=
  PhilosophyArtifact.localPhilosophyPdf = PhilosophyArtifact.clause12Form2Pin

def mashLocalPdfAsClause12PinIsFalse : Prop :=
  mashLocalPdfAsClause12Pin → False

/-- Treating local philosophy PDFs as the publisher URL layer. -/
def mashLocalPdfAsPublisherUrl : Prop :=
  PhilosophyArtifact.localPhilosophyPdf = PhilosophyArtifact.publisherUrl

def mashLocalPdfAsPublisherUrlIsFalse : Prop :=
  mashLocalPdfAsPublisherUrl → False

def leftoverHonestyComposes : Prop :=
  leftoverScienceCycleHonesty = true ∧
    encodingTestsAreProductCorollaryExperiments = false ∧
    leftoverCycleMissingExperimentsDoesNotCompose ∧
    leftoverCycleIsNotTestsOnly ∧
    mashLeftoverScienceWithProductExperimentsIsFalse ∧
    philosophyPdfsAreClause12Form2Pins = false ∧
    philosophyPdfsReplacePublisherUrl = false ∧
    essaysMayBeVendoredAsForm2 = false ∧
    mashLocalPdfAsClause12PinIsFalse ∧
    mashLocalPdfAsPublisherUrlIsFalse

end FormalVibeficationSpec
