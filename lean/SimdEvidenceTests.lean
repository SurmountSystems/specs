/-
  Restatements of the evidence based supercompiler locks. Readers can
  find the falsifiable checks here. Proofs cite SimdEvidence. There is
  no program entry. This module does not prove False.
-/

import SimdEvidence

namespace SimdEvidenceTests

theorem supercompiler_is_evidence_based :
    SimdEvidence.lineIs SimdEvidence.evidenceLine 555 SimdEvidence.evidenceText = true :=
  SimdEvidence.supercompiler_is_evidence_based

theorem assumption_is_not_kept_before_an_experiment :
    SimdEvidence.lineIs SimdEvidence.assumptionLine 556 SimdEvidence.assumptionText = true :=
  SimdEvidence.assumption_is_not_kept_before_an_experiment

theorem order_is_model_then_evidence_then_improve :
    SimdEvidence.lineIs SimdEvidence.orderLine 557 SimdEvidence.orderText = true :=
  SimdEvidence.order_is_model_then_evidence_then_improve

theorem ranking_is_local :
    SimdEvidence.lineIs SimdEvidence.rankingLine 558 SimdEvidence.rankingText = true :=
  SimdEvidence.ranking_is_local

theorem no_separate_numeric_weight_formula :
    SimdEvidence.lineIs SimdEvidence.weightLine 559 SimdEvidence.weightText = true :=
  SimdEvidence.no_separate_numeric_weight_formula

theorem sample_speedup_is_not_the_equivalence_proof :
    SimdEvidence.lineIs SimdEvidence.speedupLine 560 SimdEvidence.speedupText = true :=
  SimdEvidence.sample_speedup_is_not_the_equivalence_proof

theorem fma_single_rounding_stays_the_reference :
    SimdEvidence.lineIs SimdEvidence.fmaLine 561 SimdEvidence.fmaText = true :=
  SimdEvidence.fma_single_rounding_stays_the_reference

theorem similar_to_opentimestamps_and_not_opentimestamps :
    SimdEvidence.lineIs SimdEvidence.contributedLine 562 SimdEvidence.contributedText = true ∧
      SimdEvidence.mentionsPhrase "similar to OpenTimeStamps" SimdEvidence.contributedLine.text = true ∧
      SimdEvidence.mentionsPhrase "not OpenTimeStamps" SimdEvidence.contributedLine.text = true :=
  SimdEvidence.similar_to_opentimestamps_and_not_opentimestamps

theorem radicle_kind_and_not_claimed_to_be_radicle :
    SimdEvidence.lineIs SimdEvidence.contributedLine 562 SimdEvidence.contributedText = true ∧
      SimdEvidence.mentionsPhrase "Radicle kind" SimdEvidence.contributedLine.text = true ∧
      SimdEvidence.mentionsPhrase "not claimed to be Radicle" SimdEvidence.contributedLine.text = true :=
  SimdEvidence.radicle_kind_and_not_claimed_to_be_radicle

theorem no_client_is_claimed_running :
    SimdEvidence.clientClaimedRunning = false ∧
      SimdEvidence.lineIs SimdEvidence.clientLine 563 SimdEvidence.clientText = true :=
  SimdEvidence.no_client_is_claimed_running

theorem timestamp_format_stays_open :
    SimdEvidence.timestampFormatSpecified = false ∧
      SimdEvidence.lineIs SimdEvidence.openBothLine 564 SimdEvidence.openBothText = true ∧
      SimdEvidence.lineIs SimdEvidence.timestampOpenLine 591 SimdEvidence.timestampOpenText = true :=
  SimdEvidence.timestamp_format_stays_open

theorem gossip_protocol_stays_open :
    SimdEvidence.gossipProtocolSpecified = false ∧
      SimdEvidence.lineIs SimdEvidence.openBothLine 564 SimdEvidence.openBothText = true ∧
      SimdEvidence.lineIs SimdEvidence.gossipOpenLine 592 SimdEvidence.gossipOpenText = true :=
  SimdEvidence.gossip_protocol_stays_open

theorem decompiler_stays_unnamed :
    SimdEvidence.decompilerNamed = false ∧
      SimdEvidence.lineIs SimdEvidence.decompilerLine 565 SimdEvidence.decompilerText = true :=
  SimdEvidence.decompiler_stays_unnamed

theorem opcode_catalog_stays_not_claimed_done :
    SimdEvidence.opcodeCatalogClaimedDone = false ∧
      SimdEvidence.lineIs SimdEvidence.opcodeLine 566 SimdEvidence.opcodeText = true :=
  SimdEvidence.opcode_catalog_stays_not_claimed_done

theorem read_live_simd_evidence_is_locked :
    SimdEvidence.readLiveSimdEvidence SimdEvidence.evidenceLine SimdEvidence.assumptionLine
        SimdEvidence.orderLine SimdEvidence.rankingLine SimdEvidence.weightLine
        SimdEvidence.speedupLine SimdEvidence.fmaLine SimdEvidence.contributedLine
        SimdEvidence.clientLine SimdEvidence.openBothLine SimdEvidence.decompilerLine
        SimdEvidence.opcodeLine SimdEvidence.timestampOpenLine SimdEvidence.gossipOpenLine =
      some SimdEvidence.SimdEvidenceReading.locked :=
  SimdEvidence.read_live_simd_evidence_is_locked

end SimdEvidenceTests
