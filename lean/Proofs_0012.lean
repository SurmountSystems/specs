/-
  PROOFS for the sibling line encoding of
  `0012_Majestic_Memex.md`.

  This module is not the specification. It imports
  «0012_Majestic_Memex» and establishes identities of that
  encoding. Meaning proofs live in MemexProofs.lean. Numbered
  markdown remains the contract humans read.
-/

import «0012_Majestic_Memex»
import FormalVibeficationSpec
import SpecRegistry

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0012

open «0012_Majestic_Memex»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 12 := rfl

theorem spec_file : specFileName = "0012_Majestic_Memex.md" :=
  rfl

theorem sibling_name :
    siblingEncodingFileName = "0012_Majestic_Memex.lean" :=
  rfl

theorem proof_module_name : proofModuleName = "Proofs_0012" := rfl

theorem proof_module_distinct :
    proofModuleName ≠ siblingEncodingFileName := by
  decide

theorem mash_hidden_split_is_false :
    FormalVibeficationSpec.hidesSplit
      { moduleName := siblingEncodingFileName
        containsSpecEncodings := markedAsSpecEncoding
        containsProofsOfThoseEncodings := markedAsProof
        markedAsSpecEncoding := markedAsSpecEncoding
        markedAsProof := markedAsProof } = false :=
  rfl

theorem mash_encoding_and_proofs_nonconforming :
    FormalVibeficationSpec.conformingThisRepo
      { moduleName := "MashedSpecAndProof"
        containsSpecEncodings := true
        containsProofsOfThoseEncodings := true
        markedAsSpecEncoding := true
        markedAsProof := true } = false :=
  rfl

theorem encoded_size : encodedLines.size = 292 := by native_decide

theorem line_count : lineCount = 292 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? =
      some { number := 1, text := "# Majestic `Memex`" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_majestic_memex : mentions "Majestic `Memex`" = true := by
  native_decide

theorem mentions_majestic_ext : mentions ".majestic" = true := by
  native_decide

theorem mentions_magic : mentions "MAJESTIC" = true := by native_decide

theorem mentions_sstt_distinct : mentions ".sstt" = true := by
  native_decide

theorem mentions_proofofkeags : mentions "proofofkeags.com" = true := by
  native_decide

end Proofs_0012
