/-
  Aggregates sibling line-encoding proof modules so Lake builds them
  together. This file is not a specification and is not a mash of
  encodings with their proofs: encodings live in Spec_NNNN.lean at the
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
import Proofs_0010
import Spec_0000
import Spec_0001
import Spec_0002
import Spec_0003
import Spec_0004
import Spec_0005
import Spec_0006
import Spec_0007
import Spec_0008
import Spec_0010

namespace SpecProofs

/-- Touch proof theorems so this module fails to typecheck if a proof is mashed away. -/
theorem encodings_are_not_proofs :
    Spec_0000.markedAsProof = false ∧
      Spec_0001.markedAsProof = false ∧
      Spec_0002.markedAsProof = false ∧
      Spec_0003.markedAsProof = false ∧
      Spec_0004.markedAsProof = false ∧
      Spec_0005.markedAsProof = false ∧
      Spec_0006.markedAsProof = false ∧
      Spec_0007.markedAsProof = false ∧
      Spec_0008.markedAsProof = false ∧
      Spec_0010.markedAsProof = false :=
  And.intro Proofs_0000.encoding_is_not_proof.2
    (And.intro Proofs_0001.encoding_is_not_proof.2
      (And.intro Proofs_0002.encoding_is_not_proof.2
        (And.intro Proofs_0003.encoding_is_not_proof.2
          (And.intro Proofs_0004.encoding_is_not_proof.2
            (And.intro Proofs_0005.encoding_is_not_proof.2
              (And.intro Proofs_0006.encoding_is_not_proof.2
                (And.intro Proofs_0007.encoding_is_not_proof.2
                  (And.intro Proofs_0008.encoding_is_not_proof.2
                    Proofs_0010.encoding_is_not_proof.2))))))))

def encodingsNotMashed : Bool :=
  !Spec_0000.markedAsProof &&
    Spec_0000.markedAsSpecEncoding &&
    !Spec_0001.markedAsProof &&
    Spec_0001.markedAsSpecEncoding &&
    !Spec_0002.markedAsProof &&
    Spec_0002.markedAsSpecEncoding &&
    !Spec_0003.markedAsProof &&
    Spec_0003.markedAsSpecEncoding &&
    !Spec_0004.markedAsProof &&
    Spec_0004.markedAsSpecEncoding &&
    !Spec_0005.markedAsProof &&
    Spec_0005.markedAsSpecEncoding &&
    !Spec_0006.markedAsProof &&
    Spec_0006.markedAsSpecEncoding &&
    !Spec_0007.markedAsProof &&
    Spec_0007.markedAsSpecEncoding &&
    !Spec_0008.markedAsProof &&
    Spec_0008.markedAsSpecEncoding &&
    !Spec_0010.markedAsProof &&
    Spec_0010.markedAsSpecEncoding

theorem encodings_not_mashed : encodingsNotMashed = true := rfl

theorem ten_published_encodings :
    Spec_0000.specNumber = 0 ∧
      Spec_0001.specNumber = 1 ∧
      Spec_0002.specNumber = 2 ∧
      Spec_0003.specNumber = 3 ∧
      Spec_0004.specNumber = 4 ∧
      Spec_0005.specNumber = 5 ∧
      Spec_0006.specNumber = 6 ∧
      Spec_0007.specNumber = 7 ∧
      Spec_0008.specNumber = 8 ∧
      Spec_0010.specNumber = 10 :=
  And.intro Proofs_0000.spec_number
    (And.intro Proofs_0001.spec_number
      (And.intro Proofs_0002.spec_number
        (And.intro Proofs_0003.spec_number
          (And.intro Proofs_0004.spec_number
            (And.intro Proofs_0005.spec_number
              (And.intro Proofs_0006.spec_number
                (And.intro Proofs_0007.spec_number
                  (And.intro Proofs_0008.spec_number
                    Proofs_0010.spec_number))))))))

end SpecProofs
