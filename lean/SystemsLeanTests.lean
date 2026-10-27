/-
  Runtime checks for the Systems Lean meaning model (0002_Systems_Lean.md).
  Theorems in SystemsLeanProofs.lean already fail to typecheck if the model is
  widened (fourth multiplicity, GC allowed on the wire, SSSSS numbered 0002
  or 0003).
  This executable re-checks the decidable facts so a silent `sorry` or a
  Bool regression prints FAIL lines, matching spec_check_tests style.
-/

import SystemsLean
import SystemsLeanProofs
import «0002_Systems_Lean»

open SystemsLean

def encoded0002Haystack : String :=
  «0002_Systems_Lean».encodedLines.foldl (fun acc l => acc ++ l.text ++ "\n") ""

/-- Tests-only mash fixture: hosting from generated C does not satisfy bootstrap. -/
def mashSelfHostFromCSatisfiesBootstrapFixture : Bool :=
  selfHostFromGeneratedCSatisfiesTypecheck

/-- Elaboration of the mash theorem from Proofs. The type is the sibling line denial, not the boolean flag. -/
def mashSelfHostTheorem : generatedCSatisfiesBootstrapTypecheckAsCurrentFactIsFalse :=
  mash_self_host_from_c_satisfies_bootstrap_is_false

def readLiveCompCertRuleOptionalTheorem :
    readLiveCompCertRule clause39CompCertLine clause42Item6CompCertLine =
      some .optionalMetricNotClaimedDone :=
  read_live_compcert_rule_is_optional_metric_not_claimed_done

def historicalChangelogNotRequiredCoreStepTheorem :
    historicalReadsRequiredCoreStep historicalCompCertRequiredStepLine.text = false :=
  historical_changelog_line_does_not_read_required_core_step

def requiredCoreStepDiffersFromOptionalMetricTheorem :
    CompCertMetricReading.requiredCoreValidationStep ≠
      CompCertMetricReading.optionalMetricNotClaimedDone :=
  required_core_validation_step_is_not_optional_metric

def readLiveSlakeBootstrapNotClaimedDoneTheorem :
    readLiveSlakeBootstrap clause42Item7SlakeLine clause63SlakeBootstrapLine =
      some .notClaimedDone :=
  read_live_slake_bootstrap_is_not_claimed_done

/-- Elaboration of the rank 7 mash. The type is the sibling line denial, not the boolean flag. -/
def mashCompCertTsoSatisfiesClause42Item6Theorem :
    compCertTsoSatisfiesClause42Item6AsCurrentFactIsFalse :=
  mash_compcert_tso_satisfies_clause42_item6_is_false

def mashReferenceTargetSatisfiesClause42Item6Theorem :
    mashReferenceTargetSatisfiesClause42Item6IsFalse :=
  mash_reference_target_satisfies_clause42_item6_is_false

def compCertRefinesNotClaimedDoneTheorem :
    compCertRefinesClaimedDone = false :=
  compcert_refines_not_claimed_done

def mashCompCertRefinesClaimedDoneTheorem :
    compCertRefinesFinishedAsCurrentFactIsFalse :=
  mash_compcert_refines_claimed_done_is_false

/-- Elaboration of the rank 8 mash. The type is the sibling line denial, not the boolean flag. -/
def mashSafeKernelImpliesSafeCompCertTheorem :
    safeKernelImpliesSafeCompCertAsCurrentFactIsFalse :=
  mash_safe_kernel_implies_safe_compcert_is_false

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

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

def holdProof (name : String) (b : Bool) {P : Prop} (_proof : P) : Case :=
  expectTrue name b

def pageCowCopyBytesTheorem : pageCowCopyBytes = 4096 :=
  page_cow_copy_bytes

def pageCowLargerPagesTheorem :
    pageCowCopyBytes = 4096 ∧
      pageCowLargerHardwarePageAllowed = true ∧
      pageCowLargerPageIsSecondCopy = false :=
  page_cow_larger_hardware_page_for_one_client

def createsNumberedSafeCFileTheorem : createsNumberedSafeCFile = false :=
  creates_numbered_safe_c_file

def safeCNoSpecNumberAndNoFileTheorem :
    safeCIsOwnPublishedSpecNumber = false ∧
      number0015Assigned = false ∧
      createsNumberedSafeCFile = false :=
  safe_c_has_no_spec_number_and_no_numbered_file

def correspondsIsNamedTheorem : correspondsNamed = true :=
  corresponds_is_named

def toSafeCSampleNoneTheorem : toSafeC RustJudgment.sample = none :=
  to_safe_c_on_sample_is_none

def toRustSampleNoneTheorem : toRust SafeCJudgment.sample = none :=
  to_rust_on_sample_is_none

def blockUniqueWhenOwnerCountIsOneTheorem :
    ({ processId := 0, ownerCount := 1, loanCount := 3, interiorLoanCount := 2 :
        BlockInProcess }).isUnique = true :=
  block_unique_when_owner_count_is_one _ rfl

def loanIsNotAnOwnerTheorem :
    (({ processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 :
        BlockInProcess }).addLoans 4).ownerCount = 1 :=
  (loan_is_not_an_owner
    { processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 }
    4).1

def moveOwnerSourceDoesNotRemainTheorem :
    (moveOwnerFromUnique
      { processId := 4, ownerCount := 1, loanCount := 2, interiorLoanCount := 0 }
      5).1.ownerCount = 0 :=
  (move_owner_source_does_not_remain
    { processId := 4, ownerCount := 1, loanCount := 2, interiorLoanCount := 0 }
    5 rfl).2.1

def copyHandleOwnerWithoutProtocolRejectedTheorem :
    copyHandleOwnerAccepted false OwnerHandle.holds = false ∧
      copyHandleOwnerAccepted false OwnerHandle.holds =
        uniqueBlockCopyHandleWithoutProtocolAccepted :=
  ⟨copy_handle_owner_without_protocol_rejected.1,
    copy_handle_owner_without_protocol_rejected.2.1⟩

def ownerCountIsNotAHeaderFieldTheorem :
    ownerCountIsHeaderField = false ∧ uniqueBlockDefaultRcHeader = false :=
  ⟨owner_count_is_not_a_header_field.1, owner_count_is_not_a_header_field.2.2⟩

def freeRejectsWhenCountSaysAnotherOwnerTheorem :
    freeIsReject
      { processId := 0, ownerCount := 2, loanCount := 0, interiorLoanCount := 0 } =
      true :=
  free_rejects_when_count_says_another_owner _ (by decide)

def freeRejectsWhenInteriorLoanLiveTheorem :
    freeIsReject
      { processId := 0, ownerCount := 1, loanCount := 1, interiorLoanCount := 1 } =
      true :=
  free_rejects_when_interior_loan_live _ (by decide)

def freeTwoOwnersRejectedTheorem :
    freeIsReject
      { processId := 0, ownerCount := 2, loanCount := 0, interiorLoanCount := 0 } =
      true :=
  free_two_owners_rejected

def freeUniqueWithInteriorLoanRejectedTheorem :
    freeIsReject
      { processId := 0, ownerCount := 1, loanCount := 1, interiorLoanCount := 1 } =
      true :=
  free_unique_with_interior_loan_rejected

def freeUniqueWithoutInteriorLoanTheorem :
    freeIsReject
      { processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 } =
      false :=
  free_unique_block_without_interior_loan_not_rejected

def samplePairIsADataRaceTheorem :
    isDataRace plainRaceWrite plainRaceRead = true ∧
      safeMemNonAtomicDataRaceAccepted = false :=
  sample_pair_is_a_data_race

def dataRaceIsNotSafeThrTheorem :
    safeThrHoldsOnPair plainRaceWrite plainRaceRead = false :=
  (data_race_is_not_safe_thr plainRaceWrite plainRaceRead
    samplePairIsADataRaceTheorem.1).1

def sampleRaceIsNotSafeThrTheorem :
    safeThrHoldsOnPair plainRaceWrite plainRaceRead = false ∧
      safeThrAllowsDataRace = false :=
  sample_race_is_not_safe_thr

def dataRaceHasNoHappensBeforeEdgeTheorem :
    plainRaceWrite.happensBeforeEdge = false ∧
      plainRaceRead.happensBeforeEdge = false ∧
      dataRaceHasNoHappensBefore = true :=
  data_race_has_no_happens_before_edge plainRaceWrite plainRaceRead
    samplePairIsADataRaceTheorem.1

def happensBeforeEdgeBlocksTheorem :
    isDataRace { plainRaceWrite with happensBeforeEdge := true } plainRaceRead = false ∧
      dataRaceHasNoHappensBefore = true :=
  happens_before_edge_blocks_data_race
    { plainRaceWrite with happensBeforeEdge := true } plainRaceRead rfl

def otherHappensBeforeEdgeBlocksTheorem :
    isDataRace plainRaceWrite { plainRaceRead with happensBeforeEdge := true } = false ∧
      dataRaceHasNoHappensBefore = true :=
  other_happens_before_edge_blocks_data_race plainRaceWrite
    { plainRaceRead with happensBeforeEdge := true } rfl

def atomicCellEventIsNotDataRaceTheorem :
    isDataRace atomicCellWrite plainRaceRead = false :=
  atomic_cell_event_is_not_data_race atomicCellWrite plainRaceRead rfl

def atomicCellSampleIsNotADataRaceTheorem :
    isDataRace atomicCellWrite plainRaceRead = false :=
  atomic_cell_sample_is_not_a_data_race

def atomicProgramOrderDoesNotVerifyKernelTheorem :
    atomicCellProgramOrder earlierAtomicCell laterAtomicCell = true ∧
      programOrderProvesMainlineLinux = false ∧
      runningKernelVerified = false :=
  ⟨atomic_program_order_does_not_verify_kernel.1,
    atomic_program_order_does_not_verify_kernel.2.1,
    atomic_program_order_does_not_verify_kernel.2.2.2.1⟩

def officialCompCertDoesNotProveThreadsTheorem :
    officialCompCertProvesThreads = false ∧
      safeCompCertImpliesThreadProof = false ∧
      safeCompCertImpliesSafeKernel SafeCompCert.holds = SafeKernel.holds :=
  official_compcert_does_not_prove_threads .holds

def safeThrStaysOnTheSafeKernelSideTheorem :
    safeThrRequiredForSafeKernel = true ∧
      safeThrIsCompCertThreadProof = false ∧
      SafeKernelConjuncts.holds kernelMissingSafeThr = false :=
  ⟨safe_thr_stays_on_the_safe_kernel_side.1,
    safe_thr_stays_on_the_safe_kernel_side.2.1,
    safe_thr_stays_on_the_safe_kernel_side.2.2.2⟩

def lockFreeIsTheThreePartClaimTheorem :
    LockFreeOp.holds lockFreeSample = true ∧
      lockFreeMeansMutexAbsent = false ∧
      lockFreeMeansCompareAndSwap = false ∧
      lockFreeProofsClaimedDone = false :=
  ⟨lock_free_is_the_three_part_claim.1,
    lock_free_is_the_three_part_claim.2.1,
    lock_free_is_the_three_part_claim.2.2.1,
    lock_free_is_the_three_part_claim.2.2.2.2.2⟩

def waitFreeAndObstructionFreeAreNotLockFreeTheorem :
    WaitFreeOp.holds waitFreeSample = true ∧
      ObstructionFreeOp.holds obstructionFreeSample = true ∧
      LockFreeOp.holds lockFreeMissingSpec = false ∧
      lockFreeIsWaitFree = false ∧
      lockFreeIsObstructionFree = false :=
  wait_free_and_obstruction_free_are_not_lock_free

def lockFreeFreeWithoutReclamationTheorem :
    reclamationFreeAccepted freeNoReclamation = false ∧
      reclamationFreeAccepted freeNoReclamation =
        lockFreeFreeWithoutReclamationAccepted :=
  ⟨lock_free_free_without_reclamation_matches_fixture.1,
    lock_free_free_without_reclamation_matches_fixture.2.1⟩

def lockFreeFreeWithoutReclamationKeepsMashTheorem :
    mashLockFreeFreeWithoutReclamationIsFalse :=
  lock_free_free_without_reclamation_keeps_mash

def sampleRaceDerivesSafeMemMashTheorem :
    mashSafeMemNonAtomicDataRaceIsFalse :=
  sample_race_derives_safe_mem_mash

def channelMoveOwnerRemovesSenderTheorem :
    (moveOwnerChannel 1 0).senderOwnersAfter = 0 ∧
      (moveOwnerChannel 1 0).receiverOwnersAfter = 1 :=
  ⟨(channel_move_owner_removes_sender 0).1,
    (channel_move_owner_removes_sender 0).2.1⟩

def channelCopyBitsAddsNoOwnerTheorem :
    (copyBitsChannel 2 0).receiverOwnersAfter = 0 ∧
      (copyBitsChannel 2 0).senderOwnersAfter = 2 :=
  ⟨(channel_copy_bits_adds_no_owner 2 0).1,
    (channel_copy_bits_adds_no_owner 2 0).2.1⟩

def channelTrafficIsNotPosixForkTheorem :
    ForkJoin.holds oneProcessForkJoin = true ∧
      channelIsPosixFork = false ∧
      channelImplementationClaimed = false ∧
      posixForkIsForkJoin = false :=
  ⟨channel_traffic_is_not_posix_fork.1,
    channel_traffic_is_not_posix_fork.2.1,
    channel_traffic_is_not_posix_fork.2.2.2.1,
    channel_traffic_is_not_posix_fork.2.2.2.2.1⟩

def misalignedExplicitPackedRejectedTheorem :
    explicitPackedRejected misalignedExplicitPacked = true ∧
      explicitPackedRejected undocumentedExplicitPacked = true ∧
      autovectorizationIsSimdProof = false :=
  ⟨misaligned_explicit_packed_rejected.1,
    misaligned_explicit_packed_rejected.2.1,
    misaligned_explicit_packed_rejected.2.2.2⟩

def explicitPackedOpIsNotAtomicCellTheorem :
    alignedExplicitPacked.atomicLocation = false ∧
      explicitPackedIsAtomicCell = false :=
  ⟨explicit_packed_op_is_not_atomic_cell.1,
    explicit_packed_op_is_not_atomic_cell.2.1⟩

def explicitPackedIsNotAutomaticAndNotAtomicLocationTheorem :
    explicitPackedIsAutomatic = false ∧
      explicitPackedIsAtomicLocation = false ∧
      packedOpcodeCatalogClaimedDone = false :=
  ⟨explicit_packed_is_not_automatic_and_not_atomic_location.1,
    explicit_packed_is_not_automatic_and_not_atomic_location.2.1,
    explicit_packed_is_not_automatic_and_not_atomic_location.2.2.1⟩

def atomicProgramOrderIsNotLkmmProofTheorem :
    atomicProgramOrderProvesLkmm = false ∧
      programOrderProvesMainlineLinux = false ∧
      linuxKernelMemoryModelRequired = true :=
  ⟨atomic_program_order_is_not_lkmm_proof.2.1,
    atomic_program_order_is_not_lkmm_proof.2.2.1,
    atomic_program_order_is_not_lkmm_proof.2.2.2.1⟩

def explicitPackedKeepsAutovectorizationMashTheorem :
    mashAutovectorizationIsSimdProofIsFalse :=
  explicit_packed_keeps_autovectorization_mash

def cacheSecretViolationOnlyWhenSafeCtOnTheorem :
    cacheCarriesSecretRejected false true = false ∧
      cacheCarriesSecretRejected true true = true ∧
      safeCtOnByDefault = false :=
  ⟨cache_secret_violation_only_when_safe_ct_on.1,
    cache_secret_violation_only_when_safe_ct_on.2.1,
    cache_secret_violation_only_when_safe_ct_on.2.2.2.1⟩

def runCases : List Case :=
  [
    expectTrue "Systems Lean live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "Systems Lean live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectEqNat "exactly three multiplicities"
      Multiplicity.all.length 3,
    expectEqNat "erased maps to Fin 0" Multiplicity.erased.toFin.val 0,
    expectEqNat "once maps to Fin 1" Multiplicity.once.toFin.val 1,
    expectEqNat "unrestricted maps to Fin 2" Multiplicity.unrestricted.toFin.val 2,
    expectTrue "erased is not on the freestanding wire"
      (!Multiplicity.appearsInFreestandingProduct .erased),
    expectTrue "multiplicity 1 may appear on the wire"
      (Multiplicity.appearsInFreestandingProduct .once),
    expectTrue "multiplicity omega may appear on the wire"
      (Multiplicity.appearsInFreestandingProduct .unrestricted),
    expectEqNat "multiplicity 1 has two disciplines (linear or affine)"
      Multiplicity.onceDisciplines.length 2,
    expectTrue "linear maps to multiplicity 1"
      (ResourceTag.linear.multiplicity == .once),
    expectTrue "affine maps to multiplicity 1"
      (ResourceTag.affine.multiplicity == .once),
    expectTrue "erased used 0 times is ok" (ResourceTag.erased.usesOk 0),
    expectFalse "erased used 1 time is not ok" (ResourceTag.erased.usesOk 1),
    expectTrue "linear used 1 time is ok" (ResourceTag.linear.usesOk 1),
    expectFalse "linear used 0 times is not ok" (ResourceTag.linear.usesOk 0),
    expectFalse "linear used 2 times is not ok" (ResourceTag.linear.usesOk 2),
    expectTrue "affine used 0 times is ok" (ResourceTag.affine.usesOk 0),
    expectTrue "affine used 1 time is ok" (ResourceTag.affine.usesOk 1),
    expectFalse "affine used 2 times is not ok" (ResourceTag.affine.usesOk 2),
    expectTrue "unrestricted used 0 times is ok"
      (ResourceTag.unrestricted.usesOk 0),
    expectTrue "unrestricted used many times is ok"
      (ResourceTag.unrestricted.usesOk 7),
    expectTrue "clean freestanding wire is ok" cleanWire.ok,
    expectFalse "garbage collection on the wire is not ok" gcWire.ok,
    expectFalse "managed Lean runtime on the wire is not ok" managedRuntimeWire.ok,
    expectFalse "erased multiplicity on the wire is not ok" erasedOnWire.ok,
    expectTrue "primary emission is freestanding C"
      (EmissionTarget.primary == .freestandingC),
    expectFalse "LLVM IR is not required for conformance"
      llvmIrRequiredForConformance,
    expectTrue "canonical Slake is written in Systems Lean" slakeCanonical.conforming,
    expectFalse "Slake written in another language is not conforming"
      slakeOtherLanguage.conforming,
    expectTrue "optional LLVM IR path does not break Slake conforming"
      slakeWithLlvm.conforming,
    expectFalse "LLVM IR as primary emission is not conforming"
      slakePrimaryLlvm.conforming,
    expectTrue "fully freestanding needs no residual name"
      (residualHonesty true none),
    expectFalse "non freestanding without a named residual is dishonest"
      (residualHonesty false none),
    expectTrue "non freestanding with a named residual is honest"
      (residualHonesty false (some "managed Lean runtime leftover")),
    expectFalse "empty residual name is not honest"
      (residualHonesty false (some "")),
    expectTrue "clean wire with no residual satisfies Clause 5 item 2"
      (wireOrResidualHonesty cleanWire none),
    expectFalse "GC wire with no residual fails Clause 5 item 2"
      (wireOrResidualHonesty gcWire none),
    expectTrue "GC wire with a named residual satisfies Clause 5 item 2"
      (wireOrResidualHonesty gcWire (some "garbage collection")),
    expectEqNat "exactly three novel languages"
      ([NovelLanguage.idris2, .lean4IncludingSystemsLean, .pureNix] : List NovelLanguage).length
      3,
    expectFalse "shell scripts that float free of Nix are forbidden for novel product paths"
      (ProductPath.permitted .freeFloatingShell),
    expectTrue "Idris 2 is a permitted novel language"
      (ProductPath.permitted (.novel .idris2)),
    expectTrue "Lean 4 including Systems Lean is permitted"
      (ProductPath.permitted (.novel .lean4IncludingSystemsLean)),
    expectTrue "pure Nix is a permitted novel language"
      (ProductPath.permitted (.novel .pureNix)),
    expectFalse "a path list that includes shell is not permitted"
      (allPathsPermitted [.freeFloatingShell]),
    expectTrue "novel source uses the Unlicense" (hygiene .novel == .unlicense),
    expectTrue "upstream keeps its original license"
      (hygiene .upstream == .originalUpstream),
    expectTrue "honest hygiene claim is ok" hygieneOk.ok,
    expectFalse "novel source not Unlicensed fails hygiene"
      hygieneNovelNotUnlicense.ok,
    expectFalse "upstream relicensed fails hygiene"
      hygieneUpstreamRelicensed.ok,
    expectFalse "upstream not under ref/ fails hygiene"
      hygieneUpstreamNotUnderRef.ok,
    expectTrue "beastdb core claiming Clause 4.4 and targeting Slake is ok"
      (namedStackClaim .beastdbCore true).ok,
    expectTrue "Lean Machine claiming Clause 4.4 and targeting Slake is ok"
      (namedStackClaim .leanMachine true).ok,
    expectTrue "SSSSS components that are safety critical claiming Clause 4.4 and targeting Slake is ok"
      (namedStackClaim .ssssSafetyCritical true).ok,
    expectTrue "FixOS vision claiming Clause 4.4 and targeting Slake is ok"
      (namedStackClaim .fixOSVision true).ok,
    expectFalse "claiming Clause 4.4 without targeting Slake is not ok"
      (namedStackClaim .beastdbCore false).ok,
    expectTrue "not claiming Clause 4.4 may omit Slake targeting"
      ({ component := .beastdbCore
         claimsClause44 := false
         canTargetSlake := false } : NamedComponentClaim).ok,
    expectTrue "canonical product conforms to Clause 5"
      canonicalProduct.conforms,
    expectFalse "GC wire without a named residual does not conform"
      productGcSilent.conforms,
    expectTrue "GC wire with a named residual still conforms"
      productGcNamed.conforms,
    expectFalse "linear resource used twice does not conform"
      productLinearUsedTwice.conforms,
    expectFalse "erased resource used once does not conform"
      productErasedUsedOnce.conforms,
    expectFalse "affine resource used twice does not conform"
      productAffineUsedTwice.conforms,
    expectFalse "path with shell scripts that float free of Nix does not conform"
      productShellPath.conforms,
    expectFalse "novel source not Unlicensed does not conform"
      productBadHygiene.conforms,
    expectFalse "Clause 4.4 claim that cannot target Slake does not conform"
      productCannotTargetSlake.conforms,
    expectFalse "Slake not written in Systems Lean does not conform"
      productOtherLanguage.conforms,
    expectTrue "optional LLVM IR path still conforms"
      productWithOptionalLlvm.conforms,
    expectFalse "LLVM IR as primary emission does not conform"
      productPrimaryLlvm.conforms,
    expectTrue "canonical product tree ref/ directory names are ok"
      productRefLayoutCanonical.ok,
    expectFalse "wrong product tree ref/ directory names are not ok"
      productRefLayoutWrongIdris.ok,
    expectFalse "this specifications repository does not pin Lean 4"
      specsRepoPinsLean4,
    expectFalse "this specifications repository does not pin Idris 2"
      specsRepoPinsIdris2,
    expectFalse "this specifications repository does not pin CompCert"
      specsRepoPinsCompCert,
    expectFalse "this specifications repository does not pin Rust"
      specsRepoPinsRust,
    expectTrue "CompCert verified compilation performed is ok"
      compCertPerformed.ok,
    expectFalse "missing CompCert verified compilation is not ok"
      compCertMissing.ok,
    expectTrue "bootstrapped Slake that fully typechecks is ok"
      bootstrapTypecheckDone.ok,
    expectFalse "missing Slake bootstrap is not ok"
      bootstrapMissing.ok,
    expectFalse "subset only Slake typecheck is not ok"
      bootstrapSubsetOnly.ok,
    expectFalse "typecheck claim without bootstrap is not ok"
      typecheckWithoutBootstrap.ok,
    expectTrue "missing CompCert step still conforms"
      productMissingCompCert.conforms,
    expectFalse "missing Slake bootstrap typecheck does not conform"
      productMissingBootstrapTypecheck.conforms,
    expectFalse "subset only Slake typecheck does not conform"
      productSubsetTypecheck.conforms,
    expectFalse "typecheck without bootstrap does not conform"
      productTypecheckWithoutBootstrap.conforms,
    expectFalse "wrong product tree ref/ layout does not conform"
      productWrongRefLayout.conforms,
    expectTrue "named residual still satisfies Clause 5 item 2 when CompCert is missing"
      productNamedResidualMissingCompCert.item2,
    expectTrue "named residual with missing CompCert still conforms"
      productNamedResidualMissingCompCert.conforms,
    expectTrue "named residual still satisfies Clause 5 item 2 when bootstrap typecheck is missing"
      productNamedResidualMissingBootstrap.item2,
    expectFalse "named residual does not excuse a missing bootstrap typecheck"
      productNamedResidualMissingBootstrap.conforms,
    expectEqNat "this specification number is 0002" systemsLeanSpecNumber 2,
    expectEqNat "SSSSS is specification 0004" ssssSpecNumber 4,
    expectTrue "SSSSS is not specification 0002"
      (ssssSpecNumber != systemsLeanSpecNumber),
    expectTrue "SSSSS is not specification 0003"
      (ssssSpecNumber != 3),
    expectEqNat "beastdb is specification 0003" beastdbSpecNumber 3,
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
    expectTrue "required CompCert tool is ccomp"
      (requiredCompCertTool == "ccomp"),
    expectTrue "CompCert uses ccomp of the freestanding C emit"
      compCertUsesCcomp,
    expectTrue "performed CompCert step uses ccomp of freestanding C"
      compCertPerformed.usesCcompOfFreestandingC,
    expectFalse "gcc is not CompCert ccomp"
      compCertWrongTool.ok,
    expectFalse "ccomp of LLVM IR is not the required emit"
      compCertWrongEmit.ok,
    expectFalse "live CompCert verified compilation is not claimed done"
      compCertVerifiedCompilationClaimedDone,
    holdProof "live Clause 3.9 and Clause 4.2 item 6 read as the optional metric"
      (readLiveCompCertRule clause39CompCertLine clause42Item6CompCertLine ==
        some CompCertMetricReading.optionalMetricNotClaimedDone)
      readLiveCompCertRuleOptionalTheorem,
    holdProof "the withdrawn changelog line is not the required core step reading"
      (historicalReadsRequiredCoreStep historicalCompCertRequiredStepLine.text == false)
      historicalChangelogNotRequiredCoreStepTheorem,
    holdProof "the required core step reading is not the optional metric reading"
      (decide
        (CompCertMetricReading.requiredCoreValidationStep ≠
          CompCertMetricReading.optionalMetricNotClaimedDone))
      requiredCoreStepDiffersFromOptionalMetricTheorem,
    expectConsFalse "treating CompCertTSO satisfies Clause 4.2 item 6 as the current fact is false"
      compCertTsoCountedSatisfiesClause42Item6
      compCertTsoSatisfiesClause42Item6AsCurrentFact
      compCertTsoSatisfiesClause42Item6AsCurrentFactIsFalse
      rfl
      mashCompCertTsoSatisfiesClause42Item6Theorem,
    expectFalse "CompCertTSO as a reference target does not satisfy Clause 4.2 item 6"
      compCertTsoAsReferenceTargetSatisfiesClause42Item6,
    expectFalse "gcc as a reference target does not satisfy Clause 4.2 item 6"
      gccAsReferenceTargetSatisfiesClause42Item6,
    expectFalse "LLVM as a reference target does not satisfy Clause 4.2 item 6"
      llvmAsReferenceTargetSatisfiesClause42Item6,
    expectFalse "cc as a reference target does not satisfy Clause 4.2 item 6"
      ccAsReferenceTargetSatisfiesClause42Item6,
    expectConsFalse "a reference target does not satisfy Clause 4.2 item 6"
      referenceTargetSatisfiesClause42Item6
      mashReferenceTargetSatisfiesClause42Item6
      mashReferenceTargetSatisfiesClause42Item6IsFalse
      rfl
      mashReferenceTargetSatisfiesClause42Item6Theorem,
    expectTrue "conforming bootstrap typecheck includes theorems"
      bootstrapTypecheckIncludesTheorems,
    expectTrue "done bootstrap fixture includes theorems"
      bootstrapTypecheckDone.includesTheorems,
    expectFalse "bootstrap without theorems is not ok"
      bootstrapWithoutTheorems.ok,
    expectFalse "live Slake bootstrap typecheck is not claimed done"
      slakeBootstrapTypecheckClaimedDone,
    holdProof "live Clause 4.2 item 7 and Clause 6.3 read as not claimed done"
      (readLiveSlakeBootstrap clause42Item7SlakeLine clause63SlakeBootstrapLine ==
        some SlakeBootstrapLiveReading.notClaimedDone)
      readLiveSlakeBootstrapNotClaimedDoneTheorem,
    expectTrue "all Slake code must be typechecked"
      allSlakeCodeMustBeTypechecked,
    expectFalse "there is no exception for which Slake code is typechecked"
      slakeCodeTypecheckHasException,
    expectConsFalse "claiming FastC exempts Slake code from the typecheck is false"
      fastCExemptsSlakeCode
      mashFastCExemptsSlakeCode
      mashFastCExemptsSlakeCodeIsFalse
      rfl
      claimingFastCExemptsSlakeCodeYieldsFalse,
    expectConsFalse "claiming security priority exempts Slake code from the typecheck is false"
      securityPriorityExemptsSlakeCode
      mashSecurityPriorityExemptsSlakeCode
      mashSecurityPriorityExemptsSlakeCodeIsFalse
      rfl
      claimingSecurityPriorityExemptsSlakeCodeYieldsFalse,
    expectTrue "developers must run the typecheck"
      developerMustRunTypecheck,
    expectConsFalse "claiming a developer may skip the typecheck is false"
      developerMaySkipTypecheck
      mashDeveloperMaySkipTypecheck
      mashDeveloperMaySkipTypecheckIsFalse
      rfl
      claimingDeveloperMaySkipTypecheckYieldsFalse,
    expectTrue "agents must run the typecheck"
      agentMustRunTypecheck,
    expectConsFalse "claiming an agent may skip the typecheck is false"
      agentMaySkipTypecheck
      mashAgentMaySkipTypecheck
      mashAgentMaySkipTypecheckIsFalse
      rfl
      claimingAgentMaySkipTypecheckYieldsFalse,
    expectTrue "a user building finished code may skip running the typecheck"
      userBuildingFinishedCodeMaySkipRunningTypecheck,
    expectFalse "that skip does not exempt the Slake code"
      userSkipExemptsSlakeCode,
    expectConsFalse "treating the user skip as the typecheck being done is false"
      userSkipMeansTypecheckDone
      mashUserSkipMeansTypecheckDone
      mashUserSkipMeansTypecheckDoneIsFalse
      rfl
      claimingUserSkipMeansTypecheckDoneYieldsFalse,
    expectFalse "sharper tests for finished code, user, developer, and agent are not specified"
      sharperFinishedCodeUserDeveloperAgentTestsSpecified,
    expectFalse "FastC does not waive a missing bootstrap typecheck"
      productFastCMissingBootstrap.conforms,
    expectFalse "security priority does not waive a missing bootstrap typecheck"
      productSecurityMissingBootstrap.conforms,
    expectFalse "self host from generated C does not satisfy bootstrap typecheck"
      selfHostFromGeneratedCSatisfiesTypecheck,
    expectFalse "mash SelfHost From generated C satisfies bootstrap"
      mashSelfHostFromCSatisfiesBootstrapFixture,
    expectConsFalse "treating generated C as already satisfying the bootstrap typecheck is false"
      generatedCCountedSatisfiesBootstrap
      generatedCSatisfiesBootstrapTypecheckAsCurrentFact
      generatedCSatisfiesBootstrapTypecheckAsCurrentFactIsFalse
      rfl
      mashSelfHostTheorem,
    expectFalse "wrong CompCert tool does not conform"
      productWrongCompCertTool.conforms,
    expectFalse "wrong CompCert emit does not conform"
      productWrongCompCertEmit.conforms,
    expectFalse "bootstrap without theorems does not conform"
      productBootstrapWithoutTheorems.conforms,
    expectEqNat "RSI is specification 0006" rsiSpecNumber 6,
    expectFalse "RSI is not a compiler requirement of Systems Lean"
      rsiIsCompilerRequirement,
    expectEqNat "Lean Machine is specification 0013" leanMachineSpecNumber 13,
    expectEqString "Lean Machine file is 0013_Lean_Machine.md"
      leanMachineSpecFileName "0013_Lean_Machine.md",
    expectFalse "CompCert is not Unlicense" compCertIsUnlicense,
    expectFalse "spec_check is not a meaning spec encoding"
      specCheckIsMeaningSpecEncoding,
    expectTrue "byte identity of emit is required for a conforming product"
      byteIdentityRequiredForConformingProduct,
    expectFalse "byte identity of emit is not claimed true"
      byteIdentityOfEmitClaimedTrue,
    expectFalse "Systems Lean and Slake are not ready for use"
      systemsLeanAndSlakeReadyForUse,
    expectFalse "Systems Lean and Slake must not be read as never started"
      systemsLeanAndSlakeNeverStarted,
    expectFalse "agent skill packs must not live under product ref/"
      skillPacksUnderProductRef,
    expectTrue "pure Nix is required for novel packaging"
      pureNixRequiredForNovelPackaging,
    expectFalse "live claimed done flags must not equal the canonical fixture"
      liveClaimedDoneEqualsCanonicalFixture,
    expectTrue "live CompCert claimed done differs from canonical CompCert ok"
      (compCertVerifiedCompilationClaimedDone != canonicalProduct.compCert.ok),
    expectTrue "live bootstrap claimed done differs from canonical bootstrap ok"
      (slakeBootstrapTypecheckClaimedDone != canonicalProduct.bootstrapTypecheck.ok),
    expectFalse "SafeKernel does not imply SafeCompCert"
      safeKernelImpliesSafeCompCert,
    expectConsFalse "treating SafeKernel implies SafeCompCert as the current fact is false"
      (readLiveSafeKernelVersusSafeCompCert
          clause318SafeCompCertLine
          clause45Item1SafeCompCertImpliesKernelLine ==
        some SafeKernelVersusSafeCompCertReading.kernelImpliesCompCert)
      safeKernelImpliesSafeCompCertAsCurrentFact
      safeKernelImpliesSafeCompCertAsCurrentFactIsFalse
      rfl
      mashSafeKernelImpliesSafeCompCertTheorem,
    expectFalse "CompCertRefines is not claimed done"
      compCertRefinesClaimedDone,
    expectConsFalse "treating CompCert refinement of a real emit as finished is false"
      compCertRefinesCountedFinished
      compCertRefinesFinishedAsCurrentFact
      compCertRefinesFinishedAsCurrentFactIsFalse
      rfl
      mashCompCertRefinesClaimedDoneTheorem,
    expectFalse "UniqueBlock plus CopyHandle without protocol is not accepted"
      uniqueBlockCopyHandleWithoutProtocolAccepted,
    expectFalse "Secret plus ObjectCow is not accepted"
      secretObjectCowAccepted,
    expectFalse "Secret plus PageCow is not accepted"
      secretPageCowAccepted,
    expectFalse "CompCertFragment plus container_of is not accepted"
      compCertFragmentContainerOfAccepted,
    expectFalse "PanicFree plus a reachable unwrap is not accepted"
      panicFreeReachableUnwrapAccepted,
    expectConsFalse "CompCertFragment plus an inline assembly island is not accepted"
      compCertFragmentInlineAsmAccepted
      mashCompCertFragmentInlineAsm
      mashCompCertFragmentInlineAsmIsFalse
      rfl
      mash_compcert_fragment_inline_asm_is_false,
    expectConsFalse "A link face that exports UniqueBlock as bits is not accepted"
      linkFaceExportsUniqueBlockAsBitsAccepted
      mashLinkFaceExportsUniqueBlockAsBits
      mashLinkFaceExportsUniqueBlockAsBitsIsFalse
      rfl
      mash_link_face_exports_unique_block_as_bits_is_false,
    expectConsFalse "Language level omega on a heap OwnerHandle is not accepted"
      languageOmegaOnHeapOwnerAccepted
      mashLanguageOmegaOnHeapOwner
      mashLanguageOmegaOnHeapOwnerIsFalse
      rfl
      mash_language_omega_on_heap_owner_is_false,
    expectConsFalse "A unique only profile together with PosixFork is not accepted"
      uniqueOnlyPosixForkAccepted
      mashUniqueOnlyPosixFork
      mashUniqueOnlyPosixForkIsFalse
      rfl
      mash_unique_only_posix_fork_is_false,
    expectConsFalse "SafeMem plus a data race on a cell that is not atomic is not accepted"
      safeMemNonAtomicDataRaceAccepted
      mashSafeMemNonAtomicDataRace
      mashSafeMemNonAtomicDataRaceIsFalse
      rfl
      mash_safe_mem_non_atomic_data_race_is_false,
    expectConsFalse "LockFree that frees a node with no reclamation protocol is not accepted"
      lockFreeFreeWithoutReclamationAccepted
      mashLockFreeFreeWithoutReclamation
      mashLockFreeFreeWithoutReclamationIsFalse
      rfl
      mash_lock_free_free_without_reclamation_is_false,
    expectConsFalse "RwLock that holds many LoanShared and one LoanMut at once is not accepted"
      rwLockSharedAndExclusiveAccepted
      mashRwLockSharedAndExclusive
      mashRwLockSharedAndExclusiveIsFalse
      rfl
      mash_rw_lock_shared_and_exclusive_is_false,
    expectConsFalse "CopyHandle of a LockToken is not accepted"
      copyHandleLockTokenAccepted
      mashCopyHandleLockToken
      mashCopyHandleLockTokenIsFalse
      rfl
      mash_copy_handle_lock_token_is_false,
    expectConsFalse "Compare and swap on a UniqueBlock pointer is not accepted"
      casUniqueBlockPointerAccepted
      mashCasUniqueBlockPointer
      mashCasUniqueBlockPointerIsFalse
      rfl
      mash_cas_unique_block_pointer_is_false,
    expectConsFalse "Compare and swap on a cell that is not AtomicCell is not accepted"
      casNonAtomicCellAccepted
      mashCasNonAtomicCell
      mashCasNonAtomicCellIsFalse
      rfl
      mash_cas_non_atomic_cell_is_false,
    expectConsFalse "ThreadShared is not ProcessShared"
      threadSharedIsProcessShared
      mashThreadSharedIsProcessShared
      mashThreadSharedIsProcessSharedIsFalse
      rfl
      mash_thread_shared_is_process_shared_is_false,
    expectConsFalse "PosixFork is not ForkJoin"
      posixForkIsForkJoin
      mashPosixForkIsForkJoin
      mashPosixForkIsForkJoinIsFalse
      rfl
      mash_posix_fork_is_fork_join_is_false,
    expectConsFalse "PosixFork is not BorrowOrOwned"
      posixForkIsBorrowOrOwned
      mashPosixForkIsBorrowOrOwned
      mashPosixForkIsBorrowOrOwnedIsFalse
      rfl
      mash_posix_fork_is_borrow_or_owned_is_false,
    expectConsFalse "CopyHandle or CopyBits of Secret into a sink that is not Secret is not accepted"
      secretCopyIntoNonSecretAccepted
      mashSecretCopyIntoNonSecret
      mashSecretCopyIntoNonSecretIsFalse
      rfl
      mash_secret_copy_into_non_secret_is_false,
    expectConsFalse "PosixFork while a Secret with DontFork is live is not accepted"
      secretDontForkPosixForkAccepted
      mashSecretDontForkPosixFork
      mashSecretDontForkPosixForkIsFalse
      rfl
      mash_secret_dont_fork_posix_fork_is_false,
    expectConsFalse "Once does not imply UniqueBlock"
      onceImpliesUniqueBlock
      mashOnceImpliesUniqueBlock
      mashOnceImpliesUniqueBlockIsFalse
      rfl
      mash_once_implies_unique_block_is_false,
    expectConsFalse "The durability call list is not beastdb ACID"
      syscallDurabilityIsBeastdbAcid
      mashSyscallDurabilityIsBeastdbAcid
      mashSyscallDurabilityIsBeastdbAcidIsFalse
      rfl
      mash_syscall_durability_is_beastdb_acid_is_false,
    expectConsFalse "Cons on beastdb Props that do not attach is not accepted"
      beastdbPropsConsWithoutAttachAccepted
      mashBeastdbPropsConsWithoutAttach
      mashBeastdbPropsConsWithoutAttachIsFalse
      rfl
      mash_beastdb_props_cons_without_attach_is_false,
    expectConsFalse "TSX is not beastdb ACID"
      tsxIsBeastdbAcid
      mashTsxIsBeastdbAcid
      mashTsxIsBeastdbAcidIsFalse
      rfl
      mash_tsx_is_beastdb_acid_is_false,
    expectConsFalse "grok-oss is not SafeC"
      grokOssIsSafeC
      mashGrokOssIsSafeC
      mashGrokOssIsSafeCIsFalse
      rfl
      mash_grok_oss_is_safe_c_is_false,
    expectConsFalse "the page cache is not RCU"
      pageCacheIsRcu
      mashPageCacheIsRcu
      mashPageCacheIsRcuIsFalse
      rfl
      mash_page_cache_is_rcu_is_false,
    expectConsFalse "a crate that has completed only Gate A is not Safe"
      gateACrateIsSafe
      mashGateACrateIsSafe
      mashGateACrateIsSafeIsFalse
      rfl
      mash_gate_a_crate_is_safe_is_false,
    expectConsFalse "hardware tagging does not replace UniqueBlock"
      hardwareTagReplacesUniqueBlock
      mashHardwareTagReplacesUniqueBlock
      mashHardwareTagReplacesUniqueBlockIsFalse
      rfl
      mash_hardware_tag_replaces_unique_block_is_false,
    expectConsFalse "automatic vectorization is not a SIMD proof"
      autovectorizationIsSimdProof
      mashAutovectorizationIsSimdProof
      mashAutovectorizationIsSimdProofIsFalse
      rfl
      mash_autovectorization_is_simd_proof_is_false,
    expectConsFalse "a theorem named Perfect or ProvablyPerfect is not accepted"
      perfectTheoremNameAccepted
      mashPerfectTheoremName
      mashPerfectTheoremNameIsFalse
      rfl
      mash_perfect_theorem_name_is_false,
    expectConsFalse "a typed link input is not claimed proved"
      typedLinkInputClaimedProved
      mashTypedLinkInputClaimedProved
      mashTypedLinkInputClaimedProvedIsFalse
      rfl
      mash_typed_link_input_claimed_proved_is_false,
    expectConsFalse "Cons on every export is not claimed proved"
      consOnEveryExportClaimedProved
      mashConsOnEveryExportClaimedProved
      mashConsOnEveryExportClaimedProvedIsFalse
      rfl
      mash_cons_on_every_export_claimed_proved_is_false,
    expectConsFalse "the memcpy equation is not a present theorem"
      memcpyEquationPresentTheorem
      mashMemcpyEquationPresentTheorem
      mashMemcpyEquationPresentTheoremIsFalse
      rfl
      mash_memcpy_equation_present_theorem_is_false,
    expectConsFalse "AtomicCell, AtomicTxn, UsesLock, and LockHandled are not present theories"
      namedResidualIdentifiersPresentTheories
      mashNamedResidualIdentifiersPresentTheories
      mashNamedResidualIdentifiersPresentTheoriesIsFalse
      rfl
      mash_named_residual_identifiers_present_theories_is_false,
    expectTrue "TyperSound is named" typerSoundNamed,
    expectTrue "TyperSound implication is proved on the companion fragment"
      typerSoundImplicationProved,
    expectTrue "companion typer accepts CopyBits of Bits"
      (typerAccepts .copyBitsOfBits),
    expectTrue "companion typer accepts UniqueBlock MoveOwner"
      (typerAccepts .uniqueBlockMoveOwner),
    expectFalse "companion typer rejects UniqueBlock CopyHandle without protocol"
      (typerAccepts .uniqueBlockCopyHandleNoProtocol),
    expectFalse "companion typer rejects heap omega as owner"
      (typerAccepts .heapOmegaAsOwner),
    expectTrue "accepted CopyBits of Bits does not Step to Fault"
      (typerStep .copyBitsOfBits != .fault),
    expectTrue "accepted UniqueBlock MoveOwner does not Step to Fault"
      (typerStep .uniqueBlockMoveOwner != .fault),
    expectTrue "rejected CopyHandle without protocol would Fault under Step"
      (typerStep .uniqueBlockCopyHandleNoProtocol == .fault),
    expectTrue "rejected heap omega as owner would Fault under Step"
      (typerStep .heapOmegaAsOwner == .fault),
    expectTrue "PanicFree is named" panicFreeNamed,
    expectTrue "PanicFreeAOT is named" panicFreeAotNamed,
    expectTrue "PanicFreeAOT implication is claimed proved"
      panicFreeAotImplicationProved,
    expectTrue "typed path with PanicFree does not panic"
      (panicFreeHolds .typedPathNoPanic &&
        panicFreeExec .typedPathNoPanic != PanicOutcome.panic),
    expectFalse "reachable unwrap is not PanicFree"
      (panicFreeHolds .reachableUnwrap),
    expectTrue "reachable unwrap executes as panic"
      (panicFreeExec .reachableUnwrap == PanicOutcome.panic),
    expectTrue "allocation failure may still be PanicFree and is not a panic"
      (panicFreeHolds .allocationFailure &&
        panicFreeExec .allocationFailure != PanicOutcome.panic),
    expectTrue "hardware fault may still be PanicFree and is not a panic"
      (panicFreeHolds .hardwareFault &&
        panicFreeExec .hardwareFault != PanicOutcome.panic),
    expectFalse "PanicFree does not follow from SafeMem"
      panicFreeImpliesSafeMem,
    expectFalse "UniqueBlock has no default reference count header"
      uniqueBlockDefaultRcHeader,
    expectTrue "heap omega as owner is rejected"
      heapOmegaAsOwnerRejected,
    expectFalse "heap omega reject is not Bits Trivial"
      heapOmegaRejectCollapsedIntoBitsTrivial,
    expectFalse "fargo has no specification number"
      fargoHasSpecNumber,
    expectFalse "LLVM or cc path is not called CompCert proved"
      llvmCcPathCalledCompCertProved,
    expectTrue "Slake primary emit is freestanding C"
      slakePrimaryEmitIsFreestandingC,
    expectFalse "HostedLinuxLibc does not replace primary emit"
      hostedLinuxLibcReplacesPrimaryEmit,
    expectFalse "SafeCt is off by default"
      safeCtOnByDefault,
    expectFalse "SafeCt channels do not depend on Secret"
      safeCtChannelsDependOnSecret,
    expectFalse "failure to be constant time is not the SafeCt switch"
      notConstantTimeIsSafeCtSwitch,
    expectFalse "LockFree is not Mutex absent"
      lockFreeMeansMutexAbsent,
    expectFalse "LockFree is not compare and swap"
      lockFreeMeansCompareAndSwap,
    expectFalse "ACID is not compare and swap"
      acidIsCompareAndSwap,
    expectTrue "beastdb ACID is owned by specification 0003"
      beastdbAcidOwnedBySpec0003,
    expectTrue "PosixFork is PageCow"
      posixForkIsPageCow,
    expectEqNat "PageCow copy is one 4096 byte page" pageCowCopyBytes 4096,
    expectTrue "larger hardware page is allowed for one client"
      pageCowLargerHardwarePageAllowed,
    expectFalse "larger hardware page is not a second copy"
      pageCowLargerPageIsSecondCopy,
    expectFalse "iris-lean is not required" irisLeanRequired,
    expectFalse "canonical public GitHub organization is out of scope"
      canonicalPublicGitHubOrgInScope,
    expectFalse "a running kernel is not claimed verified" runningKernelVerified,
    expectTrue "freestanding ISO C is the emit standard"
      emitStandardIsFreestandingIsoC,
    expectTrue "one client is in scope" oneClientInScope,
    expectTrue "SeqLock is named" seqLockNamed,
    expectFalse "lock order is not claimed" lockOrderClaimed,
    expectFalse "Cons plus UbClass does not imply constant time"
      consAndUbClassImplyConstantTime,
    expectFalse "sleanify is not a shipped skill" sleanifySkillShipped,
    expectFalse "Lean Machine is not ready for use" leanMachineReadyForUse,
    expectTrue "the Phase 0 pair is LockToken and AffineUnlock"
      phase0PairIsLockTokenAndAffineUnlock,
    expectTrue "ordinary Systems Lean follows the shape of Rust"
      systemsLeanFollowsShapeOfRust,
    expectTrue "make_mut denotes ObjectCow" makeMutDenotesObjectCow,
    expectTrue "UniqueBlock requires every page unique"
      uniqueBlockRequiresEveryPageUnique,
    expectTrue "a reachable panic is Reject" reachablePanicIsReject,
    expectTrue "clients must not observe leaked exclusion"
      clientsMustNotObserveLeakedExclusion,
    expectFalse "the package InconsistencyReport module is not created here"
      inconsistencyReportPackageModuleCreatedHere,
    expectFalse "PosixFork is not ObjectCow"
      posixForkIsObjectCow,
    expectTrue "correspondence is required before isomorphism"
      correspondenceRequiredBeforeIsomorphism,
    expectEqNat "sampled v28 silence token count stays 16"
      v28SilenceTokens.length v28SilenceTokenCount,
    expectTrue "sampled v28 silence tokens appear in 0002"
      (v28SilenceTokensNamedIn encoded0002Haystack),
    expectEqNat "remaining v28 silence token count stays 9"
      v28RemainingSilenceTokens.length v28RemainingSilenceTokenCount,
    expectTrue "remaining v28 silence tokens appear in 0002"
      (v28RemainingSilenceTokensNamedIn encoded0002Haystack),
    expectEqNat "Fargo gates A through F are six constructors"
      (FargoGate.toFin FargoGate.f).val.succ 6,
    expectTrue "correspondence maps are statements"
      correspondenceMapsAreStatements,
    expectTrue "Corresponds is named" correspondsNamed,
    expectTrue "fromC is named" fromCNamed,
    expectFalse "toSafeC on the sample judgment is still none"
      (toSafeC RustJudgment.sample).isSome,
    expectFalse "toRust on the sample judgment is still none"
      (toRust SafeCJudgment.sample).isSome,
    expectConsFalse "a theorem named Isomorphism is not accepted"
      isomorphismTheoremNameAccepted
      mashIsomorphismTheoremName
      mashIsomorphismTheoremNameIsFalse
      rfl
      mash_isomorphism_theorem_name_is_false,
    expectEqNat "named C UbClass constructors are sixteen"
      (UbClass.toFin UbClass.reallocOldPointer).val.succ 16,
    expectFalse "the product UbClass Fault table is not complete"
      ubClassProductTableComplete,
    expectConsFalse "a pin does not survive PosixFork"
      pinSurvivesPosixFork
      mashPinSurvivesPosixFork
      mashPinSurvivesPosixForkIsFalse
      rfl
      mash_pin_survives_posix_fork_is_false,
    expectConsFalse "glibc malloc is not UniqueBlock against untyped C"
      glibcMallocIsUniqueBlockUntyped
      mashGlibcMallocUntypedUniqueBlock
      mashGlibcMallocUntypedUniqueBlockIsFalse
      rfl
      mash_glibc_malloc_untyped_unique_block_is_false,
    expectConsFalse "a file that lacks a Mutex is not LockFree"
      mutexFreeFileIsLockFree
      mashMutexFreeFileIsLockFree
      mashMutexFreeFileIsLockFreeIsFalse
      rfl
      mash_mutex_free_file_is_lock_free_is_false,
    expectEqNat "Reject fixtures are twenty three"
      rejectFixtureCount 23,
    expectFalse "the SafeC lake package is not shipped in this repository"
      safeCLakePackageShippedInThisRepo,
    expectFalse "number 0015 is not assigned"
      number0015Assigned,
    expectFalse "this document does not create a numbered SafeC file"
      createsNumberedSafeCFile,
    expectConsFalse "holy lean safec lean machine mash is false"
      holyLeanSafeCLeanMachineOneModule
      mashHolyLeanSafeCLeanMachine
      mashHolyLeanSafeCLeanMachineIsFalse
      rfl
      mash_holy_lean_safec_lean_machine_is_false,
    expectTrue "UniqueBlock means the owner count in that process is one"
      ({ processId := 0, ownerCount := 1, loanCount := 3, interiorLoanCount := 2 :
          BlockInProcess }).isUnique,
    expectTrue "a loan is not an owner"
      ((({ processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 :
          BlockInProcess }).addLoans 4).ownerCount == 1),
    expectTrue "MoveOwner leaves the source with no owner"
      ((moveOwnerFromUnique
        { processId := 4, ownerCount := 1, loanCount := 2, interiorLoanCount := 0 }
        5).1.ownerCount == 0),
    expectFalse "CopyHandle of an OwnerHandle with no alias protocol is Reject"
      (copyHandleOwnerAccepted false OwnerHandle.holds),
    expectFalse "the owner count is not a header field"
      ownerCountIsHeaderField,
    expectTrue "free while another owner remains is Reject"
      (freeIsReject
        { processId := 0, ownerCount := 2, loanCount := 0, interiorLoanCount := 0 }),
    expectTrue "free while an interior loan is live is Reject"
      (freeIsReject
        { processId := 0, ownerCount := 1, loanCount := 1, interiorLoanCount := 1 }),
    expectFalse "free of a unique block with no interior loan is not that Reject"
      (freeIsReject
        { processId := 0, ownerCount := 1, loanCount := 0, interiorLoanCount := 0 }),
    expectFalse "a data race on a location that is not atomic is not SafeThr"
      (safeThrHoldsOnPair plainRaceWrite plainRaceRead),
    expectTrue "a data race has no happens before edge"
      dataRaceHasNoHappensBefore,
    expectFalse "an AtomicCell event is not that data race"
      (isDataRace atomicCellWrite plainRaceRead),
    expectTrue "atomic operations on AtomicCell follow program order"
      (atomicCellProgramOrder earlierAtomicCell laterAtomicCell),
    expectFalse "program order does not prove mainline Linux"
      programOrderProvesMainlineLinux,
    expectFalse "program order on AtomicCell is not a proof of the Linux kernel memory model"
      atomicProgramOrderProvesLkmm,
    expectFalse "official CompCert does not prove threads"
      officialCompCertProvesThreads,
    expectFalse "SafeCompCert does not imply a thread proof"
      safeCompCertImpliesThreadProof,
    expectFalse "SafeKernel does not hold when SafeThr is absent"
      (SafeKernelConjuncts.holds kernelMissingSafeThr),
    expectFalse "SafeThr is not a CompCert thread proof"
      safeThrIsCompCertThreadProof,
    expectTrue "LockFree matches a sequential specification under a named sharing mode"
      (LockFreeOp.holds lockFreeSample),
    expectFalse "LockFree is not wait free"
      lockFreeIsWaitFree,
    expectFalse "LockFree is not obstruction free"
      lockFreeIsObstructionFree,
    expectFalse "LockFree proofs are not claimed done"
      lockFreeProofsClaimedDone,
    expectTrue "wait free finishes in a bounded number of its own steps"
      (WaitFreeOp.holds waitFreeSample),
    expectTrue "obstruction free finishes if it runs alone"
      (ObstructionFreeOp.holds obstructionFreeSample),
    expectFalse "a free with no reclamation protocol is not LockFree"
      (reclamationFreeAccepted freeNoReclamation),
    expectTrue "channel MoveOwner removes the sender and adds the receiver"
      ((moveOwnerChannel 1 0).senderOwnersAfter == 0 &&
        (moveOwnerChannel 1 0).receiverOwnersAfter == 1),
    expectTrue "channel CopyBits does not add an owner"
      ((copyBitsChannel 2 0).receiverOwnersAfter ==
        (copyBitsChannel 2 0).receiverOwnersBefore),
    expectFalse "that channel is not PosixFork"
      channelIsPosixFork,
    expectFalse "a channel implementation is not claimed"
      channelImplementationClaimed,
    expectTrue "a misaligned explicit packed operation is Reject"
      (explicitPackedRejected misalignedExplicitPacked),
    expectFalse "an explicit packed operation is not AtomicCell"
      explicitPackedIsAtomicCell,
    expectFalse "an explicit packed operation is not an automatic packed vector operation"
      explicitPackedIsAutomatic,
    expectFalse "an explicit packed operation is not an atomic location"
      explicitPackedIsAtomicLocation,
    expectFalse "a full opcode catalog is not claimed done"
      packedOpcodeCatalogClaimedDone,
    expectFalse "cache behavior that carries Secret is not Reject when SafeCt is off"
      (cacheCarriesSecretRejected false true),
    expectTrue "cache behavior that carries Secret is Reject when SafeCt is on"
      (cacheCarriesSecretRejected true true),
    expectTrue "the FastSafeC balance rule is stated" fastSafeCBalanceRuleStated,
    expectFalse "the FastSafeC balance proof has not been carried out"
      fastSafeCBalanceProofCarriedOut,
    expectFalse "the FastSafeC balance proof is not already finished"
      fastSafeCBalanceAlreadyFinished,
    expectFalse "the FastSafeC balance rule is not unnamed"
      fastSafeCBalanceRuleUnspecified,
    expectFalse "the FastSafeC balance rule is not an open question"
      fastSafeCBalanceRuleOpenQuestion,
    expectFalse "an unfinished FastSafeC proof does not erase the rule"
      unfinishedFastSafeCProofMeansRuleMissing,
    expectTrue "Safe judgments stay in the FastSafeC balance"
      safeJudgmentsInFastSafeCBalance,
    expectFalse "Safe judgments are not dropped from the FastSafeC balance"
      dropSafeJudgmentsFromFastSafeCBalance,
    expectTrue "FastC parallelism proofs stay in the FastSafeC balance"
      fastCParallelismProofsInFastSafeCBalance,
    expectFalse "FastC parallelism proofs are not dropped from the FastSafeC balance"
      dropFastCParallelismProofsFromFastSafeCBalance,
    expectTrue "atomics stay in the FastSafeC balance" atomicsInFastSafeCBalance,
    expectFalse "atomics are not dropped from the FastSafeC balance"
      dropAtomicsFromFastSafeCBalance,
    expectTrue "threading stays in the FastSafeC balance" threadingInFastSafeCBalance,
    expectFalse "threading is not dropped from the FastSafeC balance"
      dropThreadingFromFastSafeCBalance,
    expectTrue "proved freedom from locks stays in the FastSafeC balance"
      provedFreedomFromLocksInFastSafeCBalance,
    expectFalse "proved freedom from locks is not dropped from the FastSafeC balance"
      dropProvedFreedomFromLocksFromFastSafeCBalance,
    expectTrue "the Slake typecheck stays in the FastSafeC balance"
      slakeTypecheckInFastSafeCBalance,
    expectFalse "the Slake typecheck is not dropped from the FastSafeC balance"
      dropSlakeTypecheckFromFastSafeCBalance,
    expectTrue "byte identity of emit stays in the FastSafeC balance"
      byteIdentityOfEmitInFastSafeCBalance,
    expectFalse "byte identity of emit is not dropped from the FastSafeC balance"
      dropByteIdentityOfEmitFromFastSafeCBalance,
    expectFalse "optional ccomp does not mean forbidden" optionalCcompMeansForbidden,
    expectFalse "silence does not select FastC, SafeC, or FastSafeC"
      silenceSelectsFastCSafeCOrFastSafeC,
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
