/-
  Runtime checks for Session Bus spec encodings and proofs.
  Theorems in SessionBusProofs.lean already fail to typecheck if the
  split is mashed. This executable re-checks the decidable facts so a
  silent Bool regression prints FAIL lines.

  TDD named contracts (observe intended FAIL as comments, then the
  same cases PASS when SessionBusSpec encodings are correct):

  1. sessionBusSpecNumber and specNumber are 15. FAIL if that Nat is not 15.
  2. File name is 0015_Session_Bus.md.
  3. Approve and deny are off by default. FAIL if either default is true.
  4. There is no network listener. FAIL if networkListenerPresent is true.
  5. The socket allows the same uid only. FAIL if a different uid is allowed.
  6. The transcript returns deltas only. FAIL if full text is returned.
  7. A conforming session bus program is not claimed.
  8. Mash of spec encodings plus proofs in one module is False.

  This file does not import SpecRegistry or a sibling line encoding.
  Lake and flake wiring are not edited here.
-/

import SessionBusSpec
import SessionBusProofs

open SessionBusSpec
open SessionBusProofs

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

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

def runCases : List Case :=
  [
    -- Intended FAIL if sessionBusSpecNumber is not 15.
    expectEqNat "Session Bus is specification 0015" sessionBusSpecNumber 15,
    expectEqNat "specNumber is 15" specNumber 15,
    expectTrue "sessionBusSpecNumber matches specNumber"
      (sessionBusSpecNumber == specNumber),
    expectEqString "Session Bus file is 0015_Session_Bus.md"
      specFileName "0015_Session_Bus.md",
    expectEqString "product name is Session Bus" productName "Session Bus",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "SessionBusSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "SessionBusSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectFalse "approve is off by default" approveDefault,
    expectFalse "deny is off by default" denyDefault,
    expectTrue "approve off by default holds" approveOffByDefault,
    expectTrue "deny off by default holds" denyOffByDefault,
    expectFalse "there is no network listener" networkListenerPresent,
    expectTrue "the socket allows the same uid" (socketAllows .same),
    expectFalse "the socket rejects a different uid" (socketAllows .other),
    expectTrue "the socket is same uid only" socketIsSameUidOnly,
    expectTrue "the transcript returns deltas" transcriptReturnsDeltas,
    expectFalse "the transcript does not return full text"
      transcriptReturnsFullText,
    expectTrue "the transcript returns deltas only" transcriptReturnsDeltasOnly,
    expectFalse "a conforming session bus program is not claimed"
      conformingSessionBusProgramClaimed,
    expectFalse "products are not claimed ready for use"
      productsClaimedReadyForUse,
    expectFalse "products are not claimed never started"
      productsClaimedNeverStarted,
    expectTrue "human markdown is the contract humans read"
      humanMarkdownIsTheHumanContract,
    expectFalse "human markdown does not substitute for Lean spec encodings"
      humanMarkdownSubstitutesForLeanSpecEncoding,
    expectFalse "Lean proof is not the spec" leanProofIsTheSpec,
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "mashed fixture hides the split" (hidesSplit mashedFixture),
    expectTrue "required conformance holds" requiredConformanceHolds,
    expectConsFalse
      "a mash of the spec encoding module with the proofs module is False"
      (conformingThisRepo mashedFixture)
      mashSpecAndProof
      mashSpecAndProofIsFalse
      rfl
      mash_spec_and_proof_is_false,
    expectConsFalse
      "claiming a conforming session bus program is Cons False"
      conformingSessionBusProgramClaimed
      mashConformingSessionBusProgramClaimed
      mashConformingSessionBusProgramClaimedIsFalse
      rfl
      mash_conforming_session_bus_program_claimed_is_false
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
    IO.println s!"session_bus_tests: {runCases.length} passed"
    return 0
  else
    IO.eprintln s!"session_bus_tests: {failed} failed"
    return 1
