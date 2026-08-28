/-
  PROOFS for the sibling line encoding of `0003_beastdb.md`.

  This module is not the specification. It imports «0003_beastdb» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0003_beastdb»
import FormalVibeficationSpec

namespace Proofs_0003

open «0003_beastdb»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 3 := rfl

theorem spec_file : specFileName = "0003_beastdb.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0003_beastdb.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0003" := rfl

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

theorem encoded_size : encodedLines.size = 307 := by
  native_decide

theorem line_count_is_307 : lineCount = 307 := by
  native_decide

theorem spec_file_contains_beastdb :
    specFileName = "0003_" ++ "beastdb" ++ ".md" :=
  rfl

theorem encoded_contains_beastdb :
    encodedLines[0]?.map (fun l => l.text) = some ("# " ++ "beastdb") := by
  native_decide

end Proofs_0003
