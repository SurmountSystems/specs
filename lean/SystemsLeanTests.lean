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

/-- Elaboration of the mash theorem from Proofs. -/
def mashSelfHostTheorem : mashSelfHostFromCSatisfiesBootstrapIsFalse :=
  mash_self_host_from_c_satisfies_bootstrap_is_false

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
    expectFalse "missing CompCert step does not conform"
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
    expectFalse "named residual does not excuse a missing CompCert step"
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
    expectTrue "conforming bootstrap typecheck includes theorems"
      bootstrapTypecheckIncludesTheorems,
    expectTrue "done bootstrap fixture includes theorems"
      bootstrapTypecheckDone.includesTheorems,
    expectFalse "bootstrap without theorems is not ok"
      bootstrapWithoutTheorems.ok,
    expectFalse "live Slake bootstrap typecheck is not claimed done"
      slakeBootstrapTypecheckClaimedDone,
    expectFalse "self host from generated C does not satisfy bootstrap typecheck"
      selfHostFromGeneratedCSatisfiesTypecheck,
    expectFalse "mash SelfHost From generated C satisfies bootstrap"
      mashSelfHostFromCSatisfiesBootstrapFixture,
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
      (v28RemainingSilenceTokensNamedIn encoded0002Haystack)
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
