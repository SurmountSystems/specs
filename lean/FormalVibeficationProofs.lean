/-
  PROOFS for numbered specification 0008 Formal Vibefication.

  This module is not the specification. It imports FormalVibeficationSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import FormalVibeficationSpec
import SpecRegistry

namespace FormalVibeficationProofs

open FormalVibeficationSpec

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_agrees_registry :
    specNumber = SpecRegistry.formalVibeficationSpecNumber :=
  rfl

theorem spec_file_agrees_registry :
    specFileName = SpecRegistry.formalVibeficationFileName :=
  rfl

theorem layers_pairwise_distinct : layersPairwiseDistinct := by
  dsimp [layersPairwiseDistinct]
  decide

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem spec_check_is_markdown_form : specCheckIsMarkdownForm = true :=
  rfl

theorem spec_check_is_not_meaning_encoding :
    specCheckIsMeaningSpecEncoding = false :=
  rfl

theorem mashed_is_nonconforming : mashedIsNonconformingThisRepo :=
  rfl

theorem separate_modules_conform : separateModulesConformThisRepo := by
  dsimp [separateModulesConformThisRepo]
  decide

theorem spec_encoding_fixture_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem proof_fixture_conforms :
    conformingThisRepo proofFixture = true :=
  rfl

theorem mashed_fixture_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem mashed_hides_split : hidesSplit mashedFixture = true :=
  rfl

theorem spec_encoding_does_not_hide_split :
    hidesSplit specEncodingFixture = false :=
  rfl

theorem mash_homes_is_inconsistent : mashHomesIsInconsistent := by
  intro h
  exact Bool.noConfusion h

theorem mash_spec_and_proof (h : mashSpecAndProof) : False :=
  nomatch h

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse :=
  mash_spec_and_proof

theorem this_repo_separates : thisRepoSeparates := by
  dsimp [thisRepoSeparates]
  decide

theorem product_tree_unifies : productTreeUnifies :=
  rfl

theorem this_repo_separates_and_product_tree_unifies :
    thisRepoSeparates ∧ productTreeUnifies :=
  And.intro this_repo_separates product_tree_unifies

theorem formal_vibefication_url :
    formalVibeficationUrl =
      "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html" :=
  rfl

theorem dont_trust_verify_url :
    dontTrustVerifyUrl =
      "https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html" :=
  rfl

theorem essays_are_not_unlicense : essaysAreUnlicenseGrant = false :=
  rfl

theorem essays_not_vendored_as_form2 : essaysMayBeVendoredAsForm2 = false :=
  rfl

theorem theorems_cover_exactly_what_they_state :
    theoremsCoverExactlyWhatTheyState = true :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem number_nine_assigned : numberNineAssigned = false :=
  rfl

theorem number_nine_not_published_in_registry :
    (SpecRegistry.allEntries.any (fun e => e.number == 9)) = false :=
  SpecRegistry.number_9_not_published

theorem number_eight_published_in_registry :
    (SpecRegistry.allEntries.any (fun e => e.number == 8)) = true :=
  SpecRegistry.number_8_published

theorem sibling_line_encodings_required :
    siblingLineEncodingsRequired = true :=
  rfl

theorem sibling_proofs_are_separate_modules :
    siblingProofsAreSeparateModules = true :=
  rfl

theorem mashed_sibling_is_nonconforming : mashedSiblingIsNonconforming :=
  rfl

end FormalVibeficationProofs
