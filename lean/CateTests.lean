/-
  Runtime checks for the CATE meaning model (0005_CATE.md).
  Theorems in Cate.lean already fail to typecheck if the model is
  widened (CATE numbered 0000 or 0006, leftover unstack treated as
  conforming, residual silence treated as conforming). This executable
  re-checks the decidable facts so a silent Bool regression prints FAIL
  lines, matching spec_check_tests style.

  `cateSpecNumber = 6` is false. That case would fail if CATE were still
  numbered 0006.
-/

import Cate
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

def runCases : List Case :=
  [
    expectEqNat "CATE is specification 0005" specNumber 5,
    expectFalse "CATE is not specification 0006" (specNumber == 6),
    expectEqString "spec file is 0005_CATE.md" specFileName "0005_CATE.md",
    expectTrue "CATE is a stack number" cateIsNewStackNumber,
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
    expectFalse "Lean Machine is not assigned" leanMachineAssigned,
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
      (findingsForBasenames publishedBasenames)
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
