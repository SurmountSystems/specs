/-
  Positive locks for the evidence based supercompiler in specification
  0002, Clause 6.4 item 66, and for the open timestamp format and the open
  gossip protocol in that residual list.

  The reader looks at the sibling lines of `0002_Systems_Lean.md`.
  Those lines are the live text. `native_decide` reads them. Dropping
  a required sentence, or changing its words, makes the lock fail.
  This module does not prove False. It does not import an inconsistency
  catalog. A Bool flag set to false is an obligation, not a catalog row.
-/

import MdLine
import «0002_Systems_Lean»

namespace SimdEvidence

/-- How the live evidence sentences are read. Absent words yield `none`. -/
inductive SimdEvidenceReading where
  | locked
  deriving DecidableEq, Repr, BEq

def lineIs (line : MdLine) (n : Nat) (text : String) : Bool :=
  line.number == n && line.text == text

/-- Clause 6.4 item 66 evidence sentence. Sibling markdown line 555. Array index 554. -/
abbrev evidenceLine : MdLine :=
  «0002_Systems_Lean».encodedLines[554]!

def evidenceText : String :=
  "\tThe supercompiler is evidence based and adapts to the machine it runs on."

/-- Assumption sentence. Sibling markdown line 556. Array index 555. -/
abbrev assumptionLine : MdLine :=
  «0002_Systems_Lean».encodedLines[555]!

def assumptionText : String :=
  "\tAn assumption is not kept before an experiment."

/-- Order sentence. Sibling markdown line 557. Array index 556. -/
abbrev orderLine : MdLine :=
  «0002_Systems_Lean».encodedLines[556]!

def orderText : String :=
  "\tThe order is build a model, test every model against evidence, then improve."

/-- Ranking sentence. Sibling markdown line 558. Array index 557. -/
abbrev rankingLine : MdLine :=
  «0002_Systems_Lean».encodedLines[557]!

def rankingText : String :=
  "\tRanking is local from the known hardware specification of that machine."

/-- Weight sentence. Sibling markdown line 559. Array index 558. -/
abbrev weightLine : MdLine :=
  «0002_Systems_Lean».encodedLines[558]!

def weightText : String :=
  "\tThere is no separate numeric weight formula."

/-- Sample speedup sentence. Sibling markdown line 560. Array index 559. -/
abbrev speedupLine : MdLine :=
  «0002_Systems_Lean».encodedLines[559]!

def speedupText : String :=
  "\tA sample speedup remains evidence and is not the Systems Lean equivalence proof."

/-- FMA sentence. Sibling markdown line 561. Array index 560. -/
abbrev fmaLine : MdLine :=
  «0002_Systems_Lean».encodedLines[560]!

def fmaText : String :=
  "\tFMA single rounding stays the reference."

/-- Contribution sentence. Sibling markdown line 562. Array index 561. -/
abbrev contributedLine : MdLine :=
  «0002_Systems_Lean».encodedLines[561]!

def contributedText : String :=
  "\tProved rules may be contributed to a peer to peer gossip network, timestamped on the Bitcoin timechain in a way similar to OpenTimeStamps and not OpenTimeStamps, and to a peer to peer git network of the Radicle kind that is not claimed to be Radicle."

/-- Client sentence. Sibling markdown line 563. Array index 562. -/
abbrev clientLine : MdLine :=
  «0002_Systems_Lean».encodedLines[562]!

def clientText : String :=
  "\tNo client is claimed running."

/-- Open timestamp and gossip sentence. Sibling markdown line 564. Array index 563. -/
abbrev openBothLine : MdLine :=
  «0002_Systems_Lean».encodedLines[563]!

def openBothText : String :=
  "\tThe exact timestamp format and the exact gossip protocol stay open."

/-- Decompiler sentence. Sibling markdown line 565. Array index 564. -/
abbrev decompilerLine : MdLine :=
  «0002_Systems_Lean».encodedLines[564]!

def decompilerText : String :=
  "\tThe decompiler stays unnamed."

/-- Opcode catalog sentence. Sibling markdown line 566. Array index 565. -/
abbrev opcodeLine : MdLine :=
  «0002_Systems_Lean».encodedLines[565]!

def opcodeText : String :=
  "\tThe opcode catalog stays not claimed done."

/-- Residual item 91. Sibling markdown line 591. Array index 590. -/
abbrev timestampOpenLine : MdLine :=
  «0002_Systems_Lean».encodedLines[590]!

def timestampOpenText : String :=
  "91. The exact timestamp format stays open."

/-- Residual item 92. Sibling markdown line 592. Array index 591. -/
abbrev gossipOpenLine : MdLine :=
  «0002_Systems_Lean».encodedLines[591]!

def gossipOpenText : String :=
  "92. The exact gossip protocol stays open."

/-- No gossip client and no git client is claimed running. -/
def clientClaimedRunning : Bool := false

/-- The exact timestamp format is not specified. It stays open. -/
def timestampFormatSpecified : Bool := false

/-- The exact gossip protocol is not specified. It stays open. -/
def gossipProtocolSpecified : Bool := false

/-- The decompiler tool is not named. -/
def decompilerNamed : Bool := false

/-- A full opcode catalog is not claimed done. -/
def opcodeCatalogClaimedDone : Bool := false

/--
  One reading of the evidence sentences and the two residual open items.
  `locked` only when those sibling lines still carry those words.
-/
def readLiveSimdEvidence
    (evidence assumption order ranking weight speedup fma contributed
     client openBoth decompiler opcode timestampOpen gossipOpen : MdLine) :
    Option SimdEvidenceReading :=
  if lineIs evidence 555 evidenceText &&
      lineIs assumption 556 assumptionText &&
      lineIs order 557 orderText &&
      lineIs ranking 558 rankingText &&
      lineIs weight 559 weightText &&
      lineIs speedup 560 speedupText &&
      lineIs fma 561 fmaText &&
      lineIs contributed 562 contributedText &&
      lineIs client 563 clientText &&
      lineIs openBoth 564 openBothText &&
      lineIs decompiler 565 decompilerText &&
      lineIs opcode 566 opcodeText &&
      lineIs timestampOpen 591 timestampOpenText &&
      lineIs gossipOpen 592 gossipOpenText then
    some .locked
  else
    none

def mentionsPhrase (needle hay : String) : Bool :=
  (hay.splitOn needle).length > 1

set_option maxHeartbeats 800000

theorem supercompiler_is_evidence_based :
    lineIs evidenceLine 555 evidenceText = true := by
  native_decide

theorem assumption_is_not_kept_before_an_experiment :
    lineIs assumptionLine 556 assumptionText = true := by
  native_decide

theorem order_is_model_then_evidence_then_improve :
    lineIs orderLine 557 orderText = true := by
  native_decide

theorem ranking_is_local :
    lineIs rankingLine 558 rankingText = true := by
  native_decide

theorem no_separate_numeric_weight_formula :
    lineIs weightLine 559 weightText = true := by
  native_decide

theorem sample_speedup_is_not_the_equivalence_proof :
    lineIs speedupLine 560 speedupText = true := by
  native_decide

theorem fma_single_rounding_stays_the_reference :
    lineIs fmaLine 561 fmaText = true := by
  native_decide

theorem similar_to_opentimestamps_and_not_opentimestamps :
    lineIs contributedLine 562 contributedText = true ∧
      mentionsPhrase "similar to OpenTimeStamps" contributedLine.text = true ∧
      mentionsPhrase "not OpenTimeStamps" contributedLine.text = true := by
  native_decide

theorem radicle_kind_and_not_claimed_to_be_radicle :
    lineIs contributedLine 562 contributedText = true ∧
      mentionsPhrase "Radicle kind" contributedLine.text = true ∧
      mentionsPhrase "not claimed to be Radicle" contributedLine.text = true := by
  native_decide

theorem no_client_is_claimed_running :
    clientClaimedRunning = false ∧
      lineIs clientLine 563 clientText = true := by
  native_decide

theorem timestamp_format_stays_open :
    timestampFormatSpecified = false ∧
      lineIs openBothLine 564 openBothText = true ∧
      lineIs timestampOpenLine 591 timestampOpenText = true := by
  native_decide

theorem gossip_protocol_stays_open :
    gossipProtocolSpecified = false ∧
      lineIs openBothLine 564 openBothText = true ∧
      lineIs gossipOpenLine 592 gossipOpenText = true := by
  native_decide

theorem decompiler_stays_unnamed :
    decompilerNamed = false ∧
      lineIs decompilerLine 565 decompilerText = true := by
  native_decide

theorem opcode_catalog_stays_not_claimed_done :
    opcodeCatalogClaimedDone = false ∧
      lineIs opcodeLine 566 opcodeText = true := by
  native_decide

/--
  The live item 66 sentences and residual items 91 and 92 still say
  what this lock names. Removing any of those sentences makes this
  proof fail.
-/
theorem read_live_simd_evidence_is_locked :
    readLiveSimdEvidence evidenceLine assumptionLine orderLine rankingLine
        weightLine speedupLine fmaLine contributedLine clientLine openBothLine
        decompilerLine opcodeLine timestampOpenLine gossipOpenLine =
      some .locked := by
  native_decide

end SimdEvidence
