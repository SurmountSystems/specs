/-
  SPEC ENCODINGS for numbered specification 0015 Session Bus.

  This module states what must be true. It is not a proof module.
  Proofs of these propositions live in SessionBusProofs.lean.
  Numbered markdown at the repository root is the contract humans read.
  That markdown is not a substitute for these encodings.
  Lean proofs are not the specification.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  This file does not claim a conforming session bus program.
  Approve and deny are off by default. There is no network listener.
  The socket allows the same uid only. The transcript returns deltas only.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

namespace SessionBusSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0015. Same shape as anunnakiSpecNumber. -/
def sessionBusSpecNumber : Nat := 15

def specNumber : Nat := 15

def specFileName : String := "0015_Session_Bus.md"

def productName : String := "Session Bus"

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- Approve and deny are off by default. The stored default is false. -/
def approveDefault : Bool := false

def denyDefault : Bool := false

def approveOffByDefault : Bool := !approveDefault

def denyOffByDefault : Bool := !denyDefault

/-- There is no network listener. -/
def networkListenerPresent : Bool := false

/-- The socket allows the same uid and rejects a different uid. -/
inductive SocketUid where
  | same
  | other
  deriving DecidableEq, Repr, BEq

def socketAllows (uid : SocketUid) : Bool :=
  match uid with
  | .same => true
  | .other => false

def socketIsSameUidOnly : Bool :=
  socketAllows .same && !socketAllows .other

/-- The transcript returns deltas only. It does not return the full text. -/
def transcriptReturnsDeltas : Bool := true

def transcriptReturnsFullText : Bool := false

def transcriptReturnsDeltasOnly : Bool :=
  transcriptReturnsDeltas && !transcriptReturnsFullText

/-- This document does not claim a conforming session bus program. -/
def conformingSessionBusProgramClaimed : Bool := false

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

structure LeanModuleRole where
  moduleName : String
  containsSpecEncodings : Bool
  containsProofsOfThoseEncodings : Bool
  markedAsSpecEncoding : Bool
  markedAsProof : Bool
  deriving DecidableEq, Repr, BEq

def hidesSplit (m : LeanModuleRole) : Bool :=
  m.containsSpecEncodings && m.containsProofsOfThoseEncodings

def conformingThisRepo (m : LeanModuleRole) : Bool :=
  !hidesSplit m &&
    (!m.containsSpecEncodings || (m.markedAsSpecEncoding && !m.markedAsProof)) &&
    (!m.containsProofsOfThoseEncodings || (m.markedAsProof && !m.markedAsSpecEncoding))

def specEncodingFixture : LeanModuleRole :=
  { moduleName := "SessionBusSpec"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := false
    markedAsSpecEncoding := true
    markedAsProof := false }

def proofFixture : LeanModuleRole :=
  { moduleName := "SessionBusProofs"
    containsSpecEncodings := false
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := false
    markedAsProof := true }

def mashedFixture : LeanModuleRole :=
  { moduleName := "MashedSpecAndProof"
    containsSpecEncodings := true
    containsProofsOfThoseEncodings := true
    markedAsSpecEncoding := true
    markedAsProof := true }

def mashedIsNonconformingThisRepo : Prop :=
  conformingThisRepo mashedFixture = false

def mashSpecAndProof : Prop :=
  Layer.leanSpecEncoding = Layer.leanProof

def mashSpecAndProofIsFalse : Prop :=
  mashSpecAndProof → False

/-- Claiming a conforming session bus program is Cons False. A program is not claimed. -/
def mashConformingSessionBusProgramClaimed : Prop :=
  conformingSessionBusProgramClaimed = true

def mashConformingSessionBusProgramClaimedIsFalse : Prop :=
  mashConformingSessionBusProgramClaimed → False

/-- Required conformance holds iff every listed conjunct holds. -/
def requiredConformanceHolds : Bool :=
  sessionBusSpecNumber == 15 &&
    specNumber == 15 &&
    sessionBusSpecNumber == specNumber &&
    specFileName == "0015_Session_Bus.md" &&
    !approveDefault &&
    !denyDefault &&
    approveOffByDefault &&
    denyOffByDefault &&
    !networkListenerPresent &&
    socketAllows .same &&
    !socketAllows .other &&
    socketIsSameUidOnly &&
    transcriptReturnsDeltas &&
    !transcriptReturnsFullText &&
    transcriptReturnsDeltasOnly &&
    !conformingSessionBusProgramClaimed &&
    !productsClaimedReadyForUse &&
    !productsClaimedNeverStarted &&
    liveContainsSpecEncodings &&
    !liveContainsProofsOfThoseEncodings &&
    markedAsSpecEncoding &&
    !markedAsProof &&
    humanMarkdownIsTheHumanContract &&
    !humanMarkdownSubstitutesForLeanSpecEncoding &&
    !leanProofIsTheSpec &&
    conformingThisRepo specEncodingFixture &&
    conformingThisRepo proofFixture &&
    !conformingThisRepo mashedFixture

end SessionBusSpec
