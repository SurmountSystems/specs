/-
  Runtime checks for the RSI meaning model (0006_RSI.md).
  Theorems in RsiProofs.lean and VocabularyCollisionProofs.lean already fail to typecheck
  if the model is widened (CATE numbered 0006, fargo numbered 0005,
  leftover unstack treated as conforming, SSSP treated as specified,
  independent streams serialized, Systems Lean mashed with Slake or
  the Lake package id). This executable re-checks the decidable facts
  so a silent Bool regression prints FAIL lines, matching
  spec_check_tests style.

  Registry row counts are owned by SpecRegistry. `cateSpecNumber = 6`
  is false.
-/

import Cate
import Rsi
import RsiProofs
import SpecRegistry
import SystemsLean
import Vocabulary
import VocabularyCollisionProofs

open Rsi
open SpecRegistry

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEmpty {α : Type} [Repr α] (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected empty, got {repr xs}" }

def expectNonEmpty {α : Type} (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := false, detail := "expected diagnostics, got none" }
  else
    { name := name, ok := true }

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

def runCases : List Case :=
  [
    expectEqNat "RSI is specification 0006" specNumber 6,
    expectEqString "spec file is 0006_RSI.md" specFileName "0006_RSI.md",
    expectEqString "product short name is RSI" productName "RSI",
    expectTrue "RSI live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "RSI live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectFalse "vocabulary collision tags do not mash proofs into encodings"
      Vocabulary.liveContainsProofsOfThoseEncodings,
    expectEqNat "CATE is specification 0005" Rsi.cateSpecNumber 5,
    expectFalse "CATE is not specification 0006" (Rsi.cateSpecNumber == 6),
    expectEqString "CATE file is 0005_CATE.md" cateFileName "0005_CATE.md",
    expectTrue "CATE is not specification 0006"
      (Rsi.cateSpecNumber != specNumber),
    expectEqNat "registry CATE number is 5" SpecRegistry.cateSpecNumber 5,
    expectFalse "fargo is not assigned" fargoAssigned,
    expectTrue "fargo is not specification 0005" (!fargoAssigned),
    expectTrue "fargo is not specification 0006" (!fargoAssigned),
    expectFalse "SSSP is not specified" ssspSpecified,
    expectFalse "SSSP has no numbered specification" ssspHasNumberedSpec,
    expectFalse "a disposable job is not conforming"
      JobApproach.disposableOnce.conforming,
    expectTrue "improving a durable tool is conforming"
      JobApproach.improveDurableTool.conforming,
    expectFalse "a repeating job may not be a disposable job"
      (JobApproach.requiredWhenRepeats true .disposableOnce),
    expectTrue "a repeating job must improve a durable tool"
      (JobApproach.requiredWhenRepeats true .improveDurableTool),
    expectFalse "leftover unstack still fails"
      Cate.HyphenRepair.leftoverUnstack.conforming,
    expectFalse "local leftover unstack still fails"
      LeftoverUnstackRepair.leftoverUnstack.conforming,
    expectTrue "rephrased leftover unstack conforms"
      LeftoverUnstackRepair.rephrasedOrdinaryEnglish.conforming,
    expectFalse "language purity is not ideology" languagePurityIsIdeology,
    expectFalse "bash or Python is not Nix check policy"
      bashOrPythonAsNixCheckPolicy,
    expectFalse "do not skip a stronger tool because a weaker one is familiar"
      skipStrongerToolBecauseWeakerIsFamiliar,
    expectTrue "failing test first is conforming"
      ProofOrder.failingTestThenProduct.conforming,
    expectFalse "product then test is not conforming"
      ProofOrder.productThenTest.conforming,
    expectFalse "do not reshape a test without a contract change"
      reshapeTestToPassWithoutContractChange,
    expectTrue "stop and ask is conforming"
      AmbiguityResponse.stopAndAsk.conforming,
    expectFalse "guess and continue is not conforming"
      AmbiguityResponse.guessAndContinue.conforming,
    expectFalse "RSI is not a model retrain in this repository"
      rsiMeansModelRetrainsInThisRepo,
    expectTrue "RSI loop of tools and residual is conforming"
      RsiMeaning.loopOfToolsAndResidual.conforming,
    expectFalse "RSI as a model retrain is not conforming"
      RsiMeaning.modelRetrainsInThisRepo.conforming,
    expectFalse "scripture is not required for Slake" scriptureRequiredForSlake,
    expectFalse "scripture is not required for beastdb"
      scriptureRequiredForBeastdb,
    expectFalse "scripture is not required for SSSSS" scriptureRequiredForSssss,
    expectFalse "scripture is not a proven cosmology"
      scriptureIsProvenCosmology,
    expectFalse "bitmask-core is out of scope" bitmaskCoreInScope,
    expectFalse "bitmask-next is out of scope" bitmaskNextInScope,
    expectFalse "RGB is out of scope as product" rgbProductInScope,
    expectFalse "RSI is not a bitmask specification" rsiIsBitmaskSpec,
    expectFalse "RSI does not specify Lean Machine" leanMachineSpecified,
    expectTrue "Lean Machine is numbered specification 0013"
      leanMachineHasNumberedSpecification,
    expectTrue "registry Lean Machine is assigned"
      SpecRegistry.leanMachineAssigned,
    expectFalse "leftover unnumbered meaning of leanMachineSpecified is false"
      leftoverUnnumberedMeaning,
    expectFalse "Holy Lean is not specified" holyLeanSpecified,
    expectFalse "Legal Lean is not specified" legalLeanSpecified,
    expectFalse "Bio Lean is not specified" bioLeanSpecified,
    expectFalse "a Lean Machine shared pattern is not specified"
      leanMachineSharedPatternSpecified,
    expectFalse "Carbonado is not assigned" carbonadoAssigned,
    expectFalse "Carbonado is not CATE" carbonadoIsCate,
    expectFalse "this spec does not claim every agent conforms"
      specClaimsEveryAgentConforms,
    expectFalse "unstated heuristics are not ok" unstatedHeuristicOk,
    expectFalse "do not pad an unknown as a finding"
      padUnknownWithGuessAsFinding,
    expectTrue "remaining work on disk is conforming"
      ResidualHome.diskCompleteSentences.conforming,
    expectFalse "chat only residual is not conforming"
      ResidualHome.chatOnly.conforming,
    expectFalse "laptop rustc is not the proof when remote is required"
      rustCompileTestsOnLaptopWhenRemoteRequired,
    expectTrue "stop when the remote builder is unresponsive"
      stopWhenRemoteBuilderUnresponsive,
    expectFalse "serializing independent streams is not conforming"
      StreamSchedule.serializeIndependent.conforming,
    expectTrue "parallel disjoint streams are conforming"
      StreamSchedule.parallelDisjoint.conforming,
    expectTrue "disjoint writes may run in parallel"
      WriteSets.disjoint.mayRunInParallel,
    expectFalse "overlapping writes may not run in parallel"
      WriteSets.overlapping.mayRunInParallel,
    expectFalse "do not cancel a healthy live stream without operator stop"
      cancelHealthyLiveStreamWithoutOperatorStop,
    expectTrue "meaning model proving follows project /lean4"
      meaningModelProofFollowsLean4Skill,
    expectFalse "this Lake package has no mathlib" lakePackageHasMathlib,
    expectFalse "shipped theorems do not contain sorry" sorryInShippedTheorems,
    expectEqString "Systems Lean prose name"
      Vocabulary.systemsLean.proseName "Systems Lean",
    expectEqString "Slake prose name" Vocabulary.slake.proseName "Slake",
    expectEqString "Lake package id is SystemsLean"
      Vocabulary.lakePackageId.id "SystemsLean",
    expectTrue "Systems Lean prose is not Slake"
      (Vocabulary.systemsLean.proseName != Vocabulary.slake.proseName),
    expectTrue "Lake package id is not the language prose name"
      (Vocabulary.lakePackageId.id != Vocabulary.systemsLean.proseName),
    expectFalse "Lake package id is not a second language name"
      Vocabulary.lakePackageIdIsSecondLanguageName,
    expectEqString "RSI markdown path" Vocabulary.rsiMarkdown.path "0006_RSI.md",
    expectEqString "RSI meaning module" Vocabulary.rsiMeaning.moduleName "Rsi",
    expectEqString "form checker binary" Vocabulary.specCheckBin.binaryName
      "spec_check",
    expectFalse "meaning model is not the form checker"
      Vocabulary.meaningModelIsFormChecker,
    expectFalse "spec markdown is not the meaning model"
      Vocabulary.specMarkdownIsMeaningModel,
    expectFalse "spec markdown is not the form checker"
      Vocabulary.specMarkdownIsFormChecker,
    expectFalse "meaning proofs are not a second form checker"
      Vocabulary.meaningProofsAreSecondFormChecker,
    expectTrue "remaining work is on disk"
      Vocabulary.remainingWork.completeSentencesOnDisk,
    expectFalse "remaining work is not a named freestanding blocker"
      Vocabulary.remainingWorkIsNamedFreestandingBlocker,
    expectFalse "remaining work is not product residual free"
      Vocabulary.remainingWorkIsProductResidualFree,
    expectFalse "product residual free does not clear remaining work"
      Vocabulary.productResidualFreeClearsRemainingWork,
    expectFalse "meaning model is not a machine learning training run"
      Vocabulary.meaningModelIsMlTrainingRun,
    expectEqNat "leftover unstack is owned by CATE"
      Vocabulary.leftoverUnstackSpecNumber 5,
    expectTrue "leftover unstack is not owned by RSI"
      (Vocabulary.leftoverUnstackSpecNumber != specNumber),
    expectFalse "RSI does not replace leftover unstack"
      Vocabulary.rsiReplacesLeftoverUnstack,
    expectEqString "omega in prose is the ASCII word"
      Vocabulary.omegaProse.word "omega",
    expectEqString "Lean omega constructor is unrestricted"
      Vocabulary.omegaConstructor.name "unrestricted",
    expectTrue "omega prose is not the Lean constructor name"
      (Vocabulary.omegaProse.word != Vocabulary.omegaConstructor.name),
    expectEqString "unrestricted multiplicity prose is omega"
      (Vocabulary.proseOfMultiplicity
        SystemsLean.Multiplicity.unrestricted) "omega",
    expectFalse "scripture is not required for Slake in vocabulary"
      Vocabulary.scriptureSlake.required,
    expectFalse "scripture is not required for beastdb in vocabulary"
      Vocabulary.scriptureBeastdb.required,
    expectFalse "scripture is not required for SSSSS in vocabulary"
      Vocabulary.scriptureSssss.required,
    expectTrue "parallel disjoint streams conform in vocabulary"
      Vocabulary.DisjointStreamRun.parallel.conforming,
    expectFalse "serializing disjoint streams does not conform in vocabulary"
      Vocabulary.DisjointStreamRun.serial.conforming,
    expectTrue "failing test then product conforms in vocabulary"
      Vocabulary.ContractProofOrder.failingTestThenProduct.conforming,
    expectFalse "product then reshape test does not conform in vocabulary"
      Vocabulary.ContractProofOrder.productThenReshapeTest.conforming,
    expectEqString "vocabulary RSI id file" Vocabulary.rsiId.fileName
      "0006_RSI.md",
    expectEqString "vocabulary CATE id file" Vocabulary.cateId.fileName
      "0005_CATE.md",
    expectEqNat "vocabulary RSI number is 6" SpecRegistry.rsiSpecNumber 6,
    expectEqNat "vocabulary CATE number is 5" SpecRegistry.cateSpecNumber 5,
    expectEmpty "correct 0006_RSI token passes"
      (scanContent "0006_RSI.md"
        "This specification is number 0006. File 0006_RSI.md.\n"),
    expectEmpty "0005_CATE token in RSI prose passes"
      (scanContent "0006_RSI.md"
        "CATE is specified in `0005_CATE.md`.\n"),
    expectNonEmpty "stale 0006_CATE token fails"
      (scanContent "0006_RSI.md" "stale file name `0006_CATE.md` must fail.\n"),
    expectNonEmpty "stale 0005_RSI token fails"
      (scanContent "0006_RSI.md" "stale file name `0005_RSI.md` must fail.\n"),
    expectNonEmpty "stale 0005_fargo token fails"
      (scanContent "0006_RSI.md" "planned file name `0005_fargo.md` is stale.\n"),
    expectNonEmpty "identity sentence with wrong number fails"
      (scanContent "0006_RSI.md"
        "This specification is number 0004.\n"),
    expectNonEmpty "missing published 0006 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md", "0005_CATE.md"]),
    expectNonEmpty "wrong published 0005 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md", "0005_fargo.md"]),
    expectTrue "registry numbers are unique" (!hasDupNumbers),
    expectTrue "registry file names are unique" (!hasDupFilenames),
    expectTrue "RSI meaning model requires the science cycle"
      requiresScienceCycle,
    expectFalse "tests without a model do not conform"
      testsOnlyConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsConforms,
    expectTrue "complete science cycle conforms"
      completeScienceCycleConforms,
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient,
    expectTrue "a Lean checker is a durable tool a later session can run"
      DurableToolKind.leanChecker.laterSessionCanRun,
    expectTrue "a Nix check is a durable tool a later session can run"
      DurableToolKind.nixCheck.laterSessionCanRun,
    expectTrue "a project skill is a durable tool a later session can run"
      DurableToolKind.projectSkill.laterSessionCanRun,
    expectTrue "a helper next to a compiler is a durable tool a later session can run"
      DurableToolKind.helperNextToCompiler.laterSessionCanRun,
    expectFalse "a chat reminder is not a durable tool"
      DurableToolKind.chatReminder.conforming,
    expectFalse "a chat reminder is not something a later session can run"
      DurableToolKind.chatReminder.laterSessionCanRun,
    expectFalse "throwaway bash is not a durable tool"
      DurableToolKind.throwawayBash.conforming,
    expectFalse "throwaway Python is not a durable tool"
      DurableToolKind.throwawayPython.conforming,
    expectTrue "throwaway bash is a disposable script"
      DurableToolKind.throwawayBash.isDisposableScript,
    expectTrue "throwaway Python is a disposable script"
      DurableToolKind.throwawayPython.isDisposableScript,
    expectFalse "throwaway bash is not the product"
      DurableToolKind.throwawayBash.isProduct,
    expectFalse "throwaway Python is not the product"
      DurableToolKind.throwawayPython.isProduct,
    expectTrue "spec_check as a Lean checker next to a compiler conforms"
      specCheckAsDurableTool.conforming,
    expectFalse "a chat reminder encoded as a tool does not conform"
      chatReminderAsTool.conforming,
    expectFalse "throwaway bash encoded as a tool does not conform"
      throwawayBashAsTool.conforming,
    expectTrue "improving throwaway bash into a Lean checker conforms"
      (ToolImprovement.mk .throwawayBash .leanChecker).conforming,
    expectFalse "turning a Lean checker into throwaway Python does not conform"
      (ToolImprovement.mk .leanChecker .throwawayPython).conforming,
    expectTrue "a repeating job used as a tool factory that improves a durable tool conforms"
      ({ jobRepeats := true, output := .improvedDurableTool } : ToolFactoryUse).conforming,
    expectFalse "a repeating job performed once as the factory output does not conform"
      ({ jobRepeats := true, output := .performedJobOnce } : ToolFactoryUse).conforming,
    expectTrue "encode process improvement proved by a Lean checker conforms"
      EncodeImprovementProof.leanChecker.conforming,
    expectTrue "encode process improvement proved by a skill step conforms"
      EncodeImprovementProof.skillStep.conforming,
    expectTrue "encode process improvement proved by a Nix package conforms"
      EncodeImprovementProof.nixPackage.conforming,
    expectFalse "encode process improvement proved by a chat reminder does not conform"
      EncodeImprovementProof.chatReminder.conforming,
    expectTrue "Lean checker as check policy conforms"
      CheckPolicy.leanChecker.conforming,
    expectTrue "pure Nix evaluation as check policy conforms"
      CheckPolicy.pureNixEval.conforming,
    expectFalse "bash in Nix as check policy does not conform"
      CheckPolicy.bashInNix.conforming,
    expectFalse "Python in Nix as check policy does not conform"
      CheckPolicy.pythonInNix.conforming,
    expectTrue "this repository collision tag set keeps trees distinct"
      thisRepoCollisionTags.conforming,
    expectTrue "a Lean checker maps to improving a durable tool"
      (JobApproach.ofTool .leanChecker == JobApproach.improveDurableTool),
    expectTrue "throwaway bash maps to a disposable job"
      (JobApproach.ofTool .throwawayBash == JobApproach.disposableOnce),
    expectConsFalse "a chat reminder as a durable tool is not accepted"
      chatReminderAsDurableToolAccepted
      mashChatReminderAsDurableTool
      mashChatReminderAsDurableToolIsFalse
      rfl
      mash_chat_reminder_as_durable_tool_is_false,
    expectConsFalse "recursive self improvement as a training run is not accepted"
      rsiIsTrainingRunAccepted
      mashRsiIsTrainingRun
      mashRsiIsTrainingRunIsFalse
      rfl
      mash_rsi_is_training_run_is_false,
    expectTrue "Supercompiler improvement is the RSI loop with delta reconciliation"
      supercompilerImprovementIsRsiLoopWithDeltaReconciliation,
    expectConsFalse "Supercompiler improvement is not claimed finished"
      supercompilerImprovementFinished
      mashSupercompilerImprovementFinished
      mashSupercompilerImprovementFinishedIsFalse
      rfl
      mash_supercompiler_improvement_finished_is_false,
    expectConsFalse "this document creating SSSP is not accepted"
      thisDocumentCreatesSssp
      mashThisDocumentCreatesSssp
      mashThisDocumentCreatesSsspIsFalse
      rfl
      mash_this_document_creates_sssp_is_false,
    expectConsFalse "SSSP as numbered is not accepted"
      ssspHasNumberedSpec
      mashSsspHasNumberedSpec
      mashSsspHasNumberedSpecIsFalse
      rfl
      mash_sssp_has_numbered_spec_is_false,
    expectConsFalse "every agent already conforming is not accepted"
      specClaimsEveryAgentConforms
      mashSpecClaimsEveryAgentConforms
      mashSpecClaimsEveryAgentConformsIsFalse
      rfl
      mash_spec_claims_every_agent_conforms_is_false,
    expectConsFalse "Clause 4 already met by every session is not accepted"
      clause4AlreadyMetByEverySession
      mashClause4AlreadyMetByEverySession
      mashClause4AlreadyMetByEverySessionIsFalse
      rfl
      mash_clause_4_already_met_by_every_session_is_false,
    expectConsFalse "serializing independent streams is not accepted"
      StreamSchedule.serializeIndependent.conforming
      mashSerializeIndependent
      mashSerializeIndependentIsFalse
      rfl
      mash_serialize_independent_is_false,
    expectConsFalse "reshaping a test without a contract change is not accepted"
      reshapeTestToPassWithoutContractChange
      mashReshapeTestWithoutContractChange
      mashReshapeTestWithoutContractChangeIsFalse
      rfl
      mash_reshape_test_without_contract_change_is_false,
    expectConsFalse "leftover unstack as this specification is not accepted"
      Vocabulary.rsiReplacesLeftoverUnstack
      mashRsiReplacesLeftoverUnstack
      mashRsiReplacesLeftoverUnstackIsFalse
      rfl
      mash_rsi_replaces_leftover_unstack_is_false,
    expectConsFalse "this document as a bitmask specification is not accepted"
      rsiIsBitmaskSpec
      mashRsiIsBitmaskSpec
      mashRsiIsBitmaskSpecIsFalse
      rfl
      mash_rsi_is_bitmask_spec_is_false,
    expectConsFalse "chat as the residual record is not accepted"
      ResidualHome.chatOnly.conforming
      mashChatOnlyResidual
      mashChatOnlyResidualIsFalse
      rfl
      mash_chat_only_residual_is_false,
    expectConsFalse "meaning proofs as a second form checker is not accepted"
      Vocabulary.meaningProofsAreSecondFormChecker
      mashMeaningProofsAreSecondFormChecker
      mashMeaningProofsAreSecondFormCheckerIsFalse
      rfl
      mash_meaning_proofs_are_second_form_checker_is_false,
    expectConsFalse "collision tag encodings as already containing proofs is not accepted"
      Vocabulary.liveContainsProofsOfThoseEncodings
      Vocabulary.mashCollisionTagsSpecAndProof
      Vocabulary.mashCollisionTagsSpecAndProofIsFalse
      rfl
      Vocabulary.mash_collision_tags_spec_and_proof_is_false
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  if failed == 0 then
    IO.println s!"All {runCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {runCases.length} tests failed."
    return 1
