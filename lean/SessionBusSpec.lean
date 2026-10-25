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

/-- Socket path, mode, and client commands named by the session bus draft. -/
def socketPathPattern : String :=
  "$XDG_RUNTIME_DIR/grok-oss/<session>.sock"

def socketMode : String := "0600"

def clientCommand : String := "grok-oss bus"

def mcpServeCommand : String := "grok-oss mcp-serve bus"

/-- Methods the draft names. No extra method is required here. -/
def methodNames : List String :=
  ["sessions", "look", "transcript", "owns", "interject", "queue",
    "approve", "deny", "subscribe"]

/-- Look field text is capped at 80 characters. Replies are compact by default. -/
def lookFieldCap : Nat := 80

def compactByDefault : Bool := true

/-- The bus does not kill, reboot, or restart a session. -/
def busKillsSessions : Bool := false

def busRebootsSession : Bool := false

def busRestartsService : Bool := false

/-- Remote replacement of ACP, and outside permission or config edits, are out of scope. -/
def replacesAcp : Bool := false

def outsideAgentMayChangePermissions : Bool := false

def outsideAgentMayChangeConfig : Bool := false

/-- The draft names bus.readonly and does not state what that flag changes. -/
def readonlyEffectSpecified : Bool := false

/-- This document does not claim a conforming session bus program. -/
def conformingSessionBusProgramClaimed : Bool := false

def productsClaimedReadyForUse : Bool := false

def productsClaimedNeverStarted : Bool := false

/-- Clause 1.1 item 8. This document does not assign 0015 to fargo. -/
def assigns0015ToFargo : Bool := false

/-- Clause 1.1 item 7. An Anunnaki Encoding file at number 0015 must not exist. -/
def anunnakiFileAt0015Exists : Bool := false

/-- Clause 4.8 and Clause 6.2. The work streams are not claimed done. -/
def workStreamsClaimedDone : Bool := false

/-- Clause 1.1 item 3. No earlier shipped version is claimed. -/
def earlierShippedVersionClaimed : Bool := false

/-- Clause 1. Attach does not start a second session. -/
def attachStartsSecondSession : Bool := false

/-- Clause 1. The outside agent does not scrape the screen. -/
def scrapesTheScreen : Bool := false

/-- Clause 4.4 item 7. Steer methods are not claimed implemented. -/
def steerMethodsClaimedImplemented : Bool := false

/-- Clause 1.2 item 5. spec_check is form, not meaning. -/
def specCheckIsMeaningChecker : Bool := false

/-- Four layers of composition. Distinct constructors state the split. -/
inductive Layer where
  | humanMarkdownContract
  | leanSpecEncoding
  | leanProof
  | productImplementation
  deriving DecidableEq, Repr, BEq

/-- Clause 5. This markdown file is not itself a conforming program. -/
def markdownIsNotTheProgram : Bool :=
  !(Layer.humanMarkdownContract == Layer.productImplementation)

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

/-- Claiming the named products are ready for use. Clause 1 and Clause 6.3. -/
def mashProductsClaimedReady : Prop :=
  productsClaimedReadyForUse = true

def mashProductsClaimedReadyIsFalse : Prop :=
  mashProductsClaimedReady → False

/-- Claiming those products never started. Clause 6.3 item 1 forbids that reading. -/
def mashProductsNeverStarted : Prop :=
  productsClaimedNeverStarted = true

def mashProductsNeverStartedIsFalse : Prop :=
  mashProductsNeverStarted → False

/-- Claiming a network listener. Clause 4.2 item 5 forbids one. -/
def mashNetworkListenerPresent : Prop :=
  networkListenerPresent = true

def mashNetworkListenerPresentIsFalse : Prop :=
  mashNetworkListenerPresent → False

/-- Same user id only and a different user id allowed cannot both hold. -/
def mashOtherUidWithSameUidOnly : Prop :=
  socketIsSameUidOnly = true ∧ socketAllows .other = true

def mashOtherUidWithSameUidOnlyIsFalse : Prop :=
  mashOtherUidWithSameUidOnly → False

/-- Deltas only and a full session text cannot both hold. -/
def mashFullTextWithDeltasOnly : Prop :=
  transcriptReturnsDeltasOnly = true ∧ transcriptReturnsFullText = true

def mashFullTextWithDeltasOnlyIsFalse : Prop :=
  mashFullTextWithDeltasOnly → False

/-- Approve on by default and off by default cannot both hold. -/
def mashApproveOnAndOffByDefault : Prop :=
  approveDefault = true ∧ approveOffByDefault = true

def mashApproveOnAndOffByDefaultIsFalse : Prop :=
  mashApproveOnAndOffByDefault → False

/-- Deny on by default and off by default cannot both hold. -/
def mashDenyOnAndOffByDefault : Prop :=
  denyDefault = true ∧ denyOffByDefault = true

def mashDenyOnAndOffByDefaultIsFalse : Prop :=
  mashDenyOnAndOffByDefault → False

def mashBusKillsSessions : Prop :=
  busKillsSessions = true

def mashBusKillsSessionsIsFalse : Prop :=
  mashBusKillsSessions → False

def mashBusRebootsSession : Prop :=
  busRebootsSession = true

def mashBusRebootsSessionIsFalse : Prop :=
  mashBusRebootsSession → False

def mashBusRestartsService : Prop :=
  busRestartsService = true

def mashBusRestartsServiceIsFalse : Prop :=
  mashBusRestartsService → False

def mashReplacesAcp : Prop :=
  replacesAcp = true

def mashReplacesAcpIsFalse : Prop :=
  mashReplacesAcp → False

def mashOutsideAgentChangesPermissions : Prop :=
  outsideAgentMayChangePermissions = true

def mashOutsideAgentChangesPermissionsIsFalse : Prop :=
  mashOutsideAgentChangesPermissions → False

def mashOutsideAgentChangesConfig : Prop :=
  outsideAgentMayChangeConfig = true

def mashOutsideAgentChangesConfigIsFalse : Prop :=
  mashOutsideAgentChangesConfig → False

def mashLeanProofIsTheSpec : Prop :=
  leanProofIsTheSpec = true

def mashLeanProofIsTheSpecIsFalse : Prop :=
  mashLeanProofIsTheSpec → False

def mashMarkdownSubstitutesForEncodings : Prop :=
  humanMarkdownSubstitutesForLeanSpecEncoding = true

def mashMarkdownSubstitutesForEncodingsIsFalse : Prop :=
  mashMarkdownSubstitutesForEncodings → False

/-- Claiming the unread effect of bus.readonly is specified. The text does not state that effect. -/
def mashReadonlyEffectSpecified : Prop :=
  readonlyEffectSpecified = true

def mashReadonlyEffectSpecifiedIsFalse : Prop :=
  mashReadonlyEffectSpecified → False

/-- Clause 5. The human contract is not the product program. -/
def mashMarkdownFileIsConformingProgram : Prop :=
  Layer.humanMarkdownContract = Layer.productImplementation

def mashMarkdownFileIsConformingProgramIsFalse : Prop :=
  mashMarkdownFileIsConformingProgram → False

def mashAssigns0015ToFargo : Prop :=
  assigns0015ToFargo = true

def mashAssigns0015ToFargoIsFalse : Prop :=
  mashAssigns0015ToFargo → False

def mashAnunnakiFileAt0015Exists : Prop :=
  anunnakiFileAt0015Exists = true

def mashAnunnakiFileAt0015ExistsIsFalse : Prop :=
  mashAnunnakiFileAt0015Exists → False

def mashWorkStreamsClaimedDone : Prop :=
  workStreamsClaimedDone = true

def mashWorkStreamsClaimedDoneIsFalse : Prop :=
  mashWorkStreamsClaimedDone → False

def mashEarlierShippedVersionClaimed : Prop :=
  earlierShippedVersionClaimed = true

def mashEarlierShippedVersionClaimedIsFalse : Prop :=
  mashEarlierShippedVersionClaimed → False

def mashAttachStartsSecondSession : Prop :=
  attachStartsSecondSession = true

def mashAttachStartsSecondSessionIsFalse : Prop :=
  mashAttachStartsSecondSession → False

def mashScrapesTheScreen : Prop :=
  scrapesTheScreen = true

def mashScrapesTheScreenIsFalse : Prop :=
  mashScrapesTheScreen → False

def mashSteerMethodsClaimedImplemented : Prop :=
  steerMethodsClaimedImplemented = true

def mashSteerMethodsClaimedImplementedIsFalse : Prop :=
  mashSteerMethodsClaimedImplemented → False

def mashSpecCheckIsMeaningChecker : Prop :=
  specCheckIsMeaningChecker = true

def mashSpecCheckIsMeaningCheckerIsFalse : Prop :=
  mashSpecCheckIsMeaningChecker → False

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
    socketPathPattern == "$XDG_RUNTIME_DIR/grok-oss/<session>.sock" &&
    socketMode == "0600" &&
    clientCommand == "grok-oss bus" &&
    mcpServeCommand == "grok-oss mcp-serve bus" &&
    methodNames ==
      ["sessions", "look", "transcript", "owns", "interject", "queue",
        "approve", "deny", "subscribe"] &&
    lookFieldCap == 80 &&
    compactByDefault &&
    !busKillsSessions &&
    !busRebootsSession &&
    !busRestartsService &&
    !replacesAcp &&
    !outsideAgentMayChangePermissions &&
    !outsideAgentMayChangeConfig &&
    !readonlyEffectSpecified &&
    !conformingSessionBusProgramClaimed &&
    !productsClaimedReadyForUse &&
    !productsClaimedNeverStarted &&
    !assigns0015ToFargo &&
    !anunnakiFileAt0015Exists &&
    !workStreamsClaimedDone &&
    !earlierShippedVersionClaimed &&
    !attachStartsSecondSession &&
    !scrapesTheScreen &&
    !steerMethodsClaimedImplemented &&
    !specCheckIsMeaningChecker &&
    markdownIsNotTheProgram &&
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
