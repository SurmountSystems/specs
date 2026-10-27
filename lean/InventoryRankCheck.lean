/-
  inventory_rank - print the highest shrink row and the living catalog length.

  The row is highestShrinkBlocking. The length is livingCount.
  Neither figure is a copied literal.

  When REPO_ROOT is set, exit nonzero if INVENTORY.md or RESIDUAL.md
  is present under that root. Print the row and the length before that
  exit. When REPO_ROOT is unset, print and exit zero. Do not scan the
  current directory in that case.
-/

import InventoryRank

open InventoryRank

def retiredTrackerNames : List String :=
  ["INVENTORY.md", "RESIDUAL.md"]

def main (_args : List String) : IO UInt32 := do
  IO.println (renderShrinkBlocking highestShrinkBlocking)
  IO.println s!"living catalog length {livingCount}"
  match (← IO.getEnv "REPO_ROOT") with
  | none =>
    return 0
  | some root =>
    let repo : System.FilePath := ⟨root⟩
    let mut present : List String := []
    for name in retiredTrackerNames do
      if (← (repo / name).pathExists) then
        present := present ++ [name]
    if present.isEmpty then
      return 0
    for name in present do
      IO.println s!"inventory_rank: {name} is present under REPO_ROOT"
    return 1
