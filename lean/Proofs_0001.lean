/-
  PROOFS for the sibling line encoding of `0001_DOGE.md`.

  This module is not the specification. It imports «0001_DOGE» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0001_DOGE»
import FormalVibeficationSpec

namespace Proofs_0001

open «0001_DOGE»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 1 := rfl

theorem spec_file : specFileName = "0001_DOGE.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0001_DOGE.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0001" := rfl

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

theorem encoded_size : encodedLines.size = 154 := by
  native_decide

theorem first_line_matches :
    line0001.text = "# Digital Octal Graphical Emissive (DOGE) Color Specification" ∧
      encodedLines[0]? = some line0001 :=
  And.intro rfl (by native_decide)

theorem doge_phrase_exists :
    line0030.text = "Digital Octal Graphical Emissive. The full name of this palette." ∧
      encodedLines[29]? = some line0030 :=
  And.intro rfl (by native_decide)

end Proofs_0001
