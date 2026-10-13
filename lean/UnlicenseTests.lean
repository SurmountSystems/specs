/-
  Runtime checks for Unlicense spec encodings and proofs.
  Theorems in UnlicenseProofs.lean already fail to typecheck if
  remaining copyright or the split is mashed. This executable
  re-checks the decidable facts so a silent Bool regression prints
  FAIL lines.
-/

import UnlicenseSpec
import UnlicenseProofs
import SpecRegistry

open UnlicenseSpec
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

def runCases : List Case :=
  [
    expectEqNat "PDOSS is specification 0009" specNumber 9,
    expectEqNat "pdossSpecNumber is 9" UnlicenseSpec.pdossSpecNumber 9,
    expectEqString "PDOSS file is 0009_PDOSS.md"
      specFileName "0009_PDOSS.md",
    expectEqString "product name is PDOSS" productName "PDOSS",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "UnlicenseSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "UnlicenseSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "copyright remaining on OSS without dedication"
      (remainingCopyright ossWithoutDedication),
    expectFalse "Unlicense dedication has no remaining copyright"
      (remainingCopyright unlicenseDedication),
    expectTrue "OSS without dedication status is copyright held"
      (ossWithoutDedicationStatus == CopyrightStatus.copyrightHeld),
    expectTrue "Unlicense dedication status is public domain dedicated"
      (unlicenseDedicationStatus == CopyrightStatus.publicDomainDedicated),
    expectTrue "ideas are not scarce" ideasNonScarce,
    expectTrue "ideas are not rivalrous" ideasNotRivalrous,
    expectTrue "two people can hold the same idea at once"
      twoPeopleCanHoldTheSameIdeaAtOnce,
    expectTrue "generosity of ideas is the default"
      generosityOfIdeasIsDefault,
    expectTrue "numbered specs and Lean here are Unlicense"
      (numberedSpecsAndLeanHere == LicenseOfWork.unlicenseDedication),
    expectTrue "lean4-skills pack remains MIT"
      (lean4SkillsPack == LicenseOfWork.mitGrant),
    expectTrue "Keagan essays are not this repository grant"
      (keaganEssays == LicenseOfWork.notThisRepoGrant),
    expectFalse "this Unlicense does not apply to Keagan essays"
      unlicenseOfThisRepoAppliesToKeaganEssays,
    expectFalse "essays are not an Unlicense grant" essaysAreUnlicenseGrant,
    expectFalse "refusing a tool is not a license claim"
      refuseToolYouCannotImproveIsLicenseClaim,
    expectTrue "refusing a tool is RSI process"
      refuseToolYouCannotImproveIsRsiProcess,
    expectTrue "spec encoding constructor is not the proof constructor"
      (Layer.leanSpecEncoding != Layer.leanProof),
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "mashed fixture hides the split" (hidesSplit mashedFixture),
    expectTrue "Unlicense number is in the registry"
      (allEntries.any (fun e => e.number == 9)),
    expectTrue "number 0011 is in the registry"
      (allEntries.any (fun e => e.number == 11)),
    expectTrue "numberElevenPublished is true because 0011 is published"
      numberElevenPublished,
    expectEmpty "correct 0009_PDOSS token passes"
      (scanContent "0009_PDOSS.md"
        "This specification is number 0009. File 0009_PDOSS.md.\n"),
    expectNonEmpty "wrong 0009 filename token fails"
      (scanContent "0009_PDOSS.md"
        "do not cite 0009_unused.md\n"),
    expectNonEmpty "0009_Unlicense.md as a published token fails"
      (scanContent "0009_PDOSS.md"
        "do not cite 0009_Unlicense.md\n"),
    expectNonEmpty "withdrawn 0009_VOCABULARY token fails"
      (scanContent "0009_PDOSS.md"
        "do not create `0009_VOCABULARY.md`.\n"),
    expectNonEmpty "stale 0011_Unlicense token fails"
      (scanContent "0009_PDOSS.md"
        "do not create `0011_Unlicense.md`.\n"),
    expectTrue "Unlicense dedication meets the public domain dedication test"
      (meetsPublicDomainDedicationTest .unlicense),
    expectTrue "Unlicense dedication meets PDOSS" (meetsPdoss .unlicense),
    expectFalse "MIT does not meet a public domain dedication test"
      (meetsPublicDomainDedicationTest .mitGrant),
    expectFalse "MIT does not meet PDOSS" (meetsPdoss .mitGrant),
    expectFalse "Apache 2.0 does not meet a public domain dedication test"
      (meetsPublicDomainDedicationTest .apacheTwo),
    expectFalse "Apache 2.0 does not meet PDOSS" (meetsPdoss .apacheTwo),
    expectFalse "CC0 is not pinned as meeting PDOSS" (meetsPdoss .cc0),
    expectFalse "CC0 is not a pinned instrument that meets PDOSS"
      cc0PinnedAsMeetingPdoss,
    expectFalse "CC0 is not a Clause 12 pin" cc0IsClause12Pin,
    expectFalse "Unlicense does not replace named residual licenses"
      unlicenseReplacesNamedResidualLicenses,
    expectFalse "claiming MIT meets PDOSS is false" (meetsPdoss .mitGrant),
    expectEmpty "all published basenames including 0009 pass"
      (findingsForBasenames publishedBasenames),
    expectFalse "products are not claimed ready for use"
      productsClaimedReadyForUse,
    expectFalse "products are not claimed never started"
      productsClaimedNeverStarted,
    expectTrue "sibling line encodings are required"
      siblingLineEncodingsRequired,
    expectTrue "sibling proofs are separate modules"
      siblingProofsAreSeparateModules,
    expectTrue "this meaning model requires the science cycle"
      requiresScienceCycle,
    expectFalse "tests without a model do not conform"
      testsOnlyEffortConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsEffortConforms,
    expectTrue "complete science cycle conforms"
      completeScienceEffortConforms,
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient,
    expectTrue "Allow plus Unlicense is accepted"
      (contributionAccepted allowUnlicenseContribution),
    expectFalse "residual attribution plus Unlicense is refused"
      (contributionAccepted residualAttributionUnlicenseContribution),
    expectFalse "dual Allow and residual is refused"
      (contributionAccepted dualAllowResidualContribution),
    expectFalse "specific consent is refused"
      (contributionAccepted specificConsentUnlicenseContribution),
    expectFalse "unread is refused"
      (contributionAccepted unreadUnlicenseContribution),
    expectFalse "mash residual attribution contribution accepted is false"
      residualAttributionContributionAcceptedBool,
    expectTrue "United States example class is Allow"
      (unitedStatesClass == NationalityClass.allow),
    expectTrue "France example class is residual attribution"
      (franceClass == NationalityClass.residualAttribution),
    expectTrue "Australia example class is specific consent"
      (australiaClass == NationalityClass.specificConsent),
    expectFalse "nationality statutes are not Clause 12 pins"
      nationalityStatutesAreClause12Pins
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
