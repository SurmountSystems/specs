/-
  PROOFS for the sibling line encoding of `0004_SSSSS.md`.

  This module is not the specification. It imports «0004_SSSSS» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0004_SSSSS»
import FormalVibeficationSpec

namespace Proofs_0004

open «0004_SSSSS»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 4 := rfl

theorem spec_file : specFileName = "0004_SSSSS.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0004_SSSSS.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0004" := rfl

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

theorem encoded_size : encodedLines.size = 310 := by native_decide

theorem line_count : lineCount = 310 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_sssss : mentions "SSSSS" = true := by native_decide

end Proofs_0004
