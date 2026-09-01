/-
  PROOFS for numbered specification 0004 SSSSS.

  This module is not the specification. It imports SssssSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import SssssSpec
import SystemsLean
import SpecRegistry

namespace Sssss

open SystemsLean

theorem spec_is_0004 : specNumber = 4 := rfl

theorem spec_file_is_0004_sssss : specFileName = "0004_SSSSS.md" := rfl

theorem product_name_is_sssss : productName = "SSSSS" := rfl

theorem systems_lean_is_0002 :
    SpecRegistry.systemsLeanSpecNumber = 2 :=
  SpecRegistry.systems_lean_is_0002

theorem beastdb_is_0003 :
    SpecRegistry.beastdbSpecNumber = 3 :=
  SpecRegistry.beastdb_is_0003

theorem ssss_is_not_0002 :
    SpecRegistry.ssssSpecNumber ≠ 2 :=
  SpecRegistry.ssss_is_not_spec_0002

theorem ssss_is_not_0003 :
    SpecRegistry.ssssSpecNumber ≠ 3 :=
  SpecRegistry.ssss_is_not_spec_0003

theorem rsi_is_0006 :
    SpecRegistry.rsiSpecNumber = 6 :=
  SpecRegistry.rsi_is_0006

theorem cate_is_0005 :
    SpecRegistry.cateSpecNumber = 5 :=
  SpecRegistry.cate_is_0005

theorem fargo_is_not_spec_0005 :
    SpecRegistry.fargoAssigned = false :=
  SpecRegistry.fargo_not_assigned

theorem carbonado_unassigned :
    SpecRegistry.carbonadoAssigned = false :=
  SpecRegistry.carbonado_not_assigned

/-- This specification does not claim a conforming implementation exists. -/
theorem no_implementation_claimed :
    specClaimsImplementationExists = false := rfl

/-- Clause 1.3: television canon is not a conformance item. -/
theorem cultural_marker_not_required :
    televisionCanonRequiredForConformance = false := rfl

/-- Lean Machine is numbered specification 0013. -/
theorem lean_machine_numbered :
    leanMachineHasNumberedSpec = true := rfl

theorem lean_machine_number_is_13 :
    leanMachineAssignedNumber = some 13 := rfl

/-- This specification does not require fargo. -/
theorem fargo_not_required : fargoRequiredByThisSpec = false := rfl

theorem sequential_identity_ok :
    IdentityKind.ok .sequentialInteger = true := rfl

theorem hash_as_primary_identity_not_ok :
    IdentityKind.ok .hashDigest = false := rfl

theorem language_id_is_64_bit : languageIdBitWidth = 64 := rfl

theorem word_id_is_64_bit : wordIdBitWidth = 64 := rfl

theorem language_capacity_is_2_pow_64 :
    languageIdCapacity = 2 ^ 64 := rfl

theorem word_capacity_is_2_pow_64 : wordIdCapacity = 2 ^ 64 := rfl

theorem combined_capacity :
    languageIdCapacity * wordIdCapacity = (2 ^ 64) * (2 ^ 64) := rfl

/-- Next unused WordID is sequential, not a hash of surface text. -/
theorem assign_word_id_sequential (n : Nat) :
    (assignWordId n).value = n := rfl

theorem exactly_three_provenance_tags : Provenance.all.length = 3 := rfl

theorem rosetta_sequential_ok :
    rosettaCanonical.identityOk .sequentialInteger = true := rfl

theorem rosetta_hash_identity_not_ok :
    rosettaCanonical.identityOk .hashDigest = false := rfl

theorem same_config_same_emit
    (c1 c2 : PipelineConfig) (source : List StreamToken)
    (target : LanguageId) (h : c1 = c2) :
    emit c1 source target = emit c2 source target := by
  subst h
  rfl

theorem emit_does_not_use_hash_identity :
    emitUsesHashIdentity = false := rfl

theorem neural_reduced_acceptable : neuralReduced.acceptable = true := by
  decide

theorem neural_not_reduced_not_acceptable :
    neuralNotReduced.acceptable = false := by
  decide

theorem lean_prove_neural_is_should_not_must :
    leanProveBeforeAuthoritativeRequiredForConformance = false := rfl

theorem nl_provisional_ok : nlProvisional.ok = true := by decide

theorem nl_proven_ok : nlProven.ok = true := by decide

theorem nl_high_confidence_ok : nlHighConfidence.ok = true := by decide

theorem nl_unmarked_not_ok : nlUnmarked.ok = false := by decide

theorem nl_optional :
    naturalLanguageRequiredForConformance = false := rfl

theorem systems_lean_file_correct :
    systemsLeanFileOk systemsLeanFileCorrect = true := rfl

theorem wrong_systems_lean_file_fails :
    systemsLeanFileOk "0003_systems_lean.md" = false := rfl

theorem durable_canonical_ok : durableCanonical.ok = true := by decide

theorem durable_wrong_store_not_ok : durableWrongStore.ok = false := by
  decide

theorem durable_wrong_file_not_ok : durableWrongFile.ok = false := by decide

theorem safety_canonical_ok : safetyCanonical.ok = true := by decide

theorem safety_gc_not_ok : safetyGc.ok = false := by decide

theorem safety_missing_compcert_not_ok :
    safetyMissingCompCert.ok = false := by
  decide

theorem safety_missing_bootstrap_not_ok :
    safetyMissingBootstrap.ok = false := by
  decide

theorem safety_subset_typecheck_not_ok :
    safetySubsetTypecheck.ok = false := by
  decide

theorem safety_residual_does_not_substitute :
    safetyResidualSubstitutes.ok = false := by
  decide

theorem representation_canonical_ok :
    representationCanonical.ok = true := by
  decide

theorem representation_hashed_not_ok :
    representationHashed.ok = false := by
  decide

theorem canonical_product_conforms :
    canonicalProduct.conforms = true := by decide

theorem hashing_primary_identity_does_not_conform :
    productHashed.conforms = false := by decide

theorem hashing_rosetta_identity_does_not_conform :
    productHashedRosetta.conforms = false := by decide

theorem wrong_systems_lean_file_does_not_conform :
    productWrongSystemsLeanFile.conforms = false := by decide

theorem unreduced_neural_does_not_conform :
    productUnreducedNeural.conforms = false := by decide

theorem unmarked_nl_does_not_conform :
    productUnmarkedNl.conforms = false := by decide

theorem provisional_nl_still_conforms :
    productProvisionalNl.conforms = true := by decide

theorem missing_compcert_does_not_conform :
    productMissingCompCert.conforms = false := by decide

theorem residual_substitute_does_not_conform :
    productResidualSubstitutes.conforms = false := by decide

theorem wrong_store_does_not_conform :
    productWrongStore.conforms = false := by decide

theorem canonical_integration_conforms :
    canonicalIntegration.conformingIntegration = true := by decide

theorem mash_claimed_integration_neural_while_symbolic_is_false :
    mashNeuralWhileSymbolicCan.conformingIntegration = false := by decide

theorem mash_claimed_neural_while_symbolic_can_is_false
    (h : mashNeuralWhileSymbolicCan.conformingIntegration = true) : False := by
  simp [mash_claimed_integration_neural_while_symbolic_is_false] at h

theorem claimed_integration_that_uses_neural_while_symbolic_can
    (c : IntegrationClaim)
    (hClaim : c.integrationClaimed = true)
    (hNeural : c.neuralUsedOnlyWhenSymbolicCannot = false)
    (hConf : c.conformingIntegration = true) : False := by
  simp [IntegrationClaim.conformingIntegration, hClaim, hNeural] at hConf

theorem translation_only_is_not_claimed_integration :
    translationOnlyNoHarness.conformingIntegration = false := by decide

theorem training_substitute_does_not_conform :
    integrationTrainingSubstitutes.conformingIntegration = false := by decide

theorem unreduced_tool_improvement_does_not_conform :
    integrationUnreducedToolImprovement.conformingIntegration = false := by
  decide

theorem symbolic_not_deterministic_does_not_conform :
    integrationSymbolicNotDeterministic.conformingIntegration = false := by
  decide

theorem mash_claimed_not_systems_lean_is_false :
    mashClaimedNeuralGatedNotSystemsLean.conformingIntegration = false := by
  decide

theorem mash_claimed_not_systems_lean_is_false_as_false
    (h : mashClaimedNeuralGatedNotSystemsLean.conformingIntegration = true) :
    False := by
  simp [mash_claimed_not_systems_lean_is_false] at h

theorem canonical_product_without_integration_claim_conforms :
    canonicalProduct.conforms = true := by decide

theorem product_claiming_mash_not_systems_lean_does_not_conform :
    productClaimedNotSystemsLean.conforms = false := by decide

theorem product_claiming_canonical_integration_conforms :
    productCanonicalIntegration.conforms = true := by decide

end Sssss
