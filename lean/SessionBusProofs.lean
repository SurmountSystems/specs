/-
  PROOFS for numbered specification 0015 Session Bus.

  This module is not the specification. It imports SessionBusSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import SessionBusSpec

namespace SessionBusProofs

open SessionBusSpec

theorem session_bus_spec_number_is_15 : sessionBusSpecNumber = 15 := rfl

theorem spec_number_is_15 : specNumber = 15 := rfl

theorem session_bus_spec_number_matches_spec_number :
    sessionBusSpecNumber = specNumber :=
  rfl

theorem spec_file_is_0015_session_bus :
    specFileName = "0015_Session_Bus.md" :=
  rfl

theorem product_name_is_session_bus : productName = "Session Bus" := rfl

theorem spec_is_not_0014 : specNumber ≠ 14 := by decide

theorem approve_default_is_off : approveDefault = false := rfl

theorem deny_default_is_off : denyDefault = false := rfl

theorem approve_and_deny_are_off_by_default :
    approveDefault = false ∧ denyDefault = false :=
  And.intro rfl rfl

theorem approve_off_by_default : approveOffByDefault = true := rfl

theorem deny_off_by_default : denyOffByDefault = true := rfl

theorem no_network_listener : networkListenerPresent = false := rfl

theorem socket_allows_same_uid : socketAllows .same = true := rfl

theorem socket_rejects_other_uid : socketAllows .other = false := rfl

theorem socket_is_same_uid_only : socketIsSameUidOnly = true := rfl

theorem transcript_returns_deltas : transcriptReturnsDeltas = true := rfl

theorem transcript_does_not_return_full_text :
    transcriptReturnsFullText = false :=
  rfl

theorem transcript_returns_deltas_only :
    transcriptReturnsDeltasOnly = true :=
  rfl

theorem conforming_session_bus_program_not_claimed :
    conformingSessionBusProgramClaimed = false :=
  rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_marked_as_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false := rfl

theorem separate_spec_encoding_conforms :
    conformingThisRepo specEncodingFixture = true :=
  rfl

theorem separate_proof_conforms : conformingThisRepo proofFixture = true :=
  rfl

theorem mashed_does_not_conform :
    conformingThisRepo mashedFixture = false :=
  rfl

theorem mash_hides_split : hidesSplit mashedFixture = true := rfl

theorem mashed_is_nonconforming : mashedIsNonconformingThisRepo := rfl

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse := by
  intro h
  cases h

theorem mash_conforming_session_bus_program_claimed_is_false :
    mashConformingSessionBusProgramClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem required_conformance_holds : requiredConformanceHolds = true := rfl

end SessionBusProofs
