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
