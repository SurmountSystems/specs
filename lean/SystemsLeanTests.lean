/-
  Runtime checks for the Systems Lean meaning model (0002_Systems_Lean.md).
  Theorems in SystemsLeanProofs.lean already fail to typecheck if the model is
  widened (fourth multiplicity, GC allowed on the wire, SSSSS numbered 0002
  or 0003).
  This executable re-checks the decidable facts so a silent `sorry` or a
  Bool regression prints FAIL lines, matching spec_check_tests style.
-/

import SystemsLean

open SystemsLean

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
    expectEqNat "beastdb is specification 0003" beastdbSpecNumber 3
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
