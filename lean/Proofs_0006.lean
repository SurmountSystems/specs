/-
  PROOFS for the sibling line encoding of `0006_RSI.md`.

  This module is not the specification. It imports «0006_RSI» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0006_RSI»
import FormalVibeficationSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0006

open «0006_RSI»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 6 := rfl

theorem spec_file : specFileName = "0006_RSI.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0006_RSI.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0006" := rfl

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

theorem mash_false : markedAsProof = false := rfl

theorem encoded_size : encodedLines.size = 386 := by native_decide

theorem line_count : lineCount = 386 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? = some { number := 1, text := "# Recursive Self Improvement" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_recursive_self_improvement :
    mentions "Recursive Self Improvement" = true := by
  native_decide

theorem contains_rsi : mentions "RSI" = true := by
  native_decide

end Proofs_0006
