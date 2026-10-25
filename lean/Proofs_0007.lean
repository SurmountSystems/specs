/-
  PROOFS for the sibling line encoding of `0007_CI.md`.

  This module is not the specification. It imports «0007_CI» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0007_CI»
import FormalVibeficationSpec

namespace Proofs_0007

open «0007_CI»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 7 := rfl

theorem spec_file : specFileName = "0007_CI.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0007_CI.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0007" := rfl

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

theorem encoded_size : encodedLines.size = 272 := by
  native_decide

theorem line_count : lineCount = 272 := by
  native_decide

/-- Membership: some encoded line contains the phrase Continuous Integration. -/
def containsContinuousIntegration : Bool :=
  encodedLines.any fun l =>
    match l.text.splitOn "Continuous Integration" with
    | _ :: _ :: _ => true
    | _ => false

theorem contains_continuous_integration :
    containsContinuousIntegration = true := by
  native_decide

/-- Some encoded line names the major compilers on the reference side. -/
def containsMajorCompilers : Bool :=
  encodedLines.any fun l =>
    match l.text.splitOn "major compilers" with
    | _ :: _ :: _ => true
    | _ => false

theorem contains_major_compilers :
    containsMajorCompilers = true := by
  native_decide

theorem first_line_is_continuous_integration_title :
    encodedLines[0]? =
      some
        { number := 1
          text := "# Continuous Integration and stack consistency" } := by
  native_decide

end Proofs_0007
