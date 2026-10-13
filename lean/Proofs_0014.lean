/-
  PROOFS for the sibling line encoding of
  `0014_Anunnaki_Encoding.md`.

  This module is not the specification. It imports
  «0014_Anunnaki_Encoding» and establishes identities of that
  encoding. Meaning proofs live in AnunnakiProofs.lean. Numbered
  markdown remains the contract humans read.
-/

import «0014_Anunnaki_Encoding»
import FormalVibeficationSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0014

open «0014_Anunnaki_Encoding»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 14 := rfl

theorem spec_file : specFileName = "0014_Anunnaki_Encoding.md" :=
  rfl

theorem sibling_name :
    siblingEncodingFileName = "0014_Anunnaki_Encoding.lean" :=
  rfl

theorem proof_module_name : proofModuleName = "Proofs_0014" := rfl

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

theorem encoded_size : encodedLines.size = 338 := by native_decide

theorem line_count : lineCount = 338 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? =
      some { number := 1, text := "# Anunnaki Encoding" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_anunnaki : mentions "Anunnaki Encoding" = true := by
  native_decide

theorem mentions_enki : mentions "ENKI" = true := by
  native_decide

theorem mentions_cate : mentions "0005_CATE.md" = true := by
  native_decide

theorem mentions_sssss : mentions "0004_SSSSS.md" = true := by
  native_decide

theorem mentions_memex : mentions "0012_Majestic_Memex.md" = true := by
  native_decide

theorem mentions_proofofkeags : mentions "proofofkeags.com" = true := by
  native_decide

theorem mentions_unlicense : mentions "0009_PDOSS.md" = true := by
  native_decide

end Proofs_0014
