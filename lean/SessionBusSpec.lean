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

  conformingSessionBusProgramClaimed is false.
  The act tier keys default to false. There is no network listener.
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

/-- Clause 4.5. max_field defaults to 80 tokens. That default is a specification choice. -/
def maxFieldDefaultTokens : Nat := 80

/-- Clause 4.5. Summary is the default detail level. -/
def summaryIsDefaultDetail : Bool := true

/-- The bus does not kill, reboot, or restart a session. -/
def busKillsSessions : Bool := false

def busRebootsSession : Bool := false

def busRestartsService : Bool := false

/-- Remote replacement of ACP, and attached agent permission or config edits, are out of scope. -/
def replacesAcp : Bool := false

/-- Clause 4.7. An attached agent must not change permissions. -/
def attachedAgentMayChangePermissions : Bool := false

/-- Clause 4.7. An attached agent must not change configuration. -/
def attachedAgentMayChangeConfig : Bool := false

/-- Clause 3. Attached agent is the defined term. -/
def attachedAgentIsDefinedTerm : Bool := true

/-- Clause 4.4. The effect of bus.readonly is specified. -/
def readonlyEffectSpecified : Bool := true

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

/-- Clause 1. The attached agent does not scrape the screen. -/
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

def mashAttachedAgentChangesPermissions : Prop :=
  attachedAgentMayChangePermissions = true

def mashAttachedAgentChangesPermissionsIsFalse : Prop :=
  mashAttachedAgentChangesPermissions → False

def mashAttachedAgentChangesConfig : Prop :=
  attachedAgentMayChangeConfig = true

def mashAttachedAgentChangesConfigIsFalse : Prop :=
  mashAttachedAgentChangesConfig → False

def mashLeanProofIsTheSpec : Prop :=
  leanProofIsTheSpec = true

def mashLeanProofIsTheSpecIsFalse : Prop :=
  mashLeanProofIsTheSpec → False

def mashMarkdownSubstitutesForEncodings : Prop :=
  humanMarkdownSubstitutesForLeanSpecEncoding = true

def mashMarkdownSubstitutesForEncodingsIsFalse : Prop :=
  mashMarkdownSubstitutesForEncodings → False

/-- Clause 4.4. [bus] allow_act defaults to false. -/
def allowActDefault : Bool := false

/-- Clause 4.4. [bus] allow_approve defaults to false. -/
def allowApproveDefault : Bool := false

inductive ActMethod where
  | interject
  | queue
  | approve
  | deny
  deriving DecidableEq, Repr, BEq

inductive ReadMethod where
  | sessions
  | look
  | transcript
  | owns
  | subscribe
  deriving DecidableEq, Repr, BEq

/-- interject and queue need allow_act. approve and deny need both keys. -/
def actTierRuns (allowAct allowApprove : Bool) (m : ActMethod) : Bool :=
  match m with
  | .interject => allowAct
  | .queue => allowAct
  | .approve => allowAct && allowApprove
  | .deny => allowAct && allowApprove

/-- When bus.readonly is true, the act tier method is rejected. -/
def readonlyRejectsAct (readonly : Bool) (m : ActMethod) : Bool :=
  match m with
  | .interject => readonly
  | .queue => readonly
  | .approve => readonly
  | .deny => readonly

/-- look, transcript, sessions, owns, and subscribe are not rejected by bus.readonly. -/
def readonlyRejectsRead (readonly : Bool) (_m : ReadMethod) : Bool :=
  readonly && false

/-- Clause 4.2. The server must verify the peer with SO_PEERCRED. -/
def soPeercredRequired : Bool := true

/-- Clause 4.2. The directory mode is 0700. -/
def directoryMode : String := "0700"

/-- Clause 4.2. A 0600 socket alone does not prove the peer user. -/
def socketModeAloneProvesPeerUser : Bool := false

/-- Clause 4.3. look returns summaries of the last 3 turns. -/
def lookTurnCount : Nat := 3

/-- Clause 4.5. Detail levels replace the retired tier names. -/
inductive DetailLevel where
  | summary
  | step
  | full
  deriving DecidableEq, Repr, BEq

/-- Clause 4.5. Summary is the default detail level. -/
def defaultDetailLevel : DetailLevel := .summary

/-- Clause 4.5. Step adds tool name, arguments, and exit status, and does not add output. -/
def stepAddsOutput : Bool := false

/-- Clause 4.5. Full adds tool output. -/
def fullAddsOutput : Bool := true

/-- Clause 4.5. Content classes. Output is denied by default. -/
inductive ContentClass where
  | «meta»
  | chat
  | call
  | output
  deriving DecidableEq, Repr, BEq

def contentClassAllowedByDefault : ContentClass → Bool
  | .meta => true
  | .chat => true
  | .call => true
  | .output => false

/-- Clause 4.2. Each L1 owns one socket. Plain streaming I/O. No ZeroMQ. No broker. -/
def eachL1OwnsOneSocket : Bool := true

def plainStreamingIo : Bool := true

def usesZeroMq : Bool := false

def usesBrokerDaemon : Bool := false

/-- Clause 4.2. The session bus server, not L0, runs on the same host as the L1 sessions. -/
def serverSameHostAsL1 : Bool := true

def serverWatchesWithInotify : Bool := true

/-- Clause 4.2. The session bus server must not add a network listener. -/
def serverMayAddNetworkListener : Bool := false

/-- Clause 4.2. Whether the serve command exists in a product tree is not verified here. -/
def mcpServeCommandVerifiedInProductTree : Bool := false

/-- Clause 4.2. Bind a temporary path, then rename atomically. -/
def bindTempThenAtomicRename : Bool := true

/-- Clause 4.2. A flock marks a live session. A taken lock means stale and is cleaned up. -/
def flockMarksLiveSession : Bool := true

def staleLockIsCleaned : Bool := true

/-- Clause 4.2. Never unlink a live socket. -/
def neverUnlinkLiveSocket : Bool := true

/-- Clause 4.2. Abstract namespace sockets are forbidden. File descriptors are CLOEXEC. -/
def abstractNamespaceForbidden : Bool := true

def socketFdCloexec : Bool := true

/-- Clause 4.2. At most 8 subscribers. Specification choice, not a measurement. -/
def maxSubscribersPerSession : Nat := 8

/-- Clause 4.2. One message is at most 64 KiB. The ring holds 1024 events. -/
def maxMessageBytes : Nat := 64 * 1024

def ringEventCount : Nat := 1024

/-- 64 KiB times 1024 is 64 MiB. -/
def ringByteBudget : Nat := 64 * 1024 * 1024

/-- Clause 4.2. Listen backlog is 16. systemd socket activation is not required. -/
def listenBacklog : Nat := 16

def systemdSocketActivationRequired : Bool := false

/-- Clause 4.9. The wire schema is not selected. TOON is not the wire format. -/
def wireSchemaChosen : Bool := false

def toonIsWireFormat : Bool := false

def toonAtModelBoundary : Bool := true

def validatorChecksFrameFirst : Bool := true

def fieldIdsReused : Bool := false

def unknownEventKindsSkipped : Bool := true

/-- Clause 4.10. Event kinds, order, gap, and ping. -/
def eventKinds : List String :=
  ["session.start", "turn.start", "turn.end", "approval.needed",
    "approval.resolved", "error", "goal.changed", "plan.changed",
    "idle", "exit", "gap", "throttled", "ping",
    "l2.spawned", "l2.report_written", "l2.compacted",
    "l3.spawned", "l3.finished", "resume_from", "follow_up",
    "exit.without_report"]

/-- Clause 4.10. seq increases when the later value is greater. -/
def seqFollows (earlier later : Nat) : Bool :=
  decide (earlier < later)

/-- Clause 4.10. A skip needs a gap. A consecutive pair does not. -/
def gapCoversSkip (earlier later : Nat) (gapPresent : Bool) : Bool :=
  if later <= earlier + 1 then true else gapPresent

/-- Silent loss is a skip that the gap mark does not cover. -/
def lossIsSilent (earlier later : Nat) (gapPresent : Bool) : Bool :=
  !gapCoversSkip earlier later gapPresent

def orderedWithinSession : Bool := true

def orderedAcrossSessions : Bool := false

def slowSubscriberStallsSession : Bool := false

def subscribeSinceReplays : Bool := true

def gapMeansLookOnce : Bool := true

def approvalTestProgramClaimed : Bool := false

def pingPeriodSeconds : Nat := 30

/-- Clause 4.11. Extra Model Context Protocol tools. -/
def mcpExtraTools : List String :=
  ["events_since", "bus_wait"]

def eventsSinceExposed : Bool := true

def busWaitExposed : Bool := true

def busWaitBlocksUntilEventOrTimeout : Bool := true

def mcpNotificationsForwarded : Bool := true

/-- Operator requirement. Current product behavior is not verified in this repository. -/
def grokBotUsesWaitPath : Bool := true

def grokBotProductBehaviorVerified : Bool := false

/-- Clause 4.5. No default number for max_tokens_per_min. Omission is rejected. -/
def maxTokensPerMinHasDefault : Bool := false

def subscribeWithoutCapRejected : Bool := true

def capDropsEvent : Bool := false

def capLowersDetailAndEmitsThrottled : Bool := true

def blockedFieldRendersWithheld : Bool := true

/-- Clause 4.12. Diff and log collapse. The set of output kinds is not closed. -/
def diffCollapsesToHunkHeaders : Bool := true

def logCollapsesToErrorLines : Bool := true

def collapseSetClosed : Bool := false

/-- Clause 4.4. Tool output is not trusted. The secret check is not a guarantee. -/
def toolOutputIsUntrusted : Bool := true

def renderedFieldsMarkData : Bool := true

def secretShapeCheckRuns : Bool := true

def secretCheckIsGuarantee : Bool := false

def busRedactsEverySecret : Bool := false

/-- Clause 4.4. Origin bound is 1. The first act is allowed. A later act with that origin is refused. -/
def originDepthBound : Nat := 1

def actOriginAllowed : Nat → Bool
  | 0 => true
  | _ + 1 => false

/-- Clause 4.13. Deployment permissions. Names, numbers, hosts, and the log path are not assigned. -/
def dedicatedAgentUserRequired : Bool := true

def accountNameAssigned : Bool := false

def systemdNoNewPrivileges : Bool := true

def systemdPrivateTmp : Bool := true

def systemdProtectSystemStrict : Bool := true

def protectHomeOrReadOnlyPathsSatisfies : Bool := true

def cgroupNumberAssigned : Bool := false

def ipAddressDenyDefault : Bool := true

def allowedHostListAssigned : Bool := false

def landlockOrBubblewrapRequired : Bool := true

def confinementChoiceIsDeployment : Bool := true

def auditLogAppendOnly : Bool := true

def auditLogPathAssigned : Bool := false

/-- Clause 6.3. The Lean check does not cover the live sandbox, Landlock, bubblewrap, or the tunnel. -/
def leanCheckCoversLiveSystemd : Bool := false

def leanCheckCoversLandlock : Bool := false

def leanCheckCoversBubblewrap : Bool := false

def leanCheckCoversTunnel : Bool := false

/-- Clause 4.3. transcript stays deltas from since a turn id. -/
def transcriptCursorIsSinceTurnId : Bool := true

/-- Clause 4.3. Exclusive upper bound in seconds for an approval needed event. -/
def approvalSubscribeExclusiveUpperBoundSeconds : Nat := 1

/-- Clause 4.4. This bus does not redact tokens or keys in look or transcript. -/
def busRedactsToolSecrets : Bool := false

/-- Claim that interject still runs when bus.readonly is true. This is the negation of the reject on interject, and that negation is false. -/
def readonlyInterjectStillRuns : Bool :=
  !(readonlyRejectsAct true .interject)

/-- Claiming an act tier method still runs when bus.readonly is true. -/
def mashReadonlyEffectSpecified : Prop :=
  readonlyInterjectStillRuns = true

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

/-- Clause 4.15. The session bus server is not L0 and is not a layer. -/
def sessionBusServerIsL0 : Bool := false

def sessionBusServerIsLayer : Bool := false

def l0IsClientOfSessionBusServer : Bool := true

/-- Clause 4.15. The Master Control Program is an attached client. No layer list here. -/
def masterControlProgramIsAttachedClient : Bool := true

/-- Clause 4.2. Only an L1 owns a session socket. -/
def onlyL1OwnsSessionSocket : Bool := true

def l2OwnsSessionSocket : Bool := false

def l3OwnsSessionSocket : Bool := false

/-- Clause 4.4. Acts may address L1 or a watched L2. They do not address an L3. -/
inductive ActAddress where
  | l1
  | watchedL2
  | l3
  deriving DecidableEq, Repr, BEq

def actAddressAllowed : ActAddress → Bool
  | .l1 => true
  | .watchedL2 => true
  | .l3 => false

/-- Clause 4.13. An inherited sandbox does not widen the L1 sandbox. -/
structure SandboxBits where
  noNewPrivileges : Bool
  privateTmp : Bool
  protectSystemStrict : Bool
  deriving DecidableEq, Repr

def bitsWiden (child parent : SandboxBits) : Bool :=
  (child.noNewPrivileges && !parent.noNewPrivileges) ||
    (child.privateTmp && !parent.privateTmp) ||
    (child.protectSystemStrict && !parent.protectSystemStrict)

def l1Sandbox : SandboxBits :=
  { noNewPrivileges := true, privateTmp := true, protectSystemStrict := true }

def inheritedL2Sandbox : SandboxBits :=
  { noNewPrivileges := true, privateTmp := true, protectSystemStrict := false }

def inheritedSandboxWidensL1 : Bool := false

/-- Clause 4.3 and Clause 4.16. Fields this specification owns. -/
def sessionsLookSubagentsExposeTree : Bool := true

def ownsNamesWriteSetLayer : Bool := true

def restatesWriteSetRule : Bool := false

def exposesLayerTokenTotals : Bool := true

def exposesLayerCostTotals : Bool := true

def totalsRollUpToParent : Bool := true

def accountingCrossChecked : Bool := true

def disagreementFlagged : Bool := true

def dollarPriceSet : Bool := false

def lookCarriesBuildProgress : Bool := true

def lookInterruptsLongBuild : Bool := false

def restatesOneJobRule : Bool := false

def exitWithoutReportEventPresent : Bool := true

/-- The not finished rule stays in specification 0016. -/
def statesExitWithoutReportIsNotFinished : Bool := false

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
    maxFieldDefaultTokens == 80 &&
    summaryIsDefaultDetail &&
    !busKillsSessions &&
    !busRebootsSession &&
    !busRestartsService &&
    !replacesAcp &&
    !attachedAgentMayChangePermissions &&
    !attachedAgentMayChangeConfig &&
    attachedAgentIsDefinedTerm &&
    readonlyEffectSpecified &&
    allowActDefault == false &&
    allowApproveDefault == false &&
    actTierRuns false false .interject == false &&
    actTierRuns false false .queue == false &&
    actTierRuns false false .approve == false &&
    actTierRuns false false .deny == false &&
    actTierRuns true false .interject == true &&
    actTierRuns true false .queue == true &&
    actTierRuns true false .approve == false &&
    actTierRuns true true .approve == true &&
    actTierRuns true true .deny == true &&
    readonlyRejectsAct true .interject &&
    readonlyRejectsAct true .queue &&
    readonlyRejectsAct true .approve &&
    readonlyRejectsAct true .deny &&
    readonlyRejectsAct false .interject == false &&
    !readonlyRejectsRead true .look &&
    !readonlyRejectsRead true .transcript &&
    !readonlyRejectsRead true .sessions &&
    !readonlyRejectsRead true .owns &&
    !readonlyRejectsRead true .subscribe &&
    soPeercredRequired &&
    directoryMode == "0700" &&
    socketMode == "0600" &&
    !socketModeAloneProvesPeerUser &&
    !networkListenerPresent &&
    lookTurnCount == 3 &&
    defaultDetailLevel == .summary &&
    summaryIsDefaultDetail &&
    stepAddsOutput == false &&
    fullAddsOutput &&
    contentClassAllowedByDefault .meta &&
    contentClassAllowedByDefault .chat &&
    contentClassAllowedByDefault .call &&
    contentClassAllowedByDefault .output == false &&
    eachL1OwnsOneSocket &&
    plainStreamingIo &&
    !usesZeroMq &&
    !usesBrokerDaemon &&
    serverSameHostAsL1 &&
    serverWatchesWithInotify &&
    !serverMayAddNetworkListener &&
    !mcpServeCommandVerifiedInProductTree &&
    bindTempThenAtomicRename &&
    flockMarksLiveSession &&
    staleLockIsCleaned &&
    neverUnlinkLiveSocket &&
    abstractNamespaceForbidden &&
    socketFdCloexec &&
    maxSubscribersPerSession == 8 &&
    maxMessageBytes == 64 * 1024 &&
    ringEventCount == 1024 &&
    ringByteBudget == 64 * 1024 * 1024 &&
    maxMessageBytes * ringEventCount == ringByteBudget &&
    listenBacklog == 16 &&
    !systemdSocketActivationRequired &&
    !wireSchemaChosen &&
    !toonIsWireFormat &&
    toonAtModelBoundary &&
    validatorChecksFrameFirst &&
    !fieldIdsReused &&
    unknownEventKindsSkipped &&
    eventKinds ==
      ["session.start", "turn.start", "turn.end", "approval.needed",
        "approval.resolved", "error", "goal.changed", "plan.changed",
        "idle", "exit", "gap", "throttled", "ping",
        "l2.spawned", "l2.report_written", "l2.compacted",
        "l3.spawned", "l3.finished", "resume_from", "follow_up",
        "exit.without_report"] &&
    seqFollows 1 2 &&
    seqFollows 2 2 == false &&
    gapCoversSkip 4 5 false &&
    gapCoversSkip 4 6 true &&
    lossIsSilent 4 6 false &&
    lossIsSilent 4 6 true == false &&
    orderedWithinSession &&
    !orderedAcrossSessions &&
    !slowSubscriberStallsSession &&
    subscribeSinceReplays &&
    gapMeansLookOnce &&
    !approvalTestProgramClaimed &&
    pingPeriodSeconds == 30 &&
    mcpExtraTools == ["events_since", "bus_wait"] &&
    eventsSinceExposed &&
    busWaitExposed &&
    busWaitBlocksUntilEventOrTimeout &&
    mcpNotificationsForwarded &&
    grokBotUsesWaitPath &&
    !grokBotProductBehaviorVerified &&
    !maxTokensPerMinHasDefault &&
    subscribeWithoutCapRejected &&
    !capDropsEvent &&
    capLowersDetailAndEmitsThrottled &&
    blockedFieldRendersWithheld &&
    diffCollapsesToHunkHeaders &&
    logCollapsesToErrorLines &&
    !collapseSetClosed &&
    toolOutputIsUntrusted &&
    renderedFieldsMarkData &&
    secretShapeCheckRuns &&
    !secretCheckIsGuarantee &&
    !busRedactsEverySecret &&
    originDepthBound == 1 &&
    actOriginAllowed 0 &&
    actOriginAllowed 1 == false &&
    dedicatedAgentUserRequired &&
    !accountNameAssigned &&
    systemdNoNewPrivileges &&
    systemdPrivateTmp &&
    systemdProtectSystemStrict &&
    protectHomeOrReadOnlyPathsSatisfies &&
    !cgroupNumberAssigned &&
    ipAddressDenyDefault &&
    !allowedHostListAssigned &&
    landlockOrBubblewrapRequired &&
    confinementChoiceIsDeployment &&
    auditLogAppendOnly &&
    !auditLogPathAssigned &&
    !leanCheckCoversLiveSystemd &&
    !leanCheckCoversLandlock &&
    !leanCheckCoversBubblewrap &&
    !leanCheckCoversTunnel &&
    transcriptCursorIsSinceTurnId &&
    approvalSubscribeExclusiveUpperBoundSeconds == 1 &&
    !busRedactsToolSecrets &&
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
    !conformingThisRepo mashedFixture &&
    !sessionBusServerIsL0 &&
    !sessionBusServerIsLayer &&
    l0IsClientOfSessionBusServer &&
    masterControlProgramIsAttachedClient &&
    onlyL1OwnsSessionSocket &&
    !l2OwnsSessionSocket &&
    !l3OwnsSessionSocket &&
    actAddressAllowed .l1 &&
    actAddressAllowed .watchedL2 &&
    actAddressAllowed .l3 == false &&
    !inheritedSandboxWidensL1 &&
    bitsWiden inheritedL2Sandbox l1Sandbox == false &&
    sessionsLookSubagentsExposeTree &&
    ownsNamesWriteSetLayer &&
    !restatesWriteSetRule &&
    exposesLayerTokenTotals &&
    exposesLayerCostTotals &&
    totalsRollUpToParent &&
    accountingCrossChecked &&
    disagreementFlagged &&
    !dollarPriceSet &&
    lookCarriesBuildProgress &&
    !lookInterruptsLongBuild &&
    !restatesOneJobRule &&
    exitWithoutReportEventPresent &&
    !statesExitWithoutReportIsNotFinished

end SessionBusSpec
