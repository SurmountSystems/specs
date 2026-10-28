/-
  PROOFS for the sibling line encoding of
  `0015_Session_Bus.md`.

  This module is not the specification. It imports
  «0015_Session_Bus» and establishes identities of that
  encoding. Meaning proofs live in SessionBusProofs.lean. Numbered
  markdown remains the contract humans read.
-/

import «0015_Session_Bus»
import FormalVibeficationSpec

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Proofs_0015

open «0015_Session_Bus»

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 15 := rfl

theorem spec_file : specFileName = "0015_Session_Bus.md" :=
  rfl

theorem sibling_name :
    siblingEncodingFileName = "0015_Session_Bus.lean" :=
  rfl

theorem proof_module_name : proofModuleName = "Proofs_0015" := rfl

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

theorem encoded_size : encodedLines.size = 361 := by native_decide

theorem line_count : lineCount = 361 := by native_decide

theorem line_count_matches_array : lineCount = encodedLines.size := rfl

theorem first_line :
    encodedLines[0]? =
      some { number := 1, text := "# Session Bus" } := by
  native_decide

/-- True when some encoded line text contains `needle` as a contiguous substring. -/
def mentions (needle : String) : Bool :=
  encodedLines.any fun l => !((l.text.splitOn needle).length == 1)

theorem contains_session_bus : mentions "Session Bus" = true := by
  native_decide

theorem mentions_file : mentions "0015_Session_Bus.md" = true := by
  native_decide

theorem mentions_grok_oss : mentions "grok-oss" = true := by
  native_decide

theorem mentions_toon : mentions "TOON" = true := by
  native_decide

theorem mentions_rfc2119 : mentions "ref/rfc2119" = true := by
  native_decide

theorem mentions_semver : mentions "ref/semver" = true := by
  native_decide

theorem mentions_not_anunnaki_file :
    mentions "Anunnaki Encoding file at number 0015" = true := by
  native_decide

theorem mentions_published_file_flag :
    mentions "numberFifteenPublishedFileExists" = true := by
  native_decide

theorem residual_does_not_say_flag_stays_false :
    mentions "does not flip that flag" = false := by
  native_decide

theorem mentions_absent_yields_false :
    mentions "claiming the published file is absent yields False" = true := by
  native_decide

end Proofs_0015
