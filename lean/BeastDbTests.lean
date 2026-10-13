/-
  Runtime checks for the beastdb meaning model (0003_beastdb.md).
  Theorems in BeastDbProofs.lean already fail to typecheck if the model is
  widened (wrong product capitalization as the name, SSSSS numbered 0003,
  traditional FFI permitted, schema optional). This executable re-checks
  the decidable facts so a silent `sorry` or a Bool regression prints FAIL
  lines, matching spec_check_tests style.
-/

import BeastDb
import BeastDbProofs
import SpecRegistry

open BeastDb
open SpecRegistry

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEmpty {α : Type} [Repr α] (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected empty, got {repr xs}" }

def expectNonEmpty {α : Type} (name : String) (xs : List α) : Case :=
  if xs.isEmpty then
    { name := name, ok := false, detail := "expected diagnostics, got none" }
  else
    { name := name, ok := true }

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

def runCases : List Case :=
  [
    expectEqString "product name is beastdb" productName "beastdb",
    expectEqString "library name is libbeastdb" libraryName "libbeastdb",
    expectEqNat "beastdb is specification 0003" specNumber 3,
    expectTrue "beastdb is not specification 0002" (specNumber != 2),
    expectTrue "beastdb is not specification 0004" (specNumber != 4),
    expectEqString "spec file is 0003_beastdb.md" specFileName "0003_beastdb.md",
    expectTrue "beastdb live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "beastdb live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectEqNat "Systems Lean is specification 0002" systemsLeanSpecNumber 2,
    expectEqNat "SSSSS is specification 0004" ssssSpecNumber 4,
    expectTrue "SSSSS is not specification 0003" (ssssSpecNumber != 3),
    expectEqNat "RSI is specification 0006" rsiSpecNumber 6,
    expectEqNat "CATE is specification 0005" cateSpecNumber 5,
    expectFalse "fargo is not assigned" fargoAssigned,
    expectFalse "Carbonado is not assigned" carbonadoAssigned,
    expectFalse "this spec does not claim an implementation exists"
      specClaimsImplementationExists,
    expectTrue "canonical language claim is ok" languageCanonical.ok,
    expectFalse "BeastDB as product name is not ok" languageWrongName.ok,
    expectFalse "LibBeastDB as library name is not ok" languageWrongLibrary.ok,
    expectFalse "subset only Slake typecheck is not ok"
      languageSubsetTypecheck.ok,
    expectFalse "missing Slake bootstrap is not ok" languageMissingBootstrap.ok,
    expectFalse "missing CompCert step is not ok" languageMissingCompCert.ok,
    expectFalse "garbage collection on the wire is not ok" languageGcWire.ok,
    expectTrue "canonical concurrency is ok" concurrencyCanonical.requiredOk,
    expectTrue "optional extra writers still satisfy required concurrency"
      concurrencyWithMultiWriter.requiredOk,
    expectFalse "more than one writer is not required for conformance"
      multiWriterRequiredForConformance,
    expectFalse "missing ACID is not ok" concurrencyNoAcid.requiredOk,
    expectFalse "locked trie is not ok" concurrencyLockedTrie.requiredOk,
    expectFalse "missing SWMR is not ok" concurrencyNoSwmr.requiredOk,
    expectFalse "missing fencing by generation is not ok"
      concurrencyNoFence.requiredOk,
    expectTrue "canonical ACID claim is ok" acidCanonical.ok,
    expectFalse "ACID missing isolation is not ok" acidMissingIsolation.ok,
    expectTrue "canonical trie progress is ok" trieProgressCanonical.ok,
    expectFalse "trie progress that waits on a mutex is not ok"
      trieProgressMutexDependent.ok,
    expectFalse "durable map that is not a trie is not ok"
      trieProgressNotTrie.ok,
    expectFalse "mutex dependent trie concurrency is not ok"
      concurrencyMutexDependentTrie.requiredOk,
    expectFalse "shared leaf writers are not ok"
      concurrencySharedLeaf.requiredOk,
    expectTrue "dense identifier kind is ok"
      (IdentifierKind.ok denseIdentifierFixture),
    expectFalse "unicode code point identifier kind is not ok"
      (IdentifierKind.ok unicodeCodePointPrimaryKeyFixture),
    expectTrue "persist dense LanguageID and WordID is ok"
      persistIdentityCanonical.ok,
    expectFalse "Unicode as primary key does not persist"
      persistIdentityUnicodePrimaryKey.ok,
    expectFalse "bounce buffer is not required for a mapped read"
      bounceBufferRequiredForMappedRead,
    expectTrue "canonical layout is ok" layoutCanonical.ok,
    expectFalse "missing mmap is not ok" layoutNoMmap.ok,
    expectFalse "bounce buffer required for mapped read is not ok"
      layoutBounceRequired.ok,
    expectEqNat "exactly two schema modes" SchemaMode.all.length 2,
    expectTrue "canonical schema is ok" schemaCanonical.ok,
    expectFalse "optional schema is not ok" schemaOptional.ok,
    expectFalse "one schema mode is not ok" schemaOneMode.ok,
    expectFalse "unproven migration is not ok" schemaUnprovenMigration.ok,
    expectTrue "fargo compatibility is permitted"
      (CompatibilityPath.permitted .fargo),
    expectFalse "traditional foreign function interface is not permitted"
      (CompatibilityPath.permitted .traditionalForeignFunctionInterface),
    expectTrue "canonical access is ok" accessCanonical.ok,
    expectFalse "traditional FFI access is not ok" accessTraditionalFfi.ok,
    expectTrue "canonical stack role is ok" stackRoleCanonical.ok,
    expectTrue "canonical scope for a store that is local first is ok" scopeCanonical.ok,
    expectFalse "network peering claim is not ok" scopeNetwork.ok,
    expectFalse "Carbonado is not in beastdb scope" carbonadoInScope,
    expectTrue "canonical product conforms" canonicalProduct.conforms,
    expectFalse "subset typecheck does not conform"
      productSubsetTypecheck.conforms,
    expectFalse "traditional FFI does not conform"
      productTraditionalFfi.conforms,
    expectFalse "schemaless product does not conform"
      productSchemaless.conforms,
    expectFalse "network claims do not conform" productNetwork.conforms,
    expectFalse "wrong product name does not conform"
      productWrongName.conforms,
    expectFalse "missing ACID does not conform" productNoAcid.conforms,
    expectTrue "optional extra writers still conform"
      productOptionalMultiWriter.conforms,
    expectFalse "missing isolation does not conform"
      productMissingIsolation.conforms,
    expectFalse "Unicode primary key does not conform"
      productUnicodePrimaryKey.conforms,
    expectFalse "shared leaf writers do not conform"
      productSharedLeaf.conforms,
    expectFalse "mutex dependent trie does not conform"
      productMutexDependentTrie.conforms,
    expectFalse "bounce buffer required for mapped read does not conform"
      productBounceRequired.conforms,
    expectFalse "proven ACID is not done" provenAcidDone,
    expectFalse "tries that do not use locks are not done" triesWithoutLocksDone,
    expectFalse "mmap is not done" mmapDone,
    expectFalse "schema proofs are not done" schemaProofsDone,
    expectFalse "fargo is not specified" fargoSpecified,
    expectConsFalse "marketing ACID is not proven ACID"
      marketingAcidIsProvenAcid
      mashMarketingAcidIsProvenAcid
      mashMarketingAcidIsProvenAcidIsFalse
      rfl
      mash_marketing_acid_is_proven_acid_is_false,
    expectConsFalse "a mutex trie is not accepted"
      mutexTrieAccepted
      mashMutexTrie
      mashMutexTrieIsFalse
      rfl
      mash_mutex_trie_is_false,
    expectConsFalse "a bounce buffer is not required for a mapped read"
      bounceBufferRequiredForMappedRead
      mashBounceBufferRequired
      mashBounceBufferRequiredIsFalse
      rfl
      mash_bounce_buffer_required_is_false,
    expectConsFalse "inferred schema is not a license to remain without a schema"
      inferredSchemaLeavesDataWithoutSchemaAccepted
      mashInferredSchemaLeavesDataWithoutSchema
      mashInferredSchemaLeavesDataWithoutSchemaIsFalse
      rfl
      mash_inferred_schema_leaves_data_without_schema_is_false,
    expectConsFalse "a traditional foreign function interface is not the interoperability path"
      traditionalFfiAsInteropPathAccepted
      mashTraditionalFfiAsInteropPath
      mashTraditionalFfiAsInteropPathIsFalse
      rfl
      mash_traditional_ffi_as_interop_path_is_false,
    expectConsFalse "claiming that beastdb never started is not accepted"
      beastdbNeverStartedAccepted
      mashBeastdbNeverStarted
      mashBeastdbNeverStartedIsFalse
      rfl
      mash_beastdb_never_started_is_false,
    expectConsFalse "claiming that beastdb is ready for use is not accepted"
      beastdbReadyForUseAccepted
      mashBeastdbReadyForUse
      mashBeastdbReadyForUseIsFalse
      rfl
      mash_beastdb_ready_for_use_is_false,
    -- Registry scan fixtures (stale numbers and wrong capitalization).
    expectNonEmpty "stale 0003_SSSSS token fails"
      (scanContent "0002_Systems_Lean.md"
        "planned file name `0003_SSSSS.md` is stale.\n"),
    expectEmpty "published 0004_SSSSS token passes"
      (scanContent "0002_Systems_Lean.md"
        "specified in `0004_SSSSS.md`.\n"),
    expectNonEmpty "stale 0003_systems_lean token fails"
      (scanContent "0003_beastdb.md" "see 0003_systems_lean.md for language.\n"),
    expectNonEmpty "beastdb as 0002 filename fails"
      (scanContent "0003_beastdb.md" "wrong file 0002_beastdb.md\n"),
    expectNonEmpty "beastdb as 0004 filename fails"
      (scanContent "0003_beastdb.md" "wrong file 0004_beastdb.md\n"),
    expectNonEmpty "unassigned 0006 filename token fails"
      (scanContent "0003_beastdb.md" "do not cite 0006_carbonado.md\n"),
    expectEmpty "correct 0003_beastdb token passes"
      (scanContent "0003_beastdb.md"
        "This specification is number 0003. File 0003_beastdb.md.\n"),
    expectNonEmpty "identity sentence with wrong number fails"
      (scanContent "0002_Systems_Lean.md"
        "This specification is number 0003.\n"),
    expectNonEmpty "BeastDB capitalization fails"
      (scanContent "0003_beastdb.md" "The product BeastDB is wrongly capped.\n"),
    expectNonEmpty "BEASTDB capitalization fails"
      (scanContent "0003_beastdb.md" "The product BEASTDB is wrongly capped.\n"),
    expectNonEmpty "Beastdb capitalization fails"
      (scanContent "0003_beastdb.md" "The product Beastdb is wrongly capped.\n"),
    expectNonEmpty "spaced Beast DB fails"
      (scanContent "0003_beastdb.md" "The product Beast DB is wrongly spaced.\n"),
    expectNonEmpty "LibBeastDB library name fails"
      (scanContent "0003_beastdb.md" "Do not name it LibBeastDB.\n"),
    expectEmpty "lowercase beastdb and libbeastdb pass"
      (scanContent "0003_beastdb.md"
        "The product beastdb ships as libbeastdb.\n"),
    expectNonEmpty "missing published 0003 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md"]),
    expectNonEmpty "wrong published 0003 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_SSSSS.md"]),
    expectEmpty "all published basenames pass"
      (findingsForBasenames publishedBasenames),
    expectNonEmpty "missing published 0005 basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md"]),
    expectNonEmpty "stale 0005_fargo basename fails"
      (findingsForBasenames
        ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
          "0003_beastdb.md", "0004_SSSSS.md", "0005_fargo.md"]),
    expectEmpty "planned list empty produces no presence findings"
      (findingsForPlannedPresent []),
    expectTrue "heading titled Residual is detected"
      (isResidualHeading "## 6. Residual"),
    expectTrue "heading Residual with following words is detected"
      (isResidualHeading "### 6.1 Residual honesty of this document"),
    expectFalse "ordinary heading is not Residual"
      (isResidualHeading "## 5. Conformance"),
    expectEmpty "0003 with no unpublished token needs no Residual heading"
      (scanPlannedResidual "0003_beastdb.md"
        "fargo has no assigned specification number.\n"),
    expectEmpty "0000 is exempt from planned residual heading"
      (scanPlannedResidual "0000_spec.md"
        "Number 0005 is Concise American Technical English.\n"),
    expectEmpty "0001 without planned tokens needs no Residual heading"
      (scanPlannedResidual "0001_DOGE.md"
        "This specification is number 0001.\n"),
    expectNonEmpty "stale 0005_fargo token in 0003 fails"
      (scanContent "0003_beastdb.md"
        "later planned file `0005_fargo.md`.\n"),
    expectEmpty "published 0006_RSI token in 0003 passes"
      (scanContent "0003_beastdb.md"
        "Recursive Self Improvement is specified in `0006_RSI.md`.\n"),
    expectNonEmpty "stale 0005_RSI token in 0003 fails"
      (scanContent "0003_beastdb.md"
        "Recursive Self Improvement is specified in `0005_RSI.md`.\n"),
    expectNonEmpty "stale 0006_CATE token in 0003 fails"
      (scanContent "0003_beastdb.md"
        "CATE is specified in `0006_CATE.md`.\n"),
    expectTrue "registry numbers are unique" (!hasDupNumbers),
    expectTrue "registry file names are unique" (!hasDupFilenames),
    expectTrue "this meaning model requires the science cycle"
      requiresScienceCycle,
    expectFalse "tests without a model do not conform"
      (conformingScience testsWithoutModelFixture),
    expectFalse "model and proofs without corollary experiments do not conform"
      (conformingScience modelAndProofsWithoutExperimentsFixture),
    expectTrue "complete science cycle conforms"
      (conformingScience completeScienceFixture),
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient,
    expectFalse "unicodeCodePointIsNotPrimaryKey"
      (IdentifierKind.ok unicodeCodePointPrimaryKeyFixture)
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  if failed == 0 then
    IO.println s!"All {runCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {runCases.length} tests failed."
    return 1
