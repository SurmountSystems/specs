/-
  PROOFS for numbered specification 0003 beastdb.

  This module is not the specification. It imports BeastDbSpec and
  establishes the propositions that module states.
  Numbered markdown remains the contract humans read.
-/

import BeastDbSpec
import SystemsLean
import SpecRegistry

namespace BeastDb

open SystemsLean

theorem product_name_is_lowercase : productName = "beastdb" := rfl

theorem product_name_has_no_capitals :
    (productName.toList.all fun c => !('A' ≤ c && c ≤ 'Z')) = true := by
  decide

theorem library_is_libbeastdb : libraryName = "libbeastdb" := rfl

theorem library_is_lib_plus_product :
    libraryName = "lib" ++ productName := rfl

theorem spec_is_0003 : specNumber = 3 := rfl

theorem spec_is_not_0002 : specNumber ≠ 2 := by decide

theorem spec_is_not_0004 : specNumber ≠ 4 := by decide

theorem spec_file_is_0003_beastdb : specFileName = "0003_beastdb.md" := rfl

theorem systems_lean_is_0002 :
    SpecRegistry.systemsLeanSpecNumber = 2 :=
  SpecRegistry.systems_lean_is_0002

theorem ssss_is_0004 :
    SpecRegistry.ssssSpecNumber = 4 :=
  SpecRegistry.ssss_is_0004

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

theorem language_canonical_ok : languageCanonical.ok = true := by decide

theorem language_wrong_name_not_ok : languageWrongName.ok = false := by decide

theorem language_wrong_library_not_ok : languageWrongLibrary.ok = false := by
  decide

theorem language_subset_typecheck_not_ok :
    languageSubsetTypecheck.ok = false := by
  decide

theorem language_missing_bootstrap_not_ok :
    languageMissingBootstrap.ok = false := by
  decide

theorem language_missing_compcert_not_ok :
    languageMissingCompCert.ok = false := by
  decide

theorem language_gc_wire_not_ok : languageGcWire.ok = false := by decide

theorem multi_writer_not_required :
    multiWriterRequiredForConformance = false := rfl

theorem concurrency_canonical_ok :
    concurrencyCanonical.requiredOk = true := by decide

theorem concurrency_with_optional_multi_writer_still_ok :
    concurrencyWithMultiWriter.requiredOk = true := by decide

theorem concurrency_optional_flag_ignored
    (c : ConcurrencyClaim) :
    ({ c with multiWriterDisjointLeaves := !c.multiWriterDisjointLeaves } :
        ConcurrencyClaim).requiredOk =
      c.requiredOk :=
  rfl

theorem concurrency_no_acid_not_ok : concurrencyNoAcid.requiredOk = false := by
  decide

theorem concurrency_locked_trie_not_ok :
    concurrencyLockedTrie.requiredOk = false := by
  decide

theorem concurrency_no_swmr_not_ok : concurrencyNoSwmr.requiredOk = false := by
  decide

theorem concurrency_no_fence_not_ok : concurrencyNoFence.requiredOk = false := by
  decide

theorem acid_canonical_ok : acidCanonical.ok = true := by decide

theorem acid_missing_isolation_not_ok : acidMissingIsolation.ok = false := by
  decide

theorem trie_progress_canonical_ok : trieProgressCanonical.ok = true := by decide

theorem trie_progress_mutex_dependent_not_ok :
    trieProgressMutexDependent.ok = false := by
  decide

theorem trie_progress_not_trie_not_ok : trieProgressNotTrie.ok = false := by
  decide

theorem concurrency_mutex_dependent_trie_not_ok :
    concurrencyMutexDependentTrie.requiredOk = false := by
  decide

theorem concurrency_shared_leaf_not_ok :
    concurrencySharedLeaf.requiredOk = false := by
  decide

theorem shared_leaf_writers_do_not_conform : sharedLeafWritersDoNotConform :=
  rfl

theorem identifier_kind_dense_ok : IdentifierKind.ok .dense = true := rfl

theorem identifier_kind_unicode_not_ok :
    IdentifierKind.ok .unicodeCodePoint = false := rfl

theorem dense_identifier_fixture_ok :
    IdentifierKind.ok denseIdentifierFixture = true := rfl

theorem unicode_code_point_is_not_primary_key :
    unicodeCodePointIsNotPrimaryKey :=
  rfl

theorem persist_identity_canonical_ok :
    persistIdentityCanonical.ok = true := by decide

theorem persist_identity_unicode_primary_key_not_ok :
    persistIdentityUnicodePrimaryKey.ok = false := by decide

theorem bounce_buffer_not_required_for_mapped_read :
    bounceBufferRequiredForMappedRead = false := rfl

theorem layout_canonical_ok : layoutCanonical.ok = true := by decide

theorem layout_no_mmap_not_ok : layoutNoMmap.ok = false := by decide

theorem layout_bounce_required_not_ok : layoutBounceRequired.ok = false := by
  decide

theorem SchemaMode.ofFin_toFin (m : SchemaMode) :
    SchemaMode.ofFin m.toFin = m := by
  cases m <;> rfl

theorem exactly_two_schema_modes : SchemaMode.all.length = 2 := rfl

theorem schema_canonical_ok : schemaCanonical.ok = true := by decide

theorem schema_optional_not_ok : schemaOptional.ok = false := by decide

theorem schema_one_mode_not_ok : schemaOneMode.ok = false := by decide

theorem schema_unproven_migration_not_ok :
    schemaUnprovenMigration.ok = false := by
  decide

theorem fargo_permitted :
    CompatibilityPath.permitted .fargo = true := rfl

theorem traditional_ffi_forbidden :
    CompatibilityPath.permitted .traditionalForeignFunctionInterface = false :=
  rfl

theorem access_canonical_ok : accessCanonical.ok = true := by decide

theorem access_traditional_ffi_not_ok :
    accessTraditionalFfi.ok = false := by decide

theorem access_no_vector_not_ok : accessNoVector.ok = false := by decide

theorem stack_role_canonical_ok : stackRoleCanonical.ok = true := by decide

theorem stack_role_not_required_not_ok :
    stackRoleNotRequired.ok = false := by decide

theorem scope_canonical_ok : scopeCanonical.ok = true := by decide

theorem scope_network_not_ok : scopeNetwork.ok = false := by decide

theorem scope_not_local_not_ok : scopeNotLocal.ok = false := by decide

theorem carbonado_out_of_scope : carbonadoInScope = false := rfl

theorem canonical_product_conforms :
    canonicalProduct.conforms = true := by decide

theorem subset_typecheck_does_not_conform :
    productSubsetTypecheck.conforms = false := by decide

theorem traditional_ffi_does_not_conform :
    productTraditionalFfi.conforms = false := by decide

theorem schemaless_does_not_conform :
    productSchemaless.conforms = false := by decide

theorem network_claims_do_not_conform :
    productNetwork.conforms = false := by decide

theorem wrong_name_does_not_conform :
    productWrongName.conforms = false := by decide

theorem no_acid_does_not_conform :
    productNoAcid.conforms = false := by decide

theorem optional_multi_writer_still_conforms :
    productOptionalMultiWriter.conforms = true := by decide

theorem missing_isolation_does_not_conform :
    productMissingIsolation.conforms = false := by decide

theorem unicode_primary_key_does_not_conform :
    productUnicodePrimaryKey.conforms = false := by decide

theorem shared_leaf_product_does_not_conform :
    productSharedLeaf.conforms = false := by decide

theorem mutex_dependent_trie_does_not_conform :
    productMutexDependentTrie.conforms = false := by decide

theorem bounce_required_does_not_conform :
    productBounceRequired.conforms = false := by decide

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem tests_without_model_does_not_conform :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

end BeastDb
