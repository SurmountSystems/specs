/-
  PROOFS for the sibling line encoding of `0002_Systems_Lean.md`.

  This module is not the specification. It imports «0002_Systems_Lean» and
  establishes identities of that encoding. Numbered markdown remains
  the contract humans read.
-/

import «0002_Systems_Lean»
import FormalVibeficationSpec

namespace Proofs_0002

open «0002_Systems_Lean»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 2 := rfl

theorem spec_file : specFileName = "0002_Systems_Lean.md" := rfl

theorem sibling_name : siblingEncodingFileName = "0002_Systems_Lean.lean" := rfl

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

theorem encoded_size : encodedLines.size = 634 := by native_decide

theorem line_count : lineCount = 634 := by native_decide

/-- Physical lines added for the evidence based supercompiler. One string per line. -/
def evidencePhysicalLines : List (Nat × String) :=
  [ (555, "\tThe supercompiler is evidence based and adapts to the machine it runs on.")
  , (556, "\tAn assumption is not kept before an experiment.")
  , (557, "\tThe order is build a model, test every model against evidence, then improve.")
  , (558, "\tRanking is local from the known hardware specification of that machine.")
  , (559, "\tThere is no separate numeric weight formula.")
  , (560, "\tA sample speedup remains evidence and is not the Systems Lean equivalence proof.")
  , (561, "\tFMA single rounding stays the reference.")
  , (562, "\tProved rules may be contributed to a peer to peer gossip network, timestamped on the Bitcoin timechain in a way similar to OpenTimeStamps and not OpenTimeStamps, and to a peer to peer git network of the Radicle kind that is not claimed to be Radicle.")
  , (563, "\tNo client is claimed running.")
  , (564, "\tThe exact timestamp format and the exact gossip protocol stay open.")
  , (565, "\tThe decompiler stays unnamed.")
  , (566, "\tThe opcode catalog stays not claimed done.")
  , (591, "91. The exact timestamp format stays open.")
  , (592, "92. The exact gossip protocol stays open.")
  ]

theorem evidence_physical_lines_match_encoding :
    evidencePhysicalLines.all (fun p =>
      (encodedLines[p.fst - 1]!).number == p.fst &&
        (encodedLines[p.fst - 1]!).text == p.snd) = true := by
  native_decide

theorem first_line :
    (encodedLines[0]!).text = "# Systems Lean" := by native_decide

theorem first_line_number : (encodedLines[0]!).number = 1 := by native_decide

def mentions (needle : String) (l : MdLine) : Bool :=
  (l.text.splitOn needle).length > 1

theorem contains_slake_or_systems_lean :
    encodedLines.any (fun l => mentions "Slake" l || mentions "Systems Lean" l) = true := by
  native_decide

theorem contains_major_compilers :
    encodedLines.any (fun l => mentions "major compilers" l) = true := by
  native_decide

theorem contains_four_compilers_do_not_satisfy_clause42_item6 :
    encodedLines.any (fun l =>
      mentions "`CompCertTSO`, gcc, LLVM, and `cc` do not satisfy that item" l) = true := by
  native_decide

end Proofs_0002
