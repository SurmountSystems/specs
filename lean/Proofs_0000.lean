/-
  PROOFS for the sibling line encoding of `0000_spec.md`.

  This module is not the specification. It imports Spec_0000 and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import Spec_0000
import FormalVibeficationSpec
import MdLine

namespace Proofs_0000

open Spec_0000

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 0 := rfl

theorem spec_file : specFileName = "0000_spec.md" := rfl

theorem sibling_name : siblingEncodingFileName = "Spec_0000.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0000" := rfl

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

theorem encoded_line_count :
    encodedLines.size = 396 := by
  native_decide

theorem encoded_line_count_eq_lineCount :
    encodedLines.size = lineCount := by
  native_decide

theorem first_line_text :
    line0001.text = "# Surmount spec spec" :=
  rfl

theorem first_encoded_line_text :
    encodedLines[0]!.text = "# Surmount spec spec" := by
  native_decide

/-- True when a physical line mentions RFC 2119. -/
def mentionsRfc2119 (l : MdLine) : Bool :=
  (l.text.splitOn "RFC 2119").length != 1

theorem contains_rfc_2119 :
    encodedLines.any mentionsRfc2119 = true := by
  native_decide

end Proofs_0000
