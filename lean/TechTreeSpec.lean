/-
  SPEC ENCODINGS for numbered specification 0011 Surmount Systems
  Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`).

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in TechTreeProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  CompactSize laws here restate Bitcoin canonical CompactSize.
  Full UInt64 theorems live in btc-verified
  (BtcVerified.CompactSize). This Lake package does not vendor
  that tree. The Form 1 pin is ref/btc-verified.

  This file does not prove that a Surmount product ships a .sstt
  writer to users. The Lake package writer lives in Sstt.lean.
  This file does not prove that Slake emit already matches ELF.
  It does not prove that beastdb, SSSSS, Slake, or Continuous
  Integration are ready for use.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

import SpecRegistry
import FormalVibeficationSpec

namespace TechTreeSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0011. -/
def specNumber : Nat := 11

def specFileName : String := "0011_Surmount_Systems_Tech_Tree.md"

def productName : String := "Surmount Systems Tech Tree"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- A Surmount product that ships a .sstt writer is not claimed. -/
def producerShipped : Bool := false

/-- This Lake package includes a Lean writer and reader (`Sstt`). -/
def lakeWriterExists : Bool := true

/-- btc-verified CompactSize is a Form 1 pin of this ref/. -/
def compactSizeBtcVerifiedIsThisRepoRefPin : Bool := true

/-- Number 0012 is Majestic Memex and the numbered file exists. -/
def majesticMemexPublished : Bool := true

def fileExtension : String := ".sstt"

def magicString : String := "SSTECHTREE01"

def magicByteCount : Nat := 12

def charByte (c : Char) : UInt8 := UInt8.ofNat c.toNat

def magicBytes : List UInt8 :=
  magicString.toList.map charByte

/-!
  Bitcoin canonical CompactSize. Markers 0x00-0xfc, 0xfd, 0xfe, 0xff.
  Payload after a marker is little endian, least significant byte first.
  Shortest form only.
-/

def compactSizeSingleMax : Nat := 252

def compactSizeU16Max : Nat := 65535

def compactSizeU32Max : Nat := 4294967295

def compactSizeMarkerFd : UInt8 := 0xFD

def compactSizeMarkerFe : UInt8 := 0xFE

def compactSizeMarkerFf : UInt8 := 0xFF

def toByte (n : Nat) : UInt8 := UInt8.ofNat (n % 256)

def fromByte (b : UInt8) : Nat := b.toNat

def encodeLe (width n : Nat) : List UInt8 :=
  match width with
  | 0 => []
  | w + 1 => toByte n :: encodeLe w (n / 256)

def decodeLe (width : Nat) (bs : List UInt8) : Option (Nat × List UInt8) :=
  match width with
  | 0 => some (0, bs)
  | w + 1 =>
    match bs with
    | [] => none
    | b :: rest =>
      match decodeLe w rest with
      | none => none
      | some (hi, tail) => some (fromByte b + 256 * hi, tail)

def encodeCompactSize (n : Nat) : List UInt8 :=
  if n < 253 then
    [toByte n]
  else if n < 65536 then
    compactSizeMarkerFd :: encodeLe 2 n
  else if n < 4294967296 then
    compactSizeMarkerFe :: encodeLe 4 n
  else
    compactSizeMarkerFf :: encodeLe 8 n

def decodeCompactSize (bs : List UInt8) : Option (Nat × List UInt8) :=
  match bs with
  | [] => none
  | h :: t =>
    if h.toNat < 253 then
      some (h.toNat, t)
    else if h == compactSizeMarkerFd then
      match decodeLe 2 t with
      | some (n, rest) =>
        if n ≥ 253 then some (n, rest) else none
      | none => none
    else if h == compactSizeMarkerFe then
      match decodeLe 4 t with
      | some (n, rest) =>
        if n ≥ 65536 then some (n, rest) else none
      | none => none
    else if h == compactSizeMarkerFf then
      match decodeLe 8 t with
      | some (n, rest) =>
        if n ≥ 4294967296 then some (n, rest) else none
      | none => none
    else
      none

inductive NodeKind where
  | numberedSpec
  | siblingEncoding
  | refPin
  | sourceNote
  | skill
  | otherCited
  deriving DecidableEq, Repr, BEq

inductive EdgeKind where
  | link
  | cites
  | siblingEncoding
  | pin
  deriving DecidableEq, Repr, BEq

structure Node where
  id : Nat
  kind : NodeKind
  path : String
  deriving DecidableEq, Repr, BEq

structure Edge where
  src : Nat
  dst : Nat
  kind : EdgeKind
  deriving DecidableEq, Repr, BEq

/-- Clause 3.5 node kinds as CompactSize codes, one based. -/
def nodeKindCode : NodeKind → Nat
  | .numberedSpec => 1
  | .siblingEncoding => 2
  | .refPin => 3
  | .sourceNote => 4
  | .skill => 5
  | .otherCited => 6

def nodeKindOfCode (n : Nat) : Option NodeKind :=
  match n with
  | 1 => some .numberedSpec
  | 2 => some .siblingEncoding
  | 3 => some .refPin
  | 4 => some .sourceNote
  | 5 => some .skill
  | 6 => some .otherCited
  | _ => none

/-- Clause 3.5 edge kinds as CompactSize codes, one based. -/
def edgeKindCode : EdgeKind → Nat
  | .link => 1
  | .cites => 2
  | .siblingEncoding => 3
  | .pin => 4

def edgeKindOfCode (n : Nat) : Option EdgeKind :=
  match n with
  | 1 => some .link
  | 2 => some .cites
  | 3 => some .siblingEncoding
  | 4 => some .pin
  | _ => none

def pathIsAscii (s : String) : Bool :=
  s.toList.all (fun c => c.toNat < 128 && c.toNat != 0)

def bytesOfString (s : String) : List UInt8 :=
  s.toList.map charByte

def stringOfBytes (bs : List UInt8) : String :=
  String.ofList (bs.map (fun b => Char.ofNat b.toNat))

def takeBytes (n : Nat) (bs : List UInt8) : Option (List UInt8 × List UInt8) :=
  match n, bs with
  | 0, rest => some ([], rest)
  | n + 1, b :: rest =>
    match takeBytes n rest with
    | none => none
    | some (xs, tail) => some (b :: xs, tail)
  | _ + 1, [] => none

def encodeNode (n : Node) : List UInt8 :=
  encodeCompactSize n.id ++
    encodeCompactSize (nodeKindCode n.kind) ++
    encodeCompactSize (bytesOfString n.path).length ++
    bytesOfString n.path

def decodeNode (bs : List UInt8) : Option (Node × List UInt8) :=
  match decodeCompactSize bs with
  | none => none
  | some (id, bs1) =>
    match decodeCompactSize bs1 with
    | none => none
    | some (kindN, bs2) =>
      match nodeKindOfCode kindN with
      | none => none
      | some kind =>
        match decodeCompactSize bs2 with
        | none => none
        | some (len, bs3) =>
          match takeBytes len bs3 with
          | none => none
          | some (pbs, rest) =>
            let path := stringOfBytes pbs
            if pathIsAscii path then
              some ({ id := id, kind := kind, path := path }, rest)
            else
              none

def encodeEdge (e : Edge) : List UInt8 :=
  encodeCompactSize e.src ++
    encodeCompactSize e.dst ++
    encodeCompactSize (edgeKindCode e.kind)

def decodeEdge (bs : List UInt8) : Option (Edge × List UInt8) :=
  match decodeCompactSize bs with
  | none => none
  | some (src, bs1) =>
    match decodeCompactSize bs1 with
    | none => none
    | some (dst, bs2) =>
      match decodeCompactSize bs2 with
      | none => none
      | some (kindN, rest) =>
        match edgeKindOfCode kindN with
        | none => none
        | some kind => some ({ src := src, dst := dst, kind := kind }, rest)

def decodeMany {α : Type} (decodeOne : List UInt8 → Option (α × List UInt8)) :
    Nat → List UInt8 → Option (List α × List UInt8)
  | 0, bs => some ([], bs)
  | n + 1, bs =>
    match decodeOne bs with
    | none => none
    | some (x, rest) =>
      match decodeMany decodeOne n rest with
      | none => none
      | some (xs, rest2) => some (x :: xs, rest2)

def concatMap {α β : Type} (f : α → List β) : List α → List β
  | [] => []
  | x :: xs => f x ++ concatMap f xs

def nodeIds (nodes : List Node) : List Nat :=
  nodes.map (fun n => n.id)

def edgePairs (edges : List Edge) : List (Nat × Nat) :=
  edges.map (fun e => (e.src, e.dst))

def hasDuplicateIds : List Nat → Bool
  | [] => false
  | x :: xs => xs.contains x || hasDuplicateIds xs

def nodesHaveUniqueIds (nodes : List Node) : Bool :=
  !hasDuplicateIds (nodeIds nodes)

def edgeEndpointsExist (nodes : List Node) (edges : List Edge) : Bool :=
  let ids := nodeIds nodes
  edges.all (fun e => ids.contains e.src && ids.contains e.dst)

def pathsAreAscii (nodes : List Node) : Bool :=
  nodes.all (fun n => pathIsAscii n.path)

/-- Incoming count for `v`. -/
def inDegree (edges : List (Nat × Nat)) (v : Nat) : Nat :=
  (edges.filter (fun e => e.2 == v)).length

def sources (nodes : List Nat) (edges : List (Nat × Nat)) : List Nat :=
  nodes.filter (fun v => inDegree edges v == 0)

/-- Kahn count: how many nodes can be removed with no remaining incoming edge. -/
def kahnCount (fuel : Nat) (nodes : List Nat) (edges : List (Nat × Nat)) : Nat :=
  match fuel with
  | 0 => 0
  | fuel' + 1 =>
    match sources nodes edges with
    | [] => 0
    | v :: _ =>
      let nodes' := nodes.filter (fun n => n != v)
      let edges' := edges.filter (fun e => e.1 != v && e.2 != v)
      1 + kahnCount fuel' nodes' edges'

/-- True when every node can be ordered so every edge goes forward. -/
def isDag (nodes : List Nat) (edges : List (Nat × Nat)) : Bool :=
  kahnCount (nodes.length + 1) nodes edges == nodes.length

/-- Encoded graph laws: unique ids, existing endpoints, ASCII paths, DAG. -/
def graphOk (nodes : List Node) (edges : List Edge) : Bool :=
  nodesHaveUniqueIds nodes &&
    edgeEndpointsExist nodes edges &&
    pathsAreAscii nodes &&
    isDag (nodeIds nodes) (edgePairs edges)

def encodeGraph (nodes : List Node) (edges : List Edge) : Option (List UInt8) :=
  if !graphOk nodes edges then
    none
  else
    some
      (magicBytes ++
        encodeCompactSize nodes.length ++
        concatMap encodeNode nodes ++
        encodeCompactSize edges.length ++
        concatMap encodeEdge edges)

/-- Decode fails on wrong magic, truncated input, leftover bytes, bad kinds, or a cycle. -/
def decodeGraph (bs : List UInt8) : Option (List Node × List Edge) :=
  match takeBytes magicByteCount bs with
  | none => none
  | some (mag, rest) =>
    if mag != magicBytes then
      none
    else
      match decodeCompactSize rest with
      | none => none
      | some (nc, rest1) =>
        match decodeMany decodeNode nc rest1 with
        | none => none
        | some (nodes, rest2) =>
          match decodeCompactSize rest2 with
          | none => none
          | some (ec, rest3) =>
            match decodeMany decodeEdge ec rest3 with
            | none => none
            | some (edges, rest4) =>
              if !rest4.isEmpty then
                none
              else if !graphOk nodes edges then
                none
              else
                some (nodes, edges)

def parseFourDigitPrefix (s : String) : Option Nat :=
  let cs := s.toList
  match cs with
  | a :: b :: c :: d :: _ =>
    if a.isDigit && b.isDigit && c.isDigit && d.isDigit then
      some
        ((a.toNat - '0'.toNat) * 1000 +
          (b.toNat - '0'.toNat) * 100 +
          (c.toNat - '0'.toNat) * 10 +
          (d.toNat - '0'.toNat))
    else
      none
  | _ => none

def specNumberFromPath (path : String) : Option Nat :=
  let parts := (path.replace "\\" "/").splitOn "/"
  let base :=
    match parts.reverse with
    | p :: _ => p
    | [] => path
  if base.endsWith ".md" then
    parseFourDigitPrefix base
  else
    none

def specNumOfNode (n : Node) : Option Nat :=
  if n.kind == .numberedSpec then specNumberFromPath n.path else none

def specNumOfId (nodes : List Node) (id : Nat) : Option Nat :=
  match nodes.find? (fun n => n.id == id) with
  | none => none
  | some n => specNumOfNode n

/-- When both ends are numbered specs, keep only lower spec number to higher. -/
def orientSpecEdge (nodes : List Node) (e : Edge) : Edge :=
  match specNumOfId nodes e.src, specNumOfId nodes e.dst with
  | some a, some b =>
    if a < b then
      e
    else if b < a then
      { e with src := e.dst, dst := e.src }
    else
      e
  | _, _ => e

def dedupEdges : List Edge → List Edge
  | [] => []
  | e :: rest =>
    if rest.contains e then dedupEdges rest else e :: dedupEdges rest

def orientSpecEdges (nodes : List Node) (edges : List Edge) : List Edge :=
  dedupEdges (edges.map (orientSpecEdge nodes))

/-- The encoded graph MUST be a directed acyclic graph. -/
def encodedGraphMustBeDag : Bool := true

/-- Markdown citation among numbered specifications MAY cycle. -/
def markdownCitationMayCycle : Bool := true

def emptyGraphIsDag : Bool := isDag [] []

def chainGraphIsDag : Bool := isDag [0, 1, 2] [(0, 1), (1, 2)]

def loopGraphIsDag : Bool := isDag [0, 1] [(0, 1), (1, 0)]

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
  { moduleName := "TechTreeSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "TechTreeProofs"
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

/-- Stated: spec encoding is not the proof. -/
def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/-- Treating the Lake writer as a shipped Surmount product is Cons False. -/
def mashLakeWriterAsShippedProduct : Prop :=
  producerShipped = true

def mashLakeWriterAsShippedProductIsFalse : Prop :=
  mashLakeWriterAsShippedProduct → False

/-- Copying full UInt64 CompactSize theorems into this Lake package is Cons False. -/
def uint64TheoremsCopiedIntoThisLakePackage : Bool := false

def mashCopiedUint64Theorems : Prop :=
  uint64TheoremsCopiedIntoThisLakePackage = true

def mashCopiedUint64TheoremsIsFalse : Prop :=
  mashCopiedUint64Theorems → False

/-- Wiring a producer into a product tree stays leftover. Treating that leftover as done is Cons False. -/
def producerWiredIntoProductTree : Bool := false

def mashProducerWiredIntoProductTree : Prop :=
  producerWiredIntoProductTree = true

def mashProducerWiredIntoProductTreeIsFalse : Prop :=
  mashProducerWiredIntoProductTree → False

def siblingLineEncodingsRequired : Bool := true

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

def wrongMagicEmpty : List UInt8 :=
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0]

def fixtureNode0 : Node :=
  { id := 0, kind := .numberedSpec, path := "0000_spec.md" }

def fixtureNode5 : Node :=
  { id := 1, kind := .numberedSpec, path := "0005_CATE.md" }

def fixtureChain : List Edge :=
  [{ src := 0, dst := 1, kind := .cites }]

def fixtureLoop : List Edge :=
  [{ src := 0, dst := 1, kind := .cites },
    { src := 1, dst := 0, kind := .cites }]

/-- Two numbered specification nodes that reuse identity 0. Clause 4.2. -/
def duplicateIdNodes : List Node :=
  [fixtureNode0, { id := 0, kind := .numberedSpec, path := "0005_CATE.md" }]

/-- An edge whose destination identity is not in the node list. Clause 4.2. -/
def missingEndpointEdges : List Edge :=
  [{ src := 0, dst := 99, kind := .cites }]

/-- A node whose path contains a byte at or above 128. Clause 4.2. -/
def nonAsciiPathNode : Node :=
  { id := 0, kind := .numberedSpec, path := String.singleton (Char.ofNat 128) }

/-- Clause 6.1 withdrawn numbered names. Number 0009 is PDOSS. Unlicense remains the license. -/
def unpublishedBasenames : List String :=
  ["0009_VOCABULARY.md", "0005_fargo.md", "0011_Unlicense.md", "0009_Unlicense.md"]

def unpublishedBasename (name : String) : Bool :=
  unpublishedBasenames.contains name

/-- Well formed bytes of a two node loop. Encode refuses this graph. -/
def cyclicEncodedBytes : List UInt8 :=
  magicBytes ++
    encodeCompactSize 2 ++
    concatMap encodeNode [fixtureNode0, fixtureNode5] ++
    encodeCompactSize 2 ++
    concatMap encodeEdge fixtureLoop

def mutualCitation : List Edge :=
  [{ src := 1, dst := 0, kind := .cites },
    { src := 0, dst := 1, kind := .cites }]

def orientedMutual : List Edge :=
  orientSpecEdges [fixtureNode0, fixtureNode5] mutualCitation

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

end TechTreeSpec
