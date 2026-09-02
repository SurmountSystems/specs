/-
  Hermetic tests for the README proven logical inconsistency table.
  Red: missing table or stale table versus proven False mash claims.
  Green: matching table is current.
-/

import InconsistencyReport

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

def fixtureMissing : String :=
  "# Surmount miscellaneous specifications\n\nNo table here.\n"

def fixtureStale : String :=
  "# README\n\n" ++
    beginMarker ++ "\n" ++
    headerRow ++ "\n" ++
    separatorRow ++ "\n" ++
    "| no | (none) | (none) | no proven logical inconsistency |\n" ++
    endMarker ++ "\n"

def fixtureCurrent : String :=
  "# README\n\n" ++ wrapTable generatedTable ++ "\n"

def runCases : List Case :=
  [
    expectEqNat "six proven False mash claims" provenClaims.length 6,
    expectTrue "catalog is nonempty" existsAny,
    expectFalse "README missing table is not current"
      (readmeTableCurrent fixtureMissing),
    expectFalse "stale table versus proven False mash claims is not current"
      (readmeTableCurrent fixtureStale),
    expectTrue "matching table is current"
      (readmeTableCurrent fixtureCurrent),
    expectFalse "missing markers fail extract"
      (extractSection fixtureMissing).isSome,
    expectTrue "current fixture extracts a section"
      (extractSection fixtureCurrent).isSome,
    expectTrue "generated table names mash_spec_and_proof"
      (!((generatedTable.splitOn "mash_spec_and_proof").length == 1)),
    expectTrue "generated table names mash_homes_is_inconsistent"
      (!((generatedTable.splitOn "mash_homes_is_inconsistent").length == 1)),
    expectTrue "generated table names UnlicenseProofs"
      (!((generatedTable.splitOn "lean/UnlicenseProofs.lean").length == 1)),
    expectTrue "generated table names mash_mit_meets_pdoss"
      (!((generatedTable.splitOn "mash_mit_meets_pdoss").length == 1)),
    expectTrue "generated table names mash_apache_meets_pdoss"
      (!((generatedTable.splitOn "mash_apache_meets_pdoss").length == 1)),
    expectTrue "generated table names mash_layers_inconsistent"
      (!((generatedTable.splitOn "mash_layers_inconsistent").length == 1)),
    expectTrue "generated table names Surmount mash file"
      (!((generatedTable.splitOn "lean/Surmount.lean").length == 1)),
    expectTrue "kind is intentional nonconformance"
      (!((generatedTable.splitOn "intentional nonconformance theorem").length == 1)),
    expectTrue "tableSectionOk is the product check"
      (tableSectionOk fixtureCurrent == readmeTableCurrent fixtureCurrent)
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
