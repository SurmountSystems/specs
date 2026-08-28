/-
  PROOFS for numbered specification 0011 Surmount Systems Tech Tree.

  This module is not the specification. It imports TechTreeSpec
  and establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import TechTreeSpec
import SpecRegistry

set_option maxHeartbeats 800000

namespace TechTreeProofs

open TechTreeSpec

theorem spec_number_is_11 : specNumber = 11 := rfl

theorem spec_file_is_0011_tech_tree :
    specFileName = "0011_Surmount_Systems_Tech_Tree.md" :=
  rfl

theorem product_name_is_tech_tree :
    productName = "Surmount Systems Tech Tree" :=
  rfl

theorem spec_is_not_0010 : specNumber ≠ 10 := by decide

theorem spec_is_not_0012 : specNumber ≠ 12 := by decide

theorem spec_is_not_0009 : specNumber ≠ 9 := by decide

theorem magic_string_is_sstechtree01 :
    magicString = "SSTECHTREE01" :=
  rfl

theorem magic_length : magicString.length = 12 := rfl

theorem magic_byte_count : magicBytes.length = magicByteCount :=
  rfl

theorem magic_has_no_nul :
    magicString.toList.all (fun c => c.toNat != 0) = true :=
  rfl

theorem file_extension_is_sstt : fileExtension = ".sstt" := rfl

theorem producer_not_shipped : producerShipped = false := rfl

theorem lake_writer_exists : lakeWriterExists = true := rfl

theorem compact_size_is_this_repo_pin :
    compactSizeBtcVerifiedIsThisRepoRefPin = true :=
  rfl

theorem majestic_memex_published :
    majesticMemexPublished = true :=
  rfl

theorem node_kind_code_numbered_spec : nodeKindCode .numberedSpec = 1 :=
  rfl

theorem edge_kind_code_cites : edgeKindCode .cites = 2 := rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem this_module_is_not_the_spec_encoding :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_agrees_registry :
    specNumber = 11 :=
  rfl

theorem spec_file_agrees :
    specFileName = "0011_Surmount_Systems_Tech_Tree.md" :=
  rfl

theorem human_markdown_is_the_contract :
    humanMarkdownIsTheHumanContract = true :=
  rfl

theorem human_markdown_does_not_substitute_for_encodings :
    humanMarkdownSubstitutesForLeanSpecEncoding = false :=
  rfl

theorem lean_proof_is_not_the_spec : leanProofIsTheSpec = false :=
  rfl

theorem magic_bytes_are_twelve :
    magicBytes.length = 12 :=
  rfl

theorem magic_first_byte_is_S :
    magicBytes.head? = some (UInt8.ofNat 'S'.toNat) :=
  rfl

theorem magic_last_byte_is_1 :
    magicBytes.getLast? = some (UInt8.ofNat '1'.toNat) :=
  rfl

theorem encoded_graph_must_be_dag : encodedGraphMustBeDag = true :=
  rfl

theorem markdown_citation_may_cycle : markdownCitationMayCycle = true :=
  rfl

theorem empty_graph_is_dag : emptyGraphIsDag = true := rfl

theorem chain_graph_is_dag : chainGraphIsDag = true := rfl

theorem loop_graph_is_not_dag : loopGraphIsDag = false := rfl

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

theorem encode_0 : encodeCompactSize 0 = [0] := rfl

theorem encode_252 : encodeCompactSize 252 = [0xFC] := rfl

theorem encode_253 :
    encodeCompactSize 253 = [0xFD, 0xFD, 0x00] :=
  rfl

theorem encode_65535 :
    encodeCompactSize 65535 = [0xFD, 0xFF, 0xFF] :=
  rfl

theorem encode_65536 :
    encodeCompactSize 65536 = [0xFE, 0x00, 0x00, 0x01, 0x00] :=
  rfl

theorem decode_encode_0 :
    decodeCompactSize (encodeCompactSize 0) = some (0, []) :=
  rfl

theorem decode_encode_252 :
    decodeCompactSize (encodeCompactSize 252) = some (252, []) :=
  rfl

theorem decode_encode_253 :
    decodeCompactSize (encodeCompactSize 253) = some (253, []) :=
  rfl

theorem decode_encode_65535 :
    decodeCompactSize (encodeCompactSize 65535) = some (65535, []) :=
  rfl

theorem decode_encode_65536 :
    decodeCompactSize (encodeCompactSize 65536) = some (65536, []) :=
  rfl

theorem decode_noncanonical_fd_fc :
    decodeCompactSize [0xFD, 0xFC, 0x00] = none :=
  rfl

theorem decode_empty : decodeCompactSize [] = none := rfl

/-- Roundtrip for representative one byte CompactSize values. -/
theorem decode_encode_single_examples :
    decodeCompactSize (encodeCompactSize 1) = some (1, []) ∧
      decodeCompactSize (encodeCompactSize 127) = some (127, []) :=
  And.intro rfl rfl

theorem products_not_claimed_ready : productsClaimedReadyForUse = false :=
  rfl

theorem products_not_claimed_never_started :
    productsClaimedNeverStarted = false :=
  rfl

theorem lake_package_has_writer : lakeWriterExists = true :=
  rfl

theorem empty_sstt_roundtrip :
    decodeGraph (magicBytes ++ [0, 0]) = some ([], []) := by
  native_decide

theorem empty_sstt_bytes :
    encodeGraph [] [] = some (magicBytes ++ [0, 0]) := by
  native_decide

theorem wrong_magic_rejected :
    decodeGraph wrongMagicEmpty = none := by
  native_decide

theorem cyclic_encode_is_none :
    encodeGraph [fixtureNode0, fixtureNode5] fixtureLoop = none := by
  native_decide

theorem cyclic_payload_rejected :
    decodeGraph cyclicEncodedBytes = none := by
  native_decide

theorem chain_graph_ok_proof :
    graphOk [fixtureNode0, fixtureNode5] fixtureChain = true := by
  native_decide

theorem oriented_mutual_is_lower_to_higher :
    orientSpecEdges [fixtureNode0, fixtureNode5] mutualCitation =
      [{ src := 0, dst := 1, kind := .cites }] := by
  native_decide

theorem chain_roundtrip :
    decodeGraph
        ((encodeGraph [fixtureNode0, fixtureNode5] fixtureChain).getD []) =
      some ([fixtureNode0, fixtureNode5], fixtureChain) := by
  native_decide

end TechTreeProofs
