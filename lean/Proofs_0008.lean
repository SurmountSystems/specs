/-
  PROOFS for the sibling line encoding of `0008_Formal_Vibefication.md`.

  This module is not the specification. It imports Spec_0008 and
  establishes identities of that encoding. Meaning proofs of Formal
  Vibefication live in FormalVibeficationProofs.lean. Numbered markdown
  remains the contract humans read.
-/

import Spec_0008
import FormalVibeficationSpec
import SpecRegistry

namespace Proofs_0008

open Spec_0008

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 8 := rfl

theorem spec_file : specFileName = "0008_Formal_Vibefication.md" := rfl

theorem sibling_name : siblingEncodingFileName = "Spec_0008.lean" := rfl

theorem proof_module_name : proofModuleName = "Proofs_0008" := rfl

theorem proof_module_distinct :
    proofModuleName ≠ siblingEncodingFileName := by
  decide

theorem agrees_registry :
    specNumber = SpecRegistry.formalVibeficationSpecNumber :=
  rfl

theorem agrees_meaning_encoding :
    specNumber = FormalVibeficationSpec.specNumber :=
  rfl

theorem mash_hidden_split_is_false :
    FormalVibeficationSpec.hidesSplit
      { moduleName := siblingEncodingFileName
        containsSpecEncodings := markedAsSpecEncoding
        containsProofsOfThoseEncodings := markedAsProof
        markedAsSpecEncoding := markedAsSpecEncoding
        markedAsProof := markedAsProof } = false :=
  rfl

theorem mash_false : markedAsProof = false := rfl

theorem encoded_line_count : encodedLines.size = 303 := by
  native_decide

theorem contains_formal_vibefication :
    encodedLines.any (fun l =>
      (l.text.splitOn "Formal Vibefication").length != 1) = true := by
  native_decide

theorem backlink_proofofkeags_com_appears :
    encodedLines.any (fun l =>
      (l.text.splitOn "proofofkeags.com").length != 1) = true := by
  native_decide

end Proofs_0008
