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
  9. Socket path, mode 0600, client commands, the nine method names,
     max_field of 80 tokens, and summary as the default detail level.
  10. The bus does not kill, reboot, or restart a session, does not
      replace ACP, and does not let an attached agent change permissions
      or configuration. When bus.readonly is true, the act tier is
      rejected and look, transcript, sessions, owns, and subscribe are not.

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
    expectEqString "socket path is the runtime directory socket"
      socketPathPattern "$XDG_RUNTIME_DIR/grok-oss/<session>.sock",
    expectEqString "socket mode is 0600" socketMode "0600",
    expectEqString "client command is grok-oss bus" clientCommand "grok-oss bus",
    expectEqString "mcp serve command exposes the bus"
      mcpServeCommand "grok-oss mcp-serve bus",
    expectTrue "the nine draft methods are the method list"
      (methodNames ==
        ["sessions", "look", "transcript", "owns", "interject", "queue",
          "approve", "deny", "subscribe"]),
    expectEqNat "max_field defaults to 80 tokens" maxFieldDefaultTokens 80,
    expectTrue "summary is the default detail level" summaryIsDefaultDetail,
    expectFalse "the bus does not kill sessions" busKillsSessions,
    expectFalse "the bus does not reboot a session" busRebootsSession,
    expectFalse "the bus does not restart a service" busRestartsService,
    expectFalse "the bus does not replace ACP" replacesAcp,
    expectFalse "an attached agent may not change permissions"
      attachedAgentMayChangePermissions,
    expectFalse "an attached agent may not change configuration"
      attachedAgentMayChangeConfig,
    expectTrue "attached agent is the defined term" attachedAgentIsDefinedTerm,
    expectTrue "the readonly effect is specified" readonlyEffectSpecified,
    expectFalse "allow_act defaults to false" allowActDefault,
    expectFalse "allow_approve defaults to false" allowApproveDefault,
    expectFalse "approve does not run when both keys are false"
      (actTierRuns false false .approve),
    expectFalse "approve does not run when only allow_act is true"
      (actTierRuns true false .approve),
    expectFalse "approve does not run when only allow_approve is true"
      (actTierRuns false true .approve),
    expectTrue "approve runs when both keys are true"
      (actTierRuns true true .approve),
    expectFalse "deny does not run when both keys are false"
      (actTierRuns false false .deny),
    expectFalse "deny does not run when only allow_act is true"
      (actTierRuns true false .deny),
    expectTrue "deny runs when both keys are true"
      (actTierRuns true true .deny),
    expectFalse "interject does not run when allow_act is false"
      (actTierRuns false true .interject),
    expectTrue "interject runs on allow_act without allow_approve"
      (actTierRuns true false .interject),
    expectFalse "queue does not run when allow_act is false"
      (actTierRuns false false .queue),
    expectTrue "queue runs on allow_act without allow_approve"
      (actTierRuns true false .queue),
    expectTrue "readonly rejects interject" (readonlyRejectsAct true .interject),
    expectTrue "readonly rejects queue" (readonlyRejectsAct true .queue),
    expectTrue "readonly rejects approve" (readonlyRejectsAct true .approve),
    expectTrue "readonly rejects deny" (readonlyRejectsAct true .deny),
    expectFalse "readonly does not reject look" (readonlyRejectsRead true .look),
    expectFalse "readonly does not reject transcript"
      (readonlyRejectsRead true .transcript),
    expectFalse "readonly does not reject sessions"
      (readonlyRejectsRead true .sessions),
    expectFalse "readonly does not reject owns" (readonlyRejectsRead true .owns),
    expectFalse "readonly does not reject subscribe"
      (readonlyRejectsRead true .subscribe),
    expectTrue "SO_PEERCRED is required" soPeercredRequired,
    expectEqString "directory mode is 0700" directoryMode "0700",
    expectFalse "a 0600 socket alone does not prove the peer"
      socketModeAloneProvesPeerUser,
    expectEqNat "look returns summaries of 3 turns" lookTurnCount 3,
    expectTrue "the default detail level is summary"
      (defaultDetailLevel == .summary),
    expectFalse "step does not add output" stepAddsOutput,
    expectTrue "full adds tool output" fullAddsOutput,
    expectTrue "meta is allowed by default" (contentClassAllowedByDefault .meta),
    expectTrue "chat is allowed by default" (contentClassAllowedByDefault .chat),
    expectTrue "call is allowed by default" (contentClassAllowedByDefault .call),
    expectFalse "output is denied by default"
      (contentClassAllowedByDefault .output),
    expectTrue "transcript is deltas from a turn id" transcriptCursorIsSinceTurnId,
    expectEqNat "an approval event bound is under one second"
      approvalSubscribeExclusiveUpperBoundSeconds 1,
    expectFalse "this bus does not redact tokens or keys" busRedactsToolSecrets,
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
      mash_conforming_session_bus_program_claimed_is_false,
    expectFalse "products are not claimed ready, as a finished claim"
      productsClaimedReadyForUse,
    expectConsFalse
      "claiming products are ready for use is Cons False"
      productsClaimedReadyForUse
      mashProductsClaimedReady
      mashProductsClaimedReadyIsFalse
      rfl
      mash_products_claimed_ready_is_false,
    expectConsFalse
      "claiming products never started is Cons False"
      productsClaimedNeverStarted
      mashProductsNeverStarted
      mashProductsNeverStartedIsFalse
      rfl
      mash_products_never_started_is_false,
    expectConsFalse
      "claiming a network listener is Cons False"
      networkListenerPresent
      mashNetworkListenerPresent
      mashNetworkListenerPresentIsFalse
      rfl
      mash_network_listener_present_is_false,
    expectFalse "a different user id is not allowed with same user id only"
      (socketAllows .other),
    expectConsFalse
      "same user id only and a different user id cannot both hold"
      (socketAllows .other)
      mashOtherUidWithSameUidOnly
      mashOtherUidWithSameUidOnlyIsFalse
      rfl
      mash_other_uid_with_same_uid_only_is_false,
    expectConsFalse
      "deltas only and full text cannot both hold"
      transcriptReturnsFullText
      mashFullTextWithDeltasOnly
      mashFullTextWithDeltasOnlyIsFalse
      rfl
      mash_full_text_with_deltas_only_is_false,
    expectConsFalse
      "approve on and off by default cannot both hold"
      approveDefault
      mashApproveOnAndOffByDefault
      mashApproveOnAndOffByDefaultIsFalse
      rfl
      mash_approve_on_and_off_by_default_is_false,
    expectConsFalse
      "deny on and off by default cannot both hold"
      denyDefault
      mashDenyOnAndOffByDefault
      mashDenyOnAndOffByDefaultIsFalse
      rfl
      mash_deny_on_and_off_by_default_is_false,
    expectConsFalse
      "claiming the bus kills a session is Cons False"
      busKillsSessions
      mashBusKillsSessions
      mashBusKillsSessionsIsFalse
      rfl
      mash_bus_kills_sessions_is_false,
    expectConsFalse
      "claiming the bus reboots a session is Cons False"
      busRebootsSession
      mashBusRebootsSession
      mashBusRebootsSessionIsFalse
      rfl
      mash_bus_reboots_session_is_false,
    expectConsFalse
      "claiming the bus restarts a service is Cons False"
      busRestartsService
      mashBusRestartsService
      mashBusRestartsServiceIsFalse
      rfl
      mash_bus_restarts_service_is_false,
    expectConsFalse
      "claiming the bus replaces ACP is Cons False"
      replacesAcp
      mashReplacesAcp
      mashReplacesAcpIsFalse
      rfl
      mash_replaces_acp_is_false,
    expectConsFalse
      "claiming an attached agent changes permissions is Cons False"
      attachedAgentMayChangePermissions
      mashAttachedAgentChangesPermissions
      mashAttachedAgentChangesPermissionsIsFalse
      rfl
      mash_outside_agent_changes_permissions_is_false,
    expectConsFalse
      "claiming an attached agent changes configuration is Cons False"
      attachedAgentMayChangeConfig
      mashAttachedAgentChangesConfig
      mashAttachedAgentChangesConfigIsFalse
      rfl
      mash_outside_agent_changes_config_is_false,
    expectConsFalse
      "claiming a Lean proof is the specification is Cons False"
      leanProofIsTheSpec
      mashLeanProofIsTheSpec
      mashLeanProofIsTheSpecIsFalse
      rfl
      mash_lean_proof_is_the_spec_is_false,
    expectConsFalse
      "claiming markdown substitutes for encodings is Cons False"
      humanMarkdownSubstitutesForLeanSpecEncoding
      mashMarkdownSubstitutesForEncodings
      mashMarkdownSubstitutesForEncodingsIsFalse
      rfl
      mash_markdown_substitutes_for_encodings_is_false,
    expectConsFalse
      "claiming readonly does not reject interject is Cons False"
      (!readonlyRejectsAct true .interject)
      mashReadonlyEffectSpecified
      mashReadonlyEffectSpecifiedIsFalse
      rfl
      mash_readonly_effect_specified_is_false,
    expectTrue "this markdown file is not the product program"
      markdownIsNotTheProgram,
    expectConsFalse
      "equating the human contract with the product program is Cons False"
      (!markdownIsNotTheProgram)
      mashMarkdownFileIsConformingProgram
      mashMarkdownFileIsConformingProgramIsFalse
      rfl
      mash_markdown_file_is_conforming_program_is_false,
    expectFalse "this document does not assign 0015 to fargo" assigns0015ToFargo,
    expectConsFalse
      "claiming 0015 is assigned to fargo is Cons False"
      assigns0015ToFargo
      mashAssigns0015ToFargo
      mashAssigns0015ToFargoIsFalse
      rfl
      mash_assigns_0015_to_fargo_is_false,
    expectFalse "an Anunnaki file at number 0015 does not exist"
      anunnakiFileAt0015Exists,
    expectConsFalse
      "claiming an Anunnaki file at number 0015 exists is Cons False"
      anunnakiFileAt0015Exists
      mashAnunnakiFileAt0015Exists
      mashAnunnakiFileAt0015ExistsIsFalse
      rfl
      mash_anunnaki_file_at_0015_exists_is_false,
    expectFalse "work streams are not claimed done" workStreamsClaimedDone,
    expectConsFalse
      "claiming the work streams are done is Cons False"
      workStreamsClaimedDone
      mashWorkStreamsClaimedDone
      mashWorkStreamsClaimedDoneIsFalse
      rfl
      mash_work_streams_claimed_done_is_false,
    expectFalse "no earlier shipped version is claimed" earlierShippedVersionClaimed,
    expectConsFalse
      "claiming an earlier shipped version is Cons False"
      earlierShippedVersionClaimed
      mashEarlierShippedVersionClaimed
      mashEarlierShippedVersionClaimedIsFalse
      rfl
      mash_earlier_shipped_version_claimed_is_false,
    expectFalse "attach does not start a second session" attachStartsSecondSession,
    expectConsFalse
      "claiming attach starts a second session is Cons False"
      attachStartsSecondSession
      mashAttachStartsSecondSession
      mashAttachStartsSecondSessionIsFalse
      rfl
      mash_attach_starts_second_session_is_false,
    expectFalse "the attached agent does not scrape the screen" scrapesTheScreen,
    expectConsFalse
      "claiming the attached agent scrapes the screen is Cons False"
      scrapesTheScreen
      mashScrapesTheScreen
      mashScrapesTheScreenIsFalse
      rfl
      mash_scrapes_the_screen_is_false,
    expectFalse "steer methods are not claimed implemented"
      steerMethodsClaimedImplemented,
    expectConsFalse
      "claiming steer methods are implemented is Cons False"
      steerMethodsClaimedImplemented
      mashSteerMethodsClaimedImplemented
      mashSteerMethodsClaimedImplementedIsFalse
      rfl
      mash_steer_methods_claimed_implemented_is_false,
    expectFalse "spec_check is not a meaning checker" specCheckIsMeaningChecker,
    expectConsFalse
      "claiming spec_check is a meaning checker is Cons False"
      specCheckIsMeaningChecker
      mashSpecCheckIsMeaningChecker
      mashSpecCheckIsMeaningCheckerIsFalse
      rfl
      mash_spec_check_is_meaning_checker_is_false
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
