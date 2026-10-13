/-
  Companion Lean model of selected claims from 0007_CI.md
  (Continuous Integration and stack consistency).

  This module is not the specification. The numbered markdown is the contract
  that humans read. Spec encodings state what must be true. Proofs of those
  encodings belong in a separate module under Formal Vibefication
  (`0008_Formal_Vibefication.md`). spec_check remains the form checker (ASCII, tabs,
  RFC 2119, spelling, leftover unstack, residual heading). These declarations
  encode meaning so an inconsistent model is a type error or a failing test.

  CI is numbered specification 0007. It is not specification 0005 (CATE) and
  it is not specification 0006 (RSI). fargo is not specification 0007.
-/

import FormalVibeficationSpec
import SpecRegistry

namespace Ci

def specNumber : Nat := 7

def specFileName : String := "0007_CI.md"

def productName : String := "CI"

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def fargoSpecifiedHere : Bool := false

def ssspSpecified : Bool := false

def thisRepoNamedGate : String :=
  "nix flake check \"path:$PWD\" --print-build-logs"

/-!
  Named gate: red then commit does not conform. Naming residual does not
  replace a red gate.
-/

inductive GateColor where
  | red
  | green
  deriving DecidableEq, Repr, BEq

structure CommitAttempt where
  color : GateColor
  residualNamedAsSubstitute : Bool
  deriving DecidableEq, Repr, BEq

def CommitAttempt.conforming (c : CommitAttempt) : Bool :=
  match c.color with
  | .green => true
  | .red => false

def residualReplacesRedGate (c : CommitAttempt) : Bool :=
  c.color == .red && c.residualNamedAsSubstitute

def commitOnRed : CommitAttempt :=
  { color := .red, residualNamedAsSubstitute := false }

def commitOnGreen : CommitAttempt :=
  { color := .green, residualNamedAsSubstitute := false }

def residualInsteadOfGreen : CommitAttempt :=
  { color := .red, residualNamedAsSubstitute := true }

/-!
  Unsigned commit without the named two-tree exception does not conform.
-/

inductive CommitSignature where
  | unsigned
  | operatorSigned
  deriving DecidableEq, Repr, BEq

structure DualTreeException where
  grokBuildSourcePeopleCanRead : Bool
  distinctOpenSourcePublished : Bool
  namedInProductResidual : Bool
  treatedAsGeneralSkip : Bool
  deriving DecidableEq, Repr, BEq

def DualTreeException.applies (e : DualTreeException) : Bool :=
  e.grokBuildSourcePeopleCanRead &&
    e.distinctOpenSourcePublished &&
    e.namedInProductResidual &&
    !e.treatedAsGeneralSkip

def unsignedConforming (sig : CommitSignature) (exc : DualTreeException) : Bool :=
  match sig with
  | .operatorSigned => true
  | .unsigned => DualTreeException.applies exc

def noException : DualTreeException :=
  { grokBuildSourcePeopleCanRead := false
    distinctOpenSourcePublished := false
    namedInProductResidual := false
    treatedAsGeneralSkip := false }

def namedException : DualTreeException :=
  { grokBuildSourcePeopleCanRead := true
    distinctOpenSourcePublished := true
    namedInProductResidual := true
    treatedAsGeneralSkip := false }

def generalSkip : DualTreeException :=
  { grokBuildSourcePeopleCanRead := true
    distinctOpenSourcePublished := true
    namedInProductResidual := true
    treatedAsGeneralSkip := true }

def agentsMayCreateCommitObjects : Bool := false

def preCommitSubstitutesForOperatorSignature : Bool := false

def thisRepoClaimsUnsignedException : Bool := false

/-!
  This specifications repository: numbered markdown, meaning model, and
  product implementation stay separate.
-/

inductive StackLayer where
  | numberedMarkdown
  | meaningModel
  | productImplementation
  deriving DecidableEq, Repr, BEq

def specsRepoKeepsLayersSeparate : Bool := true

def specMarkdownIsContract : Bool := true

def meaningProofsAreSecondFormChecker : Bool := false

def lean4SurfacesLogicalInconsistency : Bool := true

/-!
  Systems Lean product path unifies the three layers in product trees.
  Bool and inductive, not a fake byte identity theorem.
-/

inductive ProductHome where
  | thisSpecificationsRepo
  | systemsLeanProductTree
  deriving DecidableEq, Repr, BEq

def ProductHome.unifiesSpecProofImpl : ProductHome → Bool
  | .thisSpecificationsRepo => false
  | .systemsLeanProductTree => true

def dumpTheoremsIntoNumberedMarkdown : Bool := false

/-!
  Byte identity of emit versus ELF (and other intermediates) is required
  for product conformance and is not claimed true. Do not encode emit = ELF
  as a proved identity.
-/

structure ByteIdentityRequirement where
  requiredForSystemsLeanSlakeProduct : Bool
  claimedTrue : Bool
  deriving DecidableEq, Repr, BEq

def byteIdentity : ByteIdentityRequirement :=
  { requiredForSystemsLeanSlakeProduct := true, claimedTrue := false }

def ByteIdentityRequirement.honest (b : ByteIdentityRequirement) : Bool :=
  b.requiredForSystemsLeanSlakeProduct && !b.claimedTrue

def emitEqualsElfProved : Bool := false

/-!
  SSSSS and beastdb reality check: required for that stack, not claimed done.
-/

structure RealityCheck where
  requiredForSssssBeastDbStack : Bool
  claimedDone : Bool
  deriving DecidableEq, Repr, BEq

def sssssBeastDbReality : RealityCheck :=
  { requiredForSssssBeastDbStack := true, claimedDone := false }

def RealityCheck.honest (r : RealityCheck) : Bool :=
  r.requiredForSssssBeastDbStack && !r.claimedDone

def rustElevationProcessSpecifiedHere : Bool := false

def conformingCiProductClaimed : Bool := false

/-- Clause 4.7 and Clause 6.3 item 2: claiming byte identity already true is a clash. -/
def mashByteIdentityClaimedTrue : Prop :=
  byteIdentity.claimedTrue = true

def mashByteIdentityClaimedTrueIsFalse : Prop :=
  mashByteIdentityClaimedTrue → False

/-- Clause 4.3 and Clause 6.2: treating the named exception as a general skip is a clash. -/
def mashUnsignedAsGeneralSkip : Prop :=
  DualTreeException.applies generalSkip = true

def mashUnsignedAsGeneralSkipIsFalse : Prop :=
  mashUnsignedAsGeneralSkip → False

/-- Clause 6.2 item 2: this repository claiming the unsigned exception is a clash. -/
def mashThisRepoClaimsUnsignedException : Prop :=
  thisRepoClaimsUnsignedException = true

def mashThisRepoClaimsUnsignedExceptionIsFalse : Prop :=
  mashThisRepoClaimsUnsignedException → False

/-- Clause 4.8 and Clause 6.3 item 3: claiming the reality check done is a clash. -/
def mashRealityCheckClaimedDone : Prop :=
  sssssBeastDbReality.claimedDone = true

def mashRealityCheckClaimedDoneIsFalse : Prop :=
  mashRealityCheckClaimedDone → False

/-- Public Domain Open Source Software (PDOSS) is specification 0009. Unlicense remains the license. -/
def pdossSpecNumber : Nat := 9

def unlicenseRemainsTheLicense : Bool := true

/-- Spec encodings declare what must be true. Proofs live in a separate module. -/
def specEncodingsStateWhatMustBeTrue : Bool := true

def proofsLiveInSeparateModule : Bool := true

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Four layers. Distinct constructors state the split. -/
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
  { moduleName := "CiSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "CiProofs"
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

/-- Stated: spec encoding is not the proof. -/
def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/--
  Product implementation in this repository: flake checks, Lake tests, and
  the GitHub Actions workflow. That layer is not a second markdown linter.
-/
inductive ImplementationKind where
  | flakeCheck
  | lakeTest
  | githubActionsWorkflow
  deriving DecidableEq, Repr, BEq

def ImplementationKind.isProductImplementation : ImplementationKind → Bool
  | .flakeCheck => true
  | .lakeTest => true
  | .githubActionsWorkflow => true

def ImplementationKind.isSecondMarkdownLinter : ImplementationKind → Bool
  | .flakeCheck => false
  | .lakeTest => false
  | .githubActionsWorkflow => false

def implementationIsThirdLayer : Bool :=
  Layer.leanSpecEncoding != Layer.productImplementation &&
    Layer.leanProof != Layer.productImplementation &&
    Layer.humanMarkdownContract != Layer.productImplementation

def implementationIsSecondMarkdownLinter : Bool := false

def namedGateIsNixFlakeCheck : Bool :=
  thisRepoNamedGate == "nix flake check \"path:$PWD\" --print-build-logs"

def writeShellApplicationCheckersAllowed : Bool := false

def writeShellApplicationIsNamedGate : Bool := false

def specCheckIsMarkdownForm : Bool := true

def specCheckIsMeaningSpecEncoding : Bool := false

/--
  Lean spec_check is numbered markdown form. Pure Nix whitespace is form
  across the tree. Dual coverage on numbered specifications is required.
  Neither authority is a meaning encoding.
-/
inductive FormAuthority where
  | leanSpecCheck
  | pureNixWhitespace
  deriving DecidableEq, Repr, BEq

def FormAuthority.isForm : FormAuthority → Bool
  | .leanSpecCheck => true
  | .pureNixWhitespace => true

def FormAuthority.isMeaningEncoding : FormAuthority → Bool
  | .leanSpecCheck => false
  | .pureNixWhitespace => false

def dualWhitespaceCoverageRequired : Bool := true

def pushOnRed : CommitAttempt := commitOnRed

def pushOnGreen : CommitAttempt := commitOnGreen

/-- This CI meaning model requires the Formal Vibefication science cycle. -/
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

end Ci
