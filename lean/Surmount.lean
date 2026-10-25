/-
  Composition model of the Surmount numbered specification stack.

  Human markdown is the contract people read. Lean spec encodings state
  what must be true. Lean proofs establish those encodings. Product
  trees implement. Those four are not the same artifact.

  Formal Vibefication encodings live in FormalVibeficationSpec.lean.
  Proofs of those encodings live in FormalVibeficationProofs.lean.
  This module composes stack identities. It is not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  Theorems cover exactly what they state. This file does not prove that
  Slake emit already matches ELF. It does not prove that beastdb, SSSSS,
  Slake, or Continuous Integration are ready for use.

  In product trees, Systems Lean (0002) and SSSSS (0004) unify spec, proof,
  and implementation so a project can be shown consistent, then Slake emits
  AOT C and LLVM IR. That unification is not a license to mix spec encodings
  with proofs in this specifications repository, and is not a license to mix
  theorems into numbered markdown here.

  Surmount Systems is numbered specification 0010
  (`0010_Surmount_Systems.md`). Formal Vibefication is numbered
  specification 0008 (`0008_Formal_Vibefication.md`). Public Domain
  Open Source Software (PDOSS) is numbered specification 0009
  (`0009_PDOSS.md`). Unlicense remains the license. The word catalog
  is owned by CATE as specification 0005 (`0005_CATE.md`). The file
  0009_VOCABULARY.md MUST NOT exist. Number 0011 is Surmount Systems
  Tech Tree. Number 0012 is Majestic Memex. Number 0013 is Lean
  Machine. Number 0014 is Anunnaki Encoding. Number 0015 is the
  session bus.
-/

import SpecRegistry
import SystemsLean
import SystemsLeanProofs
import BeastDb
import BeastDbProofs
import Sssss
import SssssProofs
import Cate
import CateProofs
import Rsi
import RsiProofs
import Vocabulary
import VocabularyCollisionProofs
import Ci
import CiProofs
import SpecCheck
import FormalVibeficationSpec
import FormalVibeficationProofs
import UnlicenseSpec
import UnlicenseProofs
import VocabularySpec
import VocabularyProofs
import SpecProofs
import TechTreeSpec
import TechTreeProofs
import MemexSpec
import MemexProofs
import LeanMachineSpec
import LeanMachineProofs
import AnunnakiSpec
import AnunnakiProofs
import SessionBusSpec
import SessionBusProofs
import «0010_Surmount_Systems»
import «0009_PDOSS»
import «0011_Surmount_Systems_Tech_Tree»
import «0012_Majestic_Memex»
import «0013_Lean_Machine»
import «0014_Anunnaki_Encoding»
import «0015_Session_Bus»
import «0002_Systems_Lean»
import «0007_CI»
import SystemsLeanSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Surmount

/-- Identity of numbered specification 0010. Cited by `0010_Surmount_Systems.md`. -/
def surmountSpecNumber : Nat := 10

def specFileName : String := "0010_Surmount_Systems.md"

/-- Identity of numbered specification 0008. -/
def formalVibeficationSpecNumber : Nat := 8

/-- Identity of numbered specification 0009. Unlicense remains the license. -/
def unlicenseSpecNumber : Nat := 9

def pdossSpecNumber : Nat := 9

/-- Identity of numbered specification 0011. -/
def techTreeSpecNumber : Nat := 11

/-- Identity of numbered specification 0012. -/
def memexSpecNumber : Nat := 12

/-- Identity of numbered specification 0013. -/
def leanMachineSpecNumber : Nat := 13

/-- Identity of numbered specification 0014. -/
def anunnakiSpecNumber : Nat := 14

/-- Identity of numbered specification 0015. -/
def sessionBusSpecNumber : Nat := 15

/-- Catalog ownership: CATE, specification 0005. Number 0009 is PDOSS. -/
def vocabularySpecNumber : Nat := 5

theorem surmount_is_0010 : surmountSpecNumber = 10 := rfl

theorem spec_file_is_0010_surmount_systems :
    specFileName = "0010_Surmount_Systems.md" :=
  rfl

theorem sibling_encoding_file_is_spec_0010 :
    «0010_Surmount_Systems».siblingEncodingFileName = "0010_Surmount_Systems.lean" :=
  rfl

theorem sibling_encoding_matches_markdown_name :
    «0010_Surmount_Systems».specFileName = specFileName :=
  rfl

theorem sibling_proofs_are_separate :
    «0010_Surmount_Systems».proofModuleName = "Proofs_0010" ∧
      «0010_Surmount_Systems».markedAsProof = false :=
  And.intro rfl rfl

theorem formal_vibefication_is_0008 : formalVibeficationSpecNumber = 8 :=
  rfl

theorem unlicense_is_0009 : unlicenseSpecNumber = 9 := rfl

theorem pdoss_is_0009 : pdossSpecNumber = 9 := rfl

theorem pdoss_equals_unlicense_number :
    pdossSpecNumber = unlicenseSpecNumber :=
  rfl

theorem unlicense_agrees_registry :
    unlicenseSpecNumber = SpecRegistry.unlicenseSpecNumber :=
  rfl

theorem unlicense_agrees_encoding :
    unlicenseSpecNumber = UnlicenseSpec.specNumber :=
  rfl

theorem unlicense_is_not_0010 : unlicenseSpecNumber ≠ 10 := by decide

theorem unlicense_is_not_0011 : unlicenseSpecNumber ≠ 11 := by decide

theorem tech_tree_is_0011 : techTreeSpecNumber = 11 := rfl

theorem tech_tree_agrees_registry :
    techTreeSpecNumber = SpecRegistry.techTreeSpecNumber :=
  rfl

theorem tech_tree_agrees_encoding :
    techTreeSpecNumber = TechTreeSpec.specNumber :=
  rfl

theorem sibling_encoding_file_is_spec_0011 :
    «0011_Surmount_Systems_Tech_Tree».siblingEncodingFileName =
      "0011_Surmount_Systems_Tech_Tree.lean" :=
  rfl

theorem memex_is_0012 : memexSpecNumber = 12 := rfl

theorem memex_agrees_registry :
    memexSpecNumber = SpecRegistry.memexSpecNumber :=
  rfl

theorem memex_agrees_encoding :
    memexSpecNumber = MemexSpec.specNumber :=
  rfl

theorem sibling_encoding_file_is_spec_0012 :
    «0012_Majestic_Memex».siblingEncodingFileName =
      "0012_Majestic_Memex.lean" :=
  rfl

theorem lean_machine_is_0013 : leanMachineSpecNumber = 13 := rfl

theorem lean_machine_agrees_registry :
    leanMachineSpecNumber = SpecRegistry.leanMachineSpecNumber :=
  rfl

theorem lean_machine_agrees_encoding :
    leanMachineSpecNumber = LeanMachineSpec.specNumber :=
  rfl

theorem sibling_encoding_file_is_spec_0013 :
    «0013_Lean_Machine».siblingEncodingFileName =
      "0013_Lean_Machine.lean" :=
  rfl

theorem anunnaki_is_0014 : anunnakiSpecNumber = 14 := rfl

theorem anunnaki_agrees_registry :
    anunnakiSpecNumber = SpecRegistry.anunnakiSpecNumber :=
  rfl

theorem anunnaki_agrees_encoding :
    anunnakiSpecNumber = AnunnakiSpec.specNumber :=
  rfl

theorem sibling_encoding_file_is_spec_0014 :
    «0014_Anunnaki_Encoding».siblingEncodingFileName =
      "0014_Anunnaki_Encoding.lean" :=
  rfl

theorem session_bus_is_0015 : sessionBusSpecNumber = 15 := rfl

theorem session_bus_agrees_registry :
    sessionBusSpecNumber = SpecRegistry.sessionBusSpecNumber :=
  rfl

theorem session_bus_agrees_encoding :
    sessionBusSpecNumber = SessionBusSpec.specNumber :=
  rfl

theorem sibling_encoding_file_is_spec_0015 :
    «0015_Session_Bus».siblingEncodingFileName =
      "0015_Session_Bus.lean" :=
  rfl

theorem session_bus_is_not_0014 : sessionBusSpecNumber ≠ 14 := by decide

theorem vocabulary_is_0005 : vocabularySpecNumber = 5 := rfl

theorem vocabulary_equals_cate :
    vocabularySpecNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem surmount_agrees_registry :
    surmountSpecNumber = SpecRegistry.surmountSystemsSpecNumber :=
  rfl

theorem formal_vibefication_agrees_registry :
    formalVibeficationSpecNumber = SpecRegistry.formalVibeficationSpecNumber :=
  rfl

theorem formal_vibefication_agrees_encoding :
    formalVibeficationSpecNumber = FormalVibeficationSpec.specNumber :=
  rfl

theorem vocabulary_agrees_registry :
    vocabularySpecNumber = SpecRegistry.vocabularySpecNumber :=
  rfl

theorem vocabulary_agrees_encoding :
    vocabularySpecNumber = VocabularySpec.specNumber :=
  rfl

theorem surmount_is_not_0007 : surmountSpecNumber ≠ 7 := by decide

theorem surmount_is_not_0008 : surmountSpecNumber ≠ 8 := by decide

theorem surmount_is_not_0009 : surmountSpecNumber ≠ 9 := by decide

/-!
  Formal Vibefication: human markdown, Lean spec encodings, Lean proofs,
  and product implementation are pairwise distinct.
-/

def specMarkdownIsContract : Bool :=
  FormalVibeficationSpec.humanMarkdownIsTheHumanContract

def companionLeanIsTheSpec : Bool :=
  FormalVibeficationSpec.leanProofIsTheSpec

theorem spec_and_proof_are_separate :
    FormalVibeficationSpec.Layer.leanSpecEncoding ≠
      FormalVibeficationSpec.Layer.leanProof := by
  decide

theorem markdown_is_not_the_lean_encoding :
    FormalVibeficationSpec.Layer.humanMarkdownContract ≠
      FormalVibeficationSpec.Layer.leanSpecEncoding := by
  decide

theorem markdown_is_not_the_lean_proof :
    FormalVibeficationSpec.Layer.humanMarkdownContract ≠
      FormalVibeficationSpec.Layer.leanProof := by
  decide

theorem spec_markdown_is_the_contract : specMarkdownIsContract = true := rfl

theorem companion_lean_is_not_the_spec : companionLeanIsTheSpec = false := rfl

theorem mash_spec_and_proof
    (h : FormalVibeficationSpec.Layer.leanSpecEncoding =
          FormalVibeficationSpec.Layer.leanProof) : False :=
  nomatch h

/-!
  This specifications repository keeps spec encodings, proofs, and
  markdown form separate. Systems Lean product trees unify spec, proof,
  and implementation. Both can be true because they name different homes.
  Treating them as the same layer is inconsistent.
-/

theorem thisRepoSeparates : FormalVibeficationSpec.thisRepoSeparates :=
  FormalVibeficationProofs.this_repo_separates

theorem thisRepoDoesNotUnifyProductLayers :
    Ci.ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl = false :=
  Ci.specs_repo_does_not_unify_layers

theorem productTreeUnifies : FormalVibeficationSpec.productTreeUnifies :=
  FormalVibeficationProofs.product_tree_unifies

theorem productTreeUnifiesCi :
    Ci.ProductHome.systemsLeanProductTree.unifiesSpecProofImpl = true :=
  Ci.systems_lean_product_unifies_layers

theorem thisRepoSeparates_and_productTreeUnifies :
    FormalVibeficationSpec.thisRepoSeparates ∧
      FormalVibeficationSpec.productTreeUnifies :=
  FormalVibeficationProofs.this_repo_separates_and_product_tree_unifies

/-- Treating the two homes as the same layer is inconsistent. -/
theorem mash_layers_inconsistent
    (h : Ci.ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl =
         Ci.ProductHome.systemsLeanProductTree.unifiesSpecProofImpl) : False := by
  have hSep := thisRepoDoesNotUnifyProductLayers
  have hUni := productTreeUnifiesCi
  rw [hSep, hUni] at h
  exact Bool.noConfusion h

/-- Product-tree unification does not license theorems in numbered markdown here. -/
theorem product_unification_does_not_license_markdown_theorems
    (h : Ci.dumpTheoremsIntoNumberedMarkdown = true) : False := by
  have hNo := Ci.no_dump_theorems_into_numbered_markdown
  rw [hNo] at h
  exact Bool.noConfusion h

/-!
  Don't Trust. Verify.: a theorem covers exactly its type. Byte identity
  required is not a proof that emit equals ELF.
-/

theorem theorems_cover_exactly_what_they_state :
    Ci.byteIdentity.requiredForSystemsLeanSlakeProduct = true ∧
      Ci.byteIdentity.claimedTrue = false ∧
      Ci.emitEqualsElfProved = false :=
  And.intro Ci.byte_identity_required
    (And.intro Ci.byte_identity_not_claimed_true Ci.emit_equals_elf_not_proved)

/-- Clause 3.10 body. Sibling markdown line 115. Array index 114. -/
abbrev ciClause310ByteIdentityLine : MdLine :=
  «0007_CI».encodedLines[114]!

/-- Clause 4.7 item 2. Sibling markdown line 177. Array index 176. -/
abbrev ciClause47Item2ByteIdentityLine : MdLine :=
  «0007_CI».encodedLines[176]!

/-- Clause 6.3 body. Sibling markdown line 481. Array index 480. -/
abbrev systemsClause63ByteIdentityLine : MdLine :=
  «0002_Systems_Lean».encodedLines[480]!

/--
  Clause 3.10 on one sibling line: exact byte match among emitted C,
  headers, archives, shared objects, LLVM IR, ELF, and other intermediates
  is required, is not claimed true, is pursued by delta reconciliation,
  and a FastC mark does not waive the match.
-/
def ciClause310ReadsByteIdentityNotClaimedTrue (s : String) : Bool :=
  SystemsLean.mentionsPhrase "Exact match of bytes (and of each file as a file) among emitted C, headers, archives, shared objects, LLVM IR, `ELF`, and other intermediates" s &&
    SystemsLean.mentionsPhrase "Byte identity is a requirement on such a product and is not claimed true" s &&
    SystemsLean.mentionsPhrase "This document does not claim that match already holds" s &&
    SystemsLean.mentionsPhrase "Byte identity of emit remains required for a conforming product and is not claimed true" s &&
    SystemsLean.mentionsPhrase "The match is pursued by delta reconciliation" s &&
    SystemsLean.mentionsPhrase "A `FastC` mark does not waive the match" s

/--
  Clause 4.7 item 2 on one sibling line: the requirement is not claimed
  true, this document does not claim that the match already holds, delta
  reconciliation pursues the match, and a FastC mark does not waive it.
-/
def ciClause47Item2ReadsByteIdentityNotClaimedTrue (s : String) : Bool :=
  SystemsLean.mentionsPhrase "That requirement is a requirement on the product and is not claimed true" s &&
    SystemsLean.mentionsPhrase "It is not a claim that the match already holds" s &&
    SystemsLean.mentionsPhrase "Byte identity of emit remains required for a conforming product and is not claimed true" s &&
    SystemsLean.mentionsPhrase "The match is pursued by delta reconciliation" s &&
    SystemsLean.mentionsPhrase "A `FastC` mark does not waive the match" s

/--
  Clause 6.3 on one sibling line: a FastC mark does not make byte identity
  of emit true, and a FastSafeC mark does not waive byte identity of emit.
-/
def systemsClause63ReadsByteIdentityNotYetTrue (s : String) : Bool :=
  SystemsLean.mentionsPhrase "does not make byte identity of emit true" s &&
    SystemsLean.mentionsPhrase "A `FastSafeC` mark does not waive byte identity of emit" s

/-- How the live byte identity sentences are read. `alreadyEqualsElf` is the claim those sentences deny. -/
inductive ByteIdentityLiveReading where
  | notClaimedTrue
  | alreadyEqualsElf
  deriving DecidableEq, Repr, BEq

/--
  One reading of Clause 3.10, Clause 4.7 item 2, and Clause 6.3.
  `notClaimedTrue` only when those sibling lines still carry those words.
  This reader does not return `alreadyEqualsElf`. Absent words yield `none`.
-/
def readLiveByteIdentity
    (clause310 clause47 clause63 : MdLine) : Option ByteIdentityLiveReading :=
  if clause310.number == 115 && clause47.number == 177 && clause63.number == 481 &&
      ciClause310ReadsByteIdentityNotClaimedTrue clause310.text &&
      ciClause47Item2ReadsByteIdentityNotClaimedTrue clause47.text &&
      systemsClause63ReadsByteIdentityNotYetTrue clause63.text then
    some .notClaimedTrue
  else
    none

/-- The claim that emit already equals ELF, read off the sibling lines. -/
def emitAlreadyEqualsElfAsProvedFact : Prop :=
  readLiveByteIdentity ciClause310ByteIdentityLine ciClause47Item2ByteIdentityLine
      systemsClause63ByteIdentityLine =
    some .alreadyEqualsElf

def emitAlreadyEqualsElfAsProvedFactIsFalse : Prop :=
  emitAlreadyEqualsElfAsProvedFact → False

/--
  Live Clause 3.10 and Clause 4.7 item 2 say byte identity among emitted C,
  headers, archives, shared objects, LLVM IR, ELF, and other intermediates
  is required, is not claimed true, is pursued by delta reconciliation, and
  a FastC mark does not waive the match. Live Clause 6.3 says a FastC mark
  does not make byte identity of emit true and a FastSafeC mark does not
  waive it. Treating emit already equals ELF as a proved fact yields False.
  The `native_decide` step reads those sibling lines. Removing the
  not claimed true wording, or the Clause 6.3 wording that a FastC mark
  does not make byte identity of emit true, makes the reading `none`, so
  this proof no longer closes.
-/
theorem claiming_emit_equals_elf_is_inconsistent :
    emitAlreadyEqualsElfAsProvedFactIsFalse := by
  intro h
  unfold emitAlreadyEqualsElfAsProvedFact at h
  have live :
      readLiveByteIdentity
        «0007_CI».encodedLines[114]!
        «0007_CI».encodedLines[176]!
        «0002_Systems_Lean».encodedLines[480]! =
        some .notClaimedTrue := by
    native_decide
  rw [live] at h
  injection h with eq
  injection eq

theorem claiming_beastdb_ready_is_inconsistent
    (h : SpecRegistry.beastdbProgress = .claimsReadyForUse) : False :=
  nomatch h

/--
  Composition of stack identities is not product readiness.
  `stackIntegrates` remaining true does not mean products are ready.
-/
def compositionIsProductReadiness : Bool := false

def mashCompositionAsProductReadiness : Prop :=
  compositionIsProductReadiness = true

def mashCompositionAsProductReadinessIsFalse : Prop :=
  mashCompositionAsProductReadiness → False

theorem composition_is_not_product_readiness :
    compositionIsProductReadiness = false :=
  rfl

theorem mash_composition_as_product_readiness_is_false :
    mashCompositionAsProductReadinessIsFalse := by
  intro h
  exact Bool.noConfusion h

/-- The Operator assigned number 0015 to the session bus. -/
def numberFifteenAssignedToSessionBus : Bool := true

theorem number_fifteen_assigned_to_session_bus :
    numberFifteenAssignedToSessionBus = true :=
  rfl

/--
  True because the sibling line encoding names `0015_Session_Bus.md`
  and that encoding's specification number is 15, and because
  `SpecRegistry.sessionBusFileName` names the same file. This is not
  a constant false while that file is in the tree.
-/
def numberFifteenPublishedFileExists : Bool :=
  «0015_Session_Bus».specFileName == "0015_Session_Bus.md" &&
    «0015_Session_Bus».specNumber == 15 &&
    SpecRegistry.sessionBusFileName == "0015_Session_Bus.md"

theorem number_fifteen_published_file_exists :
    numberFifteenPublishedFileExists = true :=
  rfl

/-- Claiming that published file is absent yields False. Not `rfl` of a false flag. -/
theorem claiming_published_session_bus_file_absent_yields_false
    (h : numberFifteenPublishedFileExists = false) : False := by
  have hPresent : numberFifteenPublishedFileExists = true := rfl
  rw [hPresent] at h
  exact Bool.noConfusion h

/-- Assignment of number 0015 and the published file both hold. -/
theorem number_fifteen_assignment_matches_published_file :
    numberFifteenAssignedToSessionBus = true ∧
      numberFifteenPublishedFileExists = true :=
  And.intro rfl rfl

theorem anunnaki_is_not_0015 : anunnakiSpecNumber ≠ 15 := by decide

theorem surmount_is_not_0015 : surmountSpecNumber ≠ 15 := by decide

theorem leftover_unstack_as_conforming_is_inconsistent
    (h : Cate.HyphenRepair.leftoverUnstack.conforming = true) : False := by
  have hNo := Cate.leftover_unstack_nonconforming
  rw [hNo] at h
  exact Bool.noConfusion h

/--
  Lean spec encodings are CATE on the leftover unstack floor.
  Sibling encodedLines and marked spec encoding comments use
  `Cate.leftoverUnstackPhrases` and the same scan as spec_check.
  Complete sentence quality is not fully mechanical.
-/
def leanSpecEncodingsAreCateOnLeftoverUnstackFloor : Bool :=
  SpecCheck.leftoverUnstackPhrases == Cate.leftoverUnstackPhrases &&
    Cate.leanSpecEncodingsUseLeftoverUnstackFloor &&
    !Cate.leftoverUnstackFloorIsCompleteEnglish &&
    !Cate.HyphenRepair.leftoverUnstack.conforming &&
    FormalVibeficationSpec.markedAsSpecEncoding &&
    !FormalVibeficationSpec.markedAsProof &&
    VocabularySpec.markedAsSpecEncoding &&
    !VocabularySpec.markedAsProof &&
    UnlicenseSpec.markedAsSpecEncoding &&
    !UnlicenseSpec.markedAsProof &&
    TechTreeSpec.markedAsSpecEncoding &&
    !TechTreeSpec.markedAsProof &&
    FormalVibeficationSpec.siblingLineEncodingsRequired

theorem lean_spec_encodings_are_cate_on_leftover_unstack_floor :
    leanSpecEncodingsAreCateOnLeftoverUnstackFloor = true :=
  rfl

theorem spec_check_leftover_unstack_phrases_are_cate :
    SpecCheck.leftoverUnstackPhrases = Cate.leftoverUnstackPhrases :=
  rfl

/-!
  Cross-model agreement. If two models assigned different numbers, the
  equality would not typecheck, and assuming the inequality is False.
-/

theorem cate_agrees_registry :
    Cate.specNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem rsi_agrees_registry :
    Rsi.specNumber = SpecRegistry.rsiSpecNumber :=
  rfl

theorem ci_agrees_registry :
    Ci.specNumber = SpecRegistry.ciSpecNumber :=
  rfl

theorem sssss_agrees_registry :
    Sssss.specNumber = SpecRegistry.ssssSpecNumber :=
  rfl

theorem beastdb_agrees_registry :
    BeastDb.specNumber = SpecRegistry.beastdbSpecNumber :=
  rfl

theorem systems_lean_agrees_registry :
    SystemsLean.systemsLeanSpecNumber = SpecRegistry.systemsLeanSpecNumber :=
  rfl

theorem surmount_spec_agrees_registry :
    surmountSpecNumber = SpecRegistry.surmountSystemsSpecNumber :=
  surmount_agrees_registry

theorem cate_number_disagreement_is_inconsistent
    (h : Cate.specNumber ≠ SpecRegistry.cateSpecNumber) : False :=
  h cate_agrees_registry

theorem surmount_number_disagreement_is_inconsistent
    (h : surmountSpecNumber ≠ SpecRegistry.surmountSystemsSpecNumber) : False :=
  h surmount_agrees_registry

theorem omitting_0008_is_inconsistent
    (h : SpecRegistry.allEntries.any (fun e => e.number == 8) = false) : False := by
  have hYes := SpecRegistry.number_8_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem omitting_0009_is_inconsistent
    (h : SpecRegistry.allEntries.any (fun e => e.number == 9) = false) : False := by
  have hYes := SpecRegistry.number_9_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem omitting_0011_is_inconsistent
    (h : SpecRegistry.allEntries.any (fun e => e.number == 11) = false) : False := by
  have hYes := SpecRegistry.number_11_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem omitting_0012_is_inconsistent
    (h : SpecRegistry.allEntries.any (fun e => e.number == 12) = false) : False := by
  have hYes := SpecRegistry.number_12_published
  rw [hYes] at h
  exact Bool.noConfusion h

theorem mash_0009_as_published_is_false :
    VocabularySpec.numberNinePublished = false :=
  VocabularyProofs.mash_0009_as_published_is_false

theorem mash_vocabulary_not_cate
    (h : vocabularySpecNumber ≠ SpecRegistry.cateSpecNumber) : False :=
  h vocabulary_equals_cate

theorem leftover_unstack_models_agree :
    Cate.HyphenRepair.leftoverUnstack.conforming =
      Rsi.LeftoverUnstackRepair.leftoverUnstack.conforming :=
  rfl

theorem sssp_models_agree :
    Rsi.ssspSpecified = SpecRegistry.ssspAssigned ∧
      Ci.ssspSpecified = SpecRegistry.ssspAssigned :=
  And.intro rfl rfl

theorem byte_identity_models_agree :
    Ci.byteIdentity.claimedTrue = SpecRegistry.byteIdentityClaimedTrue :=
  rfl

/-- The Systems Lean, CI, and registry byte identity flags are one claim. This is not emit equals ELF. -/
theorem systems_lean_byte_identity_equals_ci_and_registry :
    SystemsLean.byteIdentityOfEmitClaimedTrue = Ci.byteIdentity.claimedTrue ∧
      SystemsLean.byteIdentityOfEmitClaimedTrue =
        SpecRegistry.byteIdentityClaimedTrue :=
  And.intro rfl rfl

/-- Back linking: the form checker requires proofofkeags.com when Keagan is named. -/
def keaganBacklinkRuleExists : Bool := true

def keaganCanonicalHost : String := "proofofkeags.com"

theorem keagan_backlink_rule_exists : keaganBacklinkRuleExists = true := rfl

theorem keagan_canonical_host : keaganCanonicalHost = "proofofkeags.com" := rfl

theorem vocab_aspell_fixture_well_formed :
    VocabularySpec.wellFormed VocabularySpec.fixtureEntries = true :=
  VocabularyProofs.fixture_wellFormed

/-- Companion meaning models follow Formal Vibefication: encodings without proofs. -/
def companionMeaningModelsSplit : Bool :=
  Cate.liveContainsSpecEncodings &&
    !Cate.liveContainsProofsOfThoseEncodings &&
    Cate.markedAsSpecEncoding &&
    !Cate.markedAsProof &&
    Rsi.liveContainsSpecEncodings &&
    !Rsi.liveContainsProofsOfThoseEncodings &&
    Rsi.markedAsSpecEncoding &&
    !Rsi.markedAsProof &&
    Ci.liveContainsSpecEncodings &&
    !Ci.liveContainsProofsOfThoseEncodings &&
    Ci.markedAsSpecEncoding &&
    !Ci.markedAsProof &&
    BeastDb.liveContainsSpecEncodings &&
    !BeastDb.liveContainsProofsOfThoseEncodings &&
    BeastDb.markedAsSpecEncoding &&
    !BeastDb.markedAsProof &&
    Sssss.liveContainsSpecEncodings &&
    !Sssss.liveContainsProofsOfThoseEncodings &&
    Sssss.markedAsSpecEncoding &&
    !Sssss.markedAsProof &&
    SystemsLean.liveContainsSpecEncodings &&
    !SystemsLean.liveContainsProofsOfThoseEncodings &&
    SystemsLean.markedAsSpecEncoding &&
    !SystemsLean.markedAsProof &&
    Vocabulary.liveContainsSpecEncodings &&
    !Vocabulary.liveContainsProofsOfThoseEncodings &&
    Vocabulary.markedAsSpecEncoding &&
    !Vocabulary.markedAsProof &&
    VocabularySpec.liveContainsSpecEncodings &&
    !VocabularySpec.liveContainsProofsOfThoseEncodings &&
    VocabularySpec.markedAsSpecEncoding &&
    !VocabularySpec.markedAsProof &&
    FormalVibeficationSpec.liveContainsSpecEncodings &&
    !FormalVibeficationSpec.liveContainsProofsOfThoseEncodings &&
    FormalVibeficationSpec.markedAsSpecEncoding &&
    !FormalVibeficationSpec.markedAsProof &&
    UnlicenseSpec.liveContainsSpecEncodings &&
    !UnlicenseSpec.liveContainsProofsOfThoseEncodings &&
    UnlicenseSpec.markedAsSpecEncoding &&
    !UnlicenseSpec.markedAsProof &&
    TechTreeSpec.liveContainsSpecEncodings &&
    !TechTreeSpec.liveContainsProofsOfThoseEncodings &&
    TechTreeSpec.markedAsSpecEncoding &&
    !TechTreeSpec.markedAsProof &&
    MemexSpec.liveContainsSpecEncodings &&
    !MemexSpec.liveContainsProofsOfThoseEncodings &&
    MemexSpec.markedAsSpecEncoding &&
    !MemexSpec.markedAsProof &&
    LeanMachineSpec.liveContainsSpecEncodings &&
    !LeanMachineSpec.liveContainsProofsOfThoseEncodings &&
    LeanMachineSpec.markedAsSpecEncoding &&
    !LeanMachineSpec.markedAsProof &&
    AnunnakiSpec.liveContainsSpecEncodings &&
    !AnunnakiSpec.liveContainsProofsOfThoseEncodings &&
    AnunnakiSpec.markedAsSpecEncoding &&
    !AnunnakiSpec.markedAsProof &&
    SessionBusSpec.liveContainsSpecEncodings &&
    !SessionBusSpec.liveContainsProofsOfThoseEncodings &&
    SessionBusSpec.markedAsSpecEncoding &&
    !SessionBusSpec.markedAsProof &&
    !FormalVibeficationSpec.conformingThisRepo
      FormalVibeficationSpec.mashedFixture

theorem companion_meaning_models_split :
    companionMeaningModelsSplit = true :=
  rfl

theorem lean_machine_companion_split :
    LeanMachineSpec.liveContainsSpecEncodings = true ∧
      LeanMachineSpec.liveContainsProofsOfThoseEncodings = false ∧
      LeanMachineSpec.markedAsSpecEncoding = true ∧
      LeanMachineSpec.markedAsProof = false :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem anunnaki_companion_split :
    AnunnakiSpec.liveContainsSpecEncodings = true ∧
      AnunnakiSpec.liveContainsProofsOfThoseEncodings = false ∧
      AnunnakiSpec.markedAsSpecEncoding = true ∧
      AnunnakiSpec.markedAsProof = false :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem session_bus_companion_split :
    SessionBusSpec.liveContainsSpecEncodings = true ∧
      SessionBusSpec.liveContainsProofsOfThoseEncodings = false ∧
      SessionBusSpec.markedAsSpecEncoding = true ∧
      SessionBusSpec.markedAsProof = false :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

/--
  Formal Vibefication science cycle composition as Bool encodings.
  Hypothesis, model, theory, proof, tests, and corollary experiments
  in that order. A tests only cycle is not the required set.
-/
def scienceCycleComposesInStack : Bool :=
  FormalVibeficationSpec.ScienceCycle.toList
      FormalVibeficationSpec.composedCycle ==
    FormalVibeficationSpec.requiredScienceSteps &&
    FormalVibeficationSpec.conformingScience
      (FormalVibeficationSpec.ScienceCycle.toEffort
        FormalVibeficationSpec.composedCycle) &&
    !FormalVibeficationSpec.ScienceCycle.containsAllRequired
      FormalVibeficationSpec.testsOnlyCycle

theorem science_cycle_composes_in_stack :
    FormalVibeficationSpec.scienceCycleComposes :=
  FormalVibeficationProofs.science_cycle_composes

theorem science_cycle_composes_in_stack_bool :
    scienceCycleComposesInStack = true :=
  rfl

/--
  Lean Machine must attempt deterministic answers. Same question plus
  same notes must not yield two different answers.
-/
def leanMachineDeterministicAnswersInStack : Bool :=
  LeanMachineSpec.mustAttemptDeterministicAnswers &&
    LeanMachineSpec.timestampedNoteRequiredWhenWrongOrImprecise &&
    !LeanMachineSpec.AnswerAttempt.conformingPair
      LeanMachineSpec.mashNondeterministicA
      LeanMachineSpec.mashNondeterministicB

theorem lean_machine_deterministic_answers_in_stack :
    leanMachineDeterministicAnswersInStack = true :=
  rfl

/-- A note that names the question and the wrong answer still needs a clock time. -/
def timestampedNoteWithoutClockDoesNotConform : Bool :=
  !LeanMachineSpec.TimestampedNote.conforming
    LeanMachineSpec.noteWithoutClockTime

theorem timestamped_note_without_clock_does_not_conform :
    timestampedNoteWithoutClockDoesNotConform = true :=
  rfl

theorem timestamped_note_with_clock_conforms :
    LeanMachineSpec.TimestampedNote.conforming
      LeanMachineSpec.noteWithClockTime = true :=
  rfl

/-- Decidable conjunction of stack identities. Drifting any conjunct breaks `rfl`. -/
def stackIntegrates : Bool :=
  !SpecRegistry.hasDupNumbers &&
    !SpecRegistry.hasDupFilenames &&
    SpecRegistry.cateSpecNumber == 5 &&
    SpecRegistry.rsiSpecNumber == 6 &&
    SpecRegistry.ciSpecNumber == 7 &&
    SpecRegistry.formalVibeficationSpecNumber == 8 &&
    SpecRegistry.vocabularySpecNumber == 5 &&
    SpecRegistry.vocabularySpecNumber == SpecRegistry.cateSpecNumber &&
    SpecRegistry.ssssSpecNumber == 4 &&
    SpecRegistry.beastdbSpecNumber == 3 &&
    SpecRegistry.systemsLeanSpecNumber == 2 &&
    !SystemsLean.safeCIsOwnPublishedSpecNumber &&
    SystemsLean.safeCCarriedBySystemsLean &&
    SpecRegistry.surmountSystemsSpecNumber == 10 &&
    SpecRegistry.unlicenseSpecNumber == 9 &&
    SpecRegistry.techTreeSpecNumber == 11 &&
    SpecRegistry.memexSpecNumber == 12 &&
    surmountSpecNumber == SpecRegistry.surmountSystemsSpecNumber &&
    formalVibeficationSpecNumber == SpecRegistry.formalVibeficationSpecNumber &&
    unlicenseSpecNumber == SpecRegistry.unlicenseSpecNumber &&
    techTreeSpecNumber == SpecRegistry.techTreeSpecNumber &&
    vocabularySpecNumber == SpecRegistry.vocabularySpecNumber &&
    SpecRegistry.allEntries.any (fun e => e.number == 8) &&
    SpecRegistry.allEntries.any (fun e => e.number == 9) &&
    SpecRegistry.allEntries.any (fun e => e.number == 11) &&
    SpecRegistry.publishedEntries.any (fun e => e.number == 12) &&
    SpecRegistry.publishedEntries.any (fun e => e.number == 14) &&
    SpecRegistry.publishedEntries.any (fun e => e.number == 15) &&
    memexSpecNumber == SpecRegistry.memexSpecNumber &&
    MemexSpec.specNumber == SpecRegistry.memexSpecNumber &&
    SpecRegistry.anunnakiSpecNumber == 14 &&
    anunnakiSpecNumber == SpecRegistry.anunnakiSpecNumber &&
    AnunnakiSpec.specNumber == SpecRegistry.anunnakiSpecNumber &&
    SpecRegistry.sessionBusSpecNumber == 15 &&
    sessionBusSpecNumber == SpecRegistry.sessionBusSpecNumber &&
    SessionBusSpec.specNumber == SpecRegistry.sessionBusSpecNumber &&
    SessionBusSpec.sessionBusSpecNumber == SpecRegistry.sessionBusSpecNumber &&
    !VocabularySpec.numberNinePublished &&
    Cate.specNumber == SpecRegistry.cateSpecNumber &&
    Cate.ownsVocabularyCatalog &&
    !Cate.numberNineWithdrawn &&
    Rsi.specNumber == SpecRegistry.rsiSpecNumber &&
    Ci.specNumber == SpecRegistry.ciSpecNumber &&
    Sssss.specNumber == SpecRegistry.ssssSpecNumber &&
    BeastDb.specNumber == SpecRegistry.beastdbSpecNumber &&
    SystemsLean.systemsLeanSpecNumber == SpecRegistry.systemsLeanSpecNumber &&
    FormalVibeficationSpec.specNumber == SpecRegistry.formalVibeficationSpecNumber &&
    UnlicenseSpec.specNumber == SpecRegistry.unlicenseSpecNumber &&
    TechTreeSpec.specNumber == SpecRegistry.techTreeSpecNumber &&
    !TechTreeSpec.producerShipped &&
    TechTreeSpec.lakeWriterExists &&
    TechTreeSpec.compactSizeBtcVerifiedIsThisRepoRefPin &&
    TechTreeSpec.majesticMemexPublished &&
    TechTreeSpec.encodedGraphMustBeDag &&
    UnlicenseSpec.remainingCopyright UnlicenseSpec.ossWithoutDedication &&
    !UnlicenseSpec.remainingCopyright UnlicenseSpec.unlicenseDedication &&
    UnlicenseSpec.ideasNonScarce &&
    UnlicenseSpec.ideasNotRivalrous &&
    !UnlicenseSpec.conformingThisRepo UnlicenseSpec.mashedFixture &&
    VocabularySpec.specNumber == SpecRegistry.vocabularySpecNumber &&
    !SpecRegistry.fargoAssigned &&
    !SpecRegistry.ssspAssigned &&
    !Cate.HyphenRepair.leftoverUnstack.conforming &&
    leanSpecEncodingsAreCateOnLeftoverUnstackFloor &&
    Ci.byteIdentity.requiredForSystemsLeanSlakeProduct &&
    !Ci.byteIdentity.claimedTrue &&
    SpecRegistry.beastdbProgress == .ongoingNotReadyForUse &&
    SpecRegistry.sssssProgress == .ongoingNotReadyForUse &&
    SpecRegistry.slakeProgress == .ongoingNotReadyForUse &&
    SpecRegistry.ciProductProgress == .ongoingNotReadyForUse &&
    SpecRegistry.beastdbProgress.honestWhenWorkExists &&
    !Ci.ProductHome.thisSpecificationsRepo.unifiesSpecProofImpl &&
    Ci.ProductHome.systemsLeanProductTree.unifiesSpecProofImpl &&
    keaganBacklinkRuleExists &&
    VocabularySpec.wellFormed VocabularySpec.fixtureEntries &&
    specMarkdownIsContract &&
    !companionLeanIsTheSpec &&
    !FormalVibeficationSpec.humanMarkdownSubstitutesForLeanSpecEncoding &&
    FormalVibeficationSpec.specCheckIsMarkdownForm &&
    !FormalVibeficationSpec.specCheckIsMeaningSpecEncoding &&
    FormalVibeficationSpec.conformingThisRepo
      FormalVibeficationSpec.specEncodingFixture &&
    FormalVibeficationSpec.conformingThisRepo
      FormalVibeficationSpec.proofFixture &&
    !FormalVibeficationSpec.conformingThisRepo
      FormalVibeficationSpec.mashedFixture &&
    companionMeaningModelsSplit &&
    FormalVibeficationSpec.siblingLineEncodingsRequired &&
    FormalVibeficationSpec.siblingProofsAreSeparateModules &&
    !FormalVibeficationSpec.mashedSiblingEncodingAndProofsConform &&
    SpecProofs.encodingsNotMashed &&
    «0010_Surmount_Systems».specFileName == specFileName &&
    «0010_Surmount_Systems».siblingEncodingFileName == "0010_Surmount_Systems.lean" &&
    «0009_PDOSS».specFileName == "0009_PDOSS.md" &&
    «0009_PDOSS».siblingEncodingFileName == "0009_PDOSS.lean" &&
    !«0009_PDOSS».markedAsProof &&
    UnlicenseSpec.meetsPdoss .unlicense &&
    !UnlicenseSpec.meetsPdoss .mitGrant &&
    !UnlicenseSpec.meetsPdoss .apacheTwo &&
    «0011_Surmount_Systems_Tech_Tree».specFileName ==
      "0011_Surmount_Systems_Tech_Tree.md" &&
    «0011_Surmount_Systems_Tech_Tree».siblingEncodingFileName ==
      "0011_Surmount_Systems_Tech_Tree.lean" &&
    !«0011_Surmount_Systems_Tech_Tree».markedAsProof &&
    «0012_Majestic_Memex».specFileName ==
      "0012_Majestic_Memex.md" &&
    «0012_Majestic_Memex».siblingEncodingFileName ==
      "0012_Majestic_Memex.lean" &&
    !«0012_Majestic_Memex».markedAsProof &&
    MemexSpec.specNumber == 12 &&
    !MemexSpec.productReadyForUse &&
    «0013_Lean_Machine».specFileName ==
      "0013_Lean_Machine.md" &&
    «0013_Lean_Machine».siblingEncodingFileName ==
      "0013_Lean_Machine.lean" &&
    !«0013_Lean_Machine».markedAsProof &&
    LeanMachineSpec.specNumber == 13 &&
    SpecRegistry.leanMachineSpecNumber == 13 &&
    leanMachineSpecNumber == SpecRegistry.leanMachineSpecNumber &&
    LeanMachineSpec.leanMachineAssigned &&
    !LeanMachineSpec.worshipRequiredForConformance &&
    !LeanMachineSpec.conformingProductExists &&
    LeanMachineSpec.liveContainsSpecEncodings &&
    !LeanMachineSpec.liveContainsProofsOfThoseEncodings &&
    LeanMachineSpec.markedAsSpecEncoding &&
    !LeanMachineSpec.markedAsProof &&
    scienceCycleComposesInStack &&
    FormalVibeficationSpec.ScienceCycle.toList
      FormalVibeficationSpec.composedCycle ==
      FormalVibeficationSpec.requiredScienceSteps &&
    FormalVibeficationSpec.conformingScience
      (FormalVibeficationSpec.ScienceCycle.toEffort
        FormalVibeficationSpec.composedCycle) &&
    !FormalVibeficationSpec.ScienceCycle.containsAllRequired
      FormalVibeficationSpec.testsOnlyCycle &&
    LeanMachineSpec.mustAttemptDeterministicAnswers &&
    LeanMachineSpec.timestampedNoteRequiredWhenWrongOrImprecise &&
    leanMachineDeterministicAnswersInStack &&
    LeanMachineSpec.TimestampedNote.conforming
      LeanMachineSpec.noteWithClockTime &&
    !LeanMachineSpec.TimestampedNote.conforming
      LeanMachineSpec.noteWithoutClockTime &&
    timestampedNoteWithoutClockDoesNotConform &&
    !LeanMachineSpec.AnswerAttempt.conformingPair
      LeanMachineSpec.mashNondeterministicA
      LeanMachineSpec.mashNondeterministicB &&
    LeanMachineSpec.distributedSelfImprovementIsDesignRequirement &&
    !LeanMachineSpec.runningDistributedMachineClaimed &&
    «0014_Anunnaki_Encoding».specFileName ==
      "0014_Anunnaki_Encoding.md" &&
    «0014_Anunnaki_Encoding».siblingEncodingFileName ==
      "0014_Anunnaki_Encoding.lean" &&
    !«0014_Anunnaki_Encoding».markedAsProof &&
    AnunnakiSpec.specNumber == 14 &&
    AnunnakiSpec.enkiIsIndex &&
    AnunnakiSpec.anunnakiIsBitstream &&
    !AnunnakiSpec.enkiAndAnunnakiAreOneObject &&
    !AnunnakiSpec.enkiHasNumberedSpecification &&
    !AnunnakiSpec.conformingEncoderClaimed &&
    !AnunnakiSpec.replacesCate &&
    !AnunnakiSpec.replacesSssss &&
    !AnunnakiSpec.replacesMemex &&
    AnunnakiSpec.liveContainsSpecEncodings &&
    !AnunnakiSpec.liveContainsProofsOfThoseEncodings &&
    AnunnakiSpec.markedAsSpecEncoding &&
    !AnunnakiSpec.markedAsProof &&
    «0015_Session_Bus».specFileName ==
      "0015_Session_Bus.md" &&
    «0015_Session_Bus».siblingEncodingFileName ==
      "0015_Session_Bus.lean" &&
    !«0015_Session_Bus».markedAsProof &&
    SessionBusSpec.specNumber == 15 &&
    !SessionBusSpec.approveDefault &&
    !SessionBusSpec.denyDefault &&
    SessionBusSpec.approveOffByDefault &&
    SessionBusSpec.denyOffByDefault &&
    !SessionBusSpec.networkListenerPresent &&
    SessionBusSpec.socketIsSameUidOnly &&
    SessionBusSpec.transcriptReturnsDeltasOnly &&
    !SessionBusSpec.busKillsSessions &&
    !SessionBusSpec.conformingSessionBusProgramClaimed &&
    !SessionBusSpec.productsClaimedReadyForUse &&
    !SessionBusSpec.productsClaimedNeverStarted &&
    SessionBusSpec.liveContainsSpecEncodings &&
    !SessionBusSpec.liveContainsProofsOfThoseEncodings &&
    SessionBusSpec.markedAsSpecEncoding &&
    !SessionBusSpec.markedAsProof &&
    SessionBusSpec.requiredConformanceHolds &&
    !Ci.dumpTheoremsIntoNumberedMarkdown &&
    Sssss.leanMachineHasNumberedSpec &&
    Sssss.canonicalIntegration.conformingIntegration &&
    !Sssss.mashNeuralWhileSymbolicCan.conformingIntegration &&
    !Sssss.translationOnlyNoHarness.conformingIntegration &&
    !Sssss.mashClaimedNeuralGatedNotSystemsLean.conformingIntegration &&
    Sssss.canonicalProduct.conforms &&
    !Sssss.productClaimedNotSystemsLean.conforms &&
    Sssss.productCanonicalIntegration.conforms &&
    !compositionIsProductReadiness &&
    numberFifteenAssignedToSessionBus &&
    numberFifteenPublishedFileExists &&
    !(anunnakiSpecNumber == 15) &&
    !(surmountSpecNumber == 15)

theorem surmount_integrates : stackIntegrates = true := rfl

end Surmount
