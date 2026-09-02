/-
  PROOFS for numbered specification 0009 Public Domain Open Source
  Software (PDOSS). Unlicense remains the license.

  This module is not the specification. It imports UnlicenseSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import UnlicenseSpec
import SpecRegistry

namespace UnlicenseProofs

open UnlicenseSpec

theorem spec_number_is_9 : specNumber = 9 := rfl

theorem spec_file_is_0009_pdoss :
    specFileName = "0009_PDOSS.md" :=
  rfl

theorem product_name_is_pdoss : productName = "PDOSS" := rfl

theorem pdoss_spec_number_is_9 : pdossSpecNumber = 9 := rfl

theorem spec_is_not_0008 : specNumber ≠ 8 := by decide

theorem spec_is_not_0010 : specNumber ≠ 10 := by decide

theorem spec_is_not_0011 : specNumber ≠ 11 := by decide

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_agrees_registry :
    specNumber = SpecRegistry.unlicenseSpecNumber :=
  rfl

theorem spec_file_agrees_registry :
    specFileName = SpecRegistry.unlicenseFileName :=
  rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem oss_without_dedication_has_remaining_copyright :
    ossWithoutDedicationHasRemainingCopyright :=
  And.intro rfl rfl

theorem unlicense_dedication_has_no_remaining_copyright :
    unlicenseDedicationHasNoRemainingCopyright :=
  And.intro rfl rfl

theorem remaining_copyright_on_oss_without_dedication :
    remainingCopyright ossWithoutDedication = true :=
  rfl

theorem no_remaining_copyright_on_unlicense_dedication :
    remainingCopyright unlicenseDedication = false :=
  rfl

theorem grant_that_keeps_copyright_lets_later_contract_take_the_work :
    grantThatKeepsCopyrightLetsLaterContractTakeTheWork = true :=
  rfl

theorem most_important_work_shall_be_public_domain_dedicated :
    mostImportantWorkShallBePublicDomainDedicated = true :=
  rfl

theorem ideas_non_scarce : ideasNonScarce = true := rfl

theorem ideas_not_rivalrous : ideasNotRivalrous = true := rfl

theorem two_people_can_hold_the_same_idea :
    twoPeopleCanHoldTheSameIdeaAtOnce = true :=
  rfl

theorem generosity_of_ideas_is_default :
    generosityOfIdeasIsDefault = true :=
  rfl

theorem this_repo_unlicense_except_named_residual :
    thisRepoUnlicenseExceptNamedResidual := by
  dsimp [thisRepoUnlicenseExceptNamedResidual]
  decide

theorem numbered_specs_and_lean_are_unlicense :
    numberedSpecsAndLeanHere = LicenseOfWork.unlicenseDedication :=
  rfl

theorem lean4_skills_pack_is_mit :
    lean4SkillsPack = LicenseOfWork.mitGrant :=
  rfl

theorem btc_verified_pin_is_apache_two :
    btcVerifiedPin = LicenseOfWork.apacheTwo :=
  rfl

theorem keagan_essays_are_not_this_repo_grant :
    keaganEssays = LicenseOfWork.notThisRepoGrant :=
  rfl

theorem unlicense_meets_public_domain_dedication_test :
    meetsPublicDomainDedicationTest .unlicense = true :=
  rfl

theorem unlicense_meets_pdoss : meetsPdoss .unlicense = true :=
  rfl

theorem mit_does_not_meet_public_domain_dedication_test :
    meetsPublicDomainDedicationTest .mitGrant = false :=
  rfl

theorem mit_does_not_meet_pdoss : meetsPdoss .mitGrant = false :=
  rfl

theorem apache_two_does_not_meet_public_domain_dedication_test :
    meetsPublicDomainDedicationTest .apacheTwo = false :=
  rfl

theorem apache_two_does_not_meet_pdoss : meetsPdoss .apacheTwo = false :=
  rfl

theorem cc0_does_not_meet_pdoss : meetsPdoss .cc0 = false :=
  rfl

theorem mash_mit_meets_pdoss (h : mitMeetsPdoss) : False :=
  nomatch h

theorem mash_apache_meets_pdoss (h : apacheMeetsPdoss) : False :=
  nomatch h

theorem unlicense_does_not_apply_to_keagan :
    unlicenseOfThisRepoAppliesToKeaganEssays = false :=
  rfl

theorem essays_are_not_unlicense : essaysAreUnlicenseGrant = false :=
  rfl

theorem refuse_tool_is_not_license_claim :
    refuseToolYouCannotImproveIsLicenseClaim = false :=
  rfl

theorem refuse_tool_is_rsi_process :
    refuseToolYouCannotImproveIsRsiProcess = true :=
  rfl

theorem mashed_is_nonconforming : mashedIsNonconformingThisRepo :=
  rfl

theorem mashed_fixture_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem spec_encoding_fixture_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem proof_fixture_conforms :
    conformingThisRepo proofFixture = true :=
  rfl

theorem mash_spec_and_proof (h : mashSpecAndProof) : False :=
  nomatch h

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse :=
  mash_spec_and_proof

theorem formal_vibefication_url :
    formalVibeficationUrl =
      "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html" :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem number_nine_assigned : numberNineAssigned = true :=
  rfl

theorem number_eleven_published : numberElevenPublished = true :=
  rfl

theorem number_eleven_published_in_registry :
    (SpecRegistry.allEntries.any (fun e => e.number == 11)) = true :=
  SpecRegistry.number_11_published

theorem sibling_line_encodings_required :
    siblingLineEncodingsRequired = true :=
  rfl

theorem sibling_proofs_are_separate_modules :
    siblingProofsAreSeparateModules = true :=
  rfl

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem tests_only_effort_does_not_conform :
    testsOnlyEffortConforms = false :=
  rfl

theorem tests_without_model_does_not_conform :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_effort_does_not_conform :
    modelAndProofsWithoutExperimentsEffortConforms = false :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

theorem complete_science_effort_conforms :
    completeScienceEffortConforms = true :=
  rfl

end UnlicenseProofs
