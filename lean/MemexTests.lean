/-
  Runtime checks for Majestic Memex spec encodings and proofs.
  Magic bytes, crate versus command, Tech Tree split, and the
  license split. Exit 1 on FAIL.
-/

import MemexSpec
import MemexProofs
import SpecRegistry

open MemexSpec
open MemexProofs
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

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

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

def bytesEq (got want : List UInt8) : Bool :=
  got == want

def runCases : List Case :=
  [
    expectEqNat "Majestic Memex is specification 0012" specNumber 12,
    expectEqString "Majestic Memex file is 0012_Majestic_Memex.md"
      specFileName "0012_Majestic_Memex.md",
    expectEqString "product name is Majestic Memex" productName "Majestic Memex",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "MemexSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "MemexSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectEqString "crate name is majestic" crateName "majestic",
    expectEqString "command name is memex" commandName "memex",
    expectTrue "crate name is not the command" (crateName != commandName),
    expectEqString "magic is MAJESTIC" magicString "MAJESTIC",
    expectEqNat "magic prefix is nine bytes" magicBytes.length 9,
    expectTrue "magic version byte is 0x01" (magicVersionByte == 0x01),
    expectTrue "magic has no NUL" (magicString.toList.all (fun c => c.toNat != 0)),
    expectTrue "magic bytes are MAJESTIC plus 0x01"
      (bytesEq magicBytes
        ("MAJESTIC".toList.map charByte ++ [0x01])),
    expectEqString "file extension is .majestic" fileExtension ".majestic",
    expectTrue "file extension is not .sstt" (fileExtension != ".sstt"),
    expectTrue "magic is not SSTECHTREE01" (magicString != "SSTECHTREE01"),
    expectTrue "data root uses HOME" dataRootUsesHome,
    expectEqString "data root relative is memex" dataRootRel "memex",
    expectTrue "proof of concept still being built"
      proofOfConceptStillBeingBuilt,
    expectFalse "product is not ready for use" productReadyForUse,
    expectFalse "product is not claimed never started" productNeverStarted,
    expectTrue "memex may later load sstt" memexMayLoadSstt,
    expectFalse "majestic archive is not sstt" majesticArchiveIsSstt,
    expectFalse "sstt producer is not shipped" ssttProducerShipped,
    expectTrue "btc-verified is a Form 1 pin of this ref/"
      thisEffortAddsBtcVerifiedSubmodule,
    expectFalse "this repo Unlicense does not cover the crate"
      thisRepoUnlicenseCoversMajesticCrate,
    expectTrue "crate has its own Unlicense file"
      majesticCrateHasOwnUnlicenseFile,
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "number 0012 is in the registry"
      (allEntries.any (fun e => e.number == 12)),
    expectTrue "number 0012 is published"
      (publishedEntries.any (fun e => e.number == 12)),
    expectEmpty "correct 0012 token passes"
      (scanContent "0012_Majestic_Memex.md"
        "This specification is number 0012. File 0012_Majestic_Memex.md.\n"),
    expectNonEmpty "wrong 0012 filename token fails"
      (scanContent "0012_Majestic_Memex.md"
        "do not cite 0012_unused.md\n"),
    expectNonEmpty "withdrawn 0009_VOCABULARY token fails"
      (scanContent "0012_Majestic_Memex.md"
        "do not create `0009_VOCABULARY.md`.\n"),
    expectEmpty "all published basenames including 0012 pass"
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
    expectTrue "exact MAJESTIC plus 0x01 has the magic prefix"
      (hasMajesticMagicPrefix magicBytes),
    expectTrue "magic prefix plus payload still has the magic prefix"
      (hasMajesticMagicPrefix (magicBytes ++ [0xFF])),
    expectFalse "empty bytes do not have the magic prefix"
      (hasMajesticMagicPrefix []),
    expectFalse "MAJESTIC plus 0x00 does not have the magic prefix"
      (hasMajesticMagicPrefix
        ("MAJESTIC".toList.map charByte ++ [0x00])),
    expectFalse "SSTECHTREE01 does not have the Majestic Memex magic prefix"
      (hasMajesticMagicPrefix (techTreeMagicString.toList.map charByte)),
    expectEqString "typical grok archive is memex/grok/acct.majestic"
      (typicalArchiveRel "grok" "acct") "memex/grok/acct.majestic",
    expectFalse "there is no silent default archive"
      silentDefaultArchiveExists,
    expectTrue "live home scan does not walk the data root as a source"
      liveHomeScan.conforming,
    expectFalse "mash that walks the data root as a source does not conform"
      mashWalksDataRoot.conforming,
    expectFalse "a binary named majestic is not required"
      requireBinaryNamedCrate,
    expectEqNat "Public Domain Open Source Software is specification 0009"
      MemexSpec.pdossSpecNumber 9,
    expectFalse "this specification does not invent a second PDOSS number"
      inventsSecondPdossSpec,
    expectTrue "a numbered Vocabulary file MUST NOT exist"
      numberedVocabularyFileMustNotExist,
    expectFalse "this repository does not wait on a finished memex command"
      waitOnFinishedMemexCommand,
    expectFalse "companion Lean does not prove the crate is finished"
      companionLeanProvesCrateFinished,
    expectFalse "mashed spec and proof fixture still fails"
      (conformingThisRepo mashedFixture),
    expectConsFalse "archive is not a Tech Tree file"
      majesticArchiveIsSstt
      mashArchiveIsSstt
      mashArchiveIsSsttIsFalse
      rfl
      mash_archive_is_sstt_is_false,
    expectConsFalse "archive extension is not .sstt"
      (fileExtension == techTreeFileExtension)
      mashExtensionIsSstt
      mashExtensionIsSsttIsFalse
      rfl
      mash_extension_is_sstt_is_false,
    expectConsFalse "magic is not SSTECHTREE01"
      (magicString == techTreeMagicString)
      mashMagicIsTechTree
      mashMagicIsTechTreeIsFalse
      rfl
      mash_magic_is_tech_tree_is_false,
    expectConsFalse "crate name is not the command"
      (crateName == commandName)
      mashCrateNameIsCommand
      mashCrateNameIsCommandIsFalse
      rfl
      mash_crate_name_is_command_is_false,
    expectConsFalse "this repository Unlicense does not cover the crate"
      thisRepoUnlicenseCoversMajesticCrate
      mashRepoUnlicenseCoversCrate
      mashRepoUnlicenseCoversCrateIsFalse
      rfl
      mash_repo_unlicense_covers_crate_is_false,
    expectConsFalse "the crate is not ready for use"
      productReadyForUse
      mashProductReadyForUse
      mashProductReadyForUseIsFalse
      rfl
      mash_product_ready_for_use_is_false,
    expectConsFalse "the crate is not claimed never started"
      productNeverStarted
      mashProductNeverStarted
      mashProductNeverStartedIsFalse
      rfl
      mash_product_never_started_is_false,
    expectConsFalse "waiting on a finished memex command is not accepted"
      waitOnFinishedMemexCommand
      mashWaitOnFinishedMemexCommand
      mashWaitOnFinishedMemexCommandIsFalse
      rfl
      mash_wait_on_finished_memex_command_is_false,
    expectConsFalse "loading .sstt does not make a .majestic archive a Tech Tree file"
      (memexMayLoadSstt && majesticArchiveIsSstt)
      mashLoadSsttMakesArchiveSstt
      mashLoadSsttMakesArchiveSsttIsFalse
      rfl
      mash_load_sstt_makes_archive_sstt_is_false,
    expectConsFalse "the Lake .sstt writer is not a shipped memex product"
      ssttProducerShipped
      mashLakeWriterIsShippedMemex
      mashLakeWriterIsShippedMemexIsFalse
      rfl
      mash_lake_writer_is_shipped_memex_is_false,
    expectConsFalse "mash that companion Lean proves the crate is finished is not accepted"
      companionLeanProvesCrateFinished
      mashCompanionLeanProvesCrateFinished
      mashCompanionLeanProvesCrateFinishedIsFalse
      rfl
      mash_companion_lean_proves_crate_finished_is_false
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
    IO.println s!"memex_tests: {runCases.length} passed"
    return 0
  else
    IO.eprintln s!"memex_tests: {failed} failed"
    return 1
