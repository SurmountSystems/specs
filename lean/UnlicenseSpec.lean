/-
  SPEC ENCODINGS for numbered specification 0009 Public Domain
  Open Source Software (PDOSS) (`0009_PDOSS.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in UnlicenseProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.
  Unlicense remains the license. Lake keeps this library name.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html

  This file does not prove that Slake emit already matches ELF. It does
  not prove that beastdb, SSSSS, Slake, or Continuous Integration are
  ready for use. It does not prove that essays by Keagan McLelland
  (Proof of Keags) are Unlicense.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry
import FormalVibeficationSpec

namespace UnlicenseSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0009. -/
def specNumber : Nat := 9

def specFileName : String := "0009_PDOSS.md"

def productName : String := "PDOSS"

/-- Same number as `specNumber`. Unlicense remains the license. -/
def pdossSpecNumber : Nat := 9

/-- Copyright still held versus dedicated to the public domain. -/
inductive CopyrightStatus where
  | copyrightHeld
  | publicDomainDedicated
  deriving DecidableEq, Repr, BEq

/-- A grant of use that may or may not keep copyright. -/
structure Grant where
  keepsCopyright : Bool
  dedicatedToPublicDomain : Bool
  deriving DecidableEq, Repr, BEq

/-- Remaining copyright: the grant keeps copyright and is not a dedication. -/
def remainingCopyright (g : Grant) : Bool :=
  g.keepsCopyright && !g.dedicatedToPublicDomain

/-- A grant that keeps copyright and has no public domain dedication. -/
def ossWithoutDedication : Grant :=
  { keepsCopyright := true
    dedicatedToPublicDomain := false }

/-- Unlicense: dedication, not a grant that keeps copyright. -/
def unlicenseDedication : Grant :=
  { keepsCopyright := false
    dedicatedToPublicDomain := true }

def ossWithoutDedicationStatus : CopyrightStatus := .copyrightHeld

def unlicenseDedicationStatus : CopyrightStatus := .publicDomainDedicated

/-- Stated: remaining copyright on a grant that keeps copyright. -/
def ossWithoutDedicationHasRemainingCopyright : Prop :=
  remainingCopyright ossWithoutDedication = true ∧
    ossWithoutDedicationStatus = CopyrightStatus.copyrightHeld

/-- Stated: Unlicense dedication has no remaining copyright in the model. -/
def unlicenseDedicationHasNoRemainingCopyright : Prop :=
  remainingCopyright unlicenseDedication = false ∧
    unlicenseDedicationStatus = CopyrightStatus.publicDomainDedicated

def grantThatKeepsCopyrightLetsLaterContractTakeTheWork : Bool := true

def mostImportantWorkShallBePublicDomainDedicated : Bool := true

/-- Ideas are not used up when they are shared. -/
def ideasAreScarce : Bool := false

def ideasNonScarce : Bool := !ideasAreScarce

/-- Two people can hold the same idea at once. -/
def twoPeopleCanHoldTheSameIdeaAtOnce : Bool := true

def ideasNotRivalrous : Bool := twoPeopleCanHoldTheSameIdeaAtOnce

def generosityOfIdeasIsDefault : Bool := true

/-- Named residual licenses this repository Unlicense does not replace. -/
inductive LicenseOfWork where
  | unlicenseDedication
  | mitGrant
  | apacheTwo
  | notThisRepoGrant
  deriving DecidableEq, Repr, BEq

/-- Dedication under the PDOSS test (public domain plus open software). -/
inductive Dedication where
  | unlicense
  | mitGrant
  | apacheTwo
  | cc0
  deriving DecidableEq, Repr, BEq

/-- Public domain dedication test. MIT and Apache 2.0 keep copyright. CC0 is not pinned. -/
def meetsPublicDomainDedicationTest : Dedication → Bool
  | .unlicense => true
  | .mitGrant => false
  | .apacheTwo => false
  | .cc0 => false

/-- Source available under a use grant. CC0 is not pinned here so it is not claimed. -/
def isOpenSoftware : Dedication → Bool
  | .unlicense => true
  | .mitGrant => true
  | .apacheTwo => true
  | .cc0 => false

/-- PDOSS test: public domain dedication of software that is open. -/
def meetsPdoss (d : Dedication) : Bool :=
  meetsPublicDomainDedicationTest d && isOpenSoftware d

def mitMeetsPdoss : Prop := meetsPdoss .mitGrant = true

def apacheMeetsPdoss : Prop := meetsPdoss .apacheTwo = true

def numberedSpecsAndLeanHere : LicenseOfWork := .unlicenseDedication

def lean4SkillsPack : LicenseOfWork := .mitGrant

def btcVerifiedPin : LicenseOfWork := .apacheTwo

def keaganEssays : LicenseOfWork := .notThisRepoGrant

def thisRepoUnlicenseExceptNamedResidual : Prop :=
  numberedSpecsAndLeanHere = LicenseOfWork.unlicenseDedication ∧
    lean4SkillsPack = LicenseOfWork.mitGrant ∧
    btcVerifiedPin = LicenseOfWork.apacheTwo ∧
    keaganEssays = LicenseOfWork.notThisRepoGrant

def unlicenseOfThisRepoAppliesToKeaganEssays : Bool := false

def essaysAreUnlicenseGrant : Bool := false

def refuseToolYouCannotImproveIsLicenseClaim : Bool := false

def refuseToolYouCannotImproveIsRsiProcess : Bool := true

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Layout of one Lean module relative to the split. -/
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
  { moduleName := "UnlicenseSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "UnlicenseProofs"
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

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

def numberNineAssigned : Bool := true

def numberElevenPublished : Bool := true

def siblingLineEncodingsRequired : Bool := true

def siblingProofsAreSeparateModules : Bool := true

/-- This meaning model requires the Formal Vibefication science cycle. -/
def requiresScienceCycle : Bool := true

/-- Effort that has tests and no model. Reuses the 0008 fixture. -/
def testsOnlyEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.testsWithoutModelFixture

/-- Tests are necessary and are not sufficient. Reuses the 0008 Bool. -/
def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

/-- Model and proofs without corollary experiments. Reuses the 0008 fixture. -/
def modelAndProofsWithoutExperimentsEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

/-- Complete science cycle. Reuses the 0008 fixture. -/
def completeScienceEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.completeScienceFixture

def testsWithoutModelDoesNotConform : Prop :=
  FormalVibeficationSpec.testsWithoutModelDoesNotConform

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  FormalVibeficationSpec.modelAndProofsWithoutExperimentsDoesNotConform

def completeScienceConforms : Prop :=
  FormalVibeficationSpec.completeScienceConforms

end UnlicenseSpec
