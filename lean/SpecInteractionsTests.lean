/-
  Elaborates SpecInteractionsProofs so those proofs typecheck.
  This file does not copy theorems.
  Specification 0017 is not an edge.
  This file does not claim that the gate passed.
-/

import SpecInteractionsProofs

def main (_args : List String) : IO UInt32 := do
  IO.println "spec_interactions_tests: proofs elaborated"
  return 0
