/-
  PROOFS for the sibling line encoding of
  `0013_Lean_Machine.md`.

  This module is not the specification. It imports
  «0013_Lean_Machine» and establishes identities of that
  encoding. Meaning proofs live in LeanMachineProofs.lean. Numbered
  markdown remains the contract humans read.
-/

import «0013_Lean_Machine»
import FormalVibeficationSpec
import SpecRegistry

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0013

open «0013_Lean_Machine»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 13 := rfl

theorem spec_file : specFileName = "0013_Lean_Machine.md" :=
  rfl

theorem sibling_name :
    siblingEncodingFileName = "0013_Lean_Machine.lean" :=
  rfl

theorem proof_module_name : proofModuleName = "Proofs_0013" := rfl

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

theorem encoded_size : encodedLines.size = 303 := by native_decide

theorem line_count : lineCount = 303 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? =
      some { number := 1, text := "# Lean Machine" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_lean_machine : mentions "Lean Machine" = true := by
  native_decide

theorem mentions_legal_lean : mentions "Legal Lean" = true := by
  native_decide

theorem mentions_holy_lean : mentions "Holy Lean" = true := by
  native_decide

theorem mentions_systems_lean : mentions "Systems Lean" = true := by
  native_decide

theorem mentions_proofofkeags : mentions "proofofkeags.com" = true := by
  native_decide

theorem mentions_unlicense : mentions "0009_PDOSS.md" = true := by
  native_decide

theorem does_not_contain_must_not_worship :
    mentions "MUST NOT worship" = false := by
  native_decide

theorem mentions_not_a_conformance_conjunct :
    mentions "not a conformance conjunct" = true := by
  native_decide

end Proofs_0013
