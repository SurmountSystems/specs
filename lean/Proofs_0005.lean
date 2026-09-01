/-
  PROOFS for the sibling line encoding of `0005_CATE.md`.

  This module is not the specification. It imports «0005_CATE» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0005_CATE»
import FormalVibeficationSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0005

open «0005_CATE»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 5 := rfl

theorem spec_file : specFileName = "0005_CATE.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0005_CATE.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0005" := rfl

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

theorem mash_is_false : markedAsProof = false := rfl

theorem encoded_size : encodedLines.size = 1434 := by
  native_decide

theorem line_count_is_size : lineCount = encodedLines.size := rfl

theorem encoded_contains_CATE :
    encodedLines[0]? = some
      { number := 1, text := "# Concise American Technical English (CATE)" } := by
  native_decide

theorem first_line_in_array :
    encodedLines[0]? = some
      { number := 1, text := "# Concise American Technical English (CATE)" } :=
  encoded_contains_CATE

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_a1_heading : mentions "### A_1 `ABI`" = true := by
  native_decide

end Proofs_0005
