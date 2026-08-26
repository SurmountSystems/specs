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
  specification 0008 (`0008_Formal_Vibefication.md`). The word catalog
  is owned by CATE as specification 0005 (`0005_CATE.md`). Number 0009
  is withdrawn.
-/

import SpecRegistry
import SystemsLean
import BeastDb
import Sssss
import Cate
import Rsi
import Vocabulary
import Ci
import SpecCheck
import FormalVibeficationSpec
import FormalVibeficationProofs
import VocabularySpec
import VocabularyProofs
import SpecProofs
import Spec_0010

namespace Surmount

/-- Identity of numbered specification 0010. Cited by `0010_Surmount_Systems.md`. -/
def surmountSpecNumber : Nat := 10

def specFileName : String := "0010_Surmount_Systems.md"

/-- Identity of numbered specification 0008. -/
def formalVibeficationSpecNumber : Nat := 8

/-- Catalog ownership: CATE, specification 0005. Number 0009 is withdrawn. -/
def vocabularySpecNumber : Nat := 5

theorem surmount_is_0010 : surmountSpecNumber = 10 := rfl

theorem spec_file_is_0010_surmount_systems :
    specFileName = "0010_Surmount_Systems.md" :=
  rfl

theorem sibling_encoding_file_is_spec_0010 :
    Spec_0010.siblingEncodingFileName = "Spec_0010.lean" :=
  rfl

theorem sibling_encoding_matches_markdown_name :
    Spec_0010.specFileName = specFileName :=
  rfl

theorem sibling_proofs_are_separate :
    Spec_0010.proofModuleName = "Proofs_0010" ∧
      Spec_0010.markedAsProof = false :=
  And.intro rfl rfl

theorem formal_vibefication_is_0008 : formalVibeficationSpecNumber = 8 :=
  rfl

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

theorem claiming_emit_equals_elf_is_inconsistent
    (h : Ci.emitEqualsElfProved = true) : False := by
  have hNo := Ci.emit_equals_elf_not_proved
  rw [hNo] at h
  exact Bool.noConfusion h

theorem claiming_beastdb_ready_is_inconsistent
    (h : SpecRegistry.beastdbProgress = .claimsReadyForUse) : False :=
  nomatch h

theorem leftover_unstack_as_conforming_is_inconsistent
    (h : Cate.HyphenRepair.leftoverUnstack.conforming = true) : False := by
  have hNo := Cate.leftover_unstack_nonconforming
  rw [hNo] at h
  exact Bool.noConfusion h

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

theorem claiming_0009_published_is_inconsistent
    (h : SpecRegistry.allEntries.any (fun e => e.number == 9) = true) : False := by
  have hNo := SpecRegistry.number_9_not_published
  rw [hNo] at h
  exact Bool.noConfusion h

theorem mash_0009_as_published_is_false :
    VocabularySpec.numberNinePublished = false :=
  VocabularySpec.mash_0009_as_published_is_false

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

/-- Back linking: the form checker requires proofofkeags.com when Keagan is named. -/
def keaganBacklinkRuleExists : Bool := true

def keaganCanonicalHost : String := "proofofkeags.com"

theorem keagan_backlink_rule_exists : keaganBacklinkRuleExists = true := rfl

theorem keagan_canonical_host : keaganCanonicalHost = "proofofkeags.com" := rfl

theorem vocab_aspell_fixture_well_formed :
    VocabularySpec.wellFormed VocabularySpec.fixtureEntries = true :=
  VocabularyProofs.fixture_wellFormed

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
    SpecRegistry.surmountSystemsSpecNumber == 10 &&
    surmountSpecNumber == SpecRegistry.surmountSystemsSpecNumber &&
    formalVibeficationSpecNumber == SpecRegistry.formalVibeficationSpecNumber &&
    vocabularySpecNumber == SpecRegistry.vocabularySpecNumber &&
    SpecRegistry.allEntries.any (fun e => e.number == 8) &&
    !SpecRegistry.allEntries.any (fun e => e.number == 9) &&
    !VocabularySpec.numberNinePublished &&
    Cate.specNumber == SpecRegistry.cateSpecNumber &&
    Cate.ownsVocabularyCatalog &&
    Cate.numberNineWithdrawn &&
    Rsi.specNumber == SpecRegistry.rsiSpecNumber &&
    Ci.specNumber == SpecRegistry.ciSpecNumber &&
    Sssss.specNumber == SpecRegistry.ssssSpecNumber &&
    BeastDb.specNumber == SpecRegistry.beastdbSpecNumber &&
    SystemsLean.systemsLeanSpecNumber == SpecRegistry.systemsLeanSpecNumber &&
    FormalVibeficationSpec.specNumber == SpecRegistry.formalVibeficationSpecNumber &&
    VocabularySpec.specNumber == SpecRegistry.vocabularySpecNumber &&
    !SpecRegistry.fargoAssigned &&
    !SpecRegistry.ssspAssigned &&
    !Cate.HyphenRepair.leftoverUnstack.conforming &&
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
    FormalVibeficationSpec.siblingLineEncodingsRequired &&
    FormalVibeficationSpec.siblingProofsAreSeparateModules &&
    !FormalVibeficationSpec.mashedSiblingEncodingAndProofsConform &&
    SpecProofs.encodingsNotMashed &&
    Spec_0010.specFileName == specFileName &&
    Spec_0010.siblingEncodingFileName == "Spec_0010.lean" &&
    !Ci.dumpTheoremsIntoNumberedMarkdown

theorem surmount_integrates : stackIntegrates = true := rfl

end Surmount
