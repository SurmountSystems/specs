/-
  SPEC ENCODINGS for numbered specification 0016 Hierarchical Subagents.

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in HierarchicalSubagentsProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not claim a conforming hierarchical subagent program.
  Clause 4.11 sampling figures are informative. They are not required
  conjuncts. This model does not restate the session bus.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

namespace HierarchicalSubagentsSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0016. Same shape as sessionBusSpecNumber. -/
def hierarchicalSubagentsSpecNumber : Nat := 16

def specNumber : Nat := 16

def specFileName : String := "0016_Hierarchical_Subagents.md"

def productName : String := "Hierarchical Subagents"

def specVersion : String := "0.1.0"

def specVersionDate : String := "20261026"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Clause 1. A conforming hierarchical subagent program is not claimed. -/
def conformingProgramClaimed : Bool := false

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

def earlierShippedVersionClaimed : Bool := false

def companionFilesClaimedAlreadyPresent : Bool := false

/--
  Clause 4.1. Four layers. There is no fifth constructor.
  L0 is the laptop coordinator. L0 is not a nested agent.
-/
inductive Layer where
  | L0
  | L1
  | L2
  | L3
  deriving DecidableEq, Repr, BEq

def depthIndex : Layer → Nat
  | .L0 => 0
  | .L1 => 1
  | .L2 => 2
  | .L3 => 3

def crateNameL0 : String := "surmount-coordinator-gui"

def callNameL0 : String := "grok-oss gui"

def l0Role : String := "laptop coordinator"

def l1Role : String := "main session"

def l2Role : String := "coordinator"

def l3Role : String := "specialist"

def l0QueuesPrompts : Bool := true

/-- Clause 3 item 1 and Clause 4.1 item 1. L0 is not a nested agent. -/
def l0IsNestedAgent : Bool := false

/-- Clause 4.1 item 2. This specification does not say L0 merges into a pager dashboard. -/
def l0MergesIntoPagerDashboard : Bool := false

/-- Clause 3 item 2. The call name is informative. -/
def callNameIsInformative : Bool := true

def isNestedAgent : Layer → Bool
  | .L0 => false
  | .L1 => true
  | .L2 => true
  | .L3 => true

/-- Clause 4.1 item 4. The word coordinator means L2 only. -/
def wordCoordinatorMeansL2Only : Bool := true

/-- Clause 4.1 item 5. The word specialist means L3 only. -/
def wordSpecialistMeansL3Only : Bool := true

/-- Clause 4.6 item 4. An L3 is not called a coordinator. -/
def l3CalledCoordinator : Bool := false

/--
  Clause 4.3 and Clause 4.6. Spawn has exactly two introductions.
  L1 spawns L2. L2 spawns L3. There is no third introduction.
-/
inductive CanSpawn : Layer → Layer → Prop where
  | l1SpawnsL2 : CanSpawn Layer.L1 Layer.L2
  | l2SpawnsL3 : CanSpawn Layer.L2 Layer.L3

/--
  Clause 4.2. `parent` and `child` are banned layer words.
  They are not names for L1 or L2. The other constructors are allowed words.
-/
inductive LayerWord where
  | coordinator
  | specialist
  | layer
  | parent
  | child
  deriving DecidableEq, Repr, BEq

def badLayerWord (w : LayerWord) : Bool :=
  match w with
  | .parent => true
  | .child => true
  | .coordinator => false
  | .specialist => false
  | .layer => false

/-- A word satisfies the naming rule when it is not a banned layer word. -/
def satisfiesNamingRule (w : LayerWord) : Bool :=
  !badLayerWord w

/-- Clause 4.2 item 2. Layers are not compared to operating system process trees. -/
def comparesLayersToProcessTrees : Bool := false

/-- Clause 4.2 item 3. This document does not use that process phrase for an agent. -/
def usesProcessPhraseForAgent : Bool := false

/-- Clause 4.2 item 4. A handoff file is a report. It is not a join. -/
inductive HandoffName where
  | report
  | join
  deriving DecidableEq, Repr, BEq

def handoffNameConforms : HandoffName → Bool
  | .report => true
  | .join => false

/--
  Clause 4.2 item 5. Optional permission to name parallelism that forks
  work and then combines the results. Not a required conjunct.
  It does not allow a banned layer word.
-/
def mayNameForkThenCombine : Bool := true

/-- Clause 4.3. Tool work runs three layers deep, including implement loops. -/
def toolWorkRunsThreeLayersDeep : Bool := true

def includesImplementLoops : Bool := true

/-- Clause 4.4 item 3. The three fast path acts. There is no fourth constructor. -/
inductive FastPathAct where
  | hostCommand
  | alreadyNamedPathRead
  | quoteAskedReport
  deriving DecidableEq, Repr, BEq

/--
  Clause 4.4. L3 file work is the tool act for file work.
  The fast path constructor is L1 only and is not an edit.
  `refusedOneLineEdit` is named so the later notes' fourth act can be
  refused. No `ToolUse` introduction allows it. Clause 6.4 item 1.
-/
inductive ToolAct where
  | l3FileWork
  | fastPath (act : FastPathAct)
  | refusedOneLineEdit
  deriving DecidableEq, Repr, BEq

def isEdit (act : ToolAct) : Bool :=
  match act with
  | .l3FileWork => true
  | .refusedOneLineEdit => true
  | .fastPath _ => false

/-- Exactly two introductions: L3 file work, and the L1 fast path. -/
inductive ToolUse : Layer → ToolAct → Prop where
  | l3DoesFileWork : ToolUse Layer.L3 ToolAct.l3FileWork
  | l1FastPath : (act : FastPathAct) → ToolUse Layer.L1 (ToolAct.fastPath act)

def fastPathActCount : Nat := 3

/-- Clause 4.4 item 4. No fourth act on that path. -/
def fourthFastPathActPermitted : Bool := false

/-- Clause 6.4 item 1. A single line edit on the fast path is out of scope. -/
def oneLineEditOnFastPath : Bool := false

/-- Clause 4.4 item 5. The fast path does not appear in the L2 task description. -/
def fastPathInL2TaskDescription : Bool := false

/-- Clause 4.4 item 2. L1 does not edit product code or docs. -/
def l1EditsProductCode : Bool := false

def l1EditsDocs : Bool := false

/-- Clause 4.4 item 1. Duty names, in clause order. -/
def l1DutyNames : List String :=
  ["status", "spawn an L2", "wait", "read short reports", "board upsert"]

def l1KeepsNamedDuties : Bool := true

/-- Clause 4.5 item 1. What an L2 does. -/
def l2ParallelizesDisjointWork : Bool := true

def l2SpawnsL3 : Bool := true

def l2Waits : Bool := true

def l2ReadsL3Report : Bool := true

def l2WritesOneReport : Bool := true

def l2BoardUpsert : Bool := true

def l2DiscardsContextAfterReport : Bool := true

/-- Clause 4.5 item 2. An L2 does not do these. -/
def l2MayGrep : Bool := false

def l2MayReadProductFiles : Bool := false

def l2MayDiagnose : Bool := false

def l2MayEdit : Bool := false

def l2MayImplement : Bool := false

def l2MayReview : Bool := false

/--
  Clause 4.5 items 3 and 4. The two named spawn rules are nonconforming.
  The conforming rule is that an L2 coordinates and the L3 does the file work.
-/
inductive SpawnRule where
  | l2CoordinatesOnly
  | easyWorkStaysOnL2
  | spawnL3OnlyWhenHard
  deriving DecidableEq, Repr, BEq

def spawnRuleConforms : SpawnRule → Bool
  | .l2CoordinatesOnly => true
  | .easyWorkStaysOnL2 => false
  | .spawnL3OnlyWhenHard => false

/-- Clause 4.5 item 5. Compacting because the L2 ran implement tools is nonconforming. -/
def l2CompactsBecauseItRanImplementTools : Bool := false

/-- Clause 4.5 item 6. Clarifications go to the L2. The L3 stays undisturbed. -/
def clarificationTargetIsL2 : Bool := true

def l3StaysUndisturbed : Bool := true

/-- Clause 4.6. An L3 implements, researches, or reviews. It does not coordinate or spawn. -/
def l3MayImplement : Bool := true

def l3MayResearch : Bool := true

def l3MayReview : Bool := true

def l3Coordinates : Bool := false

def l3Spawns : Bool := false

/-- Clause 4.7. Report home on the host, not in the repository. -/
def reportHome : String := "~/.agents/reports/"

def reportsWrittenInRepository : Bool := false

/-- Clause 4.7 item 3. The four required report parts. -/
structure ReportContents where
  statesWhatChanged : Bool
  statesHowVerified : Bool
  statesWhatRemains : Bool
  statesQuestionForOperator : Bool
  deriving DecidableEq, Repr, BEq

def reportContentsComplete (r : ReportContents) : Bool :=
  r.statesWhatChanged &&
    r.statesHowVerified &&
    r.statesWhatRemains &&
    r.statesQuestionForOperator

def canonicalReport : ReportContents :=
  { statesWhatChanged := true
    statesHowVerified := true
    statesWhatRemains := true
    statesQuestionForOperator := true }

/-- Clause 4.8. Nested exploration and implementation start only after Approve. -/
inductive PlanPhase where
  | writingOrPresenting
  | afterApprove
  deriving DecidableEq, Repr, BEq

def nestedWorkMayStart : PlanPhase → Bool
  | .writingOrPresenting => false
  | .afterApprove => true

/-- Clause 4.9. Parallelism has no integer cap in this specification. -/
def disjointWriteSetsRunParallel : Bool := true

def parallelCountSetToInteger : Bool := false

def sharedFileRunsInSequence : Bool := true

def l2StaysListedUntilOwnReport : Bool := true

/--
  Clause 4.9 items 5 and 6. Finished only with the L2 report, and not
  when the exit was only a spawn.
-/
def treatedAsFinished (wroteOwnReport onlySpawned : Bool) : Bool :=
  wroteOwnReport && !onlySpawned

def exitAfterOnlySpawningIsFinished : Bool := false

def exitWithoutReportIsFinished : Bool := false

/-- Clause 4.10. One dedicated L2, one job, nice 19. -/
def longBuildDedicatedL2Count : Nat := 1

def longBuildJobCount : Nat := 1

def longBuildNice : Nat := 19

def longBuildParallelized : Bool := false

def longBuildTerminatedEarly : Bool := false

def otherWorkContinuesDuringLongBuild : Bool := true

/--
  Clause 4.11. Informative records. Not required conjuncts.
  No named enforcer function. 200k is the nested record. 500k is the L1 catalog record.
-/
def samplingCapIsInformative : Bool := true

def samplingEnforcerNamed : Bool := false

def nestedSamplingCapLabel : String := "200k"

def l1CatalogWindowLabel : String := "500k"

def nestedSamplingCapK : Nat := 200

def l1CatalogWindowK : Nat := 500

def recordedNestedTestName : String :=
  "nested_session_sampling_window_stays_200k_when_catalog_is_500k"

def recordedL1TestName : String :=
  "main_session_sampling_window_is_catalog_500k_even_when_economic_is_on"

def refreshContextUsedName : String := "refresh_context_used"

def refreshContextUsedIsEnforcer : Bool := false

def samplingTestsClaimedRunFromHere : Bool := false

/--
  Clause 4.12. Finished requires a written report, plan acceptance, and
  the owed outcome on disk. A passing test is recorded and is not enough.
-/
structure WorkRecord where
  reportWritten : Bool
  planAccepted : Bool
  owedOutcomeLandedOnDisk : Bool
  passingTest : Bool
  deriving DecidableEq, Repr, BEq

def finished (w : WorkRecord) : Bool :=
  w.reportWritten && w.planAccepted && w.owedOutcomeLandedOnDisk

def recordWithoutReport (accepted owed test : Bool) : WorkRecord :=
  { reportWritten := false
    planAccepted := accepted
    owedOutcomeLandedOnDisk := owed
    passingTest := test }

def passingTestAlone : WorkRecord :=
  { reportWritten := false
    planAccepted := false
    owedOutcomeLandedOnDisk := false
    passingTest := true }

def passingTestAloneIsFinished : Bool := false

def remainingWorkGoesToProjectResidualHome : Bool := true

def nextResidualStepIsHighestValue : Bool := true

/-- Clause 4.12 item 4. Do not recreate those files in this repository. -/
def recreatesInventoryOrResidual : Bool := false

/-- Clause 4.13. A failing test comes first only when the change is a behavior change. -/
inductive ChangeKind where
  | behavior
  | notBehavior
  deriving DecidableEq, Repr, BEq

def failingTestFirstRequired : ChangeKind → Bool
  | .behavior => true
  | .notBehavior => false

/-- Clause 4.14. Repetition is a process defect. A chat promise is not the repair. -/
def repeatedInstructionIsProcessDefect : Bool := true

def chatPromiseIsRepair : Bool := false

inductive DurablePlace where
  | agentsFile
  | skill
  | check
  | chatPromise
  deriving DecidableEq, Repr, BEq

def repairPlaceConforms : DurablePlace → Bool
  | .agentsFile => true
  | .skill => true
  | .check => true
  | .chatPromise => false

/-- Clause 4.14 item 4. Specification 0006 does not state this repetition rule. -/
def rsiStatesRepetitionRule : Bool := false

def rsiSaysChatReminderIsNotDurableTool : Bool := true

/-- Clause 1. This model does not restate the session bus. -/
def restatesSessionBus : Bool := false

/-- Clause 4.1 item 7. Specification 0015 does not define these layer names. -/
def sessionBusDefinesLayers : Bool := false

def pretendsSessionBusDefinesLayers : Bool := false

def number0016IsSessionBus : Bool := false

/-- Clause 1.1. This document does not replace those specifications. -/
def cateSpecNumber : Nat := 5

def rsiSpecNumber : Nat := 6

def ciSpecNumber : Nat := 7

def formalVibeficationSpecNumber : Nat := 8

def pdossSpecNumber : Nat := 9

def sessionBusSpecNumber : Nat := 15

def cateIsThisSpecification : Bool := false

def rsiIsThisSpecification : Bool := false

def formalVibeficationIsThisSpecification : Bool := false

def pdossIsThisSpecification : Bool := false

def ciStatesLongBuildRule : Bool := false

/-- Clause 1.2 item 6. spec_check is form, not meaning. -/
def specCheckIsMeaningChecker : Bool := false

/-- Clause 6.1. fargo and Carbonado stay unassigned. This number is not stolen onto them. -/
def fargoAssignedNumber : Bool := false

def carbonadoAssignedNumber : Bool := false

def assigns0016ToFargo : Bool := false

def assigns0016ToCarbonado : Bool := false

def stealsNumbers0005Through0015 : Bool := false

def inventsNumberAfter0016 : Bool := false

/-- Clause 6.4. Choices this specification does not make. -/
def choosesPersonaFileReader : Bool := false

def amendsOtherReposThatSayParent : Bool := false

def amends0000FirstPublication : Bool := false

def wiresLakeOrNix : Bool := false

/-- Clause 5, after the list. This markdown file is not itself that program. -/
inductive ArtifactKind where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

def markdownIsNotTheProgram : Bool :=
  !(ArtifactKind.humanMarkdownContract == ArtifactKind.productImplementation)

/-- Clause 1.2 item 5 and Clause 3.5 of specification 0008. Distinct module roles. -/
structure LeanModuleRole where
  moduleName : String
  containsSpecEncodings : Bool
  containsProofsOfThoseEncodings : Bool
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  deriving DecidableEq, Repr, BEq

def hidesSplit (m : LeanModuleRole) : Bool :=
  m.containsSpecEncodings && m.containsProofsOfThoseEncodings

def conformingThisRepo (m : LeanModuleRole) : Bool :=
  !hidesSplit m &&
    (!m.containsSpecEncodings || (m.markedAsSpecEncoding && !m.markedAsProof)) &&
    (!m.containsProofsOfThoseEncodings || (m.markedAsProof && !m.markedAsSpecEncoding))

def specEncodingFixture : LeanModuleRole :=
  { moduleName := "HierarchicalSubagentsSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "HierarchicalSubagentsProofs"
    containsSpecEncodings := false
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := false
    markedAsProof := true }

def mashedFixture : LeanModuleRole :=
  { moduleName := "MashedSpecAndProof"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := true
    markedAsProof := true }

def mashedIsNonconformingThisRepo : Prop :=
  conformingThisRepo mashedFixture = false

/-- Clause 4.5 of specification 0008. A mash of spec encoding and proof is False. -/
def mashSpecAndProof : Prop :=
  ArtifactKind.leanSpecEncoding = ArtifactKind.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/--
  Claiming a conforming program is the proposition that the false flag is true.
  A Bool flag defined as false is not an inconsistency.
-/
def mashConformingProgramClaimed : Prop :=
  conformingProgramClaimed = true

def mashConformingProgramClaimedIsFalse : Prop :=
  mashConformingProgramClaimed → False

def mashProductsClaimedReady : Prop :=
  productsClaimedReadyForUse = true

def mashProductsClaimedReadyIsFalse : Prop :=
  mashProductsClaimedReady → False

def mashProductsNeverStarted : Prop :=
  productsClaimedNeverStarted = true

def mashProductsNeverStartedIsFalse : Prop :=
  mashProductsNeverStarted → False

/-- What the spawn and depth clauses require. -/
def depthModel : Prop :=
  CanSpawn Layer.L1 Layer.L2 ∧
    CanSpawn Layer.L2 Layer.L3 ∧
    (∀ layer : Layer,
      layer = Layer.L0 ∨ layer = Layer.L1 ∨ layer = Layer.L2 ∨ layer = Layer.L3) ∧
    (∀ tgt : Layer, ¬ CanSpawn Layer.L0 tgt) ∧
    (∀ tgt : Layer, ¬ CanSpawn Layer.L3 tgt) ∧
    (¬ CanSpawn Layer.L1 Layer.L3) ∧
    (¬ CanSpawn Layer.L2 Layer.L0) ∧
    (¬ CanSpawn Layer.L2 Layer.L1) ∧
    (¬ CanSpawn Layer.L2 Layer.L2) ∧
    (∀ a b c d : Layer, ¬ (CanSpawn a b ∧ CanSpawn b c ∧ CanSpawn c d)) ∧
    (∀ layer : Layer, depthIndex layer ≤ 3) ∧
    (∀ src tgt : Layer, CanSpawn src tgt → depthIndex tgt = depthIndex src + 1)

/-- What the tool clauses require. The fast path is not an edit. -/
def toolModel : Prop :=
  (∀ act : ToolAct, ¬ ToolUse Layer.L0 act) ∧
    (∀ act : ToolAct, ¬ ToolUse Layer.L2 act) ∧
    (∀ act : ToolAct, ToolUse Layer.L1 act → isEdit act = false) ∧
    (∀ fp : FastPathAct, ¬ ToolUse Layer.L3 (ToolAct.fastPath fp)) ∧
    (∀ layer : Layer, ¬ ToolUse layer ToolAct.refusedOneLineEdit) ∧
    (∀ fp : FastPathAct, isEdit (ToolAct.fastPath fp) = false) ∧
    (∀ act : FastPathAct,
      act = FastPathAct.hostCommand ∨
        act = FastPathAct.alreadyNamedPathRead ∨
        act = FastPathAct.quoteAskedReport) ∧
    (∀ act : ToolAct, ToolUse Layer.L1 act → ∃ fp : FastPathAct, act = ToolAct.fastPath fp)

/--
  Clause 4.12 and Clause 4.9. Exiting without a report is not finished.
  A passing test alone is not finished.
-/
def finishedModel : Prop :=
  (∀ accepted owed test : Bool,
      finished (recordWithoutReport accepted owed test) = false) ∧
    (finished passingTestAlone = false) ∧
    (∀ wrote : Bool, treatedAsFinished wrote true = false) ∧
    (∀ onlySpawned : Bool, treatedAsFinished false onlySpawned = false)

/--
  Clause 5 boolean facts. Sampling labels and the 200 and 500 records are
  not in this conjunction. Clause 4.11 says those figures are informative.
-/
def requiredFacts : Prop :=
  hierarchicalSubagentsSpecNumber = 16 ∧
    specNumber = 16 ∧
    hierarchicalSubagentsSpecNumber = specNumber ∧
    specFileName = "0016_Hierarchical_Subagents.md" ∧
    specVersion = "0.1.0" ∧
    specVersionDate = "20261026" ∧
    productName = "Hierarchical Subagents" ∧
    crateNameL0 = "surmount-coordinator-gui" ∧
    callNameL0 = "grok-oss gui" ∧
    l0Role = "laptop coordinator" ∧
    l1Role = "main session" ∧
    l2Role = "coordinator" ∧
    l3Role = "specialist" ∧
    l0QueuesPrompts = true ∧
    l0IsNestedAgent = false ∧
    isNestedAgent Layer.L0 = false ∧
    isNestedAgent Layer.L1 = true ∧
    isNestedAgent Layer.L2 = true ∧
    isNestedAgent Layer.L3 = true ∧
    l0MergesIntoPagerDashboard = false ∧
    callNameIsInformative = true ∧
    wordCoordinatorMeansL2Only = true ∧
    wordSpecialistMeansL3Only = true ∧
    l3CalledCoordinator = false ∧
    depthIndex Layer.L0 = 0 ∧
    depthIndex Layer.L1 = 1 ∧
    depthIndex Layer.L2 = 2 ∧
    depthIndex Layer.L3 = 3 ∧
    satisfiesNamingRule LayerWord.parent = false ∧
    satisfiesNamingRule LayerWord.child = false ∧
    satisfiesNamingRule LayerWord.coordinator = true ∧
    satisfiesNamingRule LayerWord.specialist = true ∧
    satisfiesNamingRule LayerWord.layer = true ∧
    comparesLayersToProcessTrees = false ∧
    usesProcessPhraseForAgent = false ∧
    handoffNameConforms HandoffName.report = true ∧
    handoffNameConforms HandoffName.join = false ∧
    toolWorkRunsThreeLayersDeep = true ∧
    includesImplementLoops = true ∧
    fastPathActCount = 3 ∧
    fourthFastPathActPermitted = false ∧
    oneLineEditOnFastPath = false ∧
    fastPathInL2TaskDescription = false ∧
    l1EditsProductCode = false ∧
    l1EditsDocs = false ∧
    l1KeepsNamedDuties = true ∧
    l1DutyNames = ["status", "spawn an L2", "wait", "read short reports", "board upsert"] ∧
    l2ParallelizesDisjointWork = true ∧
    l2SpawnsL3 = true ∧
    l2Waits = true ∧
    l2ReadsL3Report = true ∧
    l2WritesOneReport = true ∧
    l2BoardUpsert = true ∧
    l2DiscardsContextAfterReport = true ∧
    l2MayGrep = false ∧
    l2MayReadProductFiles = false ∧
    l2MayDiagnose = false ∧
    l2MayEdit = false ∧
    l2MayImplement = false ∧
    l2MayReview = false ∧
    spawnRuleConforms SpawnRule.l2CoordinatesOnly = true ∧
    spawnRuleConforms SpawnRule.easyWorkStaysOnL2 = false ∧
    spawnRuleConforms SpawnRule.spawnL3OnlyWhenHard = false ∧
    l2CompactsBecauseItRanImplementTools = false ∧
    clarificationTargetIsL2 = true ∧
    l3StaysUndisturbed = true ∧
    l3MayImplement = true ∧
    l3MayResearch = true ∧
    l3MayReview = true ∧
    l3Coordinates = false ∧
    l3Spawns = false ∧
    reportHome = "~/.agents/reports/" ∧
    reportsWrittenInRepository = false ∧
    reportContentsComplete canonicalReport = true ∧
    nestedWorkMayStart PlanPhase.writingOrPresenting = false ∧
    nestedWorkMayStart PlanPhase.afterApprove = true ∧
    disjointWriteSetsRunParallel = true ∧
    parallelCountSetToInteger = false ∧
    sharedFileRunsInSequence = true ∧
    l2StaysListedUntilOwnReport = true ∧
    exitAfterOnlySpawningIsFinished = false ∧
    exitWithoutReportIsFinished = false ∧
    longBuildDedicatedL2Count = 1 ∧
    longBuildJobCount = 1 ∧
    longBuildNice = 19 ∧
    longBuildParallelized = false ∧
    longBuildTerminatedEarly = false ∧
    otherWorkContinuesDuringLongBuild = true ∧
    passingTestAloneIsFinished = false ∧
    remainingWorkGoesToProjectResidualHome = true ∧
    nextResidualStepIsHighestValue = true ∧
    recreatesInventoryOrResidual = false ∧
    failingTestFirstRequired ChangeKind.behavior = true ∧
    failingTestFirstRequired ChangeKind.notBehavior = false ∧
    repeatedInstructionIsProcessDefect = true ∧
    chatPromiseIsRepair = false ∧
    repairPlaceConforms DurablePlace.agentsFile = true ∧
    repairPlaceConforms DurablePlace.skill = true ∧
    repairPlaceConforms DurablePlace.check = true ∧
    repairPlaceConforms DurablePlace.chatPromise = false ∧
    rsiStatesRepetitionRule = false ∧
    rsiSaysChatReminderIsNotDurableTool = true ∧
    restatesSessionBus = false ∧
    sessionBusDefinesLayers = false ∧
    pretendsSessionBusDefinesLayers = false ∧
    number0016IsSessionBus = false ∧
    cateSpecNumber = 5 ∧
    rsiSpecNumber = 6 ∧
    ciSpecNumber = 7 ∧
    formalVibeficationSpecNumber = 8 ∧
    pdossSpecNumber = 9 ∧
    sessionBusSpecNumber = 15 ∧
    cateIsThisSpecification = false ∧
    rsiIsThisSpecification = false ∧
    formalVibeficationIsThisSpecification = false ∧
    pdossIsThisSpecification = false ∧
    ciStatesLongBuildRule = false ∧
    specCheckIsMeaningChecker = false ∧
    fargoAssignedNumber = false ∧
    carbonadoAssignedNumber = false ∧
    assigns0016ToFargo = false ∧
    assigns0016ToCarbonado = false ∧
    stealsNumbers0005Through0015 = false ∧
    inventsNumberAfter0016 = false ∧
    choosesPersonaFileReader = false ∧
    amendsOtherReposThatSayParent = false ∧
    amends0000FirstPublication = false ∧
    wiresLakeOrNix = false ∧
    conformingProgramClaimed = false ∧
    productsClaimedReadyForUse = false ∧
    productsClaimedNeverStarted = false ∧
    earlierShippedVersionClaimed = false ∧
    companionFilesClaimedAlreadyPresent = false ∧
    markdownIsNotTheProgram = true ∧
    liveContainsSpecEncodings = true ∧
    liveContainsProofsOfThoseEncodings = false ∧
    markedAsSpecEncoding = true ∧
    markedAsProof = false ∧
    humanMarkdownIsTheHumanContract = true ∧
    humanMarkdownSubstitutesForLeanSpecEncoding = false ∧
    leanProofIsTheSpec = false ∧
    conformingThisRepo specEncodingFixture = true ∧
    conformingThisRepo proofFixture = true ∧
    conformingThisRepo mashedFixture = false ∧
    hidesSplit mashedFixture = true

/--
  Clause 5. Required conformance is these facts together with the depth,
  tool, and finished models. Informative sampling flags are not included.
-/
def requiredPredicates : Prop :=
  requiredFacts ∧ depthModel ∧ toolModel ∧ finishedModel

/-- Same required facts as a Bool, so Clause 5 can be checked by computation. -/
def requiredConformanceHolds : Bool :=
  hierarchicalSubagentsSpecNumber == 16 &&
    specNumber == 16 &&
    hierarchicalSubagentsSpecNumber == specNumber &&
    specFileName == "0016_Hierarchical_Subagents.md" &&
    specVersion == "0.1.0" &&
    specVersionDate == "20261026" &&
    productName == "Hierarchical Subagents" &&
    crateNameL0 == "surmount-coordinator-gui" &&
    callNameL0 == "grok-oss gui" &&
    l0QueuesPrompts &&
    !l0IsNestedAgent &&
    !isNestedAgent Layer.L0 &&
    isNestedAgent Layer.L1 &&
    isNestedAgent Layer.L2 &&
    isNestedAgent Layer.L3 &&
    !l0MergesIntoPagerDashboard &&
    callNameIsInformative &&
    wordCoordinatorMeansL2Only &&
    wordSpecialistMeansL3Only &&
    !l3CalledCoordinator &&
    depthIndex Layer.L0 == 0 &&
    depthIndex Layer.L1 == 1 &&
    depthIndex Layer.L2 == 2 &&
    depthIndex Layer.L3 == 3 &&
    !satisfiesNamingRule LayerWord.parent &&
    !satisfiesNamingRule LayerWord.child &&
    satisfiesNamingRule LayerWord.coordinator &&
    satisfiesNamingRule LayerWord.specialist &&
    satisfiesNamingRule LayerWord.layer &&
    !comparesLayersToProcessTrees &&
    !usesProcessPhraseForAgent &&
    handoffNameConforms HandoffName.report &&
    !handoffNameConforms HandoffName.join &&
    toolWorkRunsThreeLayersDeep &&
    includesImplementLoops &&
    fastPathActCount == 3 &&
    !fourthFastPathActPermitted &&
    !oneLineEditOnFastPath &&
    !fastPathInL2TaskDescription &&
    !l1EditsProductCode &&
    !l1EditsDocs &&
    l1KeepsNamedDuties &&
    l2ParallelizesDisjointWork &&
    l2SpawnsL3 &&
    l2Waits &&
    l2ReadsL3Report &&
    l2WritesOneReport &&
    l2BoardUpsert &&
    l2DiscardsContextAfterReport &&
    !l2MayGrep &&
    !l2MayReadProductFiles &&
    !l2MayDiagnose &&
    !l2MayEdit &&
    !l2MayImplement &&
    !l2MayReview &&
    spawnRuleConforms SpawnRule.l2CoordinatesOnly &&
    !spawnRuleConforms SpawnRule.easyWorkStaysOnL2 &&
    !spawnRuleConforms SpawnRule.spawnL3OnlyWhenHard &&
    !l2CompactsBecauseItRanImplementTools &&
    clarificationTargetIsL2 &&
    l3StaysUndisturbed &&
    l3MayImplement &&
    l3MayResearch &&
    l3MayReview &&
    !l3Coordinates &&
    !l3Spawns &&
    reportHome == "~/.agents/reports/" &&
    !reportsWrittenInRepository &&
    reportContentsComplete canonicalReport &&
    !nestedWorkMayStart PlanPhase.writingOrPresenting &&
    nestedWorkMayStart PlanPhase.afterApprove &&
    disjointWriteSetsRunParallel &&
    !parallelCountSetToInteger &&
    sharedFileRunsInSequence &&
    l2StaysListedUntilOwnReport &&
    !exitAfterOnlySpawningIsFinished &&
    !exitWithoutReportIsFinished &&
    longBuildDedicatedL2Count == 1 &&
    longBuildJobCount == 1 &&
    longBuildNice == 19 &&
    !longBuildParallelized &&
    !longBuildTerminatedEarly &&
    otherWorkContinuesDuringLongBuild &&
    !passingTestAloneIsFinished &&
    remainingWorkGoesToProjectResidualHome &&
    nextResidualStepIsHighestValue &&
    !recreatesInventoryOrResidual &&
    failingTestFirstRequired ChangeKind.behavior &&
    !failingTestFirstRequired ChangeKind.notBehavior &&
    repeatedInstructionIsProcessDefect &&
    !chatPromiseIsRepair &&
    repairPlaceConforms DurablePlace.agentsFile &&
    repairPlaceConforms DurablePlace.skill &&
    repairPlaceConforms DurablePlace.check &&
    !repairPlaceConforms DurablePlace.chatPromise &&
    !rsiStatesRepetitionRule &&
    rsiSaysChatReminderIsNotDurableTool &&
    !restatesSessionBus &&
    !sessionBusDefinesLayers &&
    !pretendsSessionBusDefinesLayers &&
    !number0016IsSessionBus &&
    cateSpecNumber == 5 &&
    rsiSpecNumber == 6 &&
    ciSpecNumber == 7 &&
    formalVibeficationSpecNumber == 8 &&
    pdossSpecNumber == 9 &&
    sessionBusSpecNumber == 15 &&
    !cateIsThisSpecification &&
    !rsiIsThisSpecification &&
    !formalVibeficationIsThisSpecification &&
    !pdossIsThisSpecification &&
    !ciStatesLongBuildRule &&
    !specCheckIsMeaningChecker &&
    !fargoAssignedNumber &&
    !carbonadoAssignedNumber &&
    !assigns0016ToFargo &&
    !assigns0016ToCarbonado &&
    !stealsNumbers0005Through0015 &&
    !inventsNumberAfter0016 &&
    !choosesPersonaFileReader &&
    !amendsOtherReposThatSayParent &&
    !amends0000FirstPublication &&
    !wiresLakeOrNix &&
    !conformingProgramClaimed &&
    !productsClaimedReadyForUse &&
    !productsClaimedNeverStarted &&
    !earlierShippedVersionClaimed &&
    !companionFilesClaimedAlreadyPresent &&
    markdownIsNotTheProgram &&
    liveContainsSpecEncodings &&
    !liveContainsProofsOfThoseEncodings &&
    markedAsSpecEncoding &&
    !markedAsProof &&
    humanMarkdownIsTheHumanContract &&
    !humanMarkdownSubstitutesForLeanSpecEncoding &&
    !leanProofIsTheSpec &&
    conformingThisRepo specEncodingFixture &&
    conformingThisRepo proofFixture &&
    !conformingThisRepo mashedFixture

end HierarchicalSubagentsSpec
