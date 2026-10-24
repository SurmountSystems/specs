/-
  Hermetic tests for the README proven logical inconsistency table.
  Red: missing table, stale table, a built proof absent from the catalog,
  or a catalog name that is not an inconsistency.
  Green: the catalog length is 168 and a matching table is current.
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

def fixtureSrc : String :=
  "theorem mash_hides_split : hidesSplit mashedFixture = true := rfl\n" ++
  "theorem mash_spec_and_proof_is_false : mashSpecAndProofIsFalse := by\n" ++
  "  intro h\n" ++
  "theorem mashed_does_not_conform :\n" ++
  "    conformingThisRepo mashedFixture = false :=\n" ++
  "  rfl\n"

def runCases : List Case :=
  [
    expectEqNat "built inconsistency catalog count" catalog.length 168,
    expectTrue "session bus mash_spec_and_proof_is_false is in the catalog"
      (hasClaim "lean/SessionBusProofs.lean" "mash_spec_and_proof_is_false"),
    expectTrue "session bus mash_conforming_session_bus_program_claimed_is_false is in the catalog"
      (hasClaim "lean/SessionBusProofs.lean"
        "mash_conforming_session_bus_program_claimed_is_false"),
    expectFalse "mash_hides_split is not an inconsistency"
      (claimInCatalog "mash_hides_split"),
    expectFalse "bool flag mash_vga256_as_doge_palette_is_false is not an inconsistency"
      (claimInCatalog "mash_vga256_as_doge_palette_is_false"),
    expectEqNat "a built inconsistency missing from the catalog fails the audit"
      (auditCatalog [sampleClaim] []).missing.length 1,
    expectEqNat "a catalog name that is not an inconsistency fails the audit"
      (auditCatalog [] [sampleClaim]).spurious.length 1,
    expectTrue "source scan keeps an IsFalse alias and drops a bool flag"
      (parseInconClaims fixtureSrc == ["mash_spec_and_proof_is_false"]),
    expectFalse "README missing table is not current"
      (readmeTableCurrent fixtureMissing),
    expectFalse "README stale table is not current"
      (readmeTableCurrent fixtureStale),
    expectTrue "README current table matches the catalog"
      (readmeTableCurrent fixtureCurrent),
    expectTrue "generated table names the session bus proof"
      (Nat.blt 1 (generatedTable.splitOn "mash_conforming_session_bus_program_claimed_is_false").length),
    expectTrue "catalog is not empty" existsAny
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
