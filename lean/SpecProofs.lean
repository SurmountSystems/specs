/-
  Aggregates sibling line-encoding proof modules so Lake builds them
  together. This file is not a specification and is not a mash of
  encodings with their proofs: encodings live in NNNN_descriptive.lean at the
  repository root.
-/

import Proofs_0000
import Proofs_0001
import Proofs_0002
import Proofs_0003
import Proofs_0004
import Proofs_0005
import Proofs_0006
import Proofs_0007
import Proofs_0008
import Proofs_0009
import Proofs_0010
import Proofs_0011
import Proofs_0012
import Proofs_0013
import Proofs_0014
import Proofs_0015
import Proofs_0016
import Proofs_0017
import «0000_spec»
import «0001_DOGE»
import «0002_Systems_Lean»
import «0003_beastdb»
import «0004_SSSSS»
import «0005_CATE»
import «0006_RSI»
import «0007_CI»
import «0008_Formal_Vibefication»
import «0009_PDOSS»
import «0010_Surmount_Systems»
import «0011_Surmount_Systems_Tech_Tree»
import «0012_Majestic_Memex»
import «0013_Lean_Machine»
import «0014_Anunnaki_Encoding»
import «0015_Session_Bus»
import «0016_Hierarchical_Subagents»
import «0017_Schedula»

namespace SpecProofs

/-- Touch proof theorems so this module fails to typecheck if a proof is mashed away. -/
theorem encodings_are_not_proofs :
    «0000_spec».markedAsProof = false ∧
      «0001_DOGE».markedAsProof = false ∧
      «0002_Systems_Lean».markedAsProof = false ∧
      «0003_beastdb».markedAsProof = false ∧
      «0004_SSSSS».markedAsProof = false ∧
      «0005_CATE».markedAsProof = false ∧
      «0006_RSI».markedAsProof = false ∧
      «0007_CI».markedAsProof = false ∧
      «0008_Formal_Vibefication».markedAsProof = false ∧
      «0009_PDOSS».markedAsProof = false ∧
      «0010_Surmount_Systems».markedAsProof = false ∧
      «0011_Surmount_Systems_Tech_Tree».markedAsProof = false ∧
      «0012_Majestic_Memex».markedAsProof = false ∧
      «0013_Lean_Machine».markedAsProof = false ∧
      «0014_Anunnaki_Encoding».markedAsProof = false ∧
      «0015_Session_Bus».markedAsProof = false ∧
      «0016_Hierarchical_Subagents».markedAsProof = false ∧
      «0017_Schedula».markedAsProof = false :=
  And.intro Proofs_0000.encoding_is_not_proof.2
    (And.intro Proofs_0001.encoding_is_not_proof.2
      (And.intro Proofs_0002.encoding_is_not_proof.2
        (And.intro Proofs_0003.encoding_is_not_proof.2
          (And.intro Proofs_0004.encoding_is_not_proof.2
            (And.intro Proofs_0005.encoding_is_not_proof.2
              (And.intro Proofs_0006.encoding_is_not_proof.2
                (And.intro Proofs_0007.encoding_is_not_proof.2
                  (And.intro Proofs_0008.encoding_is_not_proof.2
                    (And.intro Proofs_0009.encoding_is_not_proof.2
                      (And.intro Proofs_0010.encoding_is_not_proof.2
                        (And.intro Proofs_0011.encoding_is_not_proof.2
                          (And.intro Proofs_0012.encoding_is_not_proof.2
                            (And.intro Proofs_0013.encoding_is_not_proof.2
                              (And.intro Proofs_0014.encoding_is_not_proof.2
                                (And.intro Proofs_0015.encoding_is_not_proof.2
                                  (And.intro Proofs_0016.encoding_is_not_proof.2
                                    Proofs_0017.encoding_is_not_proof.2))))))))))))))))

def encodingsNotMashed : Bool :=
  !«0000_spec».markedAsProof &&
    «0000_spec».markedAsSpecEncoding &&
    !«0001_DOGE».markedAsProof &&
    «0001_DOGE».markedAsSpecEncoding &&
    !«0002_Systems_Lean».markedAsProof &&
    «0002_Systems_Lean».markedAsSpecEncoding &&
    !«0003_beastdb».markedAsProof &&
    «0003_beastdb».markedAsSpecEncoding &&
    !«0004_SSSSS».markedAsProof &&
    «0004_SSSSS».markedAsSpecEncoding &&
    !«0005_CATE».markedAsProof &&
    «0005_CATE».markedAsSpecEncoding &&
    !«0006_RSI».markedAsProof &&
    «0006_RSI».markedAsSpecEncoding &&
    !«0007_CI».markedAsProof &&
    «0007_CI».markedAsSpecEncoding &&
    !«0008_Formal_Vibefication».markedAsProof &&
    «0008_Formal_Vibefication».markedAsSpecEncoding &&
    !«0009_PDOSS».markedAsProof &&
    «0009_PDOSS».markedAsSpecEncoding &&
    !«0010_Surmount_Systems».markedAsProof &&
    «0010_Surmount_Systems».markedAsSpecEncoding &&
    !«0011_Surmount_Systems_Tech_Tree».markedAsProof &&
    «0011_Surmount_Systems_Tech_Tree».markedAsSpecEncoding &&
    !«0012_Majestic_Memex».markedAsProof &&
    «0012_Majestic_Memex».markedAsSpecEncoding &&
    !«0013_Lean_Machine».markedAsProof &&
    «0013_Lean_Machine».markedAsSpecEncoding &&
    !«0014_Anunnaki_Encoding».markedAsProof &&
    «0014_Anunnaki_Encoding».markedAsSpecEncoding &&
    !«0015_Session_Bus».markedAsProof &&
    «0015_Session_Bus».markedAsSpecEncoding &&
    !«0016_Hierarchical_Subagents».markedAsProof &&
    «0016_Hierarchical_Subagents».markedAsSpecEncoding &&
    !«0017_Schedula».markedAsProof &&
    «0017_Schedula».markedAsSpecEncoding

theorem encodings_not_mashed : encodingsNotMashed = true := rfl

theorem seventeen_published_encodings :
    «0000_spec».specNumber = 0 ∧
      «0001_DOGE».specNumber = 1 ∧
      «0002_Systems_Lean».specNumber = 2 ∧
      «0003_beastdb».specNumber = 3 ∧
      «0004_SSSSS».specNumber = 4 ∧
      «0005_CATE».specNumber = 5 ∧
      «0006_RSI».specNumber = 6 ∧
      «0007_CI».specNumber = 7 ∧
      «0008_Formal_Vibefication».specNumber = 8 ∧
      «0009_PDOSS».specNumber = 9 ∧
      «0010_Surmount_Systems».specNumber = 10 ∧
      «0011_Surmount_Systems_Tech_Tree».specNumber = 11 ∧
      «0012_Majestic_Memex».specNumber = 12 ∧
      «0013_Lean_Machine».specNumber = 13 ∧
      «0014_Anunnaki_Encoding».specNumber = 14 ∧
      «0015_Session_Bus».specNumber = 15 ∧
      «0016_Hierarchical_Subagents».specNumber = 16 :=
  And.intro Proofs_0000.spec_number
    (And.intro Proofs_0001.spec_number
      (And.intro Proofs_0002.spec_number
        (And.intro Proofs_0003.spec_number
          (And.intro Proofs_0004.spec_number
            (And.intro Proofs_0005.spec_number
              (And.intro Proofs_0006.spec_number
                (And.intro Proofs_0007.spec_number
                  (And.intro Proofs_0008.spec_number
                    (And.intro Proofs_0009.spec_number
                      (And.intro Proofs_0010.spec_number
                        (And.intro Proofs_0011.spec_number
                          (And.intro Proofs_0012.spec_number
                            (And.intro Proofs_0013.spec_number
                              (And.intro Proofs_0014.spec_number
                                (And.intro Proofs_0015.spec_number
                                  Proofs_0016.spec_number)))))))))))))))

/-- Eighteen published sibling encodings, specifications 0000 through 0017. -/
theorem eighteen_published_encodings :
    «0000_spec».specNumber = 0 ∧
      «0001_DOGE».specNumber = 1 ∧
      «0002_Systems_Lean».specNumber = 2 ∧
      «0003_beastdb».specNumber = 3 ∧
      «0004_SSSSS».specNumber = 4 ∧
      «0005_CATE».specNumber = 5 ∧
      «0006_RSI».specNumber = 6 ∧
      «0007_CI».specNumber = 7 ∧
      «0008_Formal_Vibefication».specNumber = 8 ∧
      «0009_PDOSS».specNumber = 9 ∧
      «0010_Surmount_Systems».specNumber = 10 ∧
      «0011_Surmount_Systems_Tech_Tree».specNumber = 11 ∧
      «0012_Majestic_Memex».specNumber = 12 ∧
      «0013_Lean_Machine».specNumber = 13 ∧
      «0014_Anunnaki_Encoding».specNumber = 14 ∧
      «0015_Session_Bus».specNumber = 15 ∧
      «0016_Hierarchical_Subagents».specNumber = 16 ∧
      «0017_Schedula».specNumber = 17 :=
  And.intro Proofs_0000.spec_number
    (And.intro Proofs_0001.spec_number
      (And.intro Proofs_0002.spec_number
        (And.intro Proofs_0003.spec_number
          (And.intro Proofs_0004.spec_number
            (And.intro Proofs_0005.spec_number
              (And.intro Proofs_0006.spec_number
                (And.intro Proofs_0007.spec_number
                  (And.intro Proofs_0008.spec_number
                    (And.intro Proofs_0009.spec_number
                      (And.intro Proofs_0010.spec_number
                        (And.intro Proofs_0011.spec_number
                          (And.intro Proofs_0012.spec_number
                            (And.intro Proofs_0013.spec_number
                              (And.intro Proofs_0014.spec_number
                                (And.intro Proofs_0015.spec_number
                                  (And.intro Proofs_0016.spec_number
                                    Proofs_0017.spec_number))))))))))))))))

end SpecProofs
