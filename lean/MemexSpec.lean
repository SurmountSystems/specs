/-
  SPEC ENCODINGS for numbered specification 0012 Majestic
  Memex (`0012_Majestic_Memex.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in MemexProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not prove that the crate at ~/majestic is finished.
  It does not prove that a .sstt producer exists. It does not prove
  that Slake emit already matches ELF. It does not prove that
  beastdb, SSSSS, Slake, or Continuous Integration are ready for use.
  The Unlicense of this specifications repository does not silently
  cover the crate tree.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry
import FormalVibeficationSpec

namespace MemexSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0012. -/
def specNumber : Nat := 12

def specFileName : String := "0012_Majestic_Memex.md"

def productName : String := "Majestic Memex"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Crate package name. -/
def crateName : String := "majestic"

/-- Installed command name. -/
def commandName : String := "memex"

def fileExtension : String := ".majestic"

def techTreeFileExtension : String := ".sstt"

def magicString : String := "MAJESTIC"

def magicVersionByte : UInt8 := 0x01

def magicAsciiByteCount : Nat := 8

def magicByteCount : Nat := 9

def charByte (c : Char) : UInt8 := UInt8.ofNat c.toNat

def magicBytes : List UInt8 :=
  magicString.toList.map charByte ++ [magicVersionByte]

/-- Uncompressed archive prefix: nine bytes MAJESTIC plus 0x01. -/
def hasMajesticMagicPrefix (bs : List UInt8) : Bool :=
  bs.take magicByteCount == magicBytes

def techTreeMagicString : String := "SSTECHTREE01"

def dataRootRel : String := "memex"

def dataRootUsesHome : Bool := true

/-- Typical archive: dataRootRel/service/account.majestic. -/
def typicalArchiveRel (service account : String) : String :=
  dataRootRel ++ "/" ++ service ++ "/" ++ account ++ fileExtension

/-- Silent default relative path is not a required layout. -/
def silentDefaultArchiveRel : String :=
  dataRootRel ++ "/archive" ++ fileExtension

def silentDefaultArchiveExists : Bool := false

/-- Home scan of export sources does not walk the data root. -/
structure HomeScan where
  walksDataRootAsSource : Bool
  deriving DecidableEq, Repr, BEq

def HomeScan.conforming (s : HomeScan) : Bool :=
  !s.walksDataRootAsSource

def liveHomeScan : HomeScan :=
  { walksDataRootAsSource := false }

def mashWalksDataRoot : HomeScan :=
  { walksDataRootAsSource := true }

/-- Authors MUST NOT require a binary named majestic in place of memex. -/
def requireBinaryNamedCrate : Bool := false

/-- Pointer: Public Domain Open Source Software is specification 0009. -/
def pdossSpecNumber : Nat := 9

def inventsSecondPdossSpec : Bool := false

def numberedVocabularyFileMustNotExist : Bool := true

/-- The crate is version 0.1 and still being built. -/
def proofOfConceptStillBeingBuilt : Bool := true

def productReadyForUse : Bool := false

def productNeverStarted : Bool := false

/-- memex MAY later load a Tech Tree file. Formats stay distinct. -/
def memexMayLoadSstt : Bool := true

def majesticArchiveIsSstt : Bool := false

def ssttProducerShipped : Bool := false

def thisEffortAddsBtcVerifiedSubmodule : Bool := true

/-- Unlicense of this specs tree does not silently cover ~/majestic. -/
def thisRepoUnlicenseCoversMajesticCrate : Bool := false

def majesticCrateHasOwnUnlicenseFile : Bool := true

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

structure LeanModuleRole where
  moduleName : String
  containsSpecEncodings : Bool
  containsProofsOfThoseEncodings : Bool
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  deriving DecidableEq, Repr, BEq

def hidesSplit (m : LeanModuleRole) : Bool :=
  m.containsSpecEncodings && m.containsProofsOfThoseEncodings

def conformingThisRepo (m : LeanModuleRole) : Bool :=
  !hidesSplit m &&
    (!m.containsSpecEncodings || (m.markedAsSpecEncoding && !m.markedAsProof)) &&
    (!m.containsProofsOfThoseEncodings || (m.markedAsProof && !m.markedAsSpecEncoding))

def specEncodingFixture : LeanModuleRole :=
  { moduleName := "MemexSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "MemexProofs"
    containsSpecEncodings := false
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := false
    markedAsProof := true }

def mashedFixture : LeanModuleRole :=
  { moduleName := "MashedSpecAndProof"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := true
    markedAsProof := true }

def mashedIsNonconformingThisRepo : Prop :=
  conformingThisRepo mashedFixture = false

/-- Spec encoding is not the proof. -/
def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/-- A .majestic archive is not a Tech Tree file. -/
def mashArchiveIsSstt : Prop :=
  majesticArchiveIsSstt = true

def mashArchiveIsSsttIsFalse : Prop :=
  mashArchiveIsSstt → False

/-- Archive extension is not .sstt. -/
def mashExtensionIsSstt : Prop :=
  fileExtension = techTreeFileExtension

def mashExtensionIsSsttIsFalse : Prop :=
  mashExtensionIsSstt → False

/-- Magic MAJESTIC is not SSTECHTREE01. -/
def mashMagicIsTechTree : Prop :=
  magicString = techTreeMagicString

def mashMagicIsTechTreeIsFalse : Prop :=
  mashMagicIsTechTree → False

/-- Crate name majestic is not command memex. -/
def mashCrateNameIsCommand : Prop :=
  crateName = commandName

def mashCrateNameIsCommandIsFalse : Prop :=
  mashCrateNameIsCommand → False

/-- This repository Unlicense does not cover ~/majestic. -/
def mashRepoUnlicenseCoversCrate : Prop :=
  thisRepoUnlicenseCoversMajesticCrate = true

def mashRepoUnlicenseCoversCrateIsFalse : Prop :=
  mashRepoUnlicenseCoversCrate → False

/-- The crate is not ready for use. -/
def mashProductReadyForUse : Prop :=
  productReadyForUse = true

def mashProductReadyForUseIsFalse : Prop :=
  mashProductReadyForUse → False

/-- The crate is not claimed never started. -/
def mashProductNeverStarted : Prop :=
  productNeverStarted = true

def mashProductNeverStartedIsFalse : Prop :=
  mashProductNeverStarted → False

/-- This repository does not wait on a finished memex command. -/
def waitOnFinishedMemexCommand : Bool := false

def mashWaitOnFinishedMemexCommand : Prop :=
  waitOnFinishedMemexCommand = true

def mashWaitOnFinishedMemexCommandIsFalse : Prop :=
  mashWaitOnFinishedMemexCommand → False

/-- Loading .sstt does not make a .majestic archive a Tech Tree file. -/
def mashLoadSsttMakesArchiveSstt : Prop :=
  memexMayLoadSstt = true ∧ majesticArchiveIsSstt = true

def mashLoadSsttMakesArchiveSsttIsFalse : Prop :=
  mashLoadSsttMakesArchiveSstt → False

/-- The Lake .sstt writer is not a shipped memex product. -/
def mashLakeWriterIsShippedMemex : Prop :=
  ssttProducerShipped = true

def mashLakeWriterIsShippedMemexIsFalse : Prop :=
  mashLakeWriterIsShippedMemex → False

/-- Companion Lean does not prove the crate is finished. -/
def companionLeanProvesCrateFinished : Bool := false

def mashCompanionLeanProvesCrateFinished : Prop :=
  companionLeanProvesCrateFinished = true

def mashCompanionLeanProvesCrateFinishedIsFalse : Prop :=
  mashCompanionLeanProvesCrateFinished → False

def formalVibeficationUrl : String :=
  "https://proofofkeags.com/research/2026-05-12-formal-vibefication.html"

def siblingLineEncodingsRequired : Bool := true

def siblingProofsAreSeparateModules : Bool := true

/-- This meaning model requires the Formal Vibefication science cycle. -/
def requiresScienceCycle : Bool := true

/-- Effort that has tests and no model. Reuses the 0008 fixture. -/
def testsOnlyEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.testsWithoutModelFixture

/-- Tests are necessary and are not sufficient. Reuses the 0008 Bool. -/
def testsAloneAreSufficient : Bool :=
  FormalVibeficationSpec.testsAloneAreSufficient

/-- Model and proofs without corollary experiments. Reuses the 0008 fixture. -/
def modelAndProofsWithoutExperimentsEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.modelAndProofsWithoutExperimentsFixture

/-- Complete science cycle. Reuses the 0008 fixture. -/
def completeScienceEffortConforms : Bool :=
  FormalVibeficationSpec.conformingScience
    FormalVibeficationSpec.completeScienceFixture

def testsWithoutModelDoesNotConform : Prop :=
  FormalVibeficationSpec.testsWithoutModelDoesNotConform

def modelAndProofsWithoutExperimentsDoesNotConform : Prop :=
  FormalVibeficationSpec.modelAndProofsWithoutExperimentsDoesNotConform

def completeScienceConforms : Prop :=
  FormalVibeficationSpec.completeScienceConforms

end MemexSpec
