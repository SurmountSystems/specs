/-
  Runtime checks for Tech Tree spec encodings and proofs.
  Magic bytes, CompactSize golden vectors, DAG fixtures, and the
  split. Exit 1 on FAIL.
-/

import TechTreeSpec
import TechTreeProofs
import SpecRegistry
import RepoLinks

open TechTreeSpec
open SpecRegistry
open RepoLinks

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

def bytesEq (got want : List UInt8) : Bool :=
  got == want

def existsKnown (p : String) : Bool :=
  p == "0000_spec.md" || p == "0005_CATE.md"

def runCases : List Case :=
  [
    expectEqNat "Tech Tree is specification 0011" specNumber 11,
    expectEqString "Tech Tree file is 0011_Surmount_Systems_Tech_Tree.md"
      specFileName "0011_Surmount_Systems_Tech_Tree.md",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "TechTreeSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "TechTreeSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectEqString "magic is SSTECHTREE01" magicString "SSTECHTREE01",
    expectEqNat "magic is twelve bytes" magicBytes.length 12,
    expectTrue "magic has no NUL" (magicString.toList.all (fun c => c.toNat != 0)),
    expectEqString "file extension is .sstt" fileExtension ".sstt",
    expectFalse "producer is not shipped" producerShipped,
    expectTrue "Lake writer exists" lakeWriterExists,
    expectTrue "btc-verified is a Form 1 pin of this ref/"
      compactSizeBtcVerifiedIsThisRepoRefPin,
    expectTrue "Majestic Memex numbered file is published" majesticMemexPublished,
    expectTrue "0 encodes as 0x00" (bytesEq (encodeCompactSize 0) [0x00]),
    expectTrue "252 encodes as 0xfc" (bytesEq (encodeCompactSize 252) [0xfc]),
    expectTrue "253 encodes as fd fd 00"
      (bytesEq (encodeCompactSize 253) [0xfd, 0xfd, 0x00]),
    expectTrue "65535 encodes as fd ff ff"
      (bytesEq (encodeCompactSize 65535) [0xfd, 0xff, 0xff]),
    expectTrue "65536 encodes as fe 00 00 01 00"
      (bytesEq (encodeCompactSize 65536) [0xfe, 0x00, 0x00, 0x01, 0x00]),
    expectTrue "decode encode 0"
      (decodeCompactSize (encodeCompactSize 0) == some (0, [])),
    expectTrue "decode encode 252"
      (decodeCompactSize (encodeCompactSize 252) == some (252, [])),
    expectTrue "decode encode 253"
      (decodeCompactSize (encodeCompactSize 253) == some (253, [])),
    expectTrue "decode encode 65535"
      (decodeCompactSize (encodeCompactSize 65535) == some (65535, [])),
    expectTrue "decode encode 65536"
      (decodeCompactSize (encodeCompactSize 65536) == some (65536, [])),
    expectTrue "non shortest fd fc 00 is rejected"
      (decodeCompactSize [0xfd, 0xfc, 0x00] == none),
    expectTrue "empty graph is a DAG" emptyGraphIsDag,
    expectTrue "chain is a DAG" chainGraphIsDag,
    expectFalse "two node loop is not a DAG" loopGraphIsDag,
    expectTrue "empty sstt roundtrip"
      (decodeGraph (magicBytes ++ [0, 0]) == some ([], [])),
    expectTrue "wrong magic is rejected"
      (decodeGraph wrongMagicEmpty == none),
    expectTrue "encode of a two node loop fails"
      (encodeGraph [fixtureNode0, fixtureNode5] fixtureLoop == none),
    expectTrue "decode of a cyclic encoded graph fails"
      (decodeGraph cyclicEncodedBytes == none),
    expectTrue "mutual citation orients lower spec to higher"
      (orientSpecEdges [fixtureNode0, fixtureNode5] mutualCitation ==
        [{ src := 0, dst := 1, kind := .cites }]),
    expectTrue "encoded graph must be a DAG" encodedGraphMustBeDag,
    expectTrue "markdown citation may cycle" markdownCitationMayCycle,
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "number 0011 is in the registry"
      (allEntries.any (fun e => e.number == 11)),
    expectTrue "number 0011 is published"
      (publishedEntries.any (fun e => e.number == 11)),
    expectTrue "number 0012 is published"
      (publishedEntries.any (fun e => e.number == 12)),
    expectEmpty "correct 0011 token passes"
      (scanContent "0011_Surmount_Systems_Tech_Tree.md"
        "This specification is number 0011. File 0011_Surmount_Systems_Tech_Tree.md.\n"),
    expectNonEmpty "wrong 0011 filename token fails"
      (scanContent "0011_Surmount_Systems_Tech_Tree.md"
        "do not cite 0011_Unlicense.md\n"),
    expectEmpty "all published basenames including 0011 pass"
      (findingsForBasenames publishedBasenames),
    expectNonEmpty "missing in-repo link fails"
      (findingsForLinks "0000_spec.md"
        "see [missing](no_such_file.md).\n" existsKnown),
    expectTrue "this meaning model requires the science cycle"
      requiresScienceCycle,
    expectFalse "tests without a model do not conform"
      testsOnlyEffortConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsEffortConforms,
    expectTrue "complete science cycle conforms"
      completeScienceEffortConforms,
    expectFalse "tests alone are not sufficient"
      testsAloneAreSufficient
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      IO.println s!"FAIL {c.name} {c.detail}"
  if failed == 0 then
    IO.println s!"tech_tree_tests: {runCases.length} passed"
    return 0
  IO.eprintln s!"tech_tree_tests: {failed} failed"
  return 1
