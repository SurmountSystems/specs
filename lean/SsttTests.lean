/-
  Runtime contracts for the .sstt writer and reader.
  Wrong magic fails. Roundtrip of a DAG passes. A cyclic
  encoded graph fails. Mutual numbered spec citation keeps
  only the edge from the lower spec number to the higher.
  Withdrawn numbered names are not nodes. Published numbered
  specification nodes match the registry, including 0012.
  The writer refuses to write tech_tree.sstt into the
  repository root. With REPO_ROOT set, --decode of a graph
  missing a published numbered specification fails. Without
  REPO_ROOT, that published set check is not applied. A cited
  skill, ref/ pin, or SOURCE dest missing from the file list
  fails honesty. A present dest still writes a DAG and
  classifies the node. Remote http URLs do not fail this
  check. Exit 1 on FAIL.
-/

import Sstt
import TechTreeSpec
import SpecRegistry
import RepoLinks

open Sstt
open TechTreeSpec
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

def runCases : List Case :=
  let emptyBytes := encodeGraph [] []
  let emptyOk :=
    match emptyBytes with
    | none => false
    | some bs => decodeGraph bs == some ([], [])
  let chainBytes := encodeGraph [fixtureNode0, fixtureNode5] fixtureChain
  let chainOk :=
    match chainBytes with
    | none => false
    | some bs =>
      decodeGraph bs == some ([fixtureNode0, fixtureNode5], fixtureChain)
  let files : List (String × String) :=
    [ ("0000_spec.md", "see [cate](0005_CATE.md).\n")
    , ("0005_CATE.md", "see [spec](0000_spec.md).\n")
    , ("0000_spec.lean", "")
    , ("ref/rfc2119/SOURCE.md", "") ]
  let (nodes, edges) := graphFromFiles files
  let specEdges :=
    edges.filter (fun e => e.kind == .cites)
  let lowerToHigher :=
    specEdges.all (fun e =>
      match specNumOfId nodes e.src, specNumOfId nodes e.dst with
      | some a, some b => a < b
      | _, _ => false)
  let filesRound :=
    match encodeFiles files with
    | none => false
    | some bs =>
      match decodeGraph bs with
      | none => false
      | some (ns, es) => ns == nodes && es == edges
  [
    expectTrue "Lake writer exists" lakeWriterExists,
    expectFalse "Surmount product writer is not claimed shipped" producerShipped,
    expectFalse "published 0012 markdown is not unpublished"
      (unpublishedBasename "0012_Majestic_Memex.md"),
    expectFalse "published 0012 sibling Lean is not unpublished"
      (unpublishedBasename "0012_Majestic_Memex.lean"),
    expectTrue "0012 markdown is a root numbered spec"
      (isRootNumberedSpec "0012_Majestic_Memex.md"),
    expectTrue "withdrawn 0009_VOCABULARY remains unpublished"
      (unpublishedBasename "0009_VOCABULARY.md"),
    expectTrue "withdrawn 0005_fargo remains unpublished"
      (unpublishedBasename "0005_fargo.md"),
    expectTrue "withdrawn 0011_Unlicense remains unpublished"
      (unpublishedBasename "0011_Unlicense.md"),
    expectEqString "extension is .sstt" Sstt.fileExtension ".sstt",
    expectTrue "empty graph roundtrip" emptyOk,
    expectTrue "chain roundtrip" chainOk,
    expectTrue "wrong magic is rejected"
      (decodeGraph wrongMagicEmpty == none),
    expectTrue "wrong first magic byte is rejected"
      (match emptyBytes with
        | none => false
        | some bs =>
          match bs with
          | [] => false
          | _ :: rest => decodeGraph (0x00 :: rest) == none),
    expectTrue "encode of a two node loop fails"
      (encodeGraph [fixtureNode0, fixtureNode5] fixtureLoop == none),
    expectTrue "decode of a cyclic encoded graph fails"
      (decodeGraph cyclicEncodedBytes == none),
    expectTrue "mutual numbered spec citation keeps lower to higher"
      lowerToHigher,
    expectTrue "mutual citation is a single cites edge"
      (specEdges.length == 1),
    expectTrue "files graph is a DAG"
      (isDag (nodeIds nodes) (edgePairs edges)),
    expectTrue "files graph roundtrip" filesRound,
    expectTrue "sibling encoding edge is present"
      (edges.any (fun e => e.kind == .siblingEncoding)),
    expectTrue "SOURCE pin is classified"
      (nodes.any (fun n => n.kind == .sourceNote && n.path.endsWith "SOURCE.md")),
    expectTrue "withdrawn numbered names are not nodes"
      (let withdrawnFiles : List (String × String) :=
        [ ("0000_spec.md", "")
        , ("0009_VOCABULARY.md", "")
        , ("0005_fargo.md", "")
        , ("0011_Unlicense.md", "") ]
      let (wnodes, _) := graphFromFiles withdrawnFiles
      let paths := wnodes.map (fun n => n.path)
      !paths.contains "0009_VOCABULARY.md" &&
        !paths.contains "0005_fargo.md" &&
        !paths.contains "0011_Unlicense.md" &&
        paths.contains "0000_spec.md"),
    expectEqNat "published numbered spec nodes match the registry"
      (let publishedFiles : List (String × String) :=
        publishedBasenames.map (fun b => (b, ""))
      let (pnodes, _) := graphFromFiles publishedFiles
      (pnodes.filter (fun n => n.kind == .numberedSpec)).length)
      publishedEntries.length,
    expectTrue "published 0012 is a numbered spec node"
      (let publishedFiles : List (String × String) :=
        publishedBasenames.map (fun b => (b, ""))
      let (pnodes, _) := graphFromFiles publishedFiles
      pnodes.any (fun n => n.path == memexFileName && n.kind == .numberedSpec)),
    expectTrue "repo root dump path is detected"
      (isRepoRootOutput ⟨"/repo"⟩ ⟨"/repo/tech_tree.sstt"⟩),
    expectTrue "bare tech_tree.sstt is a repo root dump"
      (isRepoRootOutput ⟨"/repo"⟩ ⟨"tech_tree.sstt"⟩),
    expectTrue "dot-slash tech_tree.sstt is a repo root dump"
      (isRepoRootOutput ⟨"/repo"⟩ ⟨"./tech_tree.sstt"⟩),
    expectFalse "a path under a temp directory is not a repo root dump"
      (isRepoRootOutput ⟨"/repo"⟩ ⟨"/tmp/sstt-out/tech_tree.sstt"⟩),
    expectTrue "decode of bytes for a graph with only 0000_spec.md succeeds"
      (let missingPublished : List (String × String) :=
        [ ("0000_spec.md", "") ]
      match encodeFiles missingPublished with
      | none => false
      | some bs =>
        match decodeGraph bs with
        | none => false
        | some (ns, _) => ns.any (fun n => n.path == "0000_spec.md")),
    expectFalse "a graph with only 0000_spec.md is not the published numbered specification set"
      (let missingPublished : List (String × String) :=
        [ ("0000_spec.md", "") ]
      let (missingNodes, _) := graphFromFiles missingPublished
      repoGraphHonest missingNodes),
    expectTrue "with REPO_ROOT set to this repository, decode of a graph missing a published numbered specification fails"
      (let missingPublished : List (String × String) :=
        [ ("0000_spec.md", "") ]
      let (missingNodes, _) := graphFromFiles missingPublished
      decodeHonestyFails (some "/repo") missingNodes),
    expectFalse "without REPO_ROOT, decode of a graph with only 0000_spec.md does not require the published numbered specification set"
      (let missingPublished : List (String × String) :=
        [ ("0000_spec.md", "") ]
      let (missingNodes, _) := graphFromFiles missingPublished
      decodeHonestyFails none missingNodes),
    expectFalse "without REPO_ROOT, decode of a small graph that is not this tree does not require the published numbered specification set"
      (let smallTree : List (String × String) :=
        [ ("0000_spec.md", "see [cate](0005_CATE.md).\n")
        , ("0005_CATE.md", "") ]
      let (smallNodes, _) := graphFromFiles smallTree
      decodeHonestyFails none smallNodes),
    expectFalse "with REPO_ROOT set to this repository, decode of the published numbered specification set does not fail honesty"
      (let publishedFiles : List (String × String) :=
        publishedBasenames.map (fun b => (b, ""))
      let (pnodes, _) := graphFromFiles publishedFiles
      decodeHonestyFails (some "/repo") pnodes),
    expectFalse "cited skill dest absent from the file list fails honesty"
      (let missingSkill : List (String × String) :=
        [ ("0000_spec.md",
            "see [skill](.agents/skills/absent-skill/SKILL.md).\n") ]
      citedRequiredPresent missingSkill),
    expectFalse "cited SOURCE dest absent from the file list fails honesty"
      (let missingSource : List (String × String) :=
        [ ("0000_spec.md", "see [src](ref/absent-pin/SOURCE.md).\n") ]
      citedRequiredPresent missingSource),
    expectFalse "cited ref pin dest absent from the file list fails honesty"
      (let missingRef : List (String × String) :=
        [ ("0000_spec.md", "see [pin](ref/absent-pin/rfc.txt).\n") ]
      citedRequiredPresent missingRef),
    expectEqString "writeRepo error names the missing SOURCE dest"
      (let missingSource : List (String × String) :=
        [ ("0000_spec.md", "see [src](ref/absent-pin/SOURCE.md).\n") ]
      match citedRequiredMissing missingSource with
      | p :: _ => missingCitedDestMessage p
      | [] => "")
      "cited dest is missing: ref/absent-pin/SOURCE.md",
    expectTrue "cited other path dest absent from the file list does not fail cited dest honesty"
      (let other : List (String × String) :=
        [ ("0000_spec.md", "see [r](README.md).\n") ]
      citedRequiredPresent other),
    expectTrue "cited SOURCE dest present writes a DAG and classifies the node"
      (let presentSource : List (String × String) :=
        [ ("0000_spec.md", "see [src](ref/rfc2119/SOURCE.md).\n")
        , ("ref/rfc2119/SOURCE.md", "") ]
      let (snodes, sedges) := graphFromFiles presentSource
      citedRequiredPresent presentSource &&
        snodes.any (fun n =>
          n.kind == .sourceNote && n.path == "ref/rfc2119/SOURCE.md") &&
        isDag (nodeIds snodes) (edgePairs sedges) &&
        (match encodeFiles presentSource with
          | none => false
          | some _ => true)),
    expectTrue "seed skill markdown is a skill node with a link edge"
      (let skillFiles : List (String × String) :=
        [ ("0000_spec.md",
            "see [skill](.agents/skills/demo/SKILL.md).\n")
        , (".agents/skills/demo/SKILL.md", "seed skill\n") ]
      let (knodes, kedges) := graphFromFiles skillFiles
      citedRequiredPresent skillFiles &&
        knodes.any (fun n =>
          n.kind == .skill && n.path == ".agents/skills/demo/SKILL.md") &&
        kedges.any (fun e => e.kind == .link) &&
        isDag (nodeIds knodes) (edgePairs kedges)),
    expectTrue "http URL dest does not fail cited dest honesty"
      (let remote : List (String × String) :=
        [ ("0000_spec.md", "see [x](https://example.com/foo).\n") ]
      citedRequiredPresent remote)
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
    IO.println s!"sstt_tests: {runCases.length} passed"
    return 0
  IO.eprintln s!"sstt_tests: {failed} failed"
  return 1
