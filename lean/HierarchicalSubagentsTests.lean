/-
  Elaborates HierarchicalSubagentsProofs so those proofs typecheck.
  This file does not copy theorems.
  A conforming hierarchical subagent program is not claimed.
  This file does not claim that the gate passed.
-/

import HierarchicalSubagentsProofs

def main (_args : List String) : IO UInt32 := do
  IO.println "hierarchical_subagents_tests: proofs elaborated"
  return 0
