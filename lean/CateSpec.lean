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
  (for example `lock free tries`) is nonconforming.
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

/--
  Floor list used by spec_check leftover unstack and by leftover unstack
  on Lean spec encodings. Not a complete English checker.
-/
def leftoverUnstackPhrases : List String :=
  ["non markdown", "must like", "LF only", "lock free tries",
    "fully type checking"]

/-- The leftover unstack list is a floor, not a complete English checker. -/
def leftoverUnstackFloorIsCompleteEnglish : Bool := false

/--
  Sibling encodedLines and comments in marked spec encoding modules are
  checked on this leftover unstack floor. Complete sentence quality is
  not fully mechanical.
-/
def leanSpecEncodingsUseLeftoverUnstackFloor : Bool := true

def allowedSpacedPhrases : List String :=
  ["high assurance", "3 bit", "time series"]

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

/-- Do not claim a conforming product exists unless the operator said it exists. -/
def cateAllowsInventedConformingProduct : Bool := false

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
