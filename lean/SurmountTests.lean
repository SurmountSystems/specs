/-
  Runtime checks for the Surmount composition model.
  Theorems in Surmount.lean already fail to typecheck if the stack is
  mashed (CATE numbered 0006, this repository treated as a product tree
  that unifies spec and proof, leftover unstack treated as conforming,
  byte identity claimed true, emit = ELF treated as proved). This
  executable re-checks the decidable facts so a silent Bool regression
  prints FAIL lines, matching spec_check_tests style.
-/

import Surmount
import SpecRegistry
import SystemsLean
import BeastDb
import Sssss
import Cate
import Rsi
import Vocabulary
import Ci
import SpecCheck
import FormalVibeficationSpec
import UnlicenseSpec
import VocabularySpec
import SpecProofs
import LeanMachineSpec
import AnunnakiSpec
import SessionBusSpec
import SystemsLeanProofs

open Surmount
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

/-- Names a Bool clash proof so the proof cannot be omitted. -/
def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

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
    expectTrue "spec encoding is not the Lean proof"
      (FormalVibeficationSpec.Layer.leanSpecEncoding !=
        FormalVibeficationSpec.Layer.leanProof),
    expectTrue "human markdown is not the Lean spec encoding"
      (FormalVibeficationSpec.Layer.humanMarkdownContract !=
        FormalVibeficationSpec.Layer.leanSpecEncoding),
    expectTrue "human markdown is not the Lean proof"
      (FormalVibeficationSpec.Layer.humanMarkdownContract !=
        FormalVibeficationSpec.Layer.leanProof),
    expectTrue "spec markdown is the contract humans read" specMarkdownIsContract,
    expectFalse "companion Lean proof is not the spec" companionLeanIsTheSpec,
    expectFalse "human markdown does not substitute for Lean spec encodings"
      FormalVibeficationSpec.humanMarkdownSubstitutesForLeanSpecEncoding,
    expectTrue "mashed spec and proof fixture is nonconforming"
      (!FormalVibeficationSpec.conformingThisRepo
        FormalVibeficationSpec.mashedFixture),
    expectTrue "sibling line encodings are required"
      FormalVibeficationSpec.siblingLineEncodingsRequired,
    expectTrue "sibling proofs are separate modules"
      FormalVibeficationSpec.siblingProofsAreSeparateModules,
    expectFalse "mashed sibling encodings do not conform"
      FormalVibeficationSpec.mashedSiblingEncodingAndProofsConform,
    expectTrue "published sibling encodings are not mashed"
      SpecProofs.encodingsNotMashed,
    expectTrue "separate spec encoding and proof fixtures conform"
      (FormalVibeficationSpec.conformingThisRepo
          FormalVibeficationSpec.specEncodingFixture &&
        FormalVibeficationSpec.conformingThisRepo
          FormalVibeficationSpec.proofFixture),
    expectFalse "this repository does not unify spec, proof, and implementation"
      Ci.ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl,
    expectTrue "Systems Lean product tree unifies spec, proof, and implementation"
      Ci.ProductHome.systemsLeanProductTree.unifiesSpecProofImpl,
    expectTrue "this-repo split and product unification can both hold"
      (!Ci.ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl &&
        Ci.ProductHome.systemsLeanProductTree.unifiesSpecProofImpl),
    expectFalse "theorems are not dumped into numbered markdown here"
      Ci.dumpTheoremsIntoNumberedMarkdown,
    expectTrue "unique specification numbers" (!hasDupNumbers),
    expectTrue "unique specification file names" (!hasDupFilenames),
    expectEqNat "CATE is specification 0005" cateSpecNumber 5,
    expectEqNat "RSI is specification 0006" rsiSpecNumber 6,
    expectEqNat "CI is specification 0007" ciSpecNumber 7,
    expectEqNat "Formal Vibefication is specification 0008"
      Surmount.formalVibeficationSpecNumber 8,
    expectEqNat "PDOSS is specification 0009"
      Surmount.pdossSpecNumber 9,
    expectEqNat "unlicenseSpecNumber remains 9"
      Surmount.unlicenseSpecNumber 9,
    expectEqString "PDOSS file is 0009_PDOSS.md"
      SpecRegistry.pdossFileName "0009_PDOSS.md",
    expectEqNat "word catalog is owned by specification 0005"
      Surmount.vocabularySpecNumber 5,
    expectTrue "vocabulary ownership equals CATE"
      (Surmount.vocabularySpecNumber == cateSpecNumber),
    expectEqNat "Surmount Systems is specification 0010" surmountSpecNumber 10,
    expectEqString "Surmount Systems file is 0010_Surmount_Systems.md"
      specFileName "0010_Surmount_Systems.md",
    expectEqNat "Surmount module agrees with registry"
      surmountSpecNumber surmountSystemsSpecNumber,
    expectEqNat "Formal Vibefication module agrees with registry"
      Surmount.formalVibeficationSpecNumber
        SpecRegistry.formalVibeficationSpecNumber,
    expectTrue "number 0008 is in the registry"
      (allEntries.any (fun e => e.number == 8)),
    expectTrue "number 0009 is in the registry"
      (allEntries.any (fun e => e.number == 9)),
    expectTrue "number 0011 is in the registry"
      (allEntries.any (fun e => e.number == 11)),
    expectFalse "mash of 0009 as published is false"
      VocabularySpec.numberNinePublished,
    expectNonEmpty "wrong 0008 filename token fails"
      (scanContent "0010_Surmount_Systems.md"
        "do not cite 0008_unused.md\n"),
    expectEmpty "correct 0008_Formal_Vibefication token passes"
      (scanContent "0008_Formal_Vibefication.md"
        "This specification is number 0008. File 0008_Formal_Vibefication.md.\n"),
    expectNonEmpty "wrong 0009 filename token fails"
      (scanContent "0010_Surmount_Systems.md"
        "do not cite 0009_unused.md\n"),
    expectNonEmpty "withdrawn 0009_VOCABULARY token fails"
      (scanContent "0005_CATE.md"
        "do not create `0009_VOCABULARY.md`.\n"),
    expectEmpty "correct 0010_Surmount_Systems token passes"
      (scanContent "0010_Surmount_Systems.md"
        "This specification is number 0010. File 0010_Surmount_Systems.md.\n"),
    expectNonEmpty "wrong published 0008 basename fails"
      (findingsForBasenames (publishedBasenames ++ ["0008_unused.md"])),
    expectNonEmpty "withdrawn 0009_VOCABULARY.md basename fails"
      (findingsForBasenames (publishedBasenames ++ ["0009_VOCABULARY.md"])),
    expectEmpty "all published basenames including 0009 and 0010 pass"
      (findingsForBasenames publishedBasenames),
    expectEmpty "correct 0009_PDOSS token passes"
      (scanContent "0009_PDOSS.md"
        "This specification is number 0009. File 0009_PDOSS.md.\n"),
    expectNonEmpty "wrong 0009 filename token fails"
      (scanContent "0009_PDOSS.md"
        "do not cite 0009_unused.md\n"),
    expectNonEmpty "stale 0011_Unlicense token fails"
      (scanContent "0009_PDOSS.md"
        "do not create `0011_Unlicense.md`.\n"),
    expectTrue "Unlicense meets PDOSS"
      (UnlicenseSpec.meetsPdoss .unlicense),
    expectFalse "MIT does not meet PDOSS"
      (UnlicenseSpec.meetsPdoss .mitGrant),
    expectFalse "Apache 2.0 does not meet PDOSS"
      (UnlicenseSpec.meetsPdoss .apacheTwo),
    expectTrue "copyright remaining on OSS without dedication"
      (UnlicenseSpec.remainingCopyright UnlicenseSpec.ossWithoutDedication),
    expectFalse "Unlicense dedication has no remaining copyright"
      (UnlicenseSpec.remainingCopyright UnlicenseSpec.unlicenseDedication),
    expectFalse "mashed Unlicense spec and proof fixture does not conform"
      (UnlicenseSpec.conformingThisRepo UnlicenseSpec.mashedFixture),
    expectEqNat "SSSSS is specification 0004" ssssSpecNumber 4,
    expectEqNat "beastdb is specification 0003" beastdbSpecNumber 3,
    expectEqNat "Systems Lean is specification 0002" systemsLeanSpecNumber 2,
    expectEqNat "Cate module agrees with registry" Cate.specNumber cateSpecNumber,
    expectEqNat "Rsi module agrees with registry" Rsi.specNumber rsiSpecNumber,
    expectEqNat "Ci module agrees with registry" Ci.specNumber ciSpecNumber,
    expectEqNat "Sssss module agrees with registry" Sssss.specNumber ssssSpecNumber,
    expectEqNat "BeastDb module agrees with registry" BeastDb.specNumber beastdbSpecNumber,
    expectEqNat "SystemsLean module agrees with registry"
      SystemsLean.systemsLeanSpecNumber systemsLeanSpecNumber,
    expectFalse "fargo is not assigned" fargoAssigned,
    expectFalse "SSSP is not assigned" ssspAssigned,
    expectFalse "leftover unstack is not conforming"
      Cate.HyphenRepair.leftoverUnstack.conforming,
    expectTrue "Lean spec encodings are CATE on the leftover unstack floor"
      leanSpecEncodingsAreCateOnLeftoverUnstackFloor,
    expectTrue "spec_check leftover unstack list is Cate"
      (SpecCheck.leftoverUnstackPhrases == Cate.leftoverUnstackPhrases),
    expectTrue "CATE and RSI leftover unstack models agree"
      (Cate.HyphenRepair.leftoverUnstack.conforming ==
        Rsi.LeftoverUnstackRepair.leftoverUnstack.conforming),
    expectTrue "byte identity is required for the product"
      Ci.byteIdentity.requiredForSystemsLeanSlakeProduct,
    expectFalse "byte identity is not claimed true" Ci.byteIdentity.claimedTrue,
    expectFalse "emit equal to ELF is not a proved identity" Ci.emitEqualsElfProved,
    expectTrue "Ci and SpecRegistry agree that byte identity is not claimed true"
      (Ci.byteIdentity.claimedTrue == byteIdentityClaimedTrue),
    expectTrue "beastdb is ongoing and not ready for use"
      (beastdbProgress == .ongoingNotReadyForUse),
    expectTrue "SSSSS is ongoing and not ready for use"
      (sssssProgress == .ongoingNotReadyForUse),
    expectTrue "Slake is ongoing and not ready for use"
      (slakeProgress == .ongoingNotReadyForUse),
    expectTrue "CI product is ongoing and not ready for use"
      (ciProductProgress == .ongoingNotReadyForUse),
    expectTrue "beastdb residual honesty" beastdbProgress.honestWhenWorkExists,
    expectTrue "Keagan backlink rule exists" keaganBacklinkRuleExists,
    expectEqString "Keagan canonical host" keaganCanonicalHost "proofofkeags.com",
    expectNonEmpty "Keagan without proofofkeags.com fails the form checker"
      (SpecCheck.checkKeaganBacklink "0005_CATE.md" "0005_CATE.md"
        "Inspired by Keagan McLelland (Proof of Keags).\n"),
    expectEmpty "Keagan with proofofkeags.com passes the form checker"
      (SpecCheck.checkKeaganBacklink "0005_CATE.md" "0005_CATE.md"
        "Inspired by Keagan. See https://proofofkeags.com/research/x.html\n"),
    expectTrue "VOCABULARY fixture is well formed"
      (VocabularySpec.wellFormed VocabularySpec.fixtureEntries),
    expectTrue "companion meaning models are split"
      companionMeaningModelsSplit,
    expectFalse "CATE live mash of encodings and proofs does not remain"
      Cate.liveContainsProofsOfThoseEncodings,
    expectFalse "RSI live mash of encodings and proofs does not remain"
      Rsi.liveContainsProofsOfThoseEncodings,
    expectFalse "CI live mash of encodings and proofs does not remain"
      Ci.liveContainsProofsOfThoseEncodings,
    expectFalse "beastdb live mash of encodings and proofs does not remain"
      BeastDb.liveContainsProofsOfThoseEncodings,
    expectFalse "SSSSS live mash of encodings and proofs does not remain"
      Sssss.liveContainsProofsOfThoseEncodings,
    expectFalse "Systems Lean live mash of encodings and proofs does not remain"
      SystemsLean.liveContainsProofsOfThoseEncodings,
    expectFalse "vocabulary collision tags live mash does not remain"
      Vocabulary.liveContainsProofsOfThoseEncodings,
    expectFalse "VocabularySpec live mash of encodings and proofs does not remain"
      VocabularySpec.liveContainsProofsOfThoseEncodings,
    expectFalse "FormalVibeficationSpec live mash of encodings and proofs does not remain"
      FormalVibeficationSpec.liveContainsProofsOfThoseEncodings,
    expectFalse "UnlicenseSpec live mash of encodings and proofs does not remain"
      UnlicenseSpec.liveContainsProofsOfThoseEncodings,
    expectFalse "TechTreeSpec live mash of encodings and proofs does not remain"
      TechTreeSpec.liveContainsProofsOfThoseEncodings,
    expectFalse "MemexSpec live mash of encodings and proofs does not remain"
      MemexSpec.liveContainsProofsOfThoseEncodings,
    expectFalse "Lean Machine live mash of encodings and proofs does not remain"
      LeanMachineSpec.liveContainsProofsOfThoseEncodings,
    expectTrue "Lean Machine companion encodings are split"
      (LeanMachineSpec.liveContainsSpecEncodings &&
        !LeanMachineSpec.liveContainsProofsOfThoseEncodings &&
        LeanMachineSpec.markedAsSpecEncoding &&
        !LeanMachineSpec.markedAsProof),
    expectFalse "Anunnaki Encoding live mash of encodings and proofs does not remain"
      AnunnakiSpec.liveContainsProofsOfThoseEncodings,
    expectTrue "Anunnaki Encoding companion encodings are split"
      (AnunnakiSpec.liveContainsSpecEncodings &&
        !AnunnakiSpec.liveContainsProofsOfThoseEncodings &&
        AnunnakiSpec.markedAsSpecEncoding &&
        !AnunnakiSpec.markedAsProof),
    expectFalse "Session Bus live mash of encodings and proofs does not remain"
      SessionBusSpec.liveContainsProofsOfThoseEncodings,
    expectTrue "Session Bus companion encodings are split"
      (SessionBusSpec.liveContainsSpecEncodings &&
        !SessionBusSpec.liveContainsProofsOfThoseEncodings &&
        SessionBusSpec.markedAsSpecEncoding &&
        !SessionBusSpec.markedAsProof),
    expectFalse "a conforming session bus program is not claimed"
      SessionBusSpec.conformingSessionBusProgramClaimed,
    expectTrue "session bus required conformance holds"
      SessionBusSpec.requiredConformanceHolds,
    expectFalse "mashed companion meaning fixture does not conform"
      (FormalVibeficationSpec.conformingThisRepo
        { moduleName := "MashedCompanionMeaning"
          containsSpecEncodings := true
          containsProofsOfThoseEncodings := true
          markedAsSpecEncoding := true
          markedAsProof := true }),
    expectTrue "canonical claimed SSSSS integration conforms"
      Sssss.canonicalIntegration.conformingIntegration,
    expectFalse "claimed SSSSS integration that uses neural while symbolic can complete does not conform"
      Sssss.mashNeuralWhileSymbolicCan.conformingIntegration,
    expectFalse "claimed neural-gated SSSSS integration not in Systems Lean does not conform"
      Sssss.mashClaimedNeuralGatedNotSystemsLean.conformingIntegration,
    expectTrue "SSSSS product with no integration claim still conforms"
      Sssss.canonicalProduct.conforms,
    expectFalse "SSSSS product claiming mash not in Systems Lean does not conform"
      Sssss.productClaimedNotSystemsLean.conforms,
    expectTrue "Lean Machine has numbered specification 0013 in SSSSS"
      Sssss.leanMachineHasNumberedSpec,
    expectEqNat "registry Lean Machine is specification 0013"
      SpecRegistry.leanMachineSpecNumber 13,
    expectEqNat "Anunnaki Encoding is specification 0014"
      Surmount.anunnakiSpecNumber 14,
    expectEqNat "registry Anunnaki Encoding is specification 0014"
      SpecRegistry.anunnakiSpecNumber 14,
    expectEqNat "Anunnaki Encoding module agrees with registry"
      Surmount.anunnakiSpecNumber SpecRegistry.anunnakiSpecNumber,
    expectEqNat "Session Bus is specification 0015"
      Surmount.sessionBusSpecNumber 15,
    expectEqNat "registry Session Bus is specification 0015"
      SpecRegistry.sessionBusSpecNumber 15,
    expectEqNat "Session Bus module agrees with registry"
      Surmount.sessionBusSpecNumber SpecRegistry.sessionBusSpecNumber,
    expectTrue "session bus approve is off by default"
      SessionBusSpec.approveOffByDefault,
    expectTrue "session bus deny is off by default"
      SessionBusSpec.denyOffByDefault,
    expectFalse "session bus has no network listener"
      SessionBusSpec.networkListenerPresent,
    expectTrue "session bus socket is the same user id only"
      SessionBusSpec.socketIsSameUidOnly,
    expectTrue "session bus transcript returns deltas only"
      SessionBusSpec.transcriptReturnsDeltasOnly,
    expectTrue "ENKI is the index" AnunnakiSpec.enkiIsIndex,
    expectTrue "Anunnaki is the bitstream" AnunnakiSpec.anunnakiIsBitstream,
    expectFalse "ENKI and Anunnaki are not one object"
      AnunnakiSpec.enkiAndAnunnakiAreOneObject,
    expectFalse "a conforming Anunnaki encoder is not claimed"
      AnunnakiSpec.conformingEncoderClaimed,
    expectFalse "Anunnaki Encoding does not replace CATE"
      AnunnakiSpec.replacesCate,
    expectFalse "Anunnaki Encoding does not replace SSSSS"
      AnunnakiSpec.replacesSssss,
    expectFalse "Anunnaki Encoding does not replace Majestic Memex"
      AnunnakiSpec.replacesMemex,
    expectTrue "composed science cycle is the required science steps"
      (FormalVibeficationSpec.ScienceCycle.toList
          FormalVibeficationSpec.composedCycle ==
        FormalVibeficationSpec.requiredScienceSteps),
    expectTrue "composed science cycle is conforming science"
      (FormalVibeficationSpec.conformingScience
        (FormalVibeficationSpec.ScienceCycle.toEffort
          FormalVibeficationSpec.composedCycle)),
    expectFalse "a tests only science cycle is not the required set"
      (FormalVibeficationSpec.ScienceCycle.containsAllRequired
        FormalVibeficationSpec.testsOnlyCycle),
    expectTrue "science cycle composes in the stack"
      scienceCycleComposesInStack,
    expectTrue "Lean Machine must attempt deterministic answers"
      LeanMachineSpec.mustAttemptDeterministicAnswers,
    expectTrue "Lean Machine requires a timestamped note when wrong or imprecise"
      LeanMachineSpec.timestampedNoteRequiredWhenWrongOrImprecise,
    expectTrue "Lean Machine deterministic answers compose in the stack"
      leanMachineDeterministicAnswersInStack,
    expectTrue "a timestamped note with clock time conforms"
      (LeanMachineSpec.TimestampedNote.conforming
        LeanMachineSpec.noteWithClockTime),
    expectFalse "a timestamped note without clock time does not conform"
      (LeanMachineSpec.TimestampedNote.conforming
        LeanMachineSpec.noteWithoutClockTime),
    expectTrue "a timestamped note without clock time does not conform in the stack"
      timestampedNoteWithoutClockDoesNotConform,
    expectFalse "nondeterministic Lean Machine answers with the same notes do not conform"
      (LeanMachineSpec.AnswerAttempt.conformingPair
        LeanMachineSpec.mashNondeterministicA
        LeanMachineSpec.mashNondeterministicB),
    expectTrue "distributed self improvement is a design requirement"
      LeanMachineSpec.distributedSelfImprovementIsDesignRequirement,
    expectFalse "a running distributed machine is not claimed"
      LeanMachineSpec.runningDistributedMachineClaimed,
    expectFalse "composition is not product readiness"
      compositionIsProductReadiness,
    expectTrue "the Operator assigned number 0015 to the session bus"
      numberFifteenAssignedToSessionBus,
    expectTrue "the published file for number 0015 exists"
      numberFifteenPublishedFileExists,
    expectTrue "assignment of number 0015 matches the published file"
      (numberFifteenAssignedToSessionBus && numberFifteenPublishedFileExists),
    expectTrue "Anunnaki Encoding is not specification 0015"
      (Surmount.anunnakiSpecNumber != 15),
    expectTrue "Surmount Systems is not specification 0015"
      (surmountSpecNumber != 15),
    expectEqNat "Surmount Systems stays specification 0010"
      surmountSpecNumber 10,
    expectEqNat "SafeC is carried by Systems Lean specification 0002"
      systemsLeanSpecNumber 2,
    expectFalse "SafeC is not its own published spec number"
      SystemsLean.safeCIsOwnPublishedSpecNumber,
    expectTrue "SafeC is carried by Systems Lean"
      SystemsLean.safeCCarriedBySystemsLean,
    expectConsFalse "claiming SafeC is its own published spec number is Cons False"
      SystemsLean.safeCIsOwnPublishedSpecNumber
      SystemsLean.mashSafeCIsOwnPublishedSpecNumber
      SystemsLean.mashSafeCIsOwnPublishedSpecNumberIsFalse
      rfl
      SystemsLean.mash_safe_c_is_own_published_spec_number_is_false,
    expectTrue "stack identities compose" stackIntegrates
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
