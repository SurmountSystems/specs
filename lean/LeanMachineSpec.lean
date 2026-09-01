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

/-- Unlicense of important work is specification 0009. -/
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

end LeanMachineSpec
