/-
  PROOFS for the sibling line encoding of `0002_Systems_Lean.md`.

  This module is not the specification. It imports Spec_0002 and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import Spec_0002
import FormalVibeficationSpec

namespace Proofs_0002

open Spec_0002

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 2 := rfl

theorem spec_file : specFileName = "0002_Systems_Lean.md" := rfl

theorem sibling_name : siblingEncodingFileName = "Spec_0002.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0002" := rfl

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

theorem encoded_size : encodedLines.size = 199 := by native_decide

theorem line_count : lineCount = 199 := by native_decide

theorem first_line :
    (encodedLines[0]!).text = "# Systems Lean" := by native_decide

theorem first_line_number : (encodedLines[0]!).number = 1 := by native_decide

def mentions (needle : String) (l : MdLine) : Bool :=
  (l.text.splitOn needle).length > 1

theorem contains_slake_or_systems_lean :
    encodedLines.any (fun l => mentions "Slake" l || mentions "Systems Lean" l) = true := by
  native_decide

end Proofs_0002
