/-
  PROOFS for the sibling line encoding of
  `0016_Hierarchical_Subagents.md`.

  This module is not the specification. It imports
  «0016_Hierarchical_Subagents» and establishes identities of that
  encoding. Meaning proofs live in HierarchicalSubagentsProofs.lean.
  Numbered markdown remains the contract humans read.
-/

import «0016_Hierarchical_Subagents»
import FormalVibeficationSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0016

open «0016_Hierarchical_Subagents»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 16 := rfl

theorem spec_file : specFileName = "0016_Hierarchical_Subagents.md" :=
  rfl

theorem sibling_name :
    siblingEncodingFileName = "0016_Hierarchical_Subagents.lean" :=
  rfl

theorem proof_module_name : proofModuleName = "Proofs_0016" := rfl

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

theorem encoded_size : encodedLines.size = 267 := by native_decide

theorem line_count : lineCount = 267 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? =
      some { number := 1, text := "# Hierarchical Subagents" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_hierarchical_subagents : mentions "Hierarchical Subagents" = true := by
  native_decide

theorem mentions_file : mentions "0016_Hierarchical_Subagents.md" = true := by
  native_decide

theorem mentions_grok_oss : mentions "grok-oss" = true := by
  native_decide

theorem mentions_rfc2119 : mentions "ref/rfc2119" = true := by
  native_decide

theorem mentions_semver : mentions "ref/semver" = true := by
  native_decide

theorem mentions_not_session_bus :
    mentions "Number 0016 is not the session bus" = true := by
  native_decide

theorem mentions_files_not_claimed_present :
    mentions "does not claim those files are already present" = true := by
  native_decide

theorem mentions_no_l4 : mentions "There SHALL be no `L4`" = true := by
  native_decide

theorem mentions_residual_heading : mentions "## 6. Residual" = true := by
  native_decide

theorem absent_phrase_stays_false :
    mentions "does not flip that flag" = false := by
  native_decide

end Proofs_0016
