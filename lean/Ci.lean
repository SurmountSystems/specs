/-
  Companion Lean model of selected claims from 0007_CI.md
  (Continuous Integration and stack consistency).

  This module is not the specification. The numbered markdown is the contract
  that humans read. Spec encodings state what must be true. Proofs of those
  encodings belong in a separate module under Formal Vibefication
  (`0008_Formal_Vibefication.md`); this file still mixes both and that mash
  is remaining work. spec_check remains the form checker (ASCII, tabs,
  RFC 2119, spelling, leftover unstack, residual heading). These declarations
  encode meaning so an inconsistent model is a type error or a failing test.

  CI is numbered specification 0007. It is not specification 0005 (CATE) and
  it is not specification 0006 (RSI). fargo is not specification 0007.
-/

import SpecRegistry

namespace Ci

def specNumber : Nat := 7

def specFileName : String := "0007_CI.md"

def productName : String := "CI"

theorem spec_is_0007 : specNumber = 7 := rfl

theorem spec_file_is_0007_ci : specFileName = "0007_CI.md" := rfl

theorem product_name_is_ci : productName = "CI" := rfl

theorem ci_is_not_0005 : specNumber ≠ SpecRegistry.cateSpecNumber := by
  decide

theorem ci_is_not_0006 : specNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem cate_is_0005 : SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem rsi_is_0006 : SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem fargo_not_assigned : SpecRegistry.fargoAssigned = false :=
  SpecRegistry.fargo_not_assigned

theorem fargo_is_not_spec_0007 :
    SpecRegistry.fargoAssigned = false ∧ specNumber = 7 :=
  And.intro fargo_not_assigned spec_is_0007

def fargoSpecifiedHere : Bool := false

theorem fargo_unspecified_here : fargoSpecifiedHere = false := rfl

/-- Surmount Systems System Prompt is named, not specified. -/
def ssspSpecified : Bool := false

theorem sssp_not_specified : ssspSpecified = false := rfl

def thisRepoNamedGate : String :=
  "nix flake check \"path:$PWD\" --print-build-logs"

theorem this_repo_named_gate :
    thisRepoNamedGate =
      "nix flake check \"path:$PWD\" --print-build-logs" :=
  rfl

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

theorem commit_on_red_does_not_conform :
    commitOnRed.conforming = false :=
  rfl

theorem commit_on_green_conforms :
    commitOnGreen.conforming = true :=
  rfl

theorem residual_does_not_replace_red_gate :
    residualInsteadOfGreen.conforming = false :=
  rfl

theorem residual_named_as_substitute_is_red_replace :
    residualReplacesRedGate residualInsteadOfGreen = true :=
  rfl

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

theorem unsigned_without_exception_does_not_conform :
    unsignedConforming .unsigned noException = false :=
  rfl

theorem operator_signed_conforms :
    unsignedConforming .operatorSigned noException = true :=
  rfl

theorem named_exception_allows_unsigned :
    unsignedConforming .unsigned namedException = true :=
  rfl

theorem general_skip_does_not_apply :
    DualTreeException.applies generalSkip = false :=
  rfl

theorem unsigned_as_general_skip_does_not_conform :
    unsignedConforming .unsigned generalSkip = false :=
  rfl

def agentsMayCreateCommitObjects : Bool := false

theorem agents_must_not_create_commit_objects :
    agentsMayCreateCommitObjects = false :=
  rfl

def preCommitSubstitutesForOperatorSignature : Bool := false

theorem pre_commit_is_not_operator_signature :
    preCommitSubstitutesForOperatorSignature = false :=
  rfl

def thisRepoClaimsUnsignedException : Bool := false

theorem this_repo_does_not_claim_unsigned_exception :
    thisRepoClaimsUnsignedException = false :=
  rfl

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

theorem specs_repo_layers_are_separate :
    specsRepoKeepsLayersSeparate = true :=
  rfl

theorem numbered_markdown_neq_meaning_model :
    StackLayer.numberedMarkdown ≠ StackLayer.meaningModel := by
  decide

theorem numbered_markdown_neq_product :
    StackLayer.numberedMarkdown ≠ StackLayer.productImplementation := by
  decide

theorem meaning_model_neq_product :
    StackLayer.meaningModel ≠ StackLayer.productImplementation := by
  decide

def specMarkdownIsContract : Bool := true

def meaningProofsAreSecondFormChecker : Bool := false

theorem spec_markdown_is_the_contract :
    specMarkdownIsContract = true :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

def lean4SurfacesLogicalInconsistency : Bool := true

theorem lean4_surfaces_inconsistency :
    lean4SurfacesLogicalInconsistency = true :=
  rfl

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

theorem specs_repo_does_not_unify_layers :
    ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl = false :=
  rfl

theorem systems_lean_product_unifies_layers :
    ProductHome.systemsLeanProductTree.unifiesSpecProofImpl = true :=
  rfl

def dumpTheoremsIntoNumberedMarkdown : Bool := false

theorem no_dump_theorems_into_numbered_markdown :
    dumpTheoremsIntoNumberedMarkdown = false :=
  rfl

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

theorem byte_identity_required :
    byteIdentity.requiredForSystemsLeanSlakeProduct = true :=
  rfl

theorem byte_identity_not_claimed_true :
    byteIdentity.claimedTrue = false :=
  rfl

theorem byte_identity_honest :
    byteIdentity.honest = true :=
  rfl

theorem emit_equals_elf_not_proved :
    emitEqualsElfProved = false :=
  rfl

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

theorem reality_check_required :
    sssssBeastDbReality.requiredForSssssBeastDbStack = true :=
  rfl

theorem reality_check_not_claimed_done :
    sssssBeastDbReality.claimedDone = false :=
  rfl

theorem reality_check_honest :
    sssssBeastDbReality.honest = true :=
  rfl

def rustElevationProcessSpecifiedHere : Bool := false

theorem rust_fargo_process_unspecified :
    rustElevationProcessSpecifiedHere = false :=
  rfl

def conformingCiProductClaimed : Bool := false

theorem no_invented_ci_product :
    conformingCiProductClaimed = false :=
  rfl

end Ci
