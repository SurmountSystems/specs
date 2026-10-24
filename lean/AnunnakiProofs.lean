/-
  PROOFS for numbered specification 0014 Anunnaki Encoding.

  This module is not the specification. It imports AnunnakiSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import AnunnakiSpec

namespace AnunnakiProofs

open AnunnakiSpec

theorem spec_number_is_14 : specNumber = 14 := rfl

theorem spec_file_is_0014_anunnaki_encoding :
    specFileName = "0014_Anunnaki_Encoding.md" :=
  rfl

theorem product_name_is_anunnaki_encoding :
    productName = "Anunnaki Encoding" :=
  rfl

theorem spec_is_not_0015 : specNumber ≠ 15 := by decide

theorem spec_is_not_0013 : specNumber ≠ 13 := by decide

theorem spec_is_not_0005 : specNumber ≠ 5 := by decide

theorem spec_is_not_0004 : specNumber ≠ 4 := by decide

theorem spec_is_not_0012 : specNumber ≠ 12 := by decide

theorem enki_is_index : enkiIsIndex = true := rfl

theorem anunnaki_is_bitstream : anunnakiIsBitstream = true := rfl

theorem enki_and_anunnaki_are_not_one_object :
    enkiAndAnunnakiAreOneObject = false :=
  rfl

theorem enki_has_no_numbered_specification :
    enkiHasNumberedSpecification = false :=
  rfl

theorem does_not_replace_cate : replacesCate = false := rfl

theorem cate_is_0005 : cateSpecNumber = 5 := rfl

theorem cate_owns_language_id : cateOwnsLanguageId = true := rfl

theorem cate_owns_word_id : cateOwnsWordId = true := rfl

theorem cate_owns_word_catalog : cateOwnsWordCatalog = true := rfl

theorem does_not_replace_sssss : replacesSssss = false := rfl

theorem sssss_is_0004 : sssssSpecNumber = 4 := rfl

theorem sssss_owns_language_runs : sssssOwnsLanguageRuns = true := rfl

theorem does_not_replace_memex : replacesMemex = false := rfl

theorem memex_is_0012 : memexSpecNumber = 12 := rfl

theorem memex_keeps_majestic_plus_01 : memexKeepsMajesticPlus01 = true :=
  rfl

theorem encoder_not_claimed : conformingEncoderClaimed = false := rfl

theorem no_conforming_product_claimed : conformingProductExists = false :=
  rfl

theorem huffman_may_be_measured : huffmanMayBeMeasured = true := rfl

theorem huffman_is_not_lemma_spine : huffmanIsLemmaSpine = false := rfl

theorem huffman_must_not_be_lemma_spine :
    huffmanMustNotBeLemmaSpine = true :=
  rfl

theorem arm0_payload_one_byte : payloadBytesFromLeadingOnes 0 = 1 := rfl

theorem arm10_payload_two_bytes : payloadBytesFromLeadingOnes 1 = 2 :=
  rfl

theorem arm110_payload_three_bytes : payloadBytesFromLeadingOnes 2 = 3 :=
  rfl

theorem arm1110_payload_four_bytes : payloadBytesFromLeadingOnes 3 = 4 :=
  rfl

theorem payload_cap_is_eight : payloadByteCap = 8 := rfl

theorem arm0_terminates_with_zero : terminatesWithZero arm0Bits = true :=
  rfl

theorem arm10_terminates_with_zero : terminatesWithZero arm10Bits = true :=
  rfl

theorem arm110_terminates_with_zero :
    terminatesWithZero arm110Bits = true :=
  rfl

theorem arm1110_terminates_with_zero :
    terminatesWithZero arm1110Bits = true :=
  rfl

theorem arm0_leading_ones : leadingOnes arm0Bits = 0 := rfl

theorem arm10_leading_ones : leadingOnes arm10Bits = 1 := rfl

theorem arm110_leading_ones : leadingOnes arm110Bits = 2 := rfl

theorem arm1110_leading_ones : leadingOnes arm1110Bits = 3 := rfl

/-- Clause 3.7: arm `0` means the next payload item is 1 byte. -/
theorem arm0_means_one_payload_byte :
    finishedArm arm0Bits = true ∧
      acceptedPayloadBytes arm0Bits = some 1 :=
  And.intro rfl rfl

/-- Clause 3.7: arm `10` means the next payload item is 2 bytes. -/
theorem arm10_means_two_payload_bytes :
    finishedArm arm10Bits = true ∧
      acceptedPayloadBytes arm10Bits = some 2 :=
  And.intro rfl rfl

/-- Clause 3.7: arm `110` means the next payload item is 3 bytes. -/
theorem arm110_means_three_payload_bytes :
    finishedArm arm110Bits = true ∧
      acceptedPayloadBytes arm110Bits = some 3 :=
  And.intro rfl rfl

/-- Clause 3.7: arm `1110` means the next payload item is 4 bytes. -/
theorem arm1110_means_four_payload_bytes :
    finishedArm arm1110Bits = true ∧
      acceptedPayloadBytes arm1110Bits = some 4 :=
  And.intro rfl rfl

/-- The named arms are the same bit lists as ones followed by a zero. -/
theorem named_arm_bits :
    armBits 0 = arm0Bits ∧
      armBits 1 = arm10Bits ∧
      armBits 2 = arm110Bits ∧
      armBits 3 = arm1110Bits :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

/--
  Clause 3.7: "The same rule continues at five bytes and beyond as further
  ones then a zero, up to the cap in Clause 4.4."
  Seven ones then a zero is 8 payload bytes. Eight ones then a zero is rejected.
-/
theorem width_rule_continues_to_cap :
    payloadBytesIfWithinCap 0 = some 1 ∧
      payloadBytesIfWithinCap 1 = some 2 ∧
      payloadBytesIfWithinCap 2 = some 3 ∧
      payloadBytesIfWithinCap 3 = some 4 ∧
      payloadBytesIfWithinCap 4 = some 5 ∧
      payloadBytesIfWithinCap 5 = some 6 ∧
      payloadBytesIfWithinCap 6 = some 7 ∧
      payloadBytesIfWithinCap 7 = some 8 ∧
      payloadBytesIfWithinCap 8 = none := by
  decide

/--
  Clause 4.4 item 7. The longest accepted arm is seven ones followed by a zero.
-/
theorem longest_accepted_arm :
    acceptedPayloadBytes (armBits 7) = some 8 ∧
      payloadBytesIfWithinCap 7 = some 8 ∧
      armExceedsCap 7 = false ∧
      finishedArm (armBits 7) = true :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

/--
  Clause 3.7 and Clause 4.4 item 7. Eight ones followed by a zero is a finished
  arm whose payload byte count is 9, and that count is rejected.
-/
theorem nine_payload_arm_rejected :
    acceptedPayloadBytes (armBits 8) = none ∧
      payloadBytesIfWithinCap 8 = none ∧
      armExceedsCap 8 = true ∧
      finishedArm (armBits 8) = true :=
  And.intro rfl (And.intro rfl (And.intro rfl rfl))

theorem empty_is_not_a_finished_arm : finishedArm [] = false := rfl

/-- Clause 3.16: trailing ones with no closing zero are padding, not an arm. -/
theorem pad_ones_are_not_a_finished_arm :
    finishedArm padOnesFixture = false :=
  rfl

private theorem cond_some_inv {α : Type} (c : Bool) (a n : α)
    (h : cond c (some a) none = some n) : c = true ∧ n = a := by
  cases c with
  | false =>
    change (none = some n) at h
    cases h
  | true =>
    change (some a = some n) at h
    injection h with hEq
    cases hEq
    exact And.intro rfl rfl

private theorem and_eq_true_split (a b : Bool) (h : (a && b) = true) :
    a = true ∧ b = true := by
  match a, b with
  | true, true => exact And.intro rfl rfl
  | true, false => cases h
  | false, true => cases h
  | false, false => cases h

private theorem not_true_is_false (a : Bool) (h : (!a) = true) : a = false := by
  cases a with
  | false => rfl
  | true => cases h

/--
  An accepted width is a finished arm. The cap rejects that arm when the
  payload byte count is greater than 8. The count is the number of ones plus one.
-/
theorem accepted_payload_bytes_spec (bits : List Bool) (n : Nat)
    (h : acceptedPayloadBytes bits = some n) :
    finishedArm bits = true ∧
      armExceedsCap (leadingOnes bits) = false ∧
      n = payloadBytesFromLeadingOnes (leadingOnes bits) := by
  unfold acceptedPayloadBytes at h
  have hCond :=
    cond_some_inv
      (finishedArm bits && !armExceedsCap (leadingOnes bits))
      (payloadBytesFromLeadingOnes (leadingOnes bits))
      n
      h
  have hParts := and_eq_true_split _ _ hCond.1
  have hCap := not_true_is_false _ hParts.2
  exact And.intro hParts.1 (And.intro hCap hCond.2)

/-- Clause 4.4 item 7. An accepted payload byte count is at most 8. -/
theorem accepted_payload_within_cap (bits : List Bool) (n : Nat)
    (h : acceptedPayloadBytes bits = some n) :
    n ≤ payloadByteCap := by
  have hSpec := accepted_payload_bytes_spec bits n h
  have hEq : n = payloadBytesFromLeadingOnes (leadingOnes bits) := hSpec.2.2
  have hNotEx : armExceedsCap (leadingOnes bits) = false := hSpec.2.1
  unfold armExceedsCap at hNotEx
  have hNot :
      ¬ payloadByteCap < payloadBytesFromLeadingOnes (leadingOnes bits) :=
    of_decide_eq_false hNotEx
  have hLe :
      payloadBytesFromLeadingOnes (leadingOnes bits) ≤ payloadByteCap :=
    Nat.not_lt.mp hNot
  subst hEq
  exact hLe

/-- Clause 3.9: "A page 0 index is one payload byte." That width is arm `0`. -/
theorem page0_index_width_is_arm0 :
    acceptedPayloadBytes arm0Bits = some page0IndexBytes :=
  rfl

/--
  Clause 3.10: "A page 1 index is two payload bytes."
  Clause 4.5 item 3: "A page 1 index MUST be little endian."
-/
theorem page1_index_width_is_arm10 :
    acceptedPayloadBytes arm10Bits = some page1IndexBytes ∧
      page1LittleEndian = true :=
  And.intro rfl rfl

theorem pad_ones_fixture_is_valid :
    claimedPadIsValid padOnesFixture = true :=
  rfl

theorem pad_containing_zero_is_rejected :
    mustRejectClaimedPad padContainsZeroFixture = true :=
  rfl

theorem pad_containing_zero_is_not_valid :
    claimedPadIsValid padContainsZeroFixture = false :=
  rfl

theorem pad_unused_bits_with_ones : padUnusedBitsWithOnes = true := rfl

theorem bit_7_first : bit7First = true := rfl

theorem perfectly_efficient_pad_length_zero :
    padLengthWhenPerfectlyEfficient = 0 :=
  rfl

theorem payload_is_bytes : payloadIsBytes = true := rfl

theorem page0_has_256_slots : page0Slots = 256 := rfl

theorem page0_index_is_one_byte : page0IndexBytes = 1 := rfl

theorem page1_has_65536_slots : page1Slots = 65536 := rfl

theorem page1_index_is_two_bytes : page1IndexBytes = 2 := rfl

theorem page1_is_little_endian : page1LittleEndian = true := rfl

theorem repeat_character_is_residual_plane :
    repeatCharacterIsResidualPlane = true :=
  rfl

theorem symbol_residual_is_separate : symbolResidualIsSeparate = true :=
  rfl

theorem residuals_are_not_the_same :
    repeatCharacterEqualsSymbolResidual = false :=
  rfl

theorem normalize_first_then_encode : normalizeFirstThenEncode = true :=
  rfl

theorem decode_rebuilds_original_surface :
    decodeMustRebuildOriginalSurface = true :=
  rfl

theorem one_language_keeps_one_language_id :
    oneLanguageKeepsOneLanguageId = true :=
  rfl

theorem dialect_does_not_need_own_language_id :
    dialectNeedsOwnLanguageId = false :=
  rfl

theorem spelling_tables_isomorphic_at_rank :
    spellingTablesIsomorphicAtRank = true :=
  rfl

theorem shared_rank_number_stays_the_same :
    americanSpellingTable.rankNumber = regionalSpellingTable.rankNumber :=
  rfl

theorem shared_language_id_stays_the_same :
    americanSpellingTable.languageId = regionalSpellingTable.languageId :=
  rfl

theorem surfaces_differ_at_shared_rank :
    americanSpellingTable.surface = "color" ∧
      regionalSpellingTable.surface = "regional form" :=
  And.intro rfl rfl

theorem user_preference_selects_decode_table :
    userPreferenceSelectsDecodeTable = true :=
  rfl

theorem user_preference_presents_regional_surface :
    (tableFor .userPreferred).surface = regionalSpellingTable.surface ∧
      (tableFor .userPreferred).rankNumber = sharedRankNumber :=
  And.intro rfl rfl

theorem repository_preference_presents_american_surface :
    (tableFor .repositoryAmerican).surface = americanSpellingTable.surface :=
  rfl

theorem spelling_converter_not_claimed :
    spellingConverterProgramClaimed = false :=
  rfl

theorem spelling_table_byte_layout_unspecified :
    spellingTableByteLayoutSpecified = false :=
  rfl

theorem migration_requires_lean_check :
    migrationRequiresLeanNotLongerCheck = true :=
  rfl

theorem corpus_unpinned : migrationCorpusPinned = false := rfl

theorem english_fixture_pinned : englishFixturePinned = true := rfl

theorem lean4_fixture_pinned : lean4FixturePinned = true := rfl

theorem c_fixture_unpinned : cFixturePinned = false := rfl

theorem rust1_fixture_unpinned : rust1FixturePinned = false := rfl

theorem nix_fixture_unpinned : nixFixturePinned = false := rfl

theorem cpp_fixture_unpinned : cppFixturePinned = false := rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

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

theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse := by
  intro h
  cases h

/-- Clause 6 leftover residual facts are false. -/
theorem rdps_assigned_number : rdpsAssignedNumber = false := rfl

theorem filter_script_assigned_number :
    filterScriptAssignedNumber = false :=
  rfl

theorem carbonado_assigned_number : carbonadoAssignedNumber = false :=
  rfl

theorem number_0015_assigned : number0015Assigned = false := rfl

theorem number_0015_is_this_specification :
    number0015IsThisSpecification = false :=
  rfl

theorem creates_enki_numbered_file : createsEnkiNumberedFile = false :=
  rfl

theorem fargo_assigned_number : fargoAssignedNumber = false := rfl

theorem stack_program_instruction_set_specified :
    stackProgramInstructionSetSpecified = false :=
  rfl

/-- Clause 4.8 item 2. No instruction listing for the stack program is published. -/
theorem instruction_listing_is_not_published :
    instructionListingPublished = false :=
  rfl

theorem listing_matches_unspecified_instruction_set :
    instructionListingPublished = stackProgramInstructionSetSpecified :=
  rfl

theorem nested_language_specified : nestedLanguageSpecified = false :=
  rfl

theorem on_disk_join_shape_specified :
    onDiskJoinShapeSpecified = false :=
  rfl

theorem compound_word_rules_specified :
    compoundWordRulesSpecified = false :=
  rfl

theorem anunnaki_default_majestic_specified :
    anunnakiDefaultMajesticSpecified = false :=
  rfl

theorem who_emits_stack_program_specified :
    whoEmitsStackProgramSpecified = false :=
  rfl

theorem huffman_versus_pages_measured :
    huffmanVersusPagesMeasured = false :=
  rfl

/-- Clause 6.5 leftover clashes are Cons False. -/
theorem mash_enki_and_anunnaki_are_one_object_is_false :
    mashEnkiAndAnunnakiAreOneObjectIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_conforming_encoder_claimed_is_false :
    mashConformingEncoderClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_number_0015_is_this_specification_is_false :
    mashNumber0015IsThisSpecificationIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_carbonado_assigned_number_is_false :
    mashCarbonadoAssignedNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_enki_has_numbered_specification_is_false :
    mashEnkiHasNumberedSpecificationIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_rdps_assigned_number_is_false :
    mashRdpsAssignedNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_filter_script_assigned_number_is_false :
    mashFilterScriptAssignedNumberIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_dialect_needs_own_language_id_is_false :
    mashDialectNeedsOwnLanguageIdIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_spelling_converter_claimed_is_false :
    mashSpellingConverterProgramClaimedIsFalse := by
  intro h
  exact Bool.noConfusion h

/-- Clause 4.8 item 2. Assuming the instruction listing is published yields False. -/
theorem mash_instruction_listing_published_is_false :
    mashInstructionListingPublishedIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem required_conformance_iff :
    requiredConformanceHolds = true :=
  rfl

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

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_only_does_not_conform : testsOnlyConforms = false :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsConforms = false :=
  rfl

theorem complete_science_conforms_here :
    completeScienceConformsHere = true :=
  rfl

theorem tests_without_model_does_not_conform_prop :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform_prop :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

end AnunnakiProofs
