/-
  SPEC ENCODINGS for numbered specification 0014 Anunnaki
  Encoding (`0014_Anunnaki_Encoding.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in AnunnakiProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not claim a conforming encoder. It does not claim
  a spelling converter program. It does not claim that CATE, SSSSS,
  or Majestic Memex are replaced. It does not claim that ENKI is
  this bitstream.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import FormalVibeficationSpec

namespace AnunnakiSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0014. -/
def specNumber : Nat := 14

def specFileName : String := "0014_Anunnaki_Encoding.md"

def productName : String := "Anunnaki Encoding"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- ENKI is the index. Anunnaki is the bitstream. Those names are not one object. -/
def enkiIsIndex : Bool := true

def anunnakiIsBitstream : Bool := true

def enkiAndAnunnakiAreOneObject : Bool := false

def enkiHasNumberedSpecification : Bool := false

/-- This specification does not replace CATE, SSSSS, or Majestic Memex. -/
def replacesCate : Bool := false

def cateSpecNumber : Nat := 5

def cateOwnsLanguageId : Bool := true

def cateOwnsWordId : Bool := true

def cateOwnsWordCatalog : Bool := true

def replacesSssss : Bool := false

def sssssSpecNumber : Nat := 4

def sssssOwnsLanguageRuns : Bool := true

def replacesMemex : Bool := false

def memexSpecNumber : Nat := 12

def memexKeepsMajesticPlus01 : Bool := true

def memexKeepsMajesticExtension : Bool := true

def memexKeepsSstt : Bool := true

/-- This document does not claim a conforming encoder. -/
def conformingEncoderClaimed : Bool := false

def conformingProductExists : Bool := false

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Huffman coding MAY be measured and MUST NOT be the lemma spine. -/
def huffmanMayBeMeasured : Bool := true

def huffmanIsLemmaSpine : Bool := false

def huffmanMustNotBeLemmaSpine : Bool := true

/-- Width arms: zero terminates; each one adds one payload byte. Cap 8. -/
def payloadBytesFromLeadingOnes (ones : Nat) : Nat := ones + 1

def payloadByteCap : Nat := 8

def armExceedsCap (ones : Nat) : Bool :=
  payloadBytesFromLeadingOnes ones > payloadByteCap

/-- false is the terminating zero bit. true is a leading one. -/
def arm0Bits : List Bool := [false]

def arm10Bits : List Bool := [true, false]

def arm110Bits : List Bool := [true, true, false]

def arm1110Bits : List Bool := [true, true, true, false]

def leadingOnes (bits : List Bool) : Nat :=
  (bits.takeWhile (fun b => b)).length

def terminatesWithZero (bits : List Bool) : Bool :=
  match bits.getLast? with
  | some b => !b
  | none => false

/-- Unused bits in the last template byte are ones. Reject a claimed pad that contains a zero. -/
def claimedPadIsValid (pad : List Bool) : Bool :=
  pad.all (fun b => b)

def mustRejectClaimedPad (pad : List Bool) : Bool :=
  !claimedPadIsValid pad

def padOnesFixture : List Bool := [true, true, true]

def padContainsZeroFixture : List Bool := [true, false, true]

def padUnusedBitsWithOnes : Bool := true

def bit7First : Bool := true

def perfectlyEfficientWhenLastArmZeroIsLastBitOfByte : Bool := true

def padLengthWhenPerfectlyEfficient : Nat := 0

/-- Payload is bytes. Page 0: 256 slots. Page 1: 65536 slots, little endian. -/
def payloadIsBytes : Bool := true

def page0Slots : Nat := 256

def page0IndexBytes : Nat := 1

def page1Slots : Nat := 65536

def page1IndexBytes : Nat := 2

def page1LittleEndian : Bool := true

/-- Repeat character residual is a plane of (character, count). Symbol residual is separate. -/
def repeatCharacterIsResidualPlane : Bool := true

def symbolResidualIsSeparate : Bool := true

def repeatCharacterEqualsSymbolResidual : Bool := false

/-- Normalize first, then encode. Decode MUST rebuild the original surface. -/
def normalizeFirstThenEncode : Bool := true

def decodeMustRebuildOriginalSurface : Bool := true

/--
  One language keeps one LanguageID. A dialect does not get a different
  LanguageID. Two spelling tables for one language share that id and the
  frequency ranked word number. Surfaces may differ. The user's preference
  selects which table decode uses. `surfaceTag` only lets those Bools
  reduce. It is not a byte layout and it is not a LanguageID. These
  fixtures are not an on disk layout and they are not a published CATE
  LanguageID assignment. A spelling converter program is not claimed.
-/
structure SpellingTable where
  languageId : Nat
  rankNumber : Nat
  surfaceTag : Nat
  surface : String
  deriving DecidableEq, Repr

def fixtureLanguageId : Nat := 1

def sharedRankNumber : Nat := 1

def americanSpellingTable : SpellingTable :=
  { languageId := fixtureLanguageId
    rankNumber := sharedRankNumber
    surfaceTag := 0
    surface := "color" }

/-- Regional surface data for the user preference fixture. Not specification prose. -/
def regionalSpellingTable : SpellingTable :=
  { languageId := fixtureLanguageId
    rankNumber := sharedRankNumber
    surfaceTag := 1
    surface := "regional form" }

def oneLanguageKeepsOneLanguageId : Bool :=
  americanSpellingTable.languageId == regionalSpellingTable.languageId

/-- The claim that a dialect needs its own LanguageID is false. -/
def dialectNeedsOwnLanguageId : Bool := false

def spellingTablesIsomorphicAtRank : Bool :=
  oneLanguageKeepsOneLanguageId &&
    americanSpellingTable.rankNumber == regionalSpellingTable.rankNumber &&
    americanSpellingTable.surfaceTag != regionalSpellingTable.surfaceTag

inductive SpellingPreference where
  | repositoryAmerican
  | userPreferred
  deriving DecidableEq, Repr, BEq

def tableFor (pref : SpellingPreference) : SpellingTable :=
  match pref with
  | .repositoryAmerican => americanSpellingTable
  | .userPreferred => regionalSpellingTable

def userPreferenceSelectsDecodeTable : Bool :=
  (tableFor .userPreferred).surfaceTag == regionalSpellingTable.surfaceTag &&
    (tableFor .userPreferred).rankNumber == sharedRankNumber &&
    (tableFor .repositoryAmerican).surfaceTag == americanSpellingTable.surfaceTag &&
    (tableFor .repositoryAmerican).languageId == fixtureLanguageId

def spellingConverterProgramClaimed : Bool := false

def spellingTableByteLayoutSpecified : Bool := false

/-- Migration accepted only when a Lean check shows the new encoding is not longer. Corpus remains Residual. -/
def migrationRequiresLeanNotLongerCheck : Bool := true

def migrationCorpusPinned : Bool := false

/-- v2 fixtures: English and Lean 4 only. C, Rust 1, Nix, and C++ are named and unpinned. -/
def englishFixturePinned : Bool := true

def lean4FixturePinned : Bool := true

def cFixturePinned : Bool := false

def rust1FixturePinned : Bool := false

def nixFixturePinned : Bool := false

def cppFixturePinned : Bool := false

/--
  Clause 6 leftover residual facts. All of these are false.
  RDPS, FilterScript, Carbonado, number 0015, ENKI as a numbered file,
  and fargo stay unassigned here. A stack program instruction set,
  nested language, on disk join shape, spelling table byte layout,
  compound word rules, default Majestic use, who emits the stack
  program, and Huffman versus pages length on a real corpus remain
  unspecified or unmeasured here. A dialect does not need its own
  LanguageID.
-/
def rdpsAssignedNumber : Bool := false

def filterScriptAssignedNumber : Bool := false

def carbonadoAssignedNumber : Bool := false

def number0015Assigned : Bool := false

def number0015IsThisSpecification : Bool := false

def createsEnkiNumberedFile : Bool := false

def fargoAssignedNumber : Bool := false

def stackProgramInstructionSetSpecified : Bool := false

def nestedLanguageSpecified : Bool := false

def onDiskJoinShapeSpecified : Bool := false

def compoundWordRulesSpecified : Bool := false

def anunnakiDefaultMajesticSpecified : Bool := false

def whoEmitsStackProgramSpecified : Bool := false

def huffmanVersusPagesMeasured : Bool := false

def siblingLineEncodingsRequired : Bool := true

def siblingProofsAreSeparateModules : Bool := true

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

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
  { moduleName := "AnunnakiSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "AnunnakiProofs"
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

def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/--
  Clause 6.5 leftover clashes. Treating a leftover as accepted is Cons False.
  Mash of spec encodings plus proofs stays `mashSpecAndProofIsFalse` above.
  Do not restate that mash as a new catalog identity here.
-/
def mashEnkiAndAnunnakiAreOneObject : Prop :=
  enkiAndAnunnakiAreOneObject = true

def mashEnkiAndAnunnakiAreOneObjectIsFalse : Prop :=
  mashEnkiAndAnunnakiAreOneObject → False

def mashConformingEncoderClaimed : Prop :=
  conformingEncoderClaimed = true

def mashConformingEncoderClaimedIsFalse : Prop :=
  mashConformingEncoderClaimed → False

def mashNumber0015IsThisSpecification : Prop :=
  number0015IsThisSpecification = true

def mashNumber0015IsThisSpecificationIsFalse : Prop :=
  mashNumber0015IsThisSpecification → False

def mashCarbonadoAssignedNumber : Prop :=
  carbonadoAssignedNumber = true

def mashCarbonadoAssignedNumberIsFalse : Prop :=
  mashCarbonadoAssignedNumber → False

def mashEnkiHasNumberedSpecification : Prop :=
  enkiHasNumberedSpecification = true

def mashEnkiHasNumberedSpecificationIsFalse : Prop :=
  mashEnkiHasNumberedSpecification → False

def mashRdpsAssignedNumber : Prop :=
  rdpsAssignedNumber = true

def mashRdpsAssignedNumberIsFalse : Prop :=
  mashRdpsAssignedNumber → False

def mashFilterScriptAssignedNumber : Prop :=
  filterScriptAssignedNumber = true

def mashFilterScriptAssignedNumberIsFalse : Prop :=
  mashFilterScriptAssignedNumber → False

/-- Treating a dialect as needing its own LanguageID is Cons False. -/
def mashDialectNeedsOwnLanguageId : Prop :=
  dialectNeedsOwnLanguageId = true

def mashDialectNeedsOwnLanguageIdIsFalse : Prop :=
  mashDialectNeedsOwnLanguageId → False

/-- Claiming a spelling converter program is Cons False. A converter program is not claimed. -/
def mashSpellingConverterProgramClaimed : Prop :=
  spellingConverterProgramClaimed = true

def mashSpellingConverterProgramClaimedIsFalse : Prop :=
  mashSpellingConverterProgramClaimed → False

/-- Required Conformance holds iff every listed conjunct holds. -/
def requiredConformanceHolds : Bool :=
  specNumber == 14 &&
    specFileName == "0014_Anunnaki_Encoding.md" &&
    enkiIsIndex &&
    anunnakiIsBitstream &&
    !enkiAndAnunnakiAreOneObject &&
    !enkiHasNumberedSpecification &&
    !replacesCate &&
    cateSpecNumber == 5 &&
    !replacesSssss &&
    sssssSpecNumber == 4 &&
    !replacesMemex &&
    memexSpecNumber == 12 &&
    memexKeepsMajesticPlus01 &&
    !conformingEncoderClaimed &&
    huffmanMayBeMeasured &&
    !huffmanIsLemmaSpine &&
    huffmanMustNotBeLemmaSpine &&
    payloadBytesFromLeadingOnes 0 == 1 &&
    payloadBytesFromLeadingOnes 1 == 2 &&
    payloadBytesFromLeadingOnes 2 == 3 &&
    payloadBytesFromLeadingOnes 3 == 4 &&
    payloadByteCap == 8 &&
    claimedPadIsValid padOnesFixture &&
    mustRejectClaimedPad padContainsZeroFixture &&
    padUnusedBitsWithOnes &&
    bit7First &&
    payloadIsBytes &&
    page0Slots == 256 &&
    page1Slots == 65536 &&
    page1LittleEndian &&
    repeatCharacterIsResidualPlane &&
    symbolResidualIsSeparate &&
    !repeatCharacterEqualsSymbolResidual &&
    normalizeFirstThenEncode &&
    decodeMustRebuildOriginalSurface &&
    oneLanguageKeepsOneLanguageId &&
    !dialectNeedsOwnLanguageId &&
    spellingTablesIsomorphicAtRank &&
    userPreferenceSelectsDecodeTable &&
    !spellingConverterProgramClaimed &&
    !spellingTableByteLayoutSpecified &&
    migrationRequiresLeanNotLongerCheck &&
    !migrationCorpusPinned &&
    englishFixturePinned &&
    lean4FixturePinned &&
    !cFixturePinned &&
    !rust1FixturePinned &&
    !nixFixturePinned &&
    !cppFixturePinned &&
    liveContainsSpecEncodings &&
    !liveContainsProofsOfThoseEncodings &&
    markedAsSpecEncoding &&
    !markedAsProof &&
    conformingThisRepo specEncodingFixture &&
    conformingThisRepo proofFixture &&
    !conformingThisRepo mashedFixture &&
    !FormalVibeficationSpec.testsAloneAreSufficient &&
    !rdpsAssignedNumber &&
    !filterScriptAssignedNumber &&
    !carbonadoAssignedNumber &&
    !number0015Assigned &&
    !number0015IsThisSpecification &&
    !createsEnkiNumberedFile &&
    !fargoAssignedNumber &&
    !stackProgramInstructionSetSpecified &&
    !nestedLanguageSpecified &&
    !onDiskJoinShapeSpecified &&
    !compoundWordRulesSpecified &&
    !anunnakiDefaultMajesticSpecified &&
    !whoEmitsStackProgramSpecified &&
    !huffmanVersusPagesMeasured

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

/-- This meaning model requires the Formal Vibefication science cycle. -/
def requiresScienceCycle : Bool := true

def testsOnlyEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.testsWithoutModelFixture

def testsOnlyConforms : Bool :=
  FormalVibeficationSpec.conformingScience testsOnlyEffort

def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

def modelAndProofsWithoutExperimentsEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

def modelAndProofsWithoutExperimentsConforms : Bool :=
  FormalVibeficationSpec.conformingScience modelAndProofsWithoutExperimentsEffort

def completeScienceEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.completeScienceFixture

def completeScienceConformsHere : Bool :=
  FormalVibeficationSpec.conformingScience completeScienceEffort

def testsWithoutModelDoesNotConform : Prop :=
  testsOnlyConforms = false

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  modelAndProofsWithoutExperimentsConforms = false

def completeScienceConforms : Prop :=
  completeScienceConformsHere = true

end AnunnakiSpec
