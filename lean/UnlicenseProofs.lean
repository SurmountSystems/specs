/-
  PROOFS for numbered specification 0009 Public Domain Open Source
  Software (PDOSS). Unlicense remains the license.

  This module is not the specification. It imports UnlicenseSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import UnlicenseSpec
import SpecRegistry
import «0009_PDOSS»

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

theorem unlicense_does_not_replace_named_residual_licenses :
    unlicenseReplacesNamedResidualLicenses = false :=
  rfl

theorem mash_unlicense_replaces_named_residual_licenses
    (h : mashUnlicenseReplacesNamedResidualLicenses) : False :=
  nomatch h

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

theorem cc0_is_not_pinned_as_meeting_pdoss :
    cc0PinnedAsMeetingPdoss = false :=
  rfl

theorem cc0_is_not_clause_12_pin : cc0IsClause12Pin = false :=
  rfl

/-- Setting `cc0Pinned` true is Cons False. Not a legal evaluation of CC0. -/
theorem mash_cc0_pinned_is_false : cc0Pinned = true → False := by
  intro h
  exact Bool.noConfusion h

/-- True when `needle` occurs in `hay`. -/
def mentionsPhrase (needle hay : String) : Bool :=
  (hay.splitOn needle).length > 1

/-- Clause 6.4 item 4. Sibling markdown line 651. Array index 650. -/
def clause64Item4Cc0Line : MdLine :=
  «0009_PDOSS».encodedLines[650]!

/--
  Clause 6.4 item 4 on one sibling line: companion Lean must not encode
  CC0 as meeting the PDOSS test, and this document does not claim CC0
  fails or meets PDOSS as a pinned instrument.
-/
def clause64Item4ReadsCc0NotClaimedToMeet (s : String) : Bool :=
  mentionsPhrase "Companion Lean MUST NOT encode CC0 as meeting the PDOSS test." s &&
    mentionsPhrase "This document does not claim CC0 fails or meets PDOSS as a pinned instrument." s

/-- How that live sentence is read. `claimedMeets` is the claim the sentence denies. -/
inductive Cc0ClaimedMeetsReading where
  | notClaimedToMeet
  | claimedMeets
  deriving DecidableEq, Repr, BEq

/--
  One reading of Clause 6.4 item 4.
  `notClaimedToMeet` only when sibling line 651 still carries that denial.
  This reader does not return `claimedMeets`. Absent words yield `none`.
-/
def readLiveCc0ClaimedMeets (line : MdLine) : Option Cc0ClaimedMeetsReading :=
  if line.number == 651 &&
      clause64Item4ReadsCc0NotClaimedToMeet line.text then
    some .notClaimedToMeet
  else
    none

/-- The claim that CC0 is claimed to meet PDOSS. -/
def cc0ClaimedMeetsPdossAsCurrentFact : Prop :=
  readLiveCc0ClaimedMeets clause64Item4Cc0Line = some .claimedMeets

def cc0ClaimedMeetsPdossAsCurrentFactIsFalse : Prop :=
  cc0ClaimedMeetsPdossAsCurrentFact → False

/-- True only when sibling line 651 is read as CC0 being claimed to meet PDOSS. -/
def cc0CountedClaimedMeetsPdoss : Bool :=
  readLiveCc0ClaimedMeets clause64Item4Cc0Line == some .claimedMeets

set_option maxHeartbeats 800000

/--
  Live sibling line 651 of `0009_PDOSS` says companion Lean must not
  encode CC0 as meeting the PDOSS test, and that this document does not
  claim CC0 fails or meets PDOSS as a pinned instrument. Treating the
  claim that CC0 meets PDOSS as the current fact yields False. The
  `native_decide` step reads that sibling line. Removing that denial
  makes the reading `none`, so this proof no longer closes.
-/
theorem mash_cc0_claimed_meets_pdoss_is_false :
    cc0ClaimedMeetsPdossAsCurrentFactIsFalse := by
  intro h
  unfold cc0ClaimedMeetsPdossAsCurrentFact at h
  have live :
      readLiveCc0ClaimedMeets clause64Item4Cc0Line =
        some .notClaimedToMeet := by
    native_decide
  rw [live] at h
  injection h with eq
  injection eq

/--
  Clause 6.4 item 4 denies pinning CC0 as an instrument.
  The pin denial is the sentence that this document does not claim
  CC0 fails or meets PDOSS as a pinned instrument.
  This reader does not decide a meets result for CC0.
-/
def clause64Item4DeniesCc0Pin (s : String) : Bool :=
  mentionsPhrase
    "This document does not claim CC0 fails or meets PDOSS as a pinned instrument."
    s

/-- How the pin sentence is read. `pinnedAsMeeting` is the pin the sentence denies. -/
inductive Cc0PinnedAsMeetingReading where
  | pinDenied
  | pinnedAsMeeting
  deriving DecidableEq, Repr, BEq

/--
  One reading of the pin on Clause 6.4 item 4.
  `pinDenied` only when sibling line 651 still carries that pin denial.
  This reader does not return `pinnedAsMeeting`. Absent words yield `none`.
  It does not read the meets denial that companion Lean must not encode CC0
  as meeting the PDOSS test.
-/
def readLiveCc0PinnedAsMeeting (line : MdLine) : Option Cc0PinnedAsMeetingReading :=
  if line.number == 651 && clause64Item4DeniesCc0Pin line.text then
    some .pinDenied
  else
    none

/-- The claim that CC0 is pinned as meeting PDOSS. Not a legal evaluation of CC0. -/
def cc0PinnedAsMeetingPdossAsCurrentFact : Prop :=
  readLiveCc0PinnedAsMeeting clause64Item4Cc0Line = some .pinnedAsMeeting

def cc0PinnedAsMeetingPdossAsCurrentFactIsFalse : Prop :=
  cc0PinnedAsMeetingPdossAsCurrentFact → False

/--
  Live sibling line 651 of `0009_PDOSS` says this document does not
  claim CC0 fails or meets PDOSS as a pinned instrument. Treating the
  claim that CC0 is pinned as meeting PDOSS as the current fact yields
  False. The `native_decide` step reads that pin denial. Removing that
  pin denial makes the reading `none`, so this proof no longer closes.
  This is the pin. It is not the meets claim. It is not a legal
  evaluation of CC0.
-/
theorem mash_cc0_pinned_as_meeting_pdoss :
    cc0PinnedAsMeetingPdossAsCurrentFactIsFalse := by
  intro h
  unfold cc0PinnedAsMeetingPdossAsCurrentFact at h
  have live :
      readLiveCc0PinnedAsMeeting clause64Item4Cc0Line =
        some .pinDenied := by
    native_decide
  rw [live] at h
  injection h with eq
  injection eq

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

theorem allow_unlicense_contribution_accepted :
    contributionAccepted allowUnlicenseContribution = true :=
  rfl

theorem residual_attribution_unlicense_refused :
    contributionAccepted residualAttributionUnlicenseContribution = false :=
  rfl

theorem dual_allow_residual_refused :
    contributionAccepted dualAllowResidualContribution = false :=
  rfl

theorem specific_consent_unlicense_refused :
    contributionAccepted specificConsentUnlicenseContribution = false :=
  rfl

theorem unread_unlicense_refused :
    contributionAccepted unreadUnlicenseContribution = false :=
  rfl

theorem mash_residual_attribution_contribution_accepted
    (h : residualAttributionContributionAccepted) : False :=
  nomatch h

theorem united_states_class_is_allow :
    unitedStatesClass = NationalityClass.allow :=
  rfl

theorem france_class_is_residual_attribution :
    franceClass = NationalityClass.residualAttribution :=
  rfl

theorem australia_class_is_specific_consent :
    australiaClass = NationalityClass.specificConsent :=
  rfl

theorem users_not_restricted_by_nationality :
    usersRestrictedByNationality = false :=
  rfl

theorem nationality_is_citizenship :
    nationalityIsCitizenship = true :=
  rfl

theorem nationality_statutes_are_not_clause_12_pins :
    nationalityStatutesAreClause12Pins = false :=
  rfl

theorem mash_nationality_statutes_are_clause_12_pins
    (h : mashNationalityStatutesAreClause12Pins) : False :=
  nomatch h

end UnlicenseProofs
