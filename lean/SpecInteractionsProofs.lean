/-
  PROOFS for cited interactions among numbered specifications 0 through 16.

  This module is not the specification. It imports SpecInteractions.
  One theorem states when an ordered pair is not an interaction.
  Numbered markdown remains the contract humans read.
-/

import SpecInteractions

namespace SpecInteractionsProofs

open SpecInteractions

theorem citedPairs_length : citedPairs.length = 162 := by native_decide

def pairInRange (p : CitedPair) : Bool :=
  decide (p.source ≤ specNumberHi) && decide (p.target ≤ specNumberHi)

theorem citedPairs_inRange : citedPairs.all pairInRange = true := by native_decide

def samePair (a b : CitedPair) : Bool :=
  a.source == b.source && a.target == b.target

def listHasPair (p : CitedPair) : List CitedPair → Bool
  | [] => false
  | q :: qs => samePair p q || listHasPair p qs

def noDuplicatePairs : List CitedPair → Bool
  | [] => true
  | p :: ps => !listHasPair p ps && noDuplicatePairs ps

theorem citedPairs_noDuplicate : noDuplicatePairs citedPairs = true := by native_decide

/-- An ordered pair of specification numbers from 0 through 16, including a pair whose two numbers are equal, is not an interaction exactly when that pair is absent from `citedPairs`. -/
theorem nonInteraction_iff_absent (source target : Nat)
    (hsource : source ≤ specNumberHi) (htarget : target ≤ specNumberHi) :
    nonInteraction source target ↔ isCited source target = false := by
  unfold nonInteraction
  constructor
  · intro h
    exact h.2.2
  · intro h
    exact And.intro hsource (And.intro htarget h)

end SpecInteractionsProofs
