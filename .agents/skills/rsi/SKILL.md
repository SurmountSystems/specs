---
name: rsi
description: Build a durable engineering tool in this specs repository that is truthful, useful, efficient, and thoughtfully designed, following 0006_RSI.md. Prefer a Lean checker, a Nix check, or a project skill a later session can run over a disposable job. Use when the user wants a new checker, flake check, project skill, helper used next to a compiler, recursive self improvement, RSI, tool factory, failing tests first, to improve spec_check, or runs /rsi.
argument-hint: durable tool to build
---

# rsi

Build or improve a durable tool in this repository. Authority is `0006_RSI.md` (Recursive Self Improvement, specification 0006). Prose is Concise American Technical English in `0005_CATE.md` (specification 0005, not 0006). This skill is this repository only. Home: `.agents/skills/rsi/`. Not `~/.grok`. Not `.grok/skills/`. Do not copy it to `~/.agents/skills`.

Recursive self improvement here is the loop of durable tools, failing tests first, honest residual, parallel independent streams, and asking when intent is ambiguous. It is not a claim that a model trains itself again in this repository.

Read `0006_RSI.md` and `0005_CATE.md`. Do not paste those files into chat. Tool choice detail: `references/tool-template.md` next to this file. Deep spawn strategy: `~/.agents/skills/shared/references/subagent-token-strategy.md`. Do not paste it here.

## Hard stop

Building a durable tool is implement work across more than one file.

1. Track a `feat:` or `bug:` board item. Write a remaining work pointer under `~/.agents/reports/`.
2. First tool: spawn a tightly scoped agent (`spawn_agent` on Zed or Surmount). Do not diagnose in the main session.
3. A coordinator fans out. A specialist does greps, reads, edits, tests, and `nix flake check` when the job is hard. A specialist MUST NOT spawn another specialist.
4. The main session reads short reports under `~/.agents/reports/` only. One command host question, one path already named, and the asked for report stay on the main session.
5. Never `git`. This repository forbids git unless the operator explicitly asks for that git work. Never `git add`. Never `git commit`.

## Sub-agents

Independent work streams with disjoint writes run as parallel tightly scoped agents (`0006_RSI.md` Clause 4.7). Shared files get one later pass. A new disjoint ask runs in parallel. Do not cancel a healthy live stream unless the operator said to stop.

| Role | Does | Does not |
|------|------|----------|
| Coordinator (main session) | Status, spawn, wait, board, read asked for reports | Build the tool, greps, flake check |
| Tightly scoped agent | Parallelize disjoint streams, write the coordinator report | Race shared files |
| Specialist | Read 0006 and 0005, implement the tool, tests, residual, gate | Spawn another specialist |

## Loop

1. Name the job in ordinary English. If intent is ambiguous, stop and ask: name the file or clause, quote the current wording, say why the choice matters, name the options, define a new phrase in the same sentence when one is introduced, and say what we will do for each option (`0005_CATE.md`).
2. Prefer a durable tool a later session can run (`0006_RSI.md` Clause 3.2) over a disposable job (Clause 3.3).
3. Use the large language model as a tool factory (Clause 3.4): improve `spec_check`, a project skill, or a Nix package. Do not grow bash or Python as check policy.
4. Pick the best available tool that can state the theorem or the contract (Clause 4.2). Language purity is not the reason. See `references/tool-template.md`. The isomorphism of numbered markdown lines and sibling `Spec_NNNN.lean` encodings is `line_encodings_check`. Those encodings are explicit `MdLine` or `String` literals, one per physical markdown line. `include_str` is not a line encoding.
5. When the durable tool is Lean, follow `.agents/skills/lean4/SKILL.md`.
6. Observe a failing test in the product tree for the named contract before the product edit that is meant to make that same test pass (Clause 4.3). Tests are contracts. Reconcile a contract change with `0006_RSI.md` or the named specification in the same effort. Do not reshape a test to finish green without a contract change.
7. Write remaining work in full on disk in complete American English (Clause 4.5). Chat is not the residual record.
8. Run independent streams in parallel. Do not serialize two jobs that do not share a write set.
9. Truthful: do not invent a conforming product. Residual in full: unpublished specifications, unassigned numbers, unpinned prior art, unimplemented requirements, and out of scope items this work names.
10. Useful: name the real thing. CATE. Leftover unstack is nonconforming (do not delete the hyphen and leave the same two words).
11. Efficient: tools that build tools. When the operator asked for size, run `scc --exclude-dir ref,.git,result,lean/.lake,.direnv --exclude-ext pdf .` before and after, including the COCOMO block. COCOMO is fun and is not a real cost or schedule. Do not pass `--no-cocomo`.
12. Thoughtfully designed: file names, modules, and UX a tired human can parse. No decoder ring jargon.

## Do not

1. Claim every agent already conforms to `0006_RSI.md`.
2. Treat this specification as a claim that a model trains itself again.
3. Treat this skill or `0006_RSI.md` as specifying SSSP.
4. Use scripture named in `0006_RSI.md` Clause 1.4 as a conformance item for Slake, beastdb, or SSSSS.
5. Invent `0005_fargo.md`, a number for fargo, or a Carbonado numbered file. Number 0005 is CATE. Number 0006 is RSI. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0009 is Unlicense (`0009_Unlicense.md`). Do not create `0009_VOCABULARY.md`. Do not steal 0007 or 0009 for fargo. Number 0011 is not published.
6. Treat `bitmask-core`, `bitmask-next`, or RGB as deliverables of this skill.
7. Fall back to a weaker testing workflow because it is familiar. If a stronger tool can state the theorem, use it.
8. Prove tests that compile on this laptop when the project already requires a remote builder. Stop if that builder is unresponsive. This repository's gate remains `nix flake check`.

## Todos

Merge upsert `feat:` / `bug:` only. Never wipe the board. Never `git add`. Never `git commit`.

## Done when

1. A durable tool exists that a later session can run (Lean checker, Nix check, or project skill).
2. A failing test for the named contract was observed before the product edit, and the same test passes, unless the operator said skip or the work is pure docs.
3. Residual is written in full on disk.
4. Names and UX parse as ordinary English.
5. `nix flake check "path:$PWD" --print-build-logs` passed when this repository's checks apply.

Reports under `~/.agents/reports/`. Call them reports, not joins.
