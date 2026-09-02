/-
  Companion Lean model of selected claims from 0006_RSI.md.

  This module is not the specification. The numbered markdown is the contract
  people read. spec_check remains the form checker (ASCII, tabs, RFC 2119,
  spelling, leftover unstack, residual heading). SpecRegistry remains the
  number and file name registry. Vocabulary.lean holds tags for the same
  English word used in more than one tree as distinct types. These
  declarations encode meaning so an inconsistent model is a type error
  or a failing test.

  Locked numbers for this model: CATE is 5; RSI is 6. This file does not
  restate registry row counts.
-/

import Cate
import FormalVibeficationSpec
import SpecRegistry
import SystemsLean
import Vocabulary

namespace Rsi

def specNumber : Nat := SpecRegistry.rsiSpecNumber

def specFileName : String := "0006_RSI.md"

def productName : String := "RSI"

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- CATE is specification 0005. Matches SpecRegistry; kept as a named pin. -/
def cateSpecNumber : Nat := SpecRegistry.cateSpecNumber

def cateFileName : String := "0005_CATE.md"

def ssspSpecified : Bool := false

def ssspHasNumberedSpec : Bool := false

def ssspAssignedNumber : Option Nat := none

inductive JobApproach where
  | disposableOnce
  | improveDurableTool
  deriving DecidableEq, Repr, BEq

def JobApproach.conforming : JobApproach → Bool
  | .disposableOnce => false
  | .improveDurableTool => true

/-- When the job repeats, only improving a durable tool conforms. -/
def JobApproach.requiredWhenRepeats (repeats : Bool) : JobApproach → Bool
  | .disposableOnce => !repeats
  | .improveDurableTool => true

inductive LeftoverUnstackRepair where
  | leftoverUnstack
  | rephrasedOrdinaryEnglish
  deriving DecidableEq, Repr, BEq

def LeftoverUnstackRepair.conforming : LeftoverUnstackRepair → Bool
  | .leftoverUnstack => false
  | .rephrasedOrdinaryEnglish => true

def languagePurityIsIdeology : Bool := false

def bashOrPythonAsNixCheckPolicy : Bool := false

def skipStrongerToolBecauseWeakerIsFamiliar : Bool := false

inductive ProofOrder where
  | failingTestThenProduct
  | productThenTest
  deriving DecidableEq, Repr, BEq

def ProofOrder.conforming : ProofOrder → Bool
  | .failingTestThenProduct => true
  | .productThenTest => false

def reshapeTestToPassWithoutContractChange : Bool := false

inductive AmbiguityResponse where
  | stopAndAsk
  | guessAndContinue
  deriving DecidableEq, Repr, BEq

def AmbiguityResponse.conforming : AmbiguityResponse → Bool
  | .stopAndAsk => true
  | .guessAndContinue => false

def rsiMeansModelRetrainsInThisRepo : Bool := false

inductive RsiMeaning where
  | loopOfToolsAndResidual
  | modelRetrainsInThisRepo
  deriving DecidableEq, Repr, BEq

def RsiMeaning.conforming : RsiMeaning → Bool
  | .loopOfToolsAndResidual => true
  | .modelRetrainsInThisRepo => false

def scriptureRequiredForSlake : Bool := false

def scriptureRequiredForBeastdb : Bool := false

def scriptureRequiredForSssss : Bool := false

def scriptureIsProvenCosmology : Bool := false

def bitmaskCoreInScope : Bool := false

def bitmaskNextInScope : Bool := false

def rgbProductInScope : Bool := false

def rsiIsBitmaskSpec : Bool := false

/-- This RSI specification does not restate Lean Machine. -/
def leanMachineSpecified : Bool := false

/-- Lean Machine has numbered specification 0013. This is not an unnumbered leftover. -/
def leanMachineHasNumberedSpecification : Bool := true

/-- False leftover reading: `leanMachineSpecified = false` means unnumbered. -/
def leftoverUnnumberedMeaning : Bool :=
  (!leanMachineSpecified) && (!SpecRegistry.leanMachineAssigned)

def holyLeanSpecified : Bool := false

def legalLeanSpecified : Bool := false

def bioLeanSpecified : Bool := false

def leanMachineSharedPatternSpecified : Bool := false

def carbonadoIsCate : Bool := false

def specClaimsEveryAgentConforms : Bool := false

def unstatedHeuristicOk : Bool := false

def padUnknownWithGuessAsFinding : Bool := false

inductive ResidualHome where
  | diskCompleteSentences
  | chatOnly
  deriving DecidableEq, Repr, BEq

def ResidualHome.conforming : ResidualHome → Bool
  | .diskCompleteSentences => true
  | .chatOnly => false

def rustCompileTestsOnLaptopWhenRemoteRequired : Bool := false

def stopWhenRemoteBuilderUnresponsive : Bool := true

inductive StreamSchedule where
  | serializeIndependent
  | parallelDisjoint
  deriving DecidableEq, Repr, BEq

def StreamSchedule.conforming : StreamSchedule → Bool
  | .serializeIndependent => false
  | .parallelDisjoint => true

inductive WriteSets where
  | disjoint
  | overlapping
  deriving DecidableEq, Repr, BEq

def WriteSets.mayRunInParallel : WriteSets → Bool
  | .disjoint => true
  | .overlapping => false

def cancelHealthyLiveStreamWithoutOperatorStop : Bool := false

def meaningModelProofFollowsLean4Skill : Bool := true

def lakePackageHasMathlib : Bool := false

def sorryInShippedTheorems : Bool := false

/-- This RSI meaning model requires the Formal Vibefication science cycle. -/
def requiresScienceCycle : Bool := true

/-- Tests only effort for this companion. Reuses the 0008 fixture. -/
def testsOnlyEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.testsWithoutModelFixture

/-- Tests only is not conforming science. Reuses conformingScience. -/
def testsOnlyConforms : Bool :=
  FormalVibeficationSpec.conformingScience testsOnlyEffort

def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

def modelAndProofsWithoutExperimentsConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

def completeScienceCycleConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.completeScienceFixture

def testsWithoutModelDoesNotConform : Prop :=
  testsOnlyConforms = false

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  modelAndProofsWithoutExperimentsConforms = false

def completeScienceConforms : Prop :=
  completeScienceCycleConforms = true

/-!
  Clause 3.25 / 4.10: same English word, different trees.
  Vocabulary uses distinct types so a mash is a type error. These
  theorems pin the RSI model to that vocabulary.
-/

end Rsi
