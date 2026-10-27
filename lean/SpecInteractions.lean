/-
  SPEC ENCODINGS for cited interactions among numbered specifications 0 through 16.

  This module states the cited ordered pairs. It is not a proof module.
  Proofs live in SpecInteractionsProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  The source number is the specification that owns the inventory section.
  The target number is the specification named by the target file.
  Repeated rows with the same source and the same target are one record.
  A row whose status is "do not invent a link" is not a record.
-/

namespace SpecInteractions

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

/-- Lowest and highest specification numbers in this encoding. -/
def specNumberLo : Nat := 0

def specNumberHi : Nat := 16

/-- One cited ordered pair. `source` cites `target`. -/
structure CitedPair where
  source : Nat
  target : Nat
  deriving DecidableEq, Repr, BEq

/-- Distinct cited pairs from candidate links and markdown path links.
    Order is first appearance in the inventory, specification 0000 through 0016. -/
def citedPairs : List CitedPair := [
  { source := 0, target := 5 },
  { source := 0, target := 1 },
  { source := 0, target := 11 },
  { source := 0, target := 6 },
  { source := 1, target := 0 },
  { source := 2, target := 4 },
  { source := 2, target := 0 },
  { source := 2, target := 8 },
  { source := 2, target := 3 },
  { source := 2, target := 6 },
  { source := 2, target := 13 },
  { source := 2, target := 15 },
  { source := 2, target := 12 },
  { source := 2, target := 9 },
  { source := 3, target := 4 },
  { source := 3, target := 6 },
  { source := 3, target := 0 },
  { source := 3, target := 8 },
  { source := 3, target := 2 },
  { source := 3, target := 5 },
  { source := 4, target := 2 },
  { source := 4, target := 3 },
  { source := 4, target := 0 },
  { source := 4, target := 8 },
  { source := 4, target := 5 },
  { source := 4, target := 6 },
  { source := 4, target := 13 },
  { source := 4, target := 7 },
  { source := 4, target := 9 },
  { source := 5, target := 0 },
  { source := 5, target := 6 },
  { source := 5, target := 9 },
  { source := 5, target := 11 },
  { source := 5, target := 12 },
  { source := 5, target := 13 },
  { source := 5, target := 7 },
  { source := 5, target := 8 },
  { source := 5, target := 10 },
  { source := 5, target := 2 },
  { source := 5, target := 3 },
  { source := 5, target := 4 },
  { source := 5, target := 1 },
  { source := 5, target := 14 },
  { source := 6, target := 13 },
  { source := 6, target := 0 },
  { source := 6, target := 5 },
  { source := 6, target := 8 },
  { source := 6, target := 2 },
  { source := 6, target := 3 },
  { source := 6, target := 4 },
  { source := 6, target := 7 },
  { source := 6, target := 9 },
  { source := 7, target := 0 },
  { source := 7, target := 5 },
  { source := 7, target := 6 },
  { source := 7, target := 8 },
  { source := 7, target := 2 },
  { source := 7, target := 3 },
  { source := 7, target := 4 },
  { source := 7, target := 9 },
  { source := 8, target := 5 },
  { source := 8, target := 9 },
  { source := 8, target := 11 },
  { source := 8, target := 12 },
  { source := 8, target := 13 },
  { source := 8, target := 0 },
  { source := 8, target := 6 },
  { source := 8, target := 7 },
  { source := 8, target := 10 },
  { source := 8, target := 2 },
  { source := 8, target := 3 },
  { source := 8, target := 4 },
  { source := 9, target := 5 },
  { source := 9, target := 11 },
  { source := 9, target := 12 },
  { source := 9, target := 13 },
  { source := 9, target := 0 },
  { source := 9, target := 6 },
  { source := 9, target := 8 },
  { source := 9, target := 10 },
  { source := 9, target := 7 },
  { source := 9, target := 2 },
  { source := 9, target := 3 },
  { source := 9, target := 4 },
  { source := 10, target := 8 },
  { source := 10, target := 13 },
  { source := 10, target := 5 },
  { source := 10, target := 9 },
  { source := 10, target := 11 },
  { source := 10, target := 12 },
  { source := 10, target := 0 },
  { source := 10, target := 6 },
  { source := 10, target := 7 },
  { source := 10, target := 2 },
  { source := 10, target := 3 },
  { source := 10, target := 4 },
  { source := 10, target := 14 },
  { source := 10, target := 15 },
  { source := 11, target := 12 },
  { source := 11, target := 13 },
  { source := 11, target := 0 },
  { source := 11, target := 5 },
  { source := 11, target := 6 },
  { source := 11, target := 7 },
  { source := 11, target := 8 },
  { source := 11, target := 9 },
  { source := 11, target := 10 },
  { source := 11, target := 2 },
  { source := 11, target := 3 },
  { source := 11, target := 4 },
  { source := 12, target := 11 },
  { source := 12, target := 13 },
  { source := 12, target := 0 },
  { source := 12, target := 5 },
  { source := 12, target := 6 },
  { source := 12, target := 7 },
  { source := 12, target := 8 },
  { source := 12, target := 9 },
  { source := 12, target := 10 },
  { source := 12, target := 2 },
  { source := 12, target := 3 },
  { source := 12, target := 4 },
  { source := 13, target := 6 },
  { source := 13, target := 5 },
  { source := 13, target := 9 },
  { source := 13, target := 11 },
  { source := 13, target := 12 },
  { source := 13, target := 2 },
  { source := 13, target := 0 },
  { source := 13, target := 7 },
  { source := 13, target := 8 },
  { source := 13, target := 10 },
  { source := 13, target := 3 },
  { source := 13, target := 4 },
  { source := 13, target := 14 },
  { source := 14, target := 5 },
  { source := 14, target := 4 },
  { source := 14, target := 12 },
  { source := 14, target := 15 },
  { source := 14, target := 0 },
  { source := 14, target := 8 },
  { source := 14, target := 9 },
  { source := 14, target := 13 },
  { source := 14, target := 2 },
  { source := 14, target := 3 },
  { source := 14, target := 7 },
  { source := 15, target := 0 },
  { source := 15, target := 5 },
  { source := 15, target := 8 },
  { source := 15, target := 9 },
  { source := 15, target := 14 },
  { source := 15, target := 2 },
  { source := 15, target := 3 },
  { source := 15, target := 4 },
  { source := 15, target := 10 },
  { source := 16, target := 15 },
  { source := 16, target := 0 },
  { source := 16, target := 5 },
  { source := 16, target := 6 },
  { source := 16, target := 8 },
  { source := 16, target := 9 },
  { source := 16, target := 7 }
]

/-- True when `source` and `target` occur together in `citedPairs`. -/
def isCited (source target : Nat) : Bool :=
  citedPairs.any fun p => p.source == source && p.target == target

/-- A pair inside 0 through 16 is not an interaction when it is absent from `citedPairs`.
    Pairs whose two numbers are equal use this same predicate. -/
def nonInteraction (source target : Nat) : Prop :=
  source ≤ specNumberHi ∧ target ≤ specNumberHi ∧ isCited source target = false

end SpecInteractions
