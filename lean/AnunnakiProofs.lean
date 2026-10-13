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
