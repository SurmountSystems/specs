/-
  PROOFS for the sibling line encoding of `0010_Surmount_Systems.md`.

  This module is not the specification. It imports «0010_Surmount_Systems» and
  establishes identities of that encoding. Composition proofs live in
  Surmount.lean. Numbered markdown remains the contract humans read.
-/

import «0010_Surmount_Systems»
import FormalVibeficationSpec
import SpecRegistry

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0010

open «0010_Surmount_Systems»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 10 := rfl

theorem spec_file : specFileName = "0010_Surmount_Systems.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0010_Surmount_Systems.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0010" := rfl

theorem proof_module_distinct :
    proofModuleName ≠ siblingEncodingFileName := by
  decide

theorem agrees_registry :
    specNumber = SpecRegistry.surmountSystemsSpecNumber :=
  rfl

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

theorem encoded_size : encodedLines.size = 293 := by native_decide

theorem line_count : lineCount = 293 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? = some { number := 1, text := "# Surmount Systems" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_surmount_systems : mentions "Surmount Systems" = true := by
  native_decide

theorem mentions_surmount_lean : mentions "Surmount.lean" = true := by
  native_decide

theorem mentions_surmount_integrates : mentions "surmount_integrates" = true := by
  native_decide

end Proofs_0010
