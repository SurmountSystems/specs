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

/-!
  Clause 3.2 and Clause 4.1: a durable tool is a Lean checker, a Nix check,
  a project skill, or a helper next to a compiler that a later session can
  run. A chat reminder is not that tool. Throwaway bash and throwaway Python
  are not the product.
-/

inductive DurableToolKind where
  | leanChecker
  | nixCheck
  | projectSkill
  | helperNextToCompiler
  | chatReminder
  | throwawayBash
  | throwawayPython
  deriving DecidableEq, Repr, BEq

def DurableToolKind.laterSessionCanRun : DurableToolKind → Bool
  | .leanChecker => true
  | .nixCheck => true
  | .projectSkill => true
  | .helperNextToCompiler => true
  | .chatReminder => false
  | .throwawayBash => false
  | .throwawayPython => false

def DurableToolKind.conforming : DurableToolKind → Bool
  | .leanChecker => true
  | .nixCheck => true
  | .projectSkill => true
  | .helperNextToCompiler => true
  | .chatReminder => false
  | .throwawayBash => false
  | .throwawayPython => false

def DurableToolKind.isDisposableScript : DurableToolKind → Bool
  | .throwawayBash => true
  | .throwawayPython => true
  | .leanChecker => false
  | .nixCheck => false
  | .projectSkill => false
  | .helperNextToCompiler => false
  | .chatReminder => false

def DurableToolKind.isProduct : DurableToolKind → Bool
  | .leanChecker => true
  | .nixCheck => true
  | .projectSkill => true
  | .helperNextToCompiler => true
  | .chatReminder => false
  | .throwawayBash => false
  | .throwawayPython => false

def JobApproach.ofTool : DurableToolKind → JobApproach
  | .leanChecker => .improveDurableTool
  | .nixCheck => .improveDurableTool
  | .projectSkill => .improveDurableTool
  | .helperNextToCompiler => .improveDurableTool
  | .chatReminder => .disposableOnce
  | .throwawayBash => .disposableOnce
  | .throwawayPython => .disposableOnce

structure DurableTool where
  kind : DurableToolKind
  laterSessionCanRun : Bool
  nextToCompiler : Bool
  deriving DecidableEq, Repr, BEq

def DurableTool.conforming (t : DurableTool) : Bool :=
  t.kind.conforming &&
    t.laterSessionCanRun &&
    t.nextToCompiler &&
    DurableToolKind.laterSessionCanRun t.kind &&
    !t.kind.isDisposableScript

def specCheckAsDurableTool : DurableTool :=
  { kind := .leanChecker
    laterSessionCanRun := true
    nextToCompiler := true }

def chatReminderAsTool : DurableTool :=
  { kind := .chatReminder
    laterSessionCanRun := false
    nextToCompiler := false }

def throwawayBashAsTool : DurableTool :=
  { kind := .throwawayBash
    laterSessionCanRun := false
    nextToCompiler := false }

/-- Tools improve tools: the destination must remain a durable tool. -/
structure ToolImprovement where
  fromKind : DurableToolKind
  toKind : DurableToolKind
  deriving DecidableEq, Repr, BEq

def ToolImprovement.conforming (i : ToolImprovement) : Bool :=
  i.toKind.conforming && i.toKind.laterSessionCanRun

inductive FactoryOutput where
  | improvedDurableTool
  | performedJobOnce
  deriving DecidableEq, Repr, BEq

def FactoryOutput.conforming : FactoryOutput → Bool
  | .improvedDurableTool => true
  | .performedJobOnce => false

structure ToolFactoryUse where
  jobRepeats : Bool
  output : FactoryOutput
  deriving DecidableEq, Repr, BEq

def ToolFactoryUse.conforming (u : ToolFactoryUse) : Bool :=
  if u.jobRepeats then u.output.conforming else true

/-- Clause 4.1 item 4: encode process improvement is proved by a tool, not chat. -/
inductive EncodeImprovementProof where
  | leanChecker
  | skillStep
  | nixPackage
  | chatReminder
  deriving DecidableEq, Repr, BEq

def EncodeImprovementProof.conforming : EncodeImprovementProof → Bool
  | .leanChecker => true
  | .skillStep => true
  | .nixPackage => true
  | .chatReminder => false

/-- Clause 4.1 item 5 and Clause 4.2 item 3: bash or Python is not Nix check policy. -/
inductive CheckPolicy where
  | leanChecker
  | pureNixEval
  | bashInNix
  | pythonInNix
  deriving DecidableEq, Repr, BEq

def CheckPolicy.conforming : CheckPolicy → Bool
  | .leanChecker => true
  | .pureNixEval => true
  | .bashInNix => false
  | .pythonInNix => false

/-- Clause 3.25 and Clause 4.10: the same English word in more than one tree. -/
structure CollisionTagSet where
  languageNeCompiler : Bool
  markdownNeMeaning : Bool
  meaningNeFormChecker : Bool
  remainingWorkNeFreestandingBlocker : Bool
  meaningNeMlTraining : Bool
  leftoverUnstackOwnedByCate : Bool
  deriving DecidableEq, Repr, BEq

def CollisionTagSet.conforming (s : CollisionTagSet) : Bool :=
  s.languageNeCompiler &&
    s.markdownNeMeaning &&
    s.meaningNeFormChecker &&
    s.remainingWorkNeFreestandingBlocker &&
    s.meaningNeMlTraining &&
    s.leftoverUnstackOwnedByCate

def thisRepoCollisionTags : CollisionTagSet :=
  { languageNeCompiler :=
      Vocabulary.systemsLean.proseName != Vocabulary.slake.proseName
    markdownNeMeaning := !Vocabulary.specMarkdownIsMeaningModel
    meaningNeFormChecker := !Vocabulary.meaningModelIsFormChecker
    remainingWorkNeFreestandingBlocker :=
      !Vocabulary.remainingWorkIsNamedFreestandingBlocker
    meaningNeMlTraining := !Vocabulary.meaningModelIsMlTrainingRun
    leftoverUnstackOwnedByCate :=
      Vocabulary.leftoverUnstackSpecNumber == cateSpecNumber }

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

/-- Clause 3.3 and Clause 4.1 item 4: a chat reminder is not a durable tool. -/
def chatReminderAsDurableToolAccepted : Bool := false

def mashChatReminderAsDurableTool : Prop :=
  chatReminderAsDurableToolAccepted = true

def mashChatReminderAsDurableToolIsFalse : Prop :=
  mashChatReminderAsDurableTool → False

/-- Clause 1 and Clause 4.6 item 2: this specification is not a claim that a model trains itself again in this repository. -/
def rsiIsTrainingRunAccepted : Bool := false

def mashRsiIsTrainingRun : Prop :=
  rsiIsTrainingRunAccepted = true

def mashRsiIsTrainingRunIsFalse : Prop :=
  mashRsiIsTrainingRun → False

/-- Clause 4.6 item 4 and Clause 6.1 item 1: this document does not create SSSP. -/
def thisDocumentCreatesSssp : Bool := false

def mashThisDocumentCreatesSssp : Prop :=
  thisDocumentCreatesSssp = true

def mashThisDocumentCreatesSsspIsFalse : Prop :=
  mashThisDocumentCreatesSssp → False

/-- Clause 6.1 item 1: SSSP has no numbered specification. -/
def mashSsspHasNumberedSpec : Prop :=
  ssspHasNumberedSpec = true

def mashSsspHasNumberedSpecIsFalse : Prop :=
  mashSsspHasNumberedSpec → False

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

def mashSpecClaimsEveryAgentConforms : Prop :=
  specClaimsEveryAgentConforms = true

def mashSpecClaimsEveryAgentConformsIsFalse : Prop :=
  mashSpecClaimsEveryAgentConforms → False

/-- Clause 6.4 item 4: Clause 4 is not already met by every session. -/
def clause4AlreadyMetByEverySession : Bool := false

def mashClause4AlreadyMetByEverySession : Prop :=
  clause4AlreadyMetByEverySession = true

def mashClause4AlreadyMetByEverySessionIsFalse : Prop :=
  mashClause4AlreadyMetByEverySession → False

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

/-- Clause 3.25 item 8 and Clause 4.7: serializing independent streams does not conform. -/
def mashSerializeIndependent : Prop :=
  StreamSchedule.serializeIndependent.conforming = true

def mashSerializeIndependentIsFalse : Prop :=
  mashSerializeIndependent → False

/-- Clause 3.25 item 9 and Clause 4.3: reshaping a test after the product edit does not conform. -/
def mashReshapeTestWithoutContractChange : Prop :=
  reshapeTestToPassWithoutContractChange = true

def mashReshapeTestWithoutContractChangeIsFalse : Prop :=
  mashReshapeTestWithoutContractChange → False

/-- Clause 3.25 item 5: leftover unstack is CATE, not this specification. -/
def mashRsiReplacesLeftoverUnstack : Prop :=
  Vocabulary.rsiReplacesLeftoverUnstack = true

def mashRsiReplacesLeftoverUnstackIsFalse : Prop :=
  mashRsiReplacesLeftoverUnstack → False

/-- Clause 4.8 item 5: this document is not a bitmask specification. -/
def mashRsiIsBitmaskSpec : Prop :=
  rsiIsBitmaskSpec = true

def mashRsiIsBitmaskSpecIsFalse : Prop :=
  mashRsiIsBitmaskSpec → False

/-- Clause 4.5: chat is not the residual record. -/
def mashChatOnlyResidual : Prop :=
  ResidualHome.chatOnly.conforming = true

def mashChatOnlyResidualIsFalse : Prop :=
  mashChatOnlyResidual → False

/-- Clause 1.2 item 5 and Clause 3.25 item 2: meaning proofs are not a second form checker. -/
def mashMeaningProofsAreSecondFormChecker : Prop :=
  Vocabulary.meaningProofsAreSecondFormChecker = true

def mashMeaningProofsAreSecondFormCheckerIsFalse : Prop :=
  mashMeaningProofsAreSecondFormChecker → False

/--
  Continued improvement of the Supercompiler is this specification's loop
  together with delta reconciliation in 0004_SSSSS.md. That improvement
  is not claimed finished.
-/
def supercompilerImprovementIsRsiLoopWithDeltaReconciliation : Bool := true

def supercompilerImprovementFinished : Bool := false

def mashSupercompilerImprovementFinished : Prop :=
  supercompilerImprovementFinished = true

def mashSupercompilerImprovementFinishedIsFalse : Prop :=
  mashSupercompilerImprovementFinished → False

/-!
  Clause 3.25 / 4.10: same English word, different trees.
  Vocabulary uses distinct types so a mash is a type error. These
  theorems pin the RSI model to that vocabulary.
-/

end Rsi
