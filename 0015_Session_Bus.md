# Session Bus

> v0.1.0 - 20261024
>
> Outside access to a live `grok-oss` session over a `TOON` control plane that spends few tokens

## 1. Scope

This document specifies the session bus. An outside agent can look at a live `grok-oss` text user interface session, then act, then look again. The outside agent attaches to the session that is already running. It does not start a second session for that look. It does not scrape the screen.

This specification is number 0015. The file name is `0015_Session_Bus.md`. The source draft is `/home/hunter/0_session_bus_toon.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/SessionBusSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/SessionBusProofs.lean`. Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0015_Session_Bus.lean`. Those encodings are not this specification.

The source draft names a supervising agent, a Master Control Program inside Grok Bot, as the example of an outside agent that can see every running `grok-oss` session the way a person at the keyboard can. That name is an example in the draft. This specification does not assign that role a stack number.

Before an outside agent starts coding work in a repository, it can see whether a live session already owns that repository.

A conforming session bus program is not claimed. `grok-oss`, beastdb, SSSSS, Slake, and Continuous Integration are ongoing work and are not ready for use. This document does not say that those products never started.

### 1.1 Status of this document

1. This document is normative for the identity of the session bus as specification 0015, the local socket, the bus client, the named methods, the safety rules in Clause 4.4, the token budget in Clause 4.5, the success criteria in Clause 4.6, and the out of scope items in Clause 4.7.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0015. The file name is `0015_Session_Bus.md`. First publication of this specification as a numbered document is version 0.1.0 dated 20261024. No earlier shipped version of this specification is claimed.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
6. Public Domain Open Source Software is specified in `0009_PDOSS.md`. That document is specification 0009. That document is not this specification. Unlicense remains the license.
7. Anunnaki Encoding is specified in `0014_Anunnaki_Encoding.md`. That document is specification 0014. Number 0015 is not Anunnaki Encoding. This document MUST NOT be replaced by an Anunnaki Encoding file at number 0015. That Anunnaki file MUST NOT exist.
8. fargo has no assigned specification number. The Carbonado Network Protocol has no assigned specification number. This document does not assign 0015 to fargo or to Carbonado.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md`, requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/SessionBusSpec.lean` encode selected claims such as this document's identity as specification 0015 with file name `0015_Session_Bus.md`, approve and deny off by default, no network listener, a socket that allows the same user id only, a transcript that returns deltas only, no claim that a conforming session bus program exists, and that a mash of spec encodings plus proofs in one module does not conform.
3. Proofs of those encodings live in `lean/SessionBusProofs.lean`.
4. The sibling line encoding of this markdown is `0015_Session_Bus.lean`. Proofs of that line encoding live in `lean/Proofs_0015.lean`.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Systems Lean remains [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. beastdb remains [0003_beastdb.md](0003_beastdb.md).
4. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
5. Concise American Technical English remains [0005_CATE.md](0005_CATE.md).
6. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
7. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license.
8. Anunnaki Encoding remains [0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md). This document does not steal number 0014.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
3. Surmount specification `0000_spec.md`.
4. Surmount specification `0008_Formal_Vibefication.md`.

## 3. Terms

1. A session is one running `grok-oss` text user interface process.
2. An outside agent is a program that is not that session and that uses the bus client in Clause 4.2.
3. `TOON` is the notation the source draft names through `util/toon` and `GROK_TOOL_RESULT_FORMAT`. This specification does not redefine that notation.
4. Attach means open the socket of a session that is already running. Attach does not start a new session.
5. `ACP` names the internal agent client protocol the source draft records as already present inside `grok-oss`. This specification does not replace `ACP`.

## 4. Requirements

The keywords MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 4.1 Baseline the source draft records (informative)

This subsection is informative. It records what the source draft says already exists in `grok-oss`. Those sentences are not a conformance claim that this repository proved those commands. They are not a claim that a session bus program exists.

1. The draft records internal `ACP` (`app/acp_handler`, `session/acp_session_impl`). The draft records that `grok-oss agent stdio` runs a new agent over `stdio`.
2. The draft records `grok-oss running` with fields for process id, session id, working directory, state, model, and `subagents`. The draft also records `sessions`, `export`, and `leader list` and `leader info`.
3. The draft records `util/toon` and `GROK_TOOL_RESULT_FORMAT` with values `auto`, `toon`, and `json`.
4. The draft records the gap: there is no way to attach to a text user interface session that is already running. An outside agent that only sees `grok-oss running` sees a summary of one line.

### 4.2 Socket and client

1. Each running text user interface session MUST own one local socket.
2. The socket path MUST be `$XDG_RUNTIME_DIR/grok-oss/<session>.sock`.
3. The socket mode MUST be `0600`.
4. The socket MUST allow the same user id only. The socket MUST NOT allow a different user id.
5. The bus MUST NOT open a network listener.
6. The client MUST be `grok-oss bus`. The form MUST be `grok-oss bus <method> [session] [fields]` over `stdio`.
7. The client MUST use `TOON` for input and for output.
8. A `stdio` server invoked as `grok-oss mcp-serve bus` MUST expose the same methods as tools, so Grok Bot and any `MCP` client can call them.

### 4.3 Methods

A conforming bus MUST provide each method in this list. The tier names are the names in the source draft. This document does not add methods the draft does not name.

1. `sessions` returns the session id, the working directory, the repository and branch, the state (idle, working, or waiting for approval), the model, `subagents`, and the last activity. The tier is compact.
2. `look` returns the current goal, the plan and `todos`, summaries of the last N turns, a pending approval, and the files `git` reports as dirty. The tier MAY be compact, room, or rich.
3. `transcript` returns turns since the cursor `since:<turn_id>`. Those turns MUST be deltas only. The tier is rich.
4. `owns` returns which session, if any, is working in a given path or repository. The tier is compact.
5. `interject` injects a message into the running turn. That injection is the same as typing during the current turn. The tier is act.
6. `queue` places a prompt to run after the current turn. The tier is act.
7. `approve` and `deny` answer a pending permission prompt by id. The tier is act, and the pair is gated as in Clause 4.4.
8. `subscribe` streams state changes for turn start, turn end, approval needed, and error. The tier is event.

### 4.4 Safety

1. The socket rules in Clause 4.2 items 4 and 5 are REQUIRED.
2. A session MAY set `bus.readonly` to true. The source draft names that flag and does not state a further effect. This specification does not invent that effect.
3. `approve` MUST be off by default. The configuration key the draft names is `[bus] allow_approve = false` in `~/.grok/config.toml`.
4. `deny` is gated with `approve` in the source draft. `deny` MUST be off by default. The draft does not name a separate configuration key for `deny`.
5. Every act from an outside agent MUST be shown in the text user interface as `[bus: <client>]` followed by the act text, so the person at the keyboard can see who steered the session.
6. The bus MUST NOT reboot a session. The bus MUST NOT restart a service. The bus MUST NOT kill a session.
7. Steer methods (`interject`, `queue`, `approve`, and `deny`) MUST use the same permissions a person at that text user interface has. This document does not claim those methods are implemented.

### 4.5 Token budget

1. A bus reply MUST be compact by default.
2. Text fields returned by `look` MUST be capped at 80 characters. The source draft names that cap as the same style as `OUTLINE_STRING_MAX`.
3. `transcript` MUST return deltas from a cursor. `transcript` MUST NOT return the full session text.

### 4.6 Success criteria

A program that claims conformance to this specification MUST meet every item in this list. This document does not claim that such a program exists.

1. An outside agent can list sessions and can read each session plan without scraping.
2. Before that outside agent launches coding work, it can call `owns` and defer to the live session that already owns that repository.
3. `interject` and `queue` round trip, and the text user interface shows the attribution in Clause 4.4 item 5.
4. A default install exposes no network surface and does not approve by itself.

### 4.7 Out of scope

1. Remote access and network access are out of scope. Clause 4.2 item 5 already forbids a network listener.
2. Replacing `ACP` is out of scope.
3. Letting an outside agent change permissions or change configuration is out of scope.

### 4.8 Work the source draft names and this document does not claim is done

This subsection records work streams from the source draft. None of these items is claimed done. A parenthetical file name here is not the residual record. Clause 6 is the residual record.

1. The draft calls the plan itself work stream W0 and says it is done when that plan is merged. This repository does not record that merge.
2. Work stream W1 is a socket for each session in the text user interface, plus `sessions` and `look`. The draft says this is done when `grok-oss bus sessions` matches `grok-oss running`. That match is not claimed here.
3. Work stream W2 is `transcript` deltas plus `owns`. The draft says an outside agent can then tell that a session owns `~/Projects/surmount/colibri`. That check is not claimed here.
4. Work stream W3 is `interject` and `queue`, plus the attribution line in the text user interface. The draft says an interjection lands during the current turn and is visible. That landing is not claimed here.
5. Work stream W4 is `subscribe` events. The draft says an event that approval is needed reaches the client in less than one second. That timing is not claimed here.
6. Work stream W5 is `mcp-serve bus` over `stdio`. The draft says Grok Bot calls `look` through `MCP`. That call is not claimed here.
7. Work stream W6 is gated `approve` and `deny`. The draft says the gate is off by default and that tests cover the denial path. Those tests are not in this repository.
8. The draft says product tests are Rust tests in `xai-grok-shell`, in the same style as `test_leader_stdio_integration`, and that there is no Python driver. This repository does not contain those Rust tests and does not add a Python driver.

## 5. Required Conformance

Required conformance to this specification holds if and only if every item in this list holds.

1. This specification is number 0015 and the file name is `0015_Session_Bus.md` (Clause 1).
2. Each running text user interface session owns a local socket at `$XDG_RUNTIME_DIR/grok-oss/<session>.sock` with mode `0600`, the same user id only, and no network listener (Clause 4.2).
3. The client is `grok-oss bus` over `stdio` with `TOON` in both directions, and `grok-oss mcp-serve bus` exposes the same methods as tools (Clause 4.2).
4. The methods are `sessions`, `look`, `transcript`, `owns`, `interject`, `queue`, `approve`, `deny`, and `subscribe`, with the tiers and results in Clause 4.3.
5. `approve` and `deny` are off by default. `transcript` returns deltas only and does not return the full text. The bus does not kill a session (Clause 4.3, Clause 4.4, and Clause 4.5).
6. Replies are compact by default, and `look` field text is capped at 80 characters (Clause 4.5).
7. Remote access, replacing `ACP`, and outside changes to permissions or configuration are out of scope (Clause 4.7).
8. A conforming session bus program is not claimed (Clause 1 and Clause 4.6).
9. Numbered markdown remains the contract humans read. Lean spec encodings are not that markdown. Lean proofs are not the specification. A mash of spec encodings and their proofs in one module does not conform in this repository (Clause 1.2).

This specification is not itself a conforming session bus program. Meeting these items is a claim about a program that claims this specification. It is not a claim that this markdown file is that program.

Optional items (MAY, the unread effect of `bus.readonly`, and the informative baseline in Clause 4.1) do not break conformance when unmet.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program. This clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no numbered specification and no assigned number. This document does not create a numbered file for fargo.
2. The Carbonado Network Protocol has no numbered specification and no assigned number. This document does not create a Carbonado file.
3. The Surmount Systems System Prompt has no assigned number.
4. Number 0015 is this specification. It is not Anunnaki Encoding. An Anunnaki Encoding file at number 0015 MUST NOT exist.
5. This document does not assign a number after 0015. It does not create a file for that next number.
6. The source draft path is `/home/hunter/0_session_bus_toon.md`. An earlier note named `/home/hunter/Downloads/0_session_bus_toon.md`. That Downloads path is not the draft this file was encoded from. While the draft was missing, this numbered file was not written. The file is in the tree now.

### 6.2 Requirements the draft leaves unspecified or unimplemented

1. A conforming session bus program is not claimed. The work streams in Clause 4.8 are not claimed done.
2. The draft says `look` returns summaries of the last N turns and does not name N.
3. The draft names look tiers compact, room, and rich. It does not define how room differs from rich.
4. The draft names `bus.readonly = true` and does not state what that flag changes.
5. The draft names `[bus] allow_approve = false` and does not name a separate key for `deny`. This specification still requires `deny` off by default because the draft gates `deny` with `approve`.
6. The draft names the example path `~/Projects/surmount/colibri`. This repository does not check that path.
7. The draft names Rust tests in `xai-grok-shell`. Those tests are not in this repository.
8. `grok-oss`, `ACP`, `MCP`, and `TOON` are named. This repository does not pin those texts under `ref/`.
9. `lean/Surmount.lean` stores `numberFifteenPublishedFileExists` as true because `0015_Session_Bus.md` is published. Theorem `claiming_published_session_bus_file_absent_yields_false` proves that claiming the published file is absent yields False. The publication record for this file is also `lean/SpecRegistry.lean`.
10. `0002_Systems_Lean.md`, `0010_Surmount_Systems.md`, and `0014_Anunnaki_Encoding.md` still contain sentences that say this numbered file is absent because the draft was missing. This document does not rewrite those files. Their sibling line encodings would have to change with them.
11. `0005_CATE.md` Clause 3.5 still names fourteen comment paths and does not name `lean/SessionBusSpec.lean`. `lean/LineEncodings.lean` adds that path to the comment scan. This document does not rewrite `0005_CATE.md`.

### 6.3 Product claims that are not ready for use

1. beastdb, SSSSS, Slake, Continuous Integration, and the session bus program remain ongoing and are not ready for use. This document MUST NOT be read as claiming that those products never started.
2. `lean/SessionBusSpec.lean` encodes selected claims. `lean/SessionBusProofs.lean` proves those claims. `0015_Session_Bus.lean` encodes the physical lines of this markdown file. `lean/Proofs_0015.lean` proves identities of that line encoding. Those modules are not a proof that a conforming session bus program exists.
3. Lake wiring for this specification is `lean/SessionBusSpec.lean`, `lean/SessionBusProofs.lean`, sibling `0015_Session_Bus.lean`, `lean/Proofs_0015.lean`, and the `session_bus_tests` check.

## 7. Changelog

### 0.1.0 - 20261024

First publication of the session bus as numbered specification 0015 with file name `0015_Session_Bus.md`. Records attach to a text user interface session that is already running, a local socket at `$XDG_RUNTIME_DIR/grok-oss/<session>.sock` with mode `0600` and the same user id only, no network listener, client `grok-oss bus` over `stdio` with `TOON` in both directions, and `grok-oss mcp-serve bus` for the same methods. Records methods `sessions`, `look`, `transcript`, `owns`, `interject`, `queue`, `approve`, `deny`, and `subscribe`. Records `approve` and `deny` off by default, transcript deltas only, an 80 character cap on `look` fields, attribution `[bus: <client>]`, and that the bus does not kill a session. Records that remote access, replacing `ACP`, and outside changes to permissions or configuration are out of scope. Records that a conforming session bus program is not claimed. The source draft is `/home/hunter/0_session_bus_toon.md`.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This specification records the session bus draft at `/home/hunter/0_session_bus_toon.md`. It does not add product goals that draft does not state.
