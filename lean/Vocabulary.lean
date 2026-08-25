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

theorem systems_lean_prose : systemsLean.proseName = "Systems Lean" := rfl

theorem slake_prose : slake.proseName = "Slake" := rfl

theorem lake_package_id : lakePackageId.id = "SystemsLean" := rfl

theorem systems_lean_prose_ne_slake :
    systemsLean.proseName ≠ slake.proseName := by
  decide

theorem lake_package_id_ne_language_prose :
    lakePackageId.id ≠ systemsLean.proseName := by
  decide

theorem lake_package_id_ne_slake :
    lakePackageId.id ≠ slake.proseName := by
  decide

theorem lake_package_id_is_not_second_language :
    lakePackageIdIsSecondLanguageName = false :=
  rfl

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

theorem rsi_markdown_path : rsiMarkdown.path = "0006_RSI.md" := rfl

theorem rsi_meaning_module : rsiMeaning.moduleName = "Rsi" := rfl

theorem spec_check_binary : specCheckBin.binaryName = "spec_check" := rfl

theorem meaning_model_is_not_form_checker :
    meaningModelIsFormChecker = false :=
  rfl

theorem spec_markdown_is_not_meaning_model :
    specMarkdownIsMeaningModel = false :=
  rfl

theorem spec_markdown_is_not_form_checker :
    specMarkdownIsFormChecker = false :=
  rfl

theorem meaning_proofs_are_not_second_form_checker :
    meaningProofsAreSecondFormChecker = false :=
  rfl

theorem markdown_path_ne_meaning_module :
    rsiMarkdown.path ≠ rsiMeaning.moduleName := by
  decide

theorem markdown_path_ne_form_checker :
    rsiMarkdown.path ≠ specCheckBin.binaryName := by
  decide

theorem meaning_module_ne_form_checker :
    rsiMeaning.moduleName ≠ specCheckBin.binaryName := by
  decide

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

theorem remaining_work_on_disk :
    remainingWork.completeSentencesOnDisk = true :=
  rfl

theorem systems_lean_residual_is_named_blocker :
    systemsLeanResidual.blockerName = "managed Lean runtime" :=
  rfl

theorem product_residual_free_is_release_claim :
    productResidualFree.freestandingReleaseHasNoManagedLeanLeftover = true :=
  rfl

theorem product_residual_free_does_not_clear_remaining_work :
    productResidualFreeClearsRemainingWork = false :=
  rfl

theorem remaining_work_is_not_freestanding_blocker :
    remainingWorkIsNamedFreestandingBlocker = false :=
  rfl

theorem remaining_work_is_not_product_residual_free :
    remainingWorkIsProductResidualFree = false :=
  rfl

/-!
  4. Meaning model vs machine learning training run.
-/

structure MlTrainingRun where
  storedInThisRepo : Bool
  deriving DecidableEq, Repr, BEq

def mlTraining : MlTrainingRun := { storedInThisRepo := false }

def meaningModelIsMlTrainingRun : Bool := false

theorem ml_training_not_stored_here : mlTraining.storedInThisRepo = false :=
  rfl

theorem meaning_model_is_not_ml_training :
    meaningModelIsMlTrainingRun = false :=
  rfl

/-!
  5. Leftover unstack is CATE (0005). RSI does not replace it.
-/

def leftoverUnstackSpecNumber : Nat := 5

def rsiReplacesLeftoverUnstack : Bool := false

theorem leftover_unstack_owned_by_cate :
    leftoverUnstackSpecNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem leftover_unstack_not_owned_by_rsi :
    leftoverUnstackSpecNumber ≠ SpecRegistry.rsiSpecNumber := by
  decide

theorem rsi_does_not_replace_leftover_unstack :
    rsiReplacesLeftoverUnstack = false :=
  rfl

theorem leftover_unstack_still_nonconforming :
    Cate.HyphenRepair.leftoverUnstack.conforming = false :=
  Cate.leftover_unstack_nonconforming

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

theorem omega_prose_is_ascii_word : omegaProse.word = "omega" := rfl

theorem omega_lean_constructor_is_unrestricted :
    omegaConstructor.name = "unrestricted" :=
  rfl

theorem omega_prose_ne_constructor_name :
    omegaProse.word ≠ omegaConstructor.name := by
  decide

theorem unrestricted_prose_is_omega :
    proseOfMultiplicity .unrestricted = omegaProse.word :=
  rfl

theorem unrestricted_is_systems_lean_omega :
    (SystemsLean.Multiplicity.unrestricted : SystemsLean.Multiplicity) =
      .unrestricted :=
  rfl

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

theorem scripture_not_required (product : String) :
    (scriptureFor product).required = false :=
  rfl

theorem scripture_not_required_for_slake : scriptureSlake.required = false :=
  rfl

theorem scripture_not_required_for_beastdb :
    scriptureBeastdb.required = false :=
  rfl

theorem scripture_not_required_for_sssss : scriptureSssss.required = false :=
  rfl

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

theorem parallel_disjoint_conforming :
    DisjointStreamRun.parallel.conforming = true :=
  rfl

theorem serial_disjoint_not_conforming :
    DisjointStreamRun.serial.conforming = false :=
  rfl

def serializingDisjointWritesConforms : Bool := false

def parallelDisjointWritesConforms : Bool := true

theorem serializing_disjoint_writes_does_not_conform :
    serializingDisjointWritesConforms = false :=
  rfl

theorem parallel_disjoint_writes_conform :
    parallelDisjointWritesConforms = true :=
  rfl

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

theorem failing_test_then_product_conforming :
    ContractProofOrder.failingTestThenProduct.conforming = true :=
  rfl

theorem product_then_reshape_test_not_conforming :
    ContractProofOrder.productThenReshapeTest.conforming = false :=
  rfl

def failingTestThenProductConforms : Bool := true

def productThenReshapeTestConforms : Bool := false

theorem failing_test_then_product_conforms :
    failingTestThenProductConforms = true :=
  rfl

theorem product_then_reshape_test_does_not_conform :
    productThenReshapeTestConforms = false :=
  rfl

/-!
  10. CATE is 5. RSI is 6. Distinct SpecId types so rsiId = cateId
  does not typecheck.
-/

structure SpecId (n : Nat) where
  fileName : String
  deriving Repr

def cateId : SpecId 5 := { fileName := "0005_CATE.md" }

def rsiId : SpecId 6 := { fileName := "0006_RSI.md" }

theorem rsi_id_file : rsiId.fileName = "0006_RSI.md" := rfl

theorem cate_id_file : cateId.fileName = "0005_CATE.md" := rfl

theorem rsi_spec_number_is_six : SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem cate_spec_number_is_five : SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem rsi_is_not_cate :
    SpecRegistry.rsiSpecNumber ≠ SpecRegistry.cateSpecNumber := by
  decide

end Vocabulary
