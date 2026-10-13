/-
  SPEC ENCODINGS for numbered specification 0005 Concise American
  Technical English (`0005_CATE.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in CateProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  CATE is numbered specification 0005. It is not specification 0000 and it is
  not specification 0006. Number 0006 is Recursive Self Improvement (RSI).

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import FormalVibeficationSpec
import SpecRegistry

namespace Cate

def specNumber : Nat := 5

def specFileName : String := "0005_CATE.md"

def cateSpecNumber : Nat := specNumber

def cateIsNewStackNumber : Bool := true

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- The word catalog is owned by this specification, not by a distinct 0009. -/
def ownsVocabularyCatalog : Bool := true

def numberNineWithdrawn : Bool := false

/-!
  Leftover unstack: deleting a hyphen and leaving the same two words
  is nonconforming. The floor list is constructors, not a paragraph dump.
-/

inductive HyphenRepair where
  /-- Deleted the hyphen and left the same two words. -/
  | leftoverUnstack
  /-- Rephrased into ordinary English. -/
  | rephrasedOrdinaryEnglish
  deriving DecidableEq, Repr, BEq

def HyphenRepair.conforming : HyphenRepair → Bool
  | .leftoverUnstack => false
  | .rephrasedOrdinaryEnglish => true

/-- Clause 3.5 floor list as constructors. Surface strings stay for spec_check. -/
inductive LeftoverUnstackPhrase where
  | nonMarkdown
  | mustLike
  | lfOnly
  | lockFreeTries
  | fullyTypeChecking
  | copyGrain
  | firstGrain
  | pageGrain
  deriving DecidableEq, Repr, BEq

def LeftoverUnstackPhrase.surface : LeftoverUnstackPhrase → String
  | .nonMarkdown => "non markdown"
  | .mustLike => "must like"
  | .lfOnly => "LF only"
  | .lockFreeTries => "lock free tries"
  | .fullyTypeChecking => "fully type checking"
  | .copyGrain => "copy grain"
  | .firstGrain => "first grain"
  | .pageGrain => "page grain"

def leftoverUnstackPhraseConstructors : List LeftoverUnstackPhrase :=
  [.nonMarkdown, .mustLike, .lfOnly, .lockFreeTries, .fullyTypeChecking,
    .copyGrain, .firstGrain, .pageGrain]

/--
  Floor list used by spec_check leftover unstack and by leftover unstack
  on Lean spec encodings. Not a complete English checker.
-/
def leftoverUnstackPhrases : List String :=
  leftoverUnstackPhraseConstructors.map LeftoverUnstackPhrase.surface

/-- Spaced phrases the leftover unstack checker SHALL NOT flag merely for a space. -/
inductive AllowedSpacedPhrase where
  | highAssurance
  | threeBit
  | timeSeries
  deriving DecidableEq, Repr, BEq

def AllowedSpacedPhrase.surface : AllowedSpacedPhrase → String
  | .highAssurance => "high assurance"
  | .threeBit => "3 bit"
  | .timeSeries => "time series"

def allowedSpacedPhraseConstructors : List AllowedSpacedPhrase :=
  [.highAssurance, .threeBit, .timeSeries]

def allowedSpacedPhrases : List String :=
  allowedSpacedPhraseConstructors.map AllowedSpacedPhrase.surface

def asciiUpperChar (c : Char) : Char :=
  if 'a' ≤ c && c ≤ 'z' then Char.ofNat (c.toNat - 32) else c

def asciiUpper (s : String) : String :=
  String.ofList (s.toList.map asciiUpperChar)

def charsContain (hay needle : List Char) : Bool :=
  match hay with
  | [] => needle.isEmpty
  | c :: rest =>
    needle.isPrefixOf (c :: rest) || charsContain rest needle

def containsSubstring (hay needle : String) : Bool :=
  if needle.isEmpty then true
  else charsContain hay.toList needle.toList

/-- True when prose contains a Clause 3.5 leftover unstack floor phrase. -/
def containsLeftoverUnstackPhrase (prose : String) : Bool :=
  leftoverUnstackPhrases.any fun p =>
    containsSubstring (asciiUpper prose) (asciiUpper p)

def containsAllowedSpacedPhrase (prose : String) : Bool :=
  allowedSpacedPhrases.any fun p =>
    containsSubstring (asciiUpper prose) (asciiUpper p)

/-- Prose meets the leftover unstack floor when it contains none of the floor phrases. -/
def leftoverUnstackFloorConforms (prose : String) : Bool :=
  !containsLeftoverUnstackPhrase prose

def hyphenToSpace (c : Char) : Char :=
  if c == '-' then ' ' else c

/-- Deleting hyphens and leaving the same two words. -/
def leftoverUnstackOf (hyphenated : String) : String :=
  String.ofList (hyphenated.toList.map hyphenToSpace)

/-- True when after is the hyphen delete of hyphenated and after is a floor phrase. -/
def hyphenDeleteIsLeftoverUnstack (hyphenated after : String) : Bool :=
  leftoverUnstackOf hyphenated == after && leftoverUnstackPhrases.contains after

def leftoverLockFreeTriesProse : String :=
  "do not write lock free tries in prose"

def leftoverNonMarkdownProse : String :=
  "do not write non markdown in prose"

def leftoverMustLikeProse : String :=
  "do not write must like in prose"

def leftoverLfOnlyProse : String :=
  "do not write LF only in prose"

def leftoverFullyTypeCheckingProse : String :=
  "do not write fully type checking in prose"

def leftoverCopyGrainProse : String :=
  "do not write copy grain in prose"

def leftoverFirstGrainProse : String :=
  "do not write first grain in prose"

def leftoverPageGrainProse : String :=
  "do not write page grain in prose"

def allowedGrainierProse : String :=
  "Gaussian dithering appears grainier and less sharp"

def allowedThisGrainProse : String :=
  "This grain does not replace CATE"

def allowedHighAssuranceProse : String :=
  "high assurance may stay when it already reads as English"

def allowedThreeBitProse : String :=
  "a 3 bit field is allowed spaced prose"

def allowedTimeSeriesProse : String :=
  "a time series is allowed spaced prose"

def rephrasedLockTriesProse : String :=
  "tries that do not use locks"

/-- The leftover unstack list is a floor, not a complete English checker. -/
def leftoverUnstackFloorIsCompleteEnglish : Bool := false

def mashLeftoverUnstackFloorAsCompleteEnglish : Prop :=
  leftoverUnstackFloorIsCompleteEnglish = true

def mashLeftoverUnstackFloorAsCompleteEnglishIsFalse : Prop :=
  mashLeftoverUnstackFloorAsCompleteEnglish → False

/-- Clause 6.4 item 2: the contradiction floor is not a checker of every sentence pair. -/
def contradictionFloorIsEverySentencePair : Bool := false

def mashContradictionFloorIsEverySentencePair : Prop :=
  contradictionFloorIsEverySentencePair = true

def mashContradictionFloorIsEverySentencePairIsFalse : Prop :=
  mashContradictionFloorIsEverySentencePair → False

/--
  Sibling encodedLines and comments in marked spec encoding modules are
  checked on this leftover unstack floor. Complete sentence quality is
  not fully mechanical.
-/
def leanSpecEncodingsUseLeftoverUnstackFloor : Bool := true

/--
  Clause 3.5 leftover unstack comment paths on marked meaning spec
  encodings. This list is a floor, not a complete English checker.
-/
def leftoverUnstackCommentScanRelPaths : List String :=
  ["lean/FormalVibeficationSpec.lean", "lean/VocabularySpec.lean",
    "lean/Vocabulary.lean", "lean/TechTreeSpec.lean", "lean/MemexSpec.lean",
    "lean/UnlicenseSpec.lean", "lean/CateSpec.lean", "lean/RsiSpec.lean",
    "lean/CiSpec.lean", "lean/BeastDbSpec.lean", "lean/SssssSpec.lean",
    "lean/SystemsLeanSpec.lean", "lean/LeanMachineSpec.lean",
    "lean/AnunnakiSpec.lean"]

def leftoverUnstackCommentScanIncludesAnunnakiSpec : Bool :=
  leftoverUnstackCommentScanRelPaths.contains "lean/AnunnakiSpec.lean"

def leftoverLockFreeTriesFailsFloor : Prop :=
  leftoverUnstackFloorConforms leftoverLockFreeTriesProse = false

def highAssuranceMeetsFloor : Prop :=
  leftoverUnstackFloorConforms allowedHighAssuranceProse = true

def rephrasedLockTriesMeetsFloor : Prop :=
  leftoverUnstackFloorConforms rephrasedLockTriesProse = true

def hyphenDeleteLockFreeTriesIsLeftover : Prop :=
  hyphenDeleteIsLeftoverUnstack "lock-free tries" "lock free tries" = true

def rephraseLockFreeTriesIsNotLeftover : Prop :=
  hyphenDeleteIsLeftoverUnstack "lock-free tries"
      "tries that do not use locks" = false

/-!
  Residual silence: naming unpublished specs, unassigned numbers, unpinned
  prior art, unimplemented requirements, or out of scope items without a
  residual record on disk is nonconforming.
-/

structure ResidualRecord where
  namesUnpublishedOrUnpinned : Bool
  hasResidualOnDisk : Bool
  deriving DecidableEq, Repr, BEq

def ResidualRecord.silence (r : ResidualRecord) : Bool :=
  r.namesUnpublishedOrUnpinned && !r.hasResidualOnDisk

def ResidualRecord.conforming (r : ResidualRecord) : Bool :=
  !r.silence

def residualSilent : ResidualRecord :=
  { namesUnpublishedOrUnpinned := true, hasResidualOnDisk := false }

def residualWritten : ResidualRecord :=
  { namesUnpublishedOrUnpinned := true, hasResidualOnDisk := true }

def residualNothingToName : ResidualRecord :=
  { namesUnpublishedOrUnpinned := false, hasResidualOnDisk := false }

/-- Planned-file tokens in numbered specs other than 0000 require a Residual heading. -/
def plannedTokenRequiresResidualHeading (specNumber : Nat) : Bool :=
  specNumber != 0

/-- Clause 4.5: 0001 and later with a planned file token need a Residual heading. 0000 is exempt. -/
structure ResidualHeadingHonesty where
  specNumber : Nat
  hasPlannedFileToken : Bool
  hasResidualHeading : Bool
  deriving DecidableEq, Repr, BEq

def ResidualHeadingHonesty.conforming (r : ResidualHeadingHonesty) : Bool :=
  r.specNumber == 0 || !r.hasPlannedFileToken || r.hasResidualHeading

def plannedWithoutHeading : ResidualHeadingHonesty :=
  { specNumber := 5, hasPlannedFileToken := true, hasResidualHeading := false }

def plannedWithHeading : ResidualHeadingHonesty :=
  { specNumber := 5, hasPlannedFileToken := true, hasResidualHeading := true }

def spec0000WithPlannedNoHeading : ResidualHeadingHonesty :=
  { specNumber := 0, hasPlannedFileToken := true, hasResidualHeading := false }

def noPlannedNoHeading : ResidualHeadingHonesty :=
  { specNumber := 5, hasPlannedFileToken := false, hasResidualHeading := false }

/-- Heading titles named in CATE Clause 4.5 and MdLine residual checks. -/
def isResidualHeadingTitle (line : String) : Bool :=
  line == "# Residual" || line == "## Residual" || line == "## 6. Residual"

def plannedWithoutHeadingFails : Prop :=
  plannedWithoutHeading.conforming = false

def plannedWithHeadingOk : Prop :=
  plannedWithHeading.conforming = true

def spec0000PlannedWithoutHeadingOk : Prop :=
  spec0000WithPlannedNoHeading.conforming = true

/-!
  Questions to humans must carry file or clause, current wording, why it
  matters, and options, use ordinary English, define a new phrase in the
  same sentence when one is introduced, and say what we will do for each
  option. A half label is not a complete question.
-/

inductive NewPhraseInQuestion where
  | noneIntroduced
  | definedInSameSentence
  | introducedWithoutDefinition
  deriving DecidableEq, Repr, BEq

def NewPhraseInQuestion.conforming : NewPhraseInQuestion → Bool
  | .noneIntroduced => true
  | .definedInSameSentence => true
  | .introducedWithoutDefinition => false

structure OperatorQuestion where
  fileOrClause : String
  currentWording : String
  whyItMatters : String
  options : String
  usesOrdinaryEnglish : Bool
  newPhrase : NewPhraseInQuestion
  saysWhatWeWillDoEitherWay : Bool
  deriving Repr

def OperatorQuestion.complete (q : OperatorQuestion) : Bool :=
  !q.fileOrClause.isEmpty &&
    !q.currentWording.isEmpty &&
    !q.whyItMatters.isEmpty &&
    !q.options.isEmpty &&
    q.usesOrdinaryEnglish &&
    q.newPhrase.conforming &&
    q.saysWhatWeWillDoEitherWay

def halfLabelQuestion : OperatorQuestion :=
  { fileOrClause := ""
    currentWording := ""
    whyItMatters := ""
    options := ""
    usesOrdinaryEnglish := false
    newPhrase := .introducedWithoutDefinition
    saysWhatWeWillDoEitherWay := false }

def completeQuestion : OperatorQuestion :=
  { fileOrClause := "0005_CATE.md Clause 4.2"
    currentWording := "existing leftover unstack list"
    whyItMatters := "authors need a floor they can check"
    options := "keep the five phrases, or widen the list"
    usesOrdinaryEnglish := true
    newPhrase := .definedInSameSentence
    saysWhatWeWillDoEitherWay := true }

/-- Spec markdown is the contract humans read. Lean encodings are not that markdown. -/
def specMarkdownIsContract : Bool := true

def meaningProofsAreSecondFormChecker : Bool := false

/-- Clause 6.5 item 1: this document does not claim every agent already conforms. -/
def everyAgentAlreadyConforms : Bool := false

def mashEveryAgentAlreadyConforms : Prop :=
  everyAgentAlreadyConforms = true

def mashEveryAgentAlreadyConformsIsFalse : Prop :=
  mashEveryAgentAlreadyConforms → False

/-- Do not claim a conforming product exists unless the operator said it exists. -/
def cateAllowsInventedConformingProduct : Bool := false

def mashCateAllowsInventedConformingProduct : Prop :=
  cateAllowsInventedConformingProduct = true

def mashCateAllowsInventedConformingProductIsFalse : Prop :=
  mashCateAllowsInventedConformingProduct → False

/--
  Scope: British spelling is nonconforming, including names we choose.
  The American form of the example is catalog. This is not an aspell scan.
-/
def britishSpellingConforms : Bool := false

def mashBritishSpellingConforms : Prop :=
  britishSpellingConforms = true

def mashBritishSpellingConformsIsFalse : Prop :=
  mashBritishSpellingConforms → False

/-- Informative prior art named by CATE is not a Clause 12 pin. -/
def iso24495IsClause12Pin : Bool := false

def federalPlainLanguageIsClause12Pin : Bool := false

/-- CATE does not replace RFC 2119. -/
def cateReplacesRfc2119 : Bool := false

/-- Independent work streams run as parallel subagents. -/
def independentWorkStreamsRunInParallel : Bool := true

def serializeDisjointWriteSets : Bool := false

/-- Encode process self improvement in the same effort. -/
def encodeProcessSelfImprovesInSameEffort : Bool := true

def chatReminderCountsAsEncodeProof : Bool := false

/-- Size reports include COCOMO; COCOMO is not a real schedule. -/
def sccOmitsCocomoWhenSizeAsked : Bool := false

def cocomoIsRealSchedule : Bool := false

/-- Git mutate only when the operator asked. -/
def gitMutateUnlessOperatorAsked : Bool := false

/-- This CATE meaning model requires the Formal Vibefication science cycle. -/
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

end Cate
