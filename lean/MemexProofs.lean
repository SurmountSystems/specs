/-
  PROOFS for numbered specification 0012 Majestic Memex.

  This module is not the specification. It imports MemexSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import MemexSpec
import SpecRegistry

namespace MemexProofs

open MemexSpec

theorem spec_number_is_12 : specNumber = 12 := rfl

theorem spec_file_is_0012_majestic_memex :
    specFileName = "0012_Majestic_Memex.md" :=
  rfl

theorem product_name_is_majestic_memex :
    productName = "Majestic Memex" :=
  rfl

theorem spec_is_not_0011 : specNumber ≠ 11 := by decide

theorem spec_is_not_0010 : specNumber ≠ 10 := by decide

theorem spec_is_not_0009 : specNumber ≠ 9 := by decide

theorem crate_name_is_majestic : crateName = "majestic" := rfl

theorem command_name_is_memex : commandName = "memex" := rfl

theorem crate_name_is_not_the_command : crateName ≠ commandName := by
  decide

theorem magic_string_is_majestic : magicString = "MAJESTIC" := rfl

theorem magic_ascii_length : magicString.length = 8 := rfl

theorem magic_byte_count : magicBytes.length = magicByteCount :=
  rfl

theorem magic_version_is_one : magicVersionByte = 0x01 := rfl

theorem magic_has_no_nul :
    magicString.toList.all (fun c => c.toNat != 0) = true :=
  rfl

theorem file_extension_is_majestic : fileExtension = ".majestic" :=
  rfl

theorem file_extension_is_not_sstt : fileExtension ≠ ".sstt" := by
  decide

theorem tech_tree_extension_is_sstt :
    techTreeFileExtension = ".sstt" :=
  rfl

theorem magic_is_not_sstechtree01 :
    magicString ≠ techTreeMagicString := by
  decide

theorem data_root_rel_is_memex : dataRootRel = "memex" := rfl

theorem data_root_uses_home : dataRootUsesHome = true := rfl

theorem still_being_built : proofOfConceptStillBeingBuilt = true :=
  rfl

theorem not_ready_for_use : productReadyForUse = false := rfl

theorem not_claimed_never_started : productNeverStarted = false :=
  rfl

theorem may_load_sstt : memexMayLoadSstt = true := rfl

theorem archive_is_not_sstt : majesticArchiveIsSstt = false := rfl

theorem sstt_producer_not_shipped : ssttProducerShipped = false :=
  rfl

theorem btc_verified_is_form_one_pin :
    thisEffortAddsBtcVerifiedSubmodule = true :=
  rfl

theorem this_repo_unlicense_does_not_cover_crate :
    thisRepoUnlicenseCoversMajesticCrate = false :=
  rfl

theorem crate_has_own_unlicense :
    majesticCrateHasOwnUnlicenseFile = true :=
  rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_agrees_registry :
    specNumber = 12 :=
  rfl

theorem spec_file_agrees :
    specFileName = "0012_Majestic_Memex.md" :=
  rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem crate_and_command :
    crateName = "majestic" ∧ commandName = "memex" :=
  And.intro rfl rfl

theorem magic_bytes_are_nine : magicBytes.length = 9 :=
  rfl

theorem magic_first_byte_is_M :
    magicBytes.head? = some (UInt8.ofNat 'M'.toNat) :=
  rfl

theorem magic_last_byte_is_version :
    magicBytes.getLast? = some 0x01 :=
  rfl

theorem magic_ascii_is_majestic :
    (magicBytes.take 8) =
      ("MAJESTIC".toList.map charByte) :=
  rfl

theorem distinct_from_tech_tree_magic :
    magicString ≠ "SSTECHTREE01" := by
  decide

theorem distinct_from_tech_tree_extension :
    fileExtension ≠ ".sstt" := by
  decide

theorem data_lives_under_home_memex :
    dataRootUsesHome = true ∧ dataRootRel = "memex" :=
  And.intro rfl rfl

theorem proof_of_concept_not_ready :
    proofOfConceptStillBeingBuilt = true ∧
      productReadyForUse = false :=
  And.intro rfl rfl

theorem may_load_sstt_without_mixing :
    memexMayLoadSstt = true ∧ majesticArchiveIsSstt = false :=
  And.intro rfl rfl

theorem no_sstt_product_writer_and_btc_verified_pin :
    ssttProducerShipped = false ∧
      thisEffortAddsBtcVerifiedSubmodule = true :=
  And.intro rfl rfl

theorem unlicense_split :
    thisRepoUnlicenseCoversMajesticCrate = false ∧
      majesticCrateHasOwnUnlicenseFile = true :=
  And.intro rfl rfl

theorem separate_spec_encoding_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem separate_proof_conforms :
    conformingThisRepo proofFixture = true :=
  rfl

theorem mashed_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem mash_hides_split : hidesSplit mashedFixture = true := rfl

theorem formal_vibefication_url :
    formalVibeficationUrl =
      "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html" :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem sibling_line_encodings_required :
    siblingLineEncodingsRequired = true :=
  rfl

theorem sibling_proofs_are_separate_modules :
    siblingProofsAreSeparateModules = true :=
  rfl

end MemexProofs
