/-
  Runtime checks for the CATE meaning model (0005_CATE.md).
  Theorems in CateProofs.lean already fail to typecheck if the model is
  widened (CATE numbered 0000 or 0006, leftover unstack treated as
  conforming, residual silence treated as conforming). This executable
  re-checks the decidable facts so a silent Bool regression prints FAIL
  lines, matching spec_check_tests style.

  `cateSpecNumber = 6` is false. That case would fail if CATE were still
  numbered 0006.
-/

import Cate
import CateProofs
import SpecRegistry

open Cate
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
    expectEqNat "CATE is specification 0005" specNumber 5,
    expectEqNat "vocabulary ownership is specification 0005" vocabularySpecNumber 5,
    expectTrue "vocabulary ownership equals CATE"
      (vocabularySpecNumber == specNumber),
    expectTrue "CATE owns the word catalog" ownsVocabularyCatalog,
    expectFalse "number 0009 is PDOSS, not withdrawn" numberNineWithdrawn,
    expectNonEmpty "withdrawn 0009_VOCABULARY.md basename fails"
      (findingsForBasenames (publishedBasenames ++ ["0009_VOCABULARY.md"])),
    expectNonEmpty "withdrawn 0009_VOCABULARY token fails"
      (scanContent "0005_CATE.md"
        "do not create `0009_VOCABULARY.md`.\n"),
    expectFalse "CATE is not specification 0006" (specNumber == 6),
    expectEqString "spec file is 0005_CATE.md" specFileName "0005_CATE.md",
    expectTrue "CATE is a stack number" cateIsNewStackNumber,
    expectTrue "CATE live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "CATE live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "CATE spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "CATE spec encoding module is not marked as proof" markedAsProof,
    expectTrue "CATE is not specification 0000" (specNumber != 0),
    expectTrue "CATE is not specification 0006"
      (specNumber != rsiSpecNumber),
    expectEqNat "RSI is specification 0006" rsiSpecNumber 6,
    expectTrue "Carbonado is not specification 0005"
      (carbonadoAssignedNumber != some 5),
    expectTrue "Carbonado is not specification 0006"
      (carbonadoAssignedNumber != some 6),
    expectFalse "leftover unstack is not conforming"
      HyphenRepair.leftoverUnstack.conforming,
    expectTrue "rephrased hyphen is conforming"
      HyphenRepair.rephrasedOrdinaryEnglish.conforming,
    expectEqNat "five leftover unstack phrases" leftoverUnstackPhrases.length 5,
    expectTrue "leftover constructors map to the floor list"
      (leftoverUnstackPhraseConstructors.map LeftoverUnstackPhrase.surface ==
        leftoverUnstackPhrases),
    expectTrue "lock free tries prose fails leftover unstack floor"
      (containsLeftoverUnstackPhrase leftoverLockFreeTriesProse),
    expectTrue "non markdown prose fails leftover unstack floor"
      (containsLeftoverUnstackPhrase leftoverNonMarkdownProse),
    expectTrue "must like prose fails leftover unstack floor"
      (containsLeftoverUnstackPhrase leftoverMustLikeProse),
    expectTrue "LF only prose fails leftover unstack floor"
      (containsLeftoverUnstackPhrase leftoverLfOnlyProse),
    expectTrue "fully type checking prose fails leftover unstack floor"
      (containsLeftoverUnstackPhrase leftoverFullyTypeCheckingProse),
    expectFalse "high assurance is not leftover unstack"
      (containsLeftoverUnstackPhrase allowedHighAssuranceProse),
    expectFalse "3 bit is not leftover unstack"
      (containsLeftoverUnstackPhrase allowedThreeBitProse),
    expectFalse "time series is not leftover unstack"
      (containsLeftoverUnstackPhrase allowedTimeSeriesProse),
    expectTrue "high assurance is an allowed spaced phrase"
      (containsAllowedSpacedPhrase allowedHighAssuranceProse),
    expectTrue "rephrased lock tries prose meets leftover unstack floor"
      (leftoverUnstackFloorConforms rephrasedLockTriesProse),
    expectFalse "lock free tries prose does not meet leftover unstack floor"
      (leftoverUnstackFloorConforms leftoverLockFreeTriesProse),
    expectTrue "deleting hyphen from lock-free tries is leftover unstack"
      (hyphenDeleteIsLeftoverUnstack "lock-free tries" "lock free tries"),
    expectFalse "rephrasing lock-free tries is not leftover unstack"
      (hyphenDeleteIsLeftoverUnstack "lock-free tries"
        "tries that do not use locks"),
    expectFalse "0005 with planned token and no Residual heading does not conform"
      plannedWithoutHeading.conforming,
    expectTrue "0005 with planned token and Residual heading conforms"
      plannedWithHeading.conforming,
    expectTrue "0000 with planned token and no Residual heading conforms"
      spec0000WithPlannedNoHeading.conforming,
    expectTrue "0005 with no planned token conforms"
      noPlannedNoHeading.conforming,
    expectTrue "## 6. Residual is a residual heading"
      (isResidualHeadingTitle "## 6. Residual"),
    expectTrue "## Residual is a residual heading"
      (isResidualHeadingTitle "## Residual"),
    expectFalse "a half label is not a residual heading"
      (isResidualHeadingTitle "Keep or replace coined labels?"),
    expectFalse "leftover unstack floor is not complete English"
      leftoverUnstackFloorIsCompleteEnglish,
    expectTrue "Lean spec encodings use leftover unstack floor"
      leanSpecEncodingsUseLeftoverUnstackFloor,
    expectEqNat "fourteen leftover unstack comment scan paths"
      leftoverUnstackCommentScanRelPaths.length 14,
    expectTrue "AnunnakiSpec is a leftover unstack comment scan path"
      (leftoverUnstackCommentScanRelPaths.contains "lean/AnunnakiSpec.lean"),
    expectEqNat "three allowed spaced phrases" allowedSpacedPhrases.length 3,
    expectFalse "residual silence is not conforming" residualSilent.conforming,
    expectTrue "residual written is conforming" residualWritten.conforming,
    expectTrue "nothing to name is conforming" residualNothingToName.conforming,
    expectFalse "0000 is exempt from planned residual heading"
      (plannedTokenRequiresResidualHeading 0),
    expectTrue "0001 requires planned residual heading"
      (plannedTokenRequiresResidualHeading 1),
    expectTrue "0003 requires planned residual heading"
      (plannedTokenRequiresResidualHeading 3),
    expectTrue "0005 requires planned residual heading"
      (plannedTokenRequiresResidualHeading 5),
    expectTrue "0006 requires planned residual heading"
      (plannedTokenRequiresResidualHeading 6),
    expectFalse "half label question is not complete" halfLabelQuestion.complete,
    expectTrue "complete question is complete" completeQuestion.complete,
    expectTrue "complete question uses ordinary English"
      completeQuestion.usesOrdinaryEnglish,
    expectTrue "complete question defines a new phrase in the same sentence"
      completeQuestion.newPhrase.conforming,
    expectTrue "complete question says what we will do either way"
      completeQuestion.saysWhatWeWillDoEitherWay,
    expectFalse "a new phrase without a definition does not conform"
      NewPhraseInQuestion.introducedWithoutDefinition.conforming,
    expectTrue "spec markdown is the contract" specMarkdownIsContract,
    expectFalse "meaning proofs are not a second form checker"
      meaningProofsAreSecondFormChecker,
    expectFalse "CATE does not invent a conforming product"
      cateAllowsInventedConformingProduct,
    expectFalse "ISO 24495 is not a Clause 12 pin" iso24495IsClause12Pin,
    expectFalse "Federal Plain Language is not a Clause 12 pin"
      federalPlainLanguageIsClause12Pin,
    expectFalse "CATE does not replace RFC 2119" cateReplacesRfc2119,
    expectTrue "independent work streams run in parallel"
      independentWorkStreamsRunInParallel,
    expectFalse "disjoint write sets are not serialized"
      serializeDisjointWriteSets,
    expectTrue "encode process self improves in the same effort"
      encodeProcessSelfImprovesInSameEffort,
    expectFalse "a chat reminder is not encode proof"
      chatReminderCountsAsEncodeProof,
    expectFalse "scc does not omit COCOMO when size was asked"
      sccOmitsCocomoWhenSizeAsked,
    expectFalse "COCOMO is not a real schedule" cocomoIsRealSchedule,
    expectFalse "git mutate unless asked is not allowed"
      gitMutateUnlessOperatorAsked,
    expectTrue "beastdb is ongoing not ready"
      beastdbProgress.honestWhenWorkExists,
    expectTrue "SSSSS is ongoing not ready"
      sssssProgress.honestWhenWorkExists,
    expectTrue "Slake is ongoing not ready"
      slakeProgress.honestWhenWorkExists,
    expectTrue "CI product is ongoing not ready"
      ciProductProgress.honestWhenWorkExists,
    expectFalse "never started is not honest when work exists"
      ProductProgress.claimsNeverStarted.honestWhenWorkExists,
    expectFalse "byte identity is not claimed true" byteIdentityClaimedTrue,
    expectEqString "Systems Lean product tree is iso"
      systemsLeanProductTreePath "/home/hunter/Projects/ai/iso",
    expectTrue "keep existing ref pins" keepExistingRefPins,
    expectTrue "add new ref pins when present" addNewRefPinsWhenPresent,
    expectEqNat "four required this repo ref pins"
      requiredThisRepoRefPins.length 4,
    expectFalse "PDF permission note is not yet written"
      pdfPermissionNotePresent,
    expectFalse "fargo is not assigned" fargoAssigned,
    expectFalse "SSSP is not assigned" ssspAssigned,
    expectTrue "Lean Machine is assigned as specification 0013" leanMachineAssigned,
    expectEmpty "correct 0005_CATE token passes"
      (scanContent "0005_CATE.md"
        "This specification is number 0005. File 0005_CATE.md.\n"),
    expectNonEmpty "identity sentence with wrong number fails"
      (scanContent "0005_CATE.md"
        "This specification is number 0000.\n"),
    expectNonEmpty "stale 0006_CATE token fails"
      (scanContent "0005_CATE.md"
        "stale file name `0006_CATE.md` must fail.\n"),
    expectNonEmpty "stale 0005_RSI token fails"
      (scanContent "0005_CATE.md"
        "stale file name `0005_RSI.md` must fail.\n"),
    expectNonEmpty "missing published 0005 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md", "0006_RSI.md"]),
    expectEmpty "all published basenames including 0007 pass"
      (findingsForBasenames publishedBasenames),
    expectTrue "CATE meaning model requires the science cycle"
      requiresScienceCycle,
    expectFalse "tests without a model do not conform"
      testsOnlyConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsConforms,
    expectTrue "complete science cycle conforms"
      completeScienceCycleConforms,
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient,
    expectConsFalse "leftover unstack floor as complete English is not accepted"
      leftoverUnstackFloorIsCompleteEnglish
      mashLeftoverUnstackFloorAsCompleteEnglish
      mashLeftoverUnstackFloorAsCompleteEnglishIsFalse
      rfl
      mash_leftover_unstack_floor_as_complete_english_is_false,
    expectConsFalse "contradiction floor as every sentence pair is not accepted"
      contradictionFloorIsEverySentencePair
      mashContradictionFloorIsEverySentencePair
      mashContradictionFloorIsEverySentencePairIsFalse
      rfl
      mash_contradiction_floor_is_every_sentence_pair_is_false,
    expectConsFalse "every agent already conforming is not accepted"
      everyAgentAlreadyConforms
      mashEveryAgentAlreadyConforms
      mashEveryAgentAlreadyConformsIsFalse
      rfl
      mash_every_agent_already_conforms_is_false,
    expectConsFalse "invented conforming product is not accepted"
      cateAllowsInventedConformingProduct
      mashCateAllowsInventedConformingProduct
      mashCateAllowsInventedConformingProductIsFalse
      rfl
      mash_cate_allows_invented_conforming_product_is_false
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
