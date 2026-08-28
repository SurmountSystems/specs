/-
  PROOFS for the sibling line encoding of `0009_Unlicense.md`.

  This module is not the specification. It imports «0009_Unlicense» and
  establishes identities of that encoding. Meaning proofs of Unlicense
  live in UnlicenseProofs.lean. Numbered markdown remains the contract
  humans read.
-/

import «0009_Unlicense»
import UnlicenseSpec
import SpecRegistry

namespace Proofs_0009

open «0009_Unlicense»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 9 := rfl

theorem spec_file : specFileName = "0009_Unlicense.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0009_Unlicense.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0009" := rfl

theorem proof_module_distinct :
    proofModuleName ≠ siblingEncodingFileName := by
  decide

theorem agrees_registry :
    specNumber = SpecRegistry.unlicenseSpecNumber :=
  rfl

theorem agrees_meaning_encoding :
    specNumber = UnlicenseSpec.specNumber :=
  rfl

theorem mash_hidden_split_is_false :
    UnlicenseSpec.hidesSplit
      { moduleName := siblingEncodingFileName
        containsSpecEncodings := markedAsSpecEncoding
        containsProofsOfThoseEncodings := markedAsProof
        markedAsSpecEncoding := markedAsSpecEncoding
        markedAsProof := markedAsProof } = false :=
  rfl

theorem mash_false : markedAsProof = false := rfl

theorem encoded_line_count : encodedLines.size = 296 := by
  native_decide

theorem contains_unlicense :
    encodedLines.any (fun l =>
      (l.text.splitOn "Unlicense").length != 1) = true := by
  native_decide

theorem backlink_proofofkeags_com_appears :
    encodedLines.any (fun l =>
      (l.text.splitOn "proofofkeags.com").length != 1) = true := by
  native_decide

end Proofs_0009
