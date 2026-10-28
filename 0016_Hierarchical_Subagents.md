# Hierarchical Subagents

> v0.1.0 - 20261026
>
> How a laptop coordinator, a main session, a coordinator, and a specialist divide work

## 1. Scope

This document specifies hierarchical subagents. It names the layers, what each layer does, and what each layer does not do.

This specification is number 0016. The file name is `0016_Hierarchical_Subagents.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/HierarchicalSubagentsSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/HierarchicalSubagentsProofs.lean`. The sibling line encoding this specification uses is `0016_Hierarchical_Subagents.lean` at the repository root, with proofs in `lean/Proofs_0016.lean`. This document does not claim those Lean files are already present. Those encodings are not this specification.

`L0` is a client of the session bus server, as [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.15 states. This document does not restate that protocol and does not restate that reason.

A conforming hierarchical subagent program is not claimed. This document does not say that such a program is ready.

### 1.1 Status of this document

1. This document is normative for the layer names, the duties in Clause 4, the fast path of four acts, the report rules, the plan gate, parallelism without a numeric cap, the long build rule, finished work, test order where a change is a behavior change, and process repair when an instruction is repeated. Clause 4.11 is informative.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0016. The file name is `0016_Hierarchical_Subagents.md`. The version line is 0.1.0 dated 20261026. No earlier shipped version of this specification is claimed.
4. Concise American Technical English (CATE) is specified in [0005_CATE.md](0005_CATE.md). CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement is specified in [0006_RSI.md](0006_RSI.md). That document is specification 0006. That document is not this specification. This document cites it because a chat reminder is not a durable tool. That citation is not a claim that specification 0006 states the repetition rule in Clause 4.14.
6. Formal Vibefication is specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). That document is specification 0008. That document is not this specification.
7. Public Domain Open Source Software is specified in [0009_PDOSS.md](0009_PDOSS.md). That document is specification 0009. That document is not this specification. Unlicense remains the license.
8. The session bus is specified in [0015_Session_Bus.md](0015_Session_Bus.md). That document is specification 0015. Number 0016 is not the session bus.
9. fargo has no assigned specification number. The Carbonado Network Protocol has no assigned specification number. This document does not assign 0016 to fargo or to Carbonado.
10. This document does not steal specification numbers [0005](0005_CATE.md) through [0015](0015_Session_Bus.md).

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to proofs checked by machine. It is not a form rule under [0000_spec.md](0000_spec.md).

In languages with dependent types, a specification (what has to be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md), asks that the specification also be encoded in Lean as declarations of what has to be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/HierarchicalSubagentsSpec.lean` encode selected claims from this document.
3. Proofs of those encodings live in `lean/HierarchicalSubagentsProofs.lean`.
4. The sibling line encoding of this markdown is `0016_Hierarchical_Subagents.lean`. Proofs of that line encoding live in `lean/Proofs_0016.lean`. This document does not claim those files are already present.
5. A Lean module SHALL NOT mix those encodings with their proofs. A module that mixes them does not conform, as [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md) requires for a mash that hides the split. This document does not paste theorems.
6. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in [0000_spec.md](0000_spec.md)) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at [0005_CATE.md](0005_CATE.md) for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md).
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous integration as a numbered specification remains [0007_CI.md](0007_CI.md). This document does not claim that file states the long build rule in Clause 4.10.
5. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
6. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license.
7. The session bus remains [0015_Session_Bus.md](0015_Session_Bus.md). This document does not steal number 0015.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
3. Surmount specification [0000_spec.md](0000_spec.md).
4. Surmount specification [0005_CATE.md](0005_CATE.md).
5. Surmount specification [0006_RSI.md](0006_RSI.md).
6. Surmount specification [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
7. Surmount specification [0009_PDOSS.md](0009_PDOSS.md).
8. Surmount specification [0015_Session_Bus.md](0015_Session_Bus.md).

## 3. Terms

1. `L0` means the laptop coordinator. The crate name is `surmount-coordinator-gui`. `L0` queues prompts. `L0` is not a nested agent.
2. The call name `grok-oss gui` is an informative name for that same coordinator. It matches the crate.
3. `L1` means the main session.
4. `L2` means the coordinator. In this specification the word coordinator means `L2` only.
5. `L3` means the specialist. In this specification the word specialist means `L3` only.
6. `L4` is not a layer in this specification.
7. A nested agent in this specification means `L1`, `L2`, or `L3`.
8. A report means a file on disk that passes work from one layer to the next. A report is not a join.
9. A write set means the files one work stream changes.
10. The task description given to an `L2` means the text that `L2` receives when it is spawned.
11. The hierarchical fast path means the four acts in Clause 4.4.
12. Approve means the operator approval after which nested exploration and nested implementation start.
13. Red then green means a failing test first, then the fix, where Clause 4.13 applies.

## 4. Requirements

The keywords MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 4.1 Layers

1. `L0` SHALL be the laptop coordinator whose crate name is `surmount-coordinator-gui`. `L0` SHALL queue prompts. `L0` SHALL NOT be a nested agent.
2. The call name `grok-oss gui` is informative and matches that crate. This specification SHALL NOT state that `L0` merges into a pager dashboard.
3. `L1` SHALL be the main session. `L1` is the context where the agent talks to the operator.
4. `L2` SHALL be the coordinator. The word coordinator SHALL mean `L2` only.
5. `L3` SHALL be the specialist. The word specialist SHALL mean `L3` only.
6. There SHALL be no `L4`.
7. An attached client SHALL NOT be a layer.
8. The session bus server is not a layer, as [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.15 states. This specification does not restate that reason.
9. Socket ownership, and the `sessions`, `look`, and `subagents` tree, are [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.2 and Clause 4.3. This specification does not restate that field list.
10. [Issue 224](https://github.com/SurmountSystems/grok-oss/issues/224) calls `L0` the dashboard, one level above `L1`.
11. Layers can talk to the layer above and the layer below.

### 4.2 Naming

1. Authors SHALL NOT call a layer a parent, and SHALL NOT call a layer a child, in chat, board titles, spawn descriptions, plans, reports, residual, or docs.
2. Authors SHALL NOT compare layers to operating system process trees in those same places.
3. This specification SHALL NOT use the phrase child process for an agent. That phrase names a real operating system process in other technical documents. This document does not use it for an agent.
4. Files on disk that pass work from one layer to the next SHALL be called reports. They SHALL NOT be called joins.
5. When explaining this structure, an author MAY name parallelism that forks work and then joins the results. That permission does not allow calling a layer a parent or a child.

### 4.3 Depth

When implement work, diagnosis across more than one file, continuous integration, or a regression needs tools, that work SHALL run three layers deep. That includes implement loops. Complexity is hard to estimate early, so the default is that `L1` spawns an `L2` and that `L2` spawns and manages `L3`s. Hierarchical subagents are the default way `grok-oss` does work.

### 4.4 L1 and the fast path

1. `L1` duties SHALL be status, spawning an `L2`, waiting, reading short reports, and a board `upsert`.
2. `L1` SHALL NOT edit product code, and `L1` SHALL NOT edit docs, aside from the one already named edit of a single line on the hierarchical fast path.
3. The hierarchical fast path SHALL be for `L1` only. It SHALL have exactly four acts: one command that answers a host question, one read of a path that was already named, reading and quoting a report that `L1` asked for, and one already named edit of a single line.
4. That edit of a single line is in scope for the fast path. It is not out of scope.
5. The hierarchical fast path SHALL NOT appear in the task description given to an `L2`.

### 4.5 L2

1. An `L2` SHALL run at the same time the work that Clause 4.9 allows to run at the same time, spawn an `L3`, wait, read the `L3` report, write one `L2` report, record a board `upsert`, and discard context after that report. On that spawn, sandbox inheritance is [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.13. This specification does not copy those sandbox settings.
2. An `L2` SHALL NOT `grep`, read product files, diagnose, edit, implement, or review.
3. Authors SHALL NOT use the spawn rule that easy work stays on the `L2`. That rule is nonconforming.
4. Authors SHALL NOT use the spawn rule that an `L2` spawns an `L3` only when the slice is hard. That rule is nonconforming.
5. An `L2` SHALL NOT compact because it ran implement tools itself. That compaction is nonconforming.
6. Operator clarifications SHALL go to the `L2`. The `L3` SHALL stay undisturbed. Act targets for `interject` and `queue` are [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.4. This specification does not restate those targets.
7. The operator can still prompt an `L2` they are watching.
8. An `L2` MAY compact its own coordinator context. After that compact, that `L2` SHALL still receive the `L3` completion report and SHALL still resume its `L3`s. Compact on an `L2` SHALL NOT drop the `L3`. That `L2` can resume a finished `L3`. The identifier for that act on a completed `L3` is `resume_from`. That `L2` can follow up a running `L3`. The identifier for that act is `follow_up`. [Issue 222](https://github.com/SurmountSystems/grok-oss/issues/222) is the `L2` path: an `L2` may compact, and after compact that `L2` must still resume its `L3`s. The title of issue 222 is that an `L2` can compact and still resume its `L3`s. [Issue 143](https://github.com/SurmountSystems/grok-oss/issues/143) is the path where `L1` follows up a running `L2`.
9. An `L2` can restart and compact its `L3`s when those `L3`s are doing well.
10. Discarded `L2` and `L3` contexts do not have to be compacted into `L1`. They report up. That is the token efficiency.
11. Every token counted for an `L3` contributes to the token cost of its `L2`. An `L2` token total SHALL be at least the sum of the token totals of its `L3`s. Bus fields for those totals are [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.16. This specification does not restate those fields.

### 4.6 L3

1. An `L3` SHALL be an implementer, a researcher, or a reviewer.
2. The `L3` SHALL do the tool work for the jobs in Clause 4.3, aside from the `L1` fast path in Clause 4.4.
3. The `L3` SHALL NOT coordinate, and the `L3` SHALL NOT spawn.
4. There SHALL be no `L4`. An `L3` SHALL NOT be called a coordinator.

### 4.7 Reports

1. Reports SHALL be written under `~/.agents/reports/` on the host.
2. Reports SHALL NOT be written in the repository.
3. A report SHALL state what changed, how it was verified, what remains, and any question for the operator.

### 4.8 Plan gate

1. While a plan is being written or presented, nested exploration SHALL NOT start, and nested implementation SHALL NOT start.
2. Nested exploration and nested implementation SHALL start only after the operator Approve.

### 4.9 Parallelism

1. Independent work streams with disjoint write sets SHALL run as parallel `L2` coordinators at a sustainable count.
2. This specification SHALL NOT be read as setting that count to an integer.
3. Work streams that share a file SHALL run in sequence.
4. Each `L2` SHALL stay listed until that `L2` writes its own report.
5. An `L2` that exits after only spawning SHALL NOT be treated as finished.
6. An `L2` that exits without a report SHALL NOT be treated as finished. The exit without a report event is [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.10. This specification keeps the rule that such an exit is not finished.

### 4.10 Long builds

1. A long build SHALL get one dedicated `L2`.
2. That `L2` SHALL run one job.
3. That job SHALL run at nice 19.
4. That job SHALL NOT be split into several copies at once.
5. That job SHALL NOT be terminated early.
6. Other work SHALL continue while that job runs.
7. Events and `look` fields for that build's progress and memory, without interrupting it, are [0015_Session_Bus.md](0015_Session_Bus.md) Clause 4.3 and Clause 4.10. This specification does not restate those fields.

### 4.11 Context budget (informative)

This subsection is informative. It records sampling windows from the product note `FORK.md`, in the part that note calls Economic mode. It does not set a conformance cap. No named product function enforces the figures below.

1. That note records nested `L2` and `L3` sampling capped at 200k, and records that `L1` uses the catalog window of 500k.
2. The function that would enforce those figures is unnamed. `FORK.md` records tests in session spawn code. The recorded names are `nested_session_sampling_window_stays_200k_when_catalog_is_500k` and `main_session_sampling_window_is_catalog_500k_even_when_economic_is_on`. Those names are records from that note. They are not an enforcer. This document does not claim those tests were run from here.
3. The same note names `refresh_context_used` and records that this function does not copy the catalog window into the nested field. That name is not an enforcer of the 200k figure or the 500k figure.

### 4.12 Finished work

1. Work is finished only when the approved plan's owed outcome has landed.
2. That landing SHALL be checked against files on disk. One passing test is not that landing.
3. Remaining work SHALL go to the residual home that project already uses, and the next step there SHALL be the highest value next step.
4. This specification SHALL NOT be read as an instruction to recreate `INVENTORY.md` or `RESIDUAL.md` in this specifications repository.
5. This specification has its own leftover list in Clause 6.

### 4.13 Tests

1. Where a change is a behavior change, authors SHALL observe a failing test first and SHALL make the fix after that failure. That order is red then green.
2. Where a change is not a behavior change, this specification does not ask for a failing test first.

### 4.14 Process repair

1. When the operator repeats an instruction, that repetition SHALL be treated as a process defect.
2. The repair SHALL land in a durable place. A durable place is an `AGENTS.md` file, a skill, or a check.
3. A chat promise SHALL NOT be that repair.
4. [0006_RSI.md](0006_RSI.md) states that a chat reminder is not a durable tool. That statement is not this repetition rule. The repetition rule is this clause.

### 4.15 Product homes and recorded tests

1. The product `grok-oss` writes this contract in `FORK.md`, in skills, in workflows, and in the `user-guide`. `FORK.md` is the deep home for that product note. `AGENTS.md` in that product stays a pointer of about one thousand tokens and points at `FORK.md`. This specification does not vendor those files. Those homes are the `grok-oss` product.
2. Named tests in that product encode the contracts. The recorded names are `default_accomplishment_is_l1_spawn_of_l2_not_l1_doing_the_multi_file_job`, `l3_model_call_tokens_contribute_to_l2_cost`, and `l2_after_compact_still_receives_l3_completion_report`. Those names are records, in the same way Clause 4.11 records sampling window test names. This document does not claim those tests were run from this repository.
3. [Issue 224](https://github.com/SurmountSystems/grok-oss/issues/224) says the tests for issue 222 are kept. The body of issue 222 names no test identifier.

## 5. Required Conformance

Required conformance to this specification holds if and only if every item in this list holds.

1. This specification is number 0016 and the file name is `0016_Hierarchical_Subagents.md` (Clause 1).
2. The layers are `L0`, `L1`, `L2`, and `L3`, with no `L4`. The call name `grok-oss gui` is informative. An attached client is not a layer (Clause 4.1).
3. The naming bans and the report name in Clause 4.2 hold.
4. Work that needs tools, as Clause 4.3 describes, runs three layers deep, including implement loops (Clause 4.3).
5. `L1` keeps the duties in Clause 4.4. Aside from the one already named edit of a single line on the fast path, `L1` does not edit product code or docs. The fast path is the four acts in that clause and is absent from the task description given to an `L2` (Clause 4.4).
6. An `L2` coordinates as Clause 4.5 requires and does not do the tool work that clause bans. The two spawn rules named there are nonconforming. An `L2` does not compact because it ran implement tools itself. After an `L2` compacts its own coordinator context, that `L2` still receives the `L3` completion report and still resumes its `L3`s, and that compact does not drop the `L3`. The operator can still prompt an `L2` they are watching. Operator clarifications stay on the `L2` and the `L3` stays undisturbed (Clause 4.5).
7. An `L3` does the tool work for Clause 4.3 aside from the fast path, and does not coordinate or spawn (Clause 4.6).
8. Reports are written under `~/.agents/reports/` on the host, are not written in the repository, and state what changed, how it was verified, what remains, and any question for the operator (Clause 4.7).
9. Nested exploration and nested implementation wait until the operator Approve (Clause 4.8).
10. Disjoint write sets run as parallel `L2` coordinators at a sustainable count that this specification does not set to an integer. A shared file runs in sequence. An `L2` stays listed until its own report, and an exit after only spawning or without a report is not finished (Clause 4.9).
11. A long build has one dedicated `L2`, one job, at nice 19, and that job is not split into several copies at once and is not terminated early. Other work continues (Clause 4.10).
12. Finished work is the approved plan's owed outcome checked against files on disk, and remaining work goes to that project's residual home (Clause 4.12).
13. A behavior change observes a failing test first (Clause 4.13).
14. A repeated operator instruction is a process defect fixed in a durable place, not by a chat promise (Clause 4.14).
15. A conforming hierarchical subagent program is not claimed (Clause 1).
16. Numbered markdown remains the contract humans read. Lean spec encodings and their proofs stay in separate modules. A mash of those encodings and their proofs does not conform (Clause 1.2).
17. This document does not restate the session bus protocol (Clause 1).
18. [Issue 224](https://github.com/SurmountSystems/grok-oss/issues/224) calls `L0` the dashboard, one level above `L1`, and `L0` remains the laptop coordinator whose crate name is `surmount-coordinator-gui`. Layers can talk to the layer above and the layer below (Clause 4.1).
19. Complexity is hard to estimate early, so the default is that `L1` spawns an `L2` and that `L2` spawns and manages `L3`s. Hierarchical subagents are the default way `grok-oss` does work (Clause 4.3).
20. Every token counted for an `L3` contributes to the token cost of its `L2`. An `L2` token total is at least the sum of its `L3` token totals. Discarded `L2` and `L3` contexts do not have to be compacted into `L1`. They report up. That is the token efficiency. An `L2` can restart and compact its `L3`s when those `L3`s are doing well (Clause 4.5).
21. The product `grok-oss` writes this contract in `FORK.md`, in skills, in workflows, and in the `user-guide`. The recorded test names in Clause 4.15 are records. This document does not claim those tests were run from this repository (Clause 4.15).

This specification is not itself a conforming hierarchical subagent program. Meeting these items is a claim about a program that claims this specification. It is not a claim that this markdown file is that program.

The permission in Clause 4.2 item 5 is a MAY. An `L2` compacting its own coordinator context is a MAY. The context budget figures in Clause 4.11 are informative. Those items do not break conformance when unmet. The duties after a compact, in Clause 4.5, still hold when that compact happens.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. Naming a file only in Scope is not the residual record. This clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no numbered specification and no assigned number. This document does not create a numbered file for fargo.
2. The Carbonado Network Protocol has no numbered specification and no assigned number. This document does not create a Carbonado file.
3. Number 0016 is Hierarchical Subagents. This document does not steal numbers [0005](0005_CATE.md) through [0015](0015_Session_Bus.md). It does not assign 0016 to fargo or to Carbonado.
4. The stack list in `AGENTS.md` and the registry in `lean/SpecRegistry.lean` name this file as specification 0016. That naming is not a second specification. This document does not edit that list. Lake and flake wiring for a tests executable is not claimed.
5. This document does not invent a specification number after 0016.

### 6.2 Context budget figures

1. The figures 200k and 500k are not pinned by a named enforcer function. The figures stay informative in Clause 4.11. `FORK.md` Economic mode is prose. The function that would enforce the cap is unnamed.
2. The test names `nested_session_sampling_window_stays_200k_when_catalog_is_500k` and `main_session_sampling_window_is_catalog_500k_even_when_economic_is_on` are records from that note. This document does not claim those tests were run from here. `refresh_context_used` is the name that note gives for not copying the catalog window into the nested field. It is not an enforcer.

### 6.3 Session bus, sources, and the long build cite

1. Observation of sessions is specified in [0015_Session_Bus.md](0015_Session_Bus.md). This document does not restate that protocol. Clause 4.15 of that specification is the clause this document cites for the session bus server. This document does not restate that clause.
2. The source path `/home/hunter/implement/skill.md` is missing. The skill body that exists is `/home/hunter/.agents/skills/implement/SKILL.md`. The operator prompt log that exists is `/home/hunter/implement skill.md`.
3. The cite for one dedicated `L2`, one long job, and nice 19 is that operator prompt log. The `surmount-server` agent rules state nice 19 for builds a developer runs and do not state the one `L2` rule. [0007_CI.md](0007_CI.md) does not state the one job rule or nice 19.
4. The four part report list in Clause 4.7 is a requirement of this specification. The cited sources describe shorter reports.

### 6.4 Out of scope and items not specified here

1. An edit of a single line on the fast path is in scope. It is the fourth act in Clause 4.4. It is not out of scope.
2. Seat counts in the `splora` rules are local to that source and are not this specification. A preference for two to four workers is local to a strategy note and is not this specification.
3. Whether an `L2` or an `L3` reads a persona file is not specified here. Sources disagree. This specification does not choose.
4. Amending other repositories that still say parent is out of scope.
5. The first publication sentences inside [0000_spec.md](0000_spec.md) are not amended by this file.
6. A conforming hierarchical subagent program is not claimed.
7. This file does not wire Lake or Nix.
8. [0006_RSI.md](0006_RSI.md) does not use the words operator repetition. It does say a chat reminder is not a durable tool. The repetition rule in Clause 4.14 is a requirement of this specification.

### 6.5 Companion modules and product readiness

1. `lean/HierarchicalSubagentsSpec.lean`, `lean/HierarchicalSubagentsProofs.lean`, `0016_Hierarchical_Subagents.lean`, and `lean/Proofs_0016.lean` are the companion modules this specification names. This document does not claim those files are already present. This document does not paste theorems. A module that mixes the encodings with their proofs does not conform.
2. This document does not say that a hierarchical subagent program is ready. It does not say that a named product never started.

### 6.6 Issue 224 record

1. On 2026-10-20 the comment on [issue 224](https://github.com/SurmountSystems/grok-oss/issues/224) said the landing was in the product tree and was not installed. That dated status is not a conformance rule. The comment used the words this session for that landing. Those words are not a conformance rule.
2. The figure 669 is one measurement on 2026-10-20, characters divided by 4, of the `AGENTS.md` pointer in that product. That figure is not a conformance number.
3. The bundled skill cache refreshing on install is a review leftover named in that comment. That leftover is not a layer requirement.
4. [Issue 224](https://github.com/SurmountSystems/grok-oss/issues/224) says the tests for issue 222 are kept. The body of issue 222 names no test identifier. `resume_from` and `follow_up` are identifiers in that body. They are not test names.

### 6.7 Sentences in other numbered specifications

This document does not edit those files. Each quote is the live sentence. Not stale means this document does not treat the sentence as withdrawn.

1. [0017_Schedula.md](0017_Schedula.md) says: "Relation to specification 0016: the service MAY attribute a ledger row to work that specification calls a coordinator or a specialist, and it does not claim a conforming hierarchical subagent program." That sentence does not define the layer set and does not call the session bus server `L0`. It is not stale.
2. [0017_Schedula.md](0017_Schedula.md) says: "This document does not claim a conforming session bus (specification 0015, [0015_Session_Bus.md](0015_Session_Bus.md)) or a conforming hierarchical subagent program (specification 0016, [0016_Hierarchical_Subagents.md](0016_Hierarchical_Subagents.md))." That sentence is not stale.
3. [0002_Systems_Lean.md](0002_Systems_Lean.md), [0010_Surmount_Systems.md](0010_Surmount_Systems.md), and [0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md) do not state `L0`, `L1`, `L2`, or `L3` duties. Session bus sentences in those files are quoted in [0015_Session_Bus.md](0015_Session_Bus.md) Clause 6.7. This document does not copy those quotes. Whether [0010_Surmount_Systems.md](0010_Surmount_Systems.md) names hierarchical subagents outside the lines searched for this clause is unverified. The search recorded here is the lines that mention the session bus or a hierarchical layer claim, and no hierarchical layer claim was in those hits.

## 7. Changelog

### 0.1.0 - 20261026

Records hierarchical subagents as numbered specification 0016 with file name `0016_Hierarchical_Subagents.md`. The version line is 0.1.0 dated 20261026. No earlier shipped version of this specification is claimed. Records the layers `L0`, `L1`, `L2`, and `L3`, with no `L4`, and that an attached client is not a layer. Records a fast path of four acts, reports under `~/.agents/reports/` on the host with the four parts in Clause 4.7, the plan gate, parallel coordinators without a numeric cap, one long job at nice 19, informative sampling figures, finished work checked against files on disk, red then green where a change is a behavior change, and process repair when an instruction is repeated. Records that an `L2` token total is at least the sum of its `L3` token totals, and that an `L2` that exits without a report is not finished. Records the capture of [issue 224](https://github.com/SurmountSystems/grok-oss/issues/224). Records that a conforming hierarchical subagent program is not claimed. No new shipped version is claimed for that capture.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in [0009_PDOSS.md](0009_PDOSS.md). Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.
