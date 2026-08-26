/-
  Companion Lean model of selected claims from 0005_CATE.md
  (Concise American Technical English).

  This module is not the specification. The numbered markdown is the contract
  that humans read. Spec encodings state what must be true. Proofs of those
  encodings belong in a separate module under Formal Vibefication
  (`0008_Formal_Vibefication.md`); this file still mixes both and that mash
  is remaining work. spec_check remains the form checker (ASCII, tabs,
  RFC 2119, spelling, leftover unstack, residual heading). These declarations
  encode meaning so an inconsistent model is a type error or a failing test.

  CATE is numbered specification 0005. It is not specification 0000 and it is
  not specification 0006. Number 0006 is Recursive Self Improvement (RSI).
-/

import SpecRegistry

namespace Cate

def specNumber : Nat := 5

def specFileName : String := "0005_CATE.md"

def cateSpecNumber : Nat := specNumber

def cateIsNewStackNumber : Bool := true

theorem cate_is_0005 : specNumber = 5 := rfl

/-- Fails if the model still numbers CATE as 0006. -/
theorem cate_is_not_0006 : specNumber ≠ 6 := by decide

theorem cate_file_is_0005_cate : specFileName = "0005_CATE.md" := rfl

theorem cate_is_not_0000 : specNumber ≠ 0 := by decide

theorem cate_is_not_rsi :
    specNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem cate_is_new_stack_number : cateIsNewStackNumber = true := rfl

/-- The word catalog is owned by this specification, not by a distinct 0009. -/
def ownsVocabularyCatalog : Bool := true

theorem cate_owns_vocabulary_catalog : ownsVocabularyCatalog = true := rfl

theorem vocabulary_number_is_cate :
    SpecRegistry.vocabularySpecNumber = specNumber :=
  rfl

def numberNineWithdrawn : Bool := false

theorem number_nine_is_unlicense :
    SpecRegistry.unlicenseSpecNumber = 9 :=
  rfl

theorem number_nine_is_not_withdrawn : numberNineWithdrawn = false := rfl

theorem mash_unpublished_0009
    (h : SpecRegistry.allEntries.any (fun e => e.number == 9) = false) : False := by
  have hYes := SpecRegistry.number_9_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem rsi_is_0006 :
    SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem carbonado_is_not_0005 :
    SpecRegistry.carbonadoAssignedNumber ≠ some 5 := by
  decide

theorem carbonado_is_not_0006 :
    SpecRegistry.carbonadoAssignedNumber ≠ some 6 := by
  decide

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

theorem leftover_unstack_nonconforming :
    HyphenRepair.leftoverUnstack.conforming = false :=
  rfl

theorem rephrased_hyphen_conforming :
    HyphenRepair.rephrasedOrdinaryEnglish.conforming = true :=
  rfl

/--
  Floor list used by spec_check leftover unstack and by leftover unstack
  on Lean spec encodings. Not a complete English checker.
-/
def leftoverUnstackPhrases : List String :=
  ["non markdown", "must like", "LF only", "lock free tries",
    "fully type checking"]

theorem leftover_unstack_phrase_count :
    leftoverUnstackPhrases.length = 5 :=
  rfl

theorem leftover_unstack_phrases_are :
    leftoverUnstackPhrases =
      ["non markdown", "must like", "LF only", "lock free tries",
        "fully type checking"] :=
  rfl

/-- The leftover unstack list is a floor, not a complete English checker. -/
def leftoverUnstackFloorIsCompleteEnglish : Bool := false

theorem leftover_unstack_floor_is_not_complete_english :
    leftoverUnstackFloorIsCompleteEnglish = false :=
  rfl

/--
  Sibling encodedLines and comments in marked spec encoding modules are
  checked on this leftover unstack floor. Complete sentence quality is
  not fully mechanical.
-/
def leanSpecEncodingsUseLeftoverUnstackFloor : Bool := true

theorem lean_spec_encodings_use_leftover_unstack_floor :
    leanSpecEncodingsUseLeftoverUnstackFloor = true :=
  rfl

def allowedSpacedPhrases : List String :=
  ["high assurance", "3 bit", "time series"]

theorem allowed_spaced_phrase_count :
    allowedSpacedPhrases.length = 3 :=
  rfl

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

theorem residual_silence_nonconforming :
    residualSilent.conforming = false :=
  rfl

theorem residual_written_conforming :
    residualWritten.conforming = true :=
  rfl

theorem residual_nothing_to_name_conforming :
    residualNothingToName.conforming = true :=
  rfl

/-- Planned-file tokens in numbered specs other than 0000 require a Residual heading. -/
def plannedTokenRequiresResidualHeading (specNumber : Nat) : Bool :=
  specNumber != 0

theorem spec_0000_exempt_from_planned_residual_heading :
    plannedTokenRequiresResidualHeading 0 = false :=
  rfl

theorem spec_0001_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 1 = true :=
  rfl

theorem spec_0003_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 3 = true :=
  rfl

theorem spec_0005_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 5 = true :=
  rfl

theorem spec_0006_requires_planned_residual_heading :
    plannedTokenRequiresResidualHeading 6 = true :=
  rfl

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

theorem new_phrase_without_definition_not_conforming :
    NewPhraseInQuestion.introducedWithoutDefinition.conforming = false :=
  rfl

theorem new_phrase_defined_in_same_sentence_conforming :
    NewPhraseInQuestion.definedInSameSentence.conforming = true :=
  rfl

theorem half_label_question_incomplete :
    halfLabelQuestion.complete = false :=
  rfl

theorem complete_question_ok :
    completeQuestion.complete = true :=
  rfl

/-- Spec markdown is the contract humans read. Lean encodings are not that markdown. -/
def specMarkdownIsContract : Bool := true

def meaningProofsAreSecondFormChecker : Bool := false

theorem spec_markdown_is_the_contract :
    specMarkdownIsContract = true :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

/-- Do not claim a conforming product exists unless the operator said it exists. -/
def cateAllowsInventedConformingProduct : Bool := false

theorem no_invented_conforming_product :
    cateAllowsInventedConformingProduct = false :=
  rfl

/-- Informative prior art named by CATE is not a Clause 12 pin. -/
def iso24495IsClause12Pin : Bool := false

def federalPlainLanguageIsClause12Pin : Bool := false

theorem iso_24495_not_clause_12_pin :
    iso24495IsClause12Pin = false :=
  rfl

theorem federal_plain_language_not_clause_12_pin :
    federalPlainLanguageIsClause12Pin = false :=
  rfl

/-- CATE does not replace RFC 2119. -/
def cateReplacesRfc2119 : Bool := false

theorem cate_does_not_replace_rfc_2119 :
    cateReplacesRfc2119 = false :=
  rfl

/-- Independent work streams run as parallel subagents. -/
def independentWorkStreamsRunInParallel : Bool := true

def serializeDisjointWriteSets : Bool := false

theorem independent_streams_are_parallel :
    independentWorkStreamsRunInParallel = true :=
  rfl

theorem disjoint_write_sets_not_serialized :
    serializeDisjointWriteSets = false :=
  rfl

/-- Encode process self improvement in the same effort. -/
def encodeProcessSelfImprovesInSameEffort : Bool := true

def chatReminderCountsAsEncodeProof : Bool := false

theorem encode_self_improves_in_same_effort :
    encodeProcessSelfImprovesInSameEffort = true :=
  rfl

theorem chat_reminder_is_not_encode_proof :
    chatReminderCountsAsEncodeProof = false :=
  rfl

/-- Size reports include COCOMO; COCOMO is not a real schedule. -/
def sccOmitsCocomoWhenSizeAsked : Bool := false

def cocomoIsRealSchedule : Bool := false

theorem scc_includes_cocomo_when_size_asked :
    sccOmitsCocomoWhenSizeAsked = false :=
  rfl

theorem cocomo_is_not_a_real_schedule :
    cocomoIsRealSchedule = false :=
  rfl

/-- Git mutate only when the operator asked. -/
def gitMutateUnlessOperatorAsked : Bool := false

theorem no_git_mutate_unless_asked :
    gitMutateUnlessOperatorAsked = false :=
  rfl

end Cate
