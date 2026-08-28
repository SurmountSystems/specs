/-
  SPEC ENCODINGS for numbered specification 0008 Formal Vibefication
  (`0008_Formal_Vibefication.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in FormalVibeficationProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not prove that Slake emit already matches ELF. It does
  not prove that beastdb, SSSSS, Slake, or Continuous Integration are
  ready for use.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry

namespace FormalVibeficationSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0008. -/
def specNumber : Nat := 8

def specFileName : String := "0008_Formal_Vibefication.md"

def productName : String := "Formal Vibefication"

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

/-- Pairwise distinct layers, stated as a proposition. -/
def layersPairwiseDistinct : Prop :=
  Layer.humanMarkdownContract ≠ Layer.leanSpecEncoding ∧
    Layer.humanMarkdownContract ≠ Layer.leanProof ∧
    Layer.humanMarkdownContract ≠ Layer.productImplementation ∧
    Layer.leanSpecEncoding ≠ Layer.leanProof ∧
    Layer.leanSpecEncoding ≠ Layer.productImplementation ∧
    Layer.leanProof ≠ Layer.productImplementation

/-- Human markdown is the contract people read. It does not replace Lean encodings. -/
def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

def specCheckIsMarkdownForm : Bool := true

def specCheckIsMeaningSpecEncoding : Bool := false

/-- Layout of one Lean module relative to the split. -/
structure LeanModuleRole where
  moduleName : String
  containsSpecEncodings : Bool
  containsProofsOfThoseEncodings : Bool
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  deriving DecidableEq, Repr, BEq

/-- A mash that hides the split: encodings and their proofs in one module. -/
def hidesSplit (m : LeanModuleRole) : Bool :=
  m.containsSpecEncodings && m.containsProofsOfThoseEncodings

/-- Conforming for this specifications repository. -/
def conformingThisRepo (m : LeanModuleRole) : Bool :=
  !hidesSplit m &&
    (!m.containsSpecEncodings || (m.markedAsSpecEncoding && !m.markedAsProof)) &&
    (!m.containsProofsOfThoseEncodings || (m.markedAsProof && !m.markedAsSpecEncoding))

def specEncodingFixture : LeanModuleRole :=
  { moduleName := "FormalVibeficationSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "FormalVibeficationProofs"
    containsSpecEncodings := false
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := false
    markedAsProof := true }

/-- Fixture: spec encodings and proofs mashed in one module. -/
def mashedFixture : LeanModuleRole :=
  { moduleName := "MashedSpecAndProof"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := true
    markedAsProof := true }

/-- Stated: the mashed fixture does not conform here. -/
def mashedIsNonconformingThisRepo : Prop :=
  conformingThisRepo mashedFixture = false

/-- Stated: separate marked modules conform, and they are not the same file. -/
def separateModulesConformThisRepo : Prop :=
  conformingThisRepo specEncodingFixture = true ∧
    conformingThisRepo proofFixture = true ∧
    specEncodingFixture.moduleName ≠ proofFixture.moduleName

inductive Home where
  | thisSpecificationsRepo
  | systemsLeanProductTree
  deriving DecidableEq, Repr, BEq

def Home.mayUnifySpecProofImpl : Home → Bool
  | .thisSpecificationsRepo => false
  | .systemsLeanProductTree => true

/-- Treating the two homes as the same layer. -/
def mashHomes : Prop :=
  Home.thisSpecificationsRepo.mayUnifySpecProofImpl =
    Home.systemsLeanProductTree.mayUnifySpecProofImpl

/-- Stated: a mash of homes is inconsistent. -/
def mashHomesIsInconsistent : Prop :=
  mashHomes → False

/-- Stated: spec encoding is not the proof. -/
def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/-- thisRepoSeparates: encodings are not proofs and are not markdown form. -/
def thisRepoSeparates : Prop :=
  Layer.leanSpecEncoding ≠ Layer.leanProof ∧
    Layer.humanMarkdownContract ≠ Layer.leanSpecEncoding ∧
    Layer.humanMarkdownContract ≠ Layer.leanProof ∧
    Home.thisSpecificationsRepo.mayUnifySpecProofImpl = false

def productTreeUnifies : Prop :=
  Home.systemsLeanProductTree.mayUnifySpecProofImpl = true

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

def dontTrustVerifyUrl : String :=
  "https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html"

def essaysAreUnlicenseGrant : Bool := false

def essaysMayBeVendoredAsForm2 : Bool := false

def theoremsCoverExactlyWhatTheyState : Bool := true

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Number 0009 is Unlicense. The word catalog is owned by CATE. -/
def numberNineAssigned : Bool := true

/-- Every published numbered markdown has a sibling `NNNN_descriptive_name.lean` at the repository root. -/
def siblingLineEncodingsRequired : Bool := true

/-- Proofs of those encodings live in `lean/Proofs_NNNN.lean`, not in the sibling encoding. -/
def siblingProofsAreSeparateModules : Bool := true

/-- A mash of sibling line encodings and their proofs does not conform here. -/
def mashedSiblingEncodingAndProofsConform : Bool := false

def mashedSiblingIsNonconforming : Prop :=
  mashedSiblingEncodingAndProofsConform = false

end FormalVibeficationSpec
