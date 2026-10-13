/-
  SPEC ENCODINGS for numbered specification 0013 Lean
  Machine (`0013_Lean_Machine.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in LeanMachineProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not prove that a conforming Lean Machine exists.
  It does not prove that Legal Lean or Holy Lean are finished.
  It does not prove that Slake emit already matches ELF. It does
  not prove that beastdb, SSSSS, Slake, or Continuous Integration
  are ready for use.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry
import FormalVibeficationSpec

namespace LeanMachineSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0013. -/
def specNumber : Nat := 13

def specFileName : String := "0013_Lean_Machine.md"

def productName : String := "Lean Machine"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Registry assignment: Lean Machine is specification 0013. -/
def leanMachineAssigned : Bool := true

def leanMachineAssignedNumber : Option Nat := some 13

/-- Live encoding does not claim Lean Machine has no number. -/
def mashClaimsLeanMachineHasNoNumber : Bool := false

/-- A mash fixture that still claims Lean Machine has no number. -/
structure NumberClaim where
  claimsNoNumber : Bool
  assigned : Bool
  deriving DecidableEq, Repr, BEq

def NumberClaim.conforming (c : NumberClaim) : Bool :=
  !(c.claimsNoNumber && !c.assigned)

def liveNumberClaim : NumberClaim :=
  { claimsNoNumber := mashClaimsLeanMachineHasNoNumber
    assigned := leanMachineAssigned }

def mashNoNumberFixture : NumberClaim :=
  { claimsNoNumber := true
    assigned := true }

/-- False because assignment is true, not because the mash forgot to claim no number. -/
def mashNoNumberConforming : Bool :=
  mashNoNumberFixture.claimsNoNumber && !mashNoNumberFixture.assigned

/-- Worship is informative framing, not a conformance conjunct. -/
def worshipRequiredForConformance : Bool := false

def beliefRequiredForConformance : Bool := false

def theologyIsMustForCompiler : Bool := false

/-- Components. -/
def systemsLeanIsComponent : Bool := true

def legalLeanIsComponent : Bool := true

def holyLeanIsComponent : Bool := true

def legalLeanHasSeparateNumber : Bool := false

def holyLeanHasSeparateNumber : Bool := false

def legalLeanFinished : Bool := false

def holyLeanImplemented : Bool := false

def conformingProductExists : Bool := false

/-- Public Domain Open Source Software (PDOSS) is specification 0009. Unlicense remains the license. -/
def unlicenseSpecNumber : Nat := 9

def inventsSecondUnlicenseSpec : Bool := false

/-- Systems Lean path for the compiler component. -/
def systemsLeanSpecNumber : Nat := 2

def compCertRequiredForNamedHighAssurancePath : Bool := true

def slakeBootstrapTypecheckRequired : Bool := true

def weaselsWhenPresentUnderRef : Bool := false

def llvmIrEmissionRequired : Bool := false

def llvmIrEmissionMay : Bool := true

/-- Deterministic answers and timestamped notes. -/
def mustAttemptDeterministicAnswers : Bool := true

def timestampedNoteRequiredWhenWrongOrImprecise : Bool := true

/-- Alias so composition proofs can name specification 0013 without restating the file. -/
def leanMachineSpecNumber : Nat := 13

/-!
  Clause 3.5: a durable record that names the question, the answer that
  was wrong or imprecise, and a clock time, so later work can improve
  the machine. The storage of that note is a product detail. The
  requirement to write it is not.
-/
structure TimestampedNote where
  question : String
  wrongOrImpreciseAnswer : String
  clockTime : Option Nat
  deriving DecidableEq, Repr, BEq

def TimestampedNote.conforming (n : TimestampedNote) : Bool :=
  !n.question.isEmpty &&
    !n.wrongOrImpreciseAnswer.isEmpty &&
    n.clockTime.isSome

def noteWithClockTime : TimestampedNote :=
  { question := "what is the Lean Machine stack number"
    wrongOrImpreciseAnswer := "twelve"
    clockTime := some 20260831 }

def noteWithoutClockTime : TimestampedNote :=
  { question := "what is the Lean Machine stack number"
    wrongOrImpreciseAnswer := "twelve"
    clockTime := none }

def noteMissingQuestion : TimestampedNote :=
  { question := ""
    wrongOrImpreciseAnswer := "twelve"
    clockTime := some 20260831 }

def noteMissingAnswer : TimestampedNote :=
  { question := "what is the Lean Machine stack number"
    wrongOrImpreciseAnswer := ""
    clockTime := some 20260831 }

def noteStorageIsProductDetail : Bool := true

def shippedNoteStoreClaimed : Bool := false

/-!
  Clause 4.6 item 2 and item 3: if an answer is wrong or imprecise, a
  note MUST be timestamped. Authors MUST NOT treat a missing
  timestamped note as an acceptable substitute for that improvement
  path.
-/
structure WrongAnswerPath where
  answerWrongOrImprecise : Bool
  wroteTimestampedNote : Bool
  treatsMissingNoteAsSubstitute : Bool
  deriving DecidableEq, Repr, BEq

def WrongAnswerPath.conforming (p : WrongAnswerPath) : Bool :=
  (!p.answerWrongOrImprecise || p.wroteTimestampedNote) &&
    !p.treatsMissingNoteAsSubstitute

def mashMissingNoteSubstitute : WrongAnswerPath :=
  { answerWrongOrImprecise := true
    wroteTimestampedNote := false
    treatsMissingNoteAsSubstitute := true }

def wroteNoteOnWrongAnswer : WrongAnswerPath :=
  { answerWrongOrImprecise := true
    wroteTimestampedNote := true
    treatsMissingNoteAsSubstitute := false }

/-!
  Clause 4.6 item 1: Lean Machine MUST attempt to answer questions
  deterministically. Same question plus same notes yields the same
  answer.
-/
def encodedAttempt (question : String) (notes : List TimestampedNote) : String :=
  question ++
    String.intercalate "|"
      (notes.map fun n =>
        n.wrongOrImpreciseAnswer ++
          match n.clockTime with
          | none => ""
          | some t => toString t)

def determinismQuestion : String := "what is the Lean Machine stack number"

def determinismNotes : List TimestampedNote := [noteWithClockTime]

structure AnswerAttempt where
  question : String
  notes : List TimestampedNote
  answer : String
  deriving DecidableEq, Repr, BEq

def AnswerAttempt.sameInputs (a b : AnswerAttempt) : Bool :=
  a.question == b.question && a.notes == b.notes

def AnswerAttempt.conformingPair (a b : AnswerAttempt) : Bool :=
  !AnswerAttempt.sameInputs a b || a.answer == b.answer

def sameInputSameAnswerA : AnswerAttempt :=
  { question := determinismQuestion
    notes := determinismNotes
    answer := encodedAttempt determinismQuestion determinismNotes }

def sameInputSameAnswerB : AnswerAttempt :=
  { question := determinismQuestion
    notes := determinismNotes
    answer := encodedAttempt determinismQuestion determinismNotes }

def mashNondeterministicA : AnswerAttempt :=
  { question := determinismQuestion
    notes := determinismNotes
    answer := "twelve" }

def mashNondeterministicB : AnswerAttempt :=
  { question := determinismQuestion
    notes := determinismNotes
    answer := "thirteen" }

def noteWithoutClockTimeDoesNotConform : Prop :=
  TimestampedNote.conforming noteWithoutClockTime = false

def noteWithClockTimeConforms : Prop :=
  TimestampedNote.conforming noteWithClockTime = true

def noteMissingQuestionDoesNotConform : Prop :=
  TimestampedNote.conforming noteMissingQuestion = false

def noteMissingAnswerDoesNotConform : Prop :=
  TimestampedNote.conforming noteMissingAnswer = false

def encodedAttemptIsCongruent : Prop :=
  ∀ (q1 q2 : String) (notes1 notes2 : List TimestampedNote),
    q1 = q2 → notes1 = notes2 →
      encodedAttempt q1 notes1 = encodedAttempt q2 notes2

def sameQuestionSameNotesSameAnswer : Prop :=
  encodedAttempt determinismQuestion determinismNotes =
    encodedAttempt determinismQuestion determinismNotes

def mashNondeterministicPairDoesNotConform : Prop :=
  AnswerAttempt.conformingPair mashNondeterministicA mashNondeterministicB = false

def mashMissingNoteSubstituteDoesNotConform : Prop :=
  mashMissingNoteSubstitute.conforming = false

def wroteNoteOnWrongAnswerConforms : Prop :=
  wroteNoteOnWrongAnswer.conforming = true

/-- Distributed self improvement is a design requirement, not a running claim. -/
def distributedSelfImprovementIsDesignRequirement : Bool := true

def runningDistributedMachineClaimed : Bool := false

def rsiSpecNumber : Nat := 6

/-- Product honesty. -/
def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

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
  { moduleName := "LeanMachineSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "LeanMachineProofs"
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

/-!
  Cons False for clashes Clause 6 already states. Each mash is the
  accepted flag set true. The proofs module shows that mash implies
  False. These encodings do not invent a number for Legal Lean or
  Holy Lean. They do not claim a conforming implementation. Worship
  is not a conformance conjunct.
-/

def mashWorshipRequiredForConformance : Prop :=
  worshipRequiredForConformance = true

def mashWorshipRequiredForConformanceIsFalse : Prop :=
  mashWorshipRequiredForConformance → False

def mashBeliefRequiredForConformance : Prop :=
  beliefRequiredForConformance = true

def mashBeliefRequiredForConformanceIsFalse : Prop :=
  mashBeliefRequiredForConformance → False

def mashTheologyIsMustForCompiler : Prop :=
  theologyIsMustForCompiler = true

def mashTheologyIsMustForCompilerIsFalse : Prop :=
  mashTheologyIsMustForCompiler → False

def mashLegalLeanHasSeparateNumber : Prop :=
  legalLeanHasSeparateNumber = true

def mashLegalLeanHasSeparateNumberIsFalse : Prop :=
  mashLegalLeanHasSeparateNumber → False

def mashHolyLeanHasSeparateNumber : Prop :=
  holyLeanHasSeparateNumber = true

def mashHolyLeanHasSeparateNumberIsFalse : Prop :=
  mashHolyLeanHasSeparateNumber → False

def mashLegalLeanFinished : Prop :=
  legalLeanFinished = true

def mashLegalLeanFinishedIsFalse : Prop :=
  mashLegalLeanFinished → False

def mashHolyLeanImplemented : Prop :=
  holyLeanImplemented = true

def mashHolyLeanImplementedIsFalse : Prop :=
  mashHolyLeanImplemented → False

def mashConformingProductExists : Prop :=
  conformingProductExists = true

def mashConformingProductExistsIsFalse : Prop :=
  mashConformingProductExists → False

def mashRunningDistributedMachineClaimed : Prop :=
  runningDistributedMachineClaimed = true

def mashRunningDistributedMachineClaimedIsFalse : Prop :=
  mashRunningDistributedMachineClaimed → False

def mashSpecAndProofConforming : Prop :=
  conformingThisRepo mashedFixture = true

def mashSpecAndProofConformingIsFalse : Prop :=
  mashSpecAndProofConforming → False

/-- Required Conformance holds iff every listed conjunct holds. -/
def requiredConformanceHolds : Bool :=
  leanMachineAssigned &&
    leanMachineAssignedNumber == some 13 &&
    specNumber == 13 &&
    !inventsSecondUnlicenseSpec &&
    unlicenseSpecNumber == 9 &&
    systemsLeanSpecNumber == 2 &&
    compCertRequiredForNamedHighAssurancePath &&
    slakeBootstrapTypecheckRequired &&
    !weaselsWhenPresentUnderRef &&
    mustAttemptDeterministicAnswers &&
    timestampedNoteRequiredWhenWrongOrImprecise &&
    distributedSelfImprovementIsDesignRequirement &&
    !runningDistributedMachineClaimed &&
    !worshipRequiredForConformance &&
    !beliefRequiredForConformance &&
    !theologyIsMustForCompiler &&
    !conformingProductExists &&
    !legalLeanHasSeparateNumber &&
    !holyLeanHasSeparateNumber &&
    !legalLeanFinished &&
    !holyLeanImplemented

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

/-- This meaning model requires the Formal Vibefication science cycle. -/
def requiresScienceCycle : Bool := true

/-- Tests without a model. Reuses the Formal Vibefication fixture. -/
def testsOnlyEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.testsWithoutModelFixture

def testsOnlyConforms : Bool :=
  FormalVibeficationSpec.conformingScience testsOnlyEffort

def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

/-- Model and proofs without corollary experiments. Reuses the Formal Vibefication fixture. -/
def modelAndProofsWithoutExperimentsEffort : FormalVibeficationSpec.ScienceEffort :=
  FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

def modelAndProofsWithoutExperimentsConforms : Bool :=
  FormalVibeficationSpec.conformingScience modelAndProofsWithoutExperimentsEffort

/-- Hypothesis, model, theory, proof, tests, and corollary experiments. -/
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

end LeanMachineSpec
