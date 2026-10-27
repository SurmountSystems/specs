/-
  Hermetic tests for the inventory rank table.
  Ranks 1 through 4 are positive locks. They are not catalog rows.
  Every living catalog file and theorem pair appears once.
  The living length is the catalog length. It is not a copied numeral.
  That length is not 77, 78, 168, 193, 202, 210, 214, 222, or 225.
  The pure function highestShrinkBlocking returns the highest confident
  row, the next confident row, and the blocking fact that byte identity
  is required and is not claimed true. Assumed rows are not in that list.
  Sibling line indexes are 114 and 176 in 0007_CI and 480 in 0002_Systems_Lean.
  Index 114 is the array slot. It is not the markdown line number 115.
-/

import InventoryRank
import InconsistencyReport
import Surmount
import «0007_CI»
import «0002_Systems_Lean»

open InventoryRank
open InconsistencyReport

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

def retirementLength (file name : String) : Nat :=
  (withoutClaim file name).length

def rankedLock (n : Nat) (name file : String) : Bool :=
  match rankByNumber n with
  | some r =>
      r.rank == n &&
        r.theoremName == name &&
        r.sourceFile == file &&
        rowRole r == .positiveLock &&
        rowRole r != .livingCatalog &&
        inCatalog r.sourceFile r.theoremName == false
  | none => false

def mentions (hay needle : String) : Bool :=
  Nat.blt 1 (hay.splitOn needle).length

def shrinkFact : ShrinkBlocking :=
  highestShrinkBlocking

def shrinkText : String :=
  renderShrinkBlocking shrinkFact

def highestMatchesPure : Bool :=
  match highestConfidentRow with
  | some r =>
      r.theoremName == shrinkFact.highestTheorem &&
        r.sourceFile == shrinkFact.highestFile &&
        r.theoremName == "mash_compcert_refines_claimed_done_is_false" &&
        r.sourceFile == "lean/SystemsLeanProofs.lean" &&
        rowRole r == .livingCatalog &&
        inCatalog r.sourceFile r.theoremName == true &&
        inConfident r.sourceFile r.theoremName == true &&
        inAssumed r.sourceFile r.theoremName == false
  | none => false

def nextMatchesPure : Bool :=
  match nextConfidentRow, highestConfidentRow with
  | some n, some h =>
      Nat.blt h.rank n.rank &&
        n.theoremName == shrinkFact.nextTheorem &&
        n.sourceFile == shrinkFact.nextFile &&
        n.theoremName == "mash_self_host_from_c_satisfies_bootstrap_is_false" &&
        n.sourceFile == "lean/SystemsLeanProofs.lean" &&
        inConfident n.sourceFile n.theoremName == true &&
        inAssumed n.sourceFile n.theoremName == false &&
        shrinkFact.ciEncodedIndex0 == 114 &&
        shrinkFact.ciEncodedIndex1 == 176 &&
        shrinkFact.systemsLeanEncodedIndex == 480
  | _, _ => false

def blockingMatchesPure : Bool :=
  shrinkFact.byteIdentityRequired == true &&
    shrinkFact.byteIdentityClaimedTrue == false &&
    shrinkFact.liveReading == some .notClaimedTrue &&
    shrinkFact.liveReading != some .alreadyEqualsElf

theorem rank_one_is_compcert_lock_not_catalog :
    ranks[0]? = some (rankRow 1 assuranceClaimedDone compcertLockName compcertLockFile) ∧
      (ranks[0]?).map rowRole = some .positiveLock ∧
      (ranks[0]?).map rowRole ≠ some .livingCatalog ∧
      InconsistencyReport.claimInCatalog compcertLockName = false ∧
      (withoutClaim compcertLockFile compcertLockName).length =
        InconsistencyReport.catalog.length :=
  And.intro first_row
    (And.intro first_row_is_positive_lock
      (And.intro locks_are_not_living_roles.1
        (And.intro positive_locks_absent_from_catalog.1
          retiring_compcert_lock_does_not_shrink)))

theorem rank_two_is_slake_lock_not_catalog :
    ranks[1]? = some (rankRow 2 assuranceClaimedDone slakeLockName slakeLockFile) ∧
      (ranks[1]?).map rowRole = some .positiveLock ∧
      (ranks[1]?).map rowRole ≠ some .livingCatalog ∧
      InconsistencyReport.claimInCatalog slakeLockName = false ∧
      (withoutClaim slakeLockFile slakeLockName).length =
        InconsistencyReport.catalog.length :=
  And.intro second_row
    (And.intro second_row_is_positive_lock
      (And.intro locks_are_not_living_roles.2
        (And.intro positive_locks_absent_from_catalog.2
          retiring_slake_lock_does_not_shrink)))

theorem every_living_catalog_name_once :
    catalogNamesOnce = true :=
  catalog_names_once

theorem living_length_is_catalog_count :
    livingCount = InconsistencyReport.catalog.length :=
  living_catalog_length

theorem living_length_matches_catalog_length :
    livingCount = InconsistencyReport.catalog.length :=
  living_catalog_length

theorem rejected_lengths_are_not_the_living_length :
    staleCatalogLengths = [77, 78, 168, 193, 202, 210, 214, 222, 225] ∧
      staleCatalogLengths.all (fun n => n != livingCount) = true :=
  And.intro rfl stale_catalog_lengths_rejected

theorem living_length_is_not_a_stale_count :
    livingCount ≠ 77 ∧ livingCount ≠ 78 ∧ livingCount ≠ 168 ∧
      livingCount ≠ 193 ∧ livingCount ≠ 202 ∧ livingCount ≠ 210 ∧
      livingCount ≠ 214 ∧ livingCount ≠ 222 ∧ livingCount ≠ 225 := by
  native_decide

theorem rank_table_length_is_227_not_the_living_length :
    ranks.length = 227 ∧ ranks.length ≠ livingCount :=
  And.intro rank_table_length rank_count_is_not_living_count

theorem rank_three_is_byte_identity_lock_not_catalog :
    ranks[2]? = some (rankRow 3 assuranceClaimedDone
      byteIdentityLockName byteIdentityLockFile) ∧
      (ranks[2]?).map rowRole = some .positiveLock ∧
      (ranks[2]?).map rowRole ≠ some .livingCatalog ∧
      InconsistencyReport.claimInCatalog byteIdentityLockName = false ∧
      (withoutClaim byteIdentityLockFile byteIdentityLockName).length =
        InconsistencyReport.catalog.length :=
  And.intro third_row
    (And.intro third_row_is_positive_lock
      (And.intro byte_identity_locks_are_not_living.1
        (And.intro byte_identity_locks_absent_from_catalog.1
          retiring_byte_identity_lock_does_not_shrink)))

theorem rank_four_is_byte_identity_claim_lock_not_catalog :
    ranks[3]? = some (rankRow 4 assuranceClaimedDone
      byteIdentityClaimLockName byteIdentityClaimLockFile) ∧
      (ranks[3]?).map rowRole = some .positiveLock ∧
      (ranks[3]?).map rowRole ≠ some .livingCatalog ∧
      InconsistencyReport.claimInCatalog byteIdentityClaimLockName = false ∧
      (withoutClaim byteIdentityClaimLockFile byteIdentityClaimLockName).length =
        InconsistencyReport.catalog.length :=
  And.intro fourth_row
    (And.intro fourth_row_is_positive_lock
      (And.intro byte_identity_locks_are_not_living.2
        (And.intro byte_identity_locks_absent_from_catalog.2
          retiring_byte_identity_claim_lock_does_not_shrink)))

theorem highest_living_catalog_row_is_compcert_refines :
    highestLivingRow = some (rankRow 5 assuranceClaimedDone
      "mash_compcert_refines_claimed_done_is_false" "lean/SystemsLeanProofs.lean") :=
  Eq.trans highest_living_is_fifth_row fifth_row

theorem retiring_compcert_refines_shrinks_catalog_length :
    (withoutClaim "lean/SystemsLeanProofs.lean"
      "mash_compcert_refines_claimed_done_is_false").length =
      InconsistencyReport.catalog.length - 1 :=
  retiring_compcert_refines_shrinks

theorem next_rank_is_self_host_denial :
    nextRankRow = some (rankRow 6 assuranceClaimedDone
      "mash_self_host_from_c_satisfies_bootstrap_is_false"
      "lean/SystemsLeanProofs.lean") :=
  Eq.trans next_rank_is_sixth_row sixth_row

theorem shrink_selection_is_confident_only :
    shrinkRows.length = InconsistencyReport.confidentClaims.length ∧
      (shrinkRows.all fun r => inConfident r.sourceFile r.theoremName) = true ∧
      (shrinkRows.all fun r => inAssumed r.sourceFile r.theoremName == false) = true ∧
      highestConfidentRow = some (rankRow 5 assuranceClaimedDone
        "mash_compcert_refines_claimed_done_is_false" "lean/SystemsLeanProofs.lean") ∧
      nextConfidentRow = some (rankRow 6 assuranceClaimedDone
        "mash_self_host_from_c_satisfies_bootstrap_is_false"
        "lean/SystemsLeanProofs.lean") :=
  And.intro shrink_rows_match_confident_count
    (And.intro shrink_rows_are_confident
      (And.intro assumed_rows_absent_from_shrink_rows
        (And.intro
          (Eq.trans highest_confident_is_fifth_row fifth_row)
          (Eq.trans next_confident_is_sixth_row sixth_row))))

theorem retiring_self_host_shrinks_catalog_length :
    (withoutClaim "lean/SystemsLeanProofs.lean"
      "mash_self_host_from_c_satisfies_bootstrap_is_false").length =
      InconsistencyReport.catalog.length - 1 :=
  retiring_self_host_shrinks

theorem sibling_encoded_slots :
    Surmount.ciClause310ByteIdentityLine = «0007_CI».encodedLines[ciEncodedIndex0]! ∧
      Surmount.ciClause47Item2ByteIdentityLine = «0007_CI».encodedLines[ciEncodedIndex1]! ∧
      Surmount.systemsClause63ByteIdentityLine =
        «0002_Systems_Lean».encodedLines[systemsLeanEncodedIndex]! :=
  And.intro clause310_slot (And.intro clause47_slot clause63_slot)

theorem sibling_encoded_indexes :
    ciEncodedIndex0 = 114 ∧ ciEncodedIndex1 = 176 ∧ systemsLeanEncodedIndex = 480 :=
  And.intro rfl (And.intro rfl rfl)

theorem pure_function_returns_highest_shrink_and_blocking_fact :
    highestShrinkBlocking.highestTheorem = "mash_compcert_refines_claimed_done_is_false" ∧
      highestShrinkBlocking.highestFile = "lean/SystemsLeanProofs.lean" ∧
      highestShrinkBlocking.nextTheorem = "mash_self_host_from_c_satisfies_bootstrap_is_false" ∧
      highestShrinkBlocking.nextFile = "lean/SystemsLeanProofs.lean" ∧
      highestShrinkBlocking.ciEncodedIndex0 = 114 ∧
      highestShrinkBlocking.ciEncodedIndex1 = 176 ∧
      highestShrinkBlocking.systemsLeanEncodedIndex = 480 ∧
      highestShrinkBlocking.liveReading = some Surmount.ByteIdentityLiveReading.notClaimedTrue ∧
      highestShrinkBlocking.byteIdentityRequired = true ∧
      highestShrinkBlocking.byteIdentityClaimedTrue = false :=
  highest_shrink_blocking_fact

def runCases : List Case :=
  [
    expectTrue "rank 1 is the compcert lock and is not a catalog row"
      (rankedLock 1 compcertLockName compcertLockFile),
    expectTrue "rank 2 is the slake lock and is not a catalog row"
      (rankedLock 2 slakeLockName slakeLockFile),
    expectFalse "compcert lock name is not a catalog claim"
      (claimInCatalog compcertLockName),
    expectFalse "slake lock name is not a catalog claim"
      (claimInCatalog slakeLockName),
    expectEqNat "retiring rank 1 leaves the catalog length"
      (retirementLength compcertLockFile compcertLockName) catalog.length,
    expectEqNat "retiring rank 2 leaves the catalog length"
      (retirementLength slakeLockFile slakeLockName) catalog.length,
    expectTrue "every living catalog file and theorem pair appears once"
      catalogNamesOnce,
    expectTrue "living length matches the catalog length"
      (livingCount == catalog.length),
    expectTrue "catalog length is the living length"
      (catalog.length == livingCount),
    expectTrue "stale lengths are the rejected list"
      (staleCatalogLengths == [77, 78, 168, 193, 202, 210, 214, 222, 225]),
    expectTrue "none of the stale lengths is the living length"
      (staleCatalogLengths.all fun n => n != livingCount),
    expectFalse "77 is not the living length" (livingCount == 77),
    expectFalse "78 is not the living length" (livingCount == 78),
    expectFalse "168 is not the living length" (livingCount == 168),
    expectFalse "193 is not the living length" (livingCount == 193),
    expectFalse "202 is not the living length" (livingCount == 202),
    expectFalse "210 is not the living length" (livingCount == 210),
    expectFalse "214 is not the living length" (livingCount == 214),
    expectFalse "222 is not the living length" (livingCount == 222),
    expectFalse "225 is not the living length" (livingCount == 225),
    expectEqNat "rank table length is 227" ranks.length 227,
    expectFalse "rank table length is not the catalog length"
      (ranks.length == catalog.length),
    expectTrue "rank 3 is the byte identity lock and is not a catalog row"
      (rankedLock 3 byteIdentityLockName byteIdentityLockFile),
    expectTrue "rank 4 is the byte identity claim lock and is not a catalog row"
      (rankedLock 4 byteIdentityClaimLockName byteIdentityClaimLockFile),
    expectFalse "byte identity lock name is not a catalog claim"
      (claimInCatalog byteIdentityLockName),
    expectFalse "byte identity claim lock name is not a catalog claim"
      (claimInCatalog byteIdentityClaimLockName),
    expectEqNat "retiring rank 3 leaves the catalog length"
      (retirementLength byteIdentityLockFile byteIdentityLockName) catalog.length,
    expectEqNat "retiring rank 4 leaves the catalog length"
      (retirementLength byteIdentityClaimLockFile byteIdentityClaimLockName) catalog.length,
    expectTrue "highest confident row is CompCert refines in SystemsLeanProofs"
      highestMatchesPure,
    expectTrue "shrink list length is the confident count"
      (shrinkRows.length == confidentClaims.length),
    expectTrue "every shrink row is confident"
      (shrinkRows.all fun r => inConfident r.sourceFile r.theoremName),
    expectTrue "assumed rows are absent from the shrink list"
      (shrinkRows.all fun r => inAssumed r.sourceFile r.theoremName == false),
    expectFalse "reference target denial is not the shrink target"
      (shrinkFact.highestTheorem ==
        "mash_reference_target_satisfies_clause42_item6_is_false"),
    expectEqNat "retiring the highest shrink row shortens the catalog by one"
      (retirementLength shrinkFact.highestFile shrinkFact.highestTheorem)
      (catalog.length - 1),
    expectTrue "next rank is the self host denial in SystemsLeanProofs"
      nextMatchesPure,
    expectEqNat "retiring the next denial shortens the catalog by one"
      (retirementLength shrinkFact.nextFile shrinkFact.nextTheorem)
      (catalog.length - 1),
    expectEqNat "0007_CI encoded index 114" shrinkFact.ciEncodedIndex0 114,
    expectEqNat "0007_CI encoded index 176" shrinkFact.ciEncodedIndex1 176,
    expectEqNat "0002_Systems_Lean encoded index 480" shrinkFact.systemsLeanEncodedIndex 480,
    expectTrue "pure function says byte identity is required and is not claimed true"
      blockingMatchesPure,
    expectTrue "rendered fact names the CompCert refines denial"
      (mentions shrinkText "mash_compcert_refines_claimed_done_is_false"),
    expectTrue "rendered fact names lean/SystemsLeanProofs.lean"
      (mentions shrinkText "lean/SystemsLeanProofs.lean"),
    expectTrue "rendered fact names the self host denial"
      (mentions shrinkText "mash_self_host_from_c_satisfies_bootstrap_is_false"),
    expectTrue "rendered fact says byte identity is required and is not claimed true"
      (mentions shrinkText "Byte identity is required and is not claimed true."),
    expectTrue "rendered fact names encoded index 114" (mentions shrinkText "114"),
    expectTrue "rendered fact names encoded index 176" (mentions shrinkText "176"),
    expectTrue "rendered fact names encoded index 480" (mentions shrinkText "480")
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
    IO.println s!"All {runCases.length} tests passed."
    return 0
  else
    IO.eprintln s!"{failed} of {runCases.length} tests failed."
    return 1
