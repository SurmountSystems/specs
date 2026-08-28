/-
  Shared vocabulary tags for RSI consistency proofs (0006_RSI.md Clause 3.25).

  Same English word, different trees. Distinct types so equating the wrong
  pair is a type error. This module is not the specification. It is not a
  paste of bootstrap stages from the product tree. It is not a security
  term map from another project.

  The following equalities do not typecheck (intentional):
    systemsLean = slake
    systemsLean = lakePackageId
    rsiMarkdown = rsiMeaning
    rsiMarkdown = specCheckBin
    remainingWork = systemsLeanResidual
    remainingWork = productResidualFree
    rsiMeaning = mlTraining
    omegaProse = omegaConstructor
    rsiId = cateId
-/

import Cate
import SpecRegistry
import SystemsLean

namespace Vocabulary

/-- This module is a spec encoding for collision tags, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-!
  1. Systems Lean (language) vs Slake (compiler) vs Lake package id.
  The package id is not a second language name.
-/

structure SystemsLeanLanguage where
  proseName : String
  deriving DecidableEq, Repr, BEq

structure SlakeCompiler where
  proseName : String
  deriving DecidableEq, Repr, BEq

structure LakePackageId where
  id : String
  deriving DecidableEq, Repr, BEq

def systemsLean : SystemsLeanLanguage := { proseName := "Systems Lean" }

def slake : SlakeCompiler := { proseName := "Slake" }

def lakePackageId : LakePackageId := { id := "SystemsLean" }

def lakePackageIdIsSecondLanguageName : Bool := false

/-!
  2. Spec markdown vs Lean meaning model vs spec_check form checker.
-/

structure SpecMarkdown where
  path : String
  deriving DecidableEq, Repr, BEq

structure MeaningModel where
  moduleName : String
  deriving DecidableEq, Repr, BEq

structure FormChecker where
  binaryName : String
  deriving DecidableEq, Repr, BEq

def rsiMarkdown : SpecMarkdown := { path := "0006_RSI.md" }

def rsiMeaning : MeaningModel := { moduleName := "Rsi" }

def specCheckBin : FormChecker := { binaryName := "spec_check" }

def meaningModelIsFormChecker : Bool := false

def specMarkdownIsMeaningModel : Bool := false

def specMarkdownIsFormChecker : Bool := false

def meaningProofsAreSecondFormChecker : Bool := false

/-!
  3. Remaining work on disk vs Systems Lean named freestanding blocker
  vs a product tree claim that a freestanding release has no managed
  Lean leftover.
-/

structure RemainingWorkOnDisk where
  completeSentencesOnDisk : Bool
  deriving DecidableEq, Repr, BEq

structure NamedFreestandingBlocker where
  blockerName : String
  deriving DecidableEq, Repr, BEq

structure ProductResidualFree where
  freestandingReleaseHasNoManagedLeanLeftover : Bool
  deriving DecidableEq, Repr, BEq

def remainingWork : RemainingWorkOnDisk :=
  { completeSentencesOnDisk := true }

def systemsLeanResidual : NamedFreestandingBlocker :=
  { blockerName := "managed Lean runtime" }

def productResidualFree : ProductResidualFree :=
  { freestandingReleaseHasNoManagedLeanLeftover := true }

def productResidualFreeClearsRemainingWork : Bool := false

def remainingWorkIsNamedFreestandingBlocker : Bool := false

def remainingWorkIsProductResidualFree : Bool := false

/-!
  4. Meaning model vs machine learning training run.
-/

structure MlTrainingRun where
  storedInThisRepo : Bool
  deriving DecidableEq, Repr, BEq

def mlTraining : MlTrainingRun := { storedInThisRepo := false }

def meaningModelIsMlTrainingRun : Bool := false

/-!
  5. Leftover unstack is CATE (0005). RSI does not replace it.
-/

def leftoverUnstackSpecNumber : Nat := 5

def rsiReplacesLeftoverUnstack : Bool := false

/-!
  6. Omega in prose is the ASCII word. Lean constructor is unrestricted.
-/

structure OmegaProse where
  word : String
  deriving DecidableEq, Repr, BEq

structure OmegaLeanConstructor where
  name : String
  deriving DecidableEq, Repr, BEq

def omegaProse : OmegaProse := { word := "omega" }

def omegaConstructor : OmegaLeanConstructor := { name := "unrestricted" }

def proseOfMultiplicity : SystemsLean.Multiplicity → String
  | .erased => "0"
  | .once => "1"
  | .unrestricted => "omega"

/-!
  7. Scripture is not a conformance item for Slake, beastdb, or SSSSS.
-/

structure ScriptureConformance (product : String) where
  required : Bool
  deriving DecidableEq, Repr, BEq

def scriptureFor (product : String) : ScriptureConformance product :=
  { required := false }

def scriptureSlake : ScriptureConformance "Slake" := scriptureFor "Slake"

def scriptureBeastdb : ScriptureConformance "beastdb" := scriptureFor "beastdb"

def scriptureSssss : ScriptureConformance "SSSSS" := scriptureFor "SSSSS"

/-!
  8. Independent streams with disjoint writes MUST be parallel.
-/

inductive DisjointStreamRun where
  | parallel
  | serial
  deriving DecidableEq, Repr, BEq

def DisjointStreamRun.conforming : DisjointStreamRun → Bool
  | .parallel => true
  | .serial => false

def serializingDisjointWritesConforms : Bool := false

def parallelDisjointWritesConforms : Bool := true

/-!
  9. Failing test then product edit conforms. Product then reshape does not.
-/

inductive ContractProofOrder where
  | failingTestThenProduct
  | productThenReshapeTest
  deriving DecidableEq, Repr, BEq

def ContractProofOrder.conforming : ContractProofOrder → Bool
  | .failingTestThenProduct => true
  | .productThenReshapeTest => false

def failingTestThenProductConforms : Bool := true

def productThenReshapeTestConforms : Bool := false

/-!
  10. CATE is 5. RSI is 6. Distinct SpecId types so rsiId = cateId
  does not typecheck.
-/

structure SpecId (n : Nat) where
  fileName : String
  deriving Repr

def cateId : SpecId 5 := { fileName := "0005_CATE.md" }

def rsiId : SpecId 6 := { fileName := "0006_RSI.md" }

end Vocabulary
