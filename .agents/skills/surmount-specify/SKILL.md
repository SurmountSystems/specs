---
name: surmount-specify
description: Encode a Surmount numbered specification in this specs repository. Applies 0000_spec.md form rules, keeps numbered markdown as the human contract, encodes the spec in Lean, keeps proofs in separate Lean modules, updates SpecRegistry cross links, writes residual in full, and runs just check-remote on surmount-1. Use when the user pastes a spec draft, asks to add or encode a numbered specification, says encode this spec, or runs /surmount-specify.
argument-hint: spec draft or NNNN name
---

# surmount-specify

Encode or revise a numbered specification in this repository. This is the Grok Build skill for that work. Authority for form is `0000_spec.md`. Concise American Technical English (CATE) is numbered specification `0005_CATE.md` (not specification 0006). `0000_spec.md` keeps a short pointer only. Authority for stack numbers is `AGENTS.md` plus `lean/SpecRegistry.lean`. Do not paste those files into chat. Read `0005_CATE.md`. Lean `spec_check` leftover unstack and residual heading checks ride along with form rules.

This skill is this repository only. Home: `.agents/skills/surmount-specify/`. Not `~/.grok` (host Grok config). Not `.grok/skills/` (not the project skill home). Do not copy it to `~/.agents/skills`.

## Hard stop

Encoding a spec is implement work across more than one file. L1 coordinates only.

1. Track a `feat:` board item. Write a remaining work pointer under `~/.agents/reports/`.
2. First tool: `spawn_agent` (Zed/Surmount). Grok: `spawn_subagent`.
3. L2 does the work (greps, reads, edits). L2 spawns an L3 only when the slice is hard. Easy work stays on the L2. An L3 implements, researches, or reviews. An L3 does not spawn. There is no L4. Horizon (this laptop) must not compile Lean or Lake. The gate is `just check-remote` on surmount-1.
4. L1 reads short reports under `~/.agents/reports/` only. Hierarchical fast path stays on L1 (one command host question, one path already named, asked for report).
5. Never `git`. This repository forbids git unless the operator explicitly asks for that git work. Form 1 `ref/` submodules wait for that ask. Do not invent Form 2 mirrors of publisher git.

Deep guide: `~/.agents/skills/shared/references/subagent-token-strategy.md` (Hard stop). Do not paste it here.

## Agent depth (not session board L0 to L2)

| Depth | Does | Does not |
|-------|------|----------|
| L1 | Status, spawn L2, wait, board, read asked for reports | Encode the spec, greps, compile Lean or Lake, run the remote gate |
| L2 | Does the work (greps, reads, edits). Spawns an L3 only when the slice is hard. Easy work stays on the L2. Writes the L2 report | Always spawn L3 for greps. Skip product edits. Compile Lean or Lake on this laptop (horizon) |
| L3 | When spawned for a hard slice: implement, research, or review | Spawn. Coordinate. Compile Lean or Lake on this laptop (horizon) |

## Do not rubber stamp the draft

Repair the pasted draft against living files before writing `NNNN_*.md`.

1. Filename is `NNNN_descriptive_name.md` at repository root only. Match `^[0-9]{4}_[A-Za-z0-9_]+\.md$`.
2. By operator order, numbered specifications other than `0001_DOGE.md` carry version line 0.1.0. Digital Octal Graphical Emissive (DOGE) remains 1.0.0. Do not require first publication 1.0.0 for those files. Changelog history MAY record that a 1.0.0 line existed. Do not invent a 1.0.1 that was never published.
3. Stack numbers: read `AGENTS.md` and `lean/SpecRegistry.lean`. Do not guess. Today: 0000 spec spec, 0001 DOGE, 0002 Systems Lean, 0003 beastdb, 0004 SSSSS, 0005 CATE published (`0005_CATE.md`), 0006 RSI published (`0006_RSI.md`), 0007 CI published (`0007_CI.md`), 0008 Formal Vibefication published (`0008_Formal_Vibefication.md`), 0009 Public Domain Open Source Software published (`0009_PDOSS.md`), 0010 Surmount Systems published (`0010_Surmount_Systems.md`), 0011 Surmount Systems Tech Tree published (`0011_Surmount_Systems_Tech_Tree.md`), 0012 Majestic Memex published (`0012_Majestic_Memex.md`), 0013 Lean Machine published (`0013_Lean_Machine.md`), 0014 Anunnaki Encoding published (`0014_Anunnaki_Encoding.md`). Number 0015 is unassigned. Do not invent 0015. CATE is not 0006. CI is not 0005 and not 0006. Number 0009 is Public Domain Open Source Software (PDOSS). Unlicense remains the license. Do not create `0005_fargo.md`. Do not create `0009_VOCABULARY.md`. Do not create `0009_Unlicense.md`. Do not create `0011_Unlicense.md`. Do not assign 0009 to fargo or Carbonado. The word catalog lives in CATE. Root `VOCABULARY.md` is a pointer to `0005_CATE.md`. `0000_spec.md` points at 0005. fargo has no assigned number. Carbonado unassigned. SSSP unassigned.
4. Do not create `0005_fargo.md`. Number 0005 is CATE. Number 0006 is RSI. Number 0007 is CI. Number 0008 is Formal Vibefication. Number 0009 is Public Domain Open Source Software (PDOSS). Unlicense remains the license. Do not create `0009_VOCABULARY.md`. Do not create `0009_Unlicense.md`. Number 0010 is Surmount Systems. Number 0011 is Surmount Systems Tech Tree. Do not create `0011_Unlicense.md`. Number 0012 is Majestic Memex (`0012_Majestic_Memex.md`). It is published. It is not planned. Number 0013 is Lean Machine (`0013_Lean_Machine.md`). Number 0014 is Anunnaki Encoding (`0014_Anunnaki_Encoding.md`). Number 0015 is unassigned. Do not invent 0015. Do not invent a new number for fargo. Do not create `0006_fargo.md`. Do not create any Carbonado numbered file unless the operator asks.
5. Product name **beastdb** is always the lowercase closed form in normative text, package names, and CLIs. `libbeastdb` is the library name. Mixed case, `Beast DB`, `beast-db`, and `LibBeastDB` fail `spec_check`.
6. Compiler name is Slake.
7. Drop "when present under ref/" weasels. Either cite a real pin (this repo `ref/` or a product tree Form 1 path named as such) or name the thing as informative prior art and list the missing pin in residual.
8. Comparison language is not a core validation step. If the operator says CompCert or Slake bootstrap typecheck is required, encode it as REQUIRED and as a conformance conjunct.
9. Spec versus proof (Formal Vibefication, `0008_Formal_Vibefication.md`): numbered markdown is the contract people read. It is not a substitute for Lean spec encodings. Encode the specification in Lean as declarations of what must be true, in modules marked as spec encodings. Proofs SHALL live in separate Lean modules. Lean theorems do not go in the spec body. Every published numbered markdown file SHALL have a sibling `NNNN_descriptive_name.lean` at the repository root whose physical lines match that markdown (same basename, `.lean` in place of `.md`). Proofs of those line encodings live in `lean/Proofs_NNNN.lean`. `line_encodings_check` fails on drift. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, wrapping to a column, kebab, bullets, leftover unstack, residual heading, registry scan, Keagan back linking). Mixing encodings and their proofs in one mash that hides the split is nonconforming in this repository.
10. Do not claim a conforming implementation exists unless the operator says the product exists.
11. CATE: complete American English thoughts; questions to humans name file or clause, current wording, why it matters, and options, use ordinary English, define a new phrase in the same sentence when one is introduced, and say what we will do for each option; leftover unstack is nonconforming (do not delete the hyphen and leave the same two words); residual in full when the document names unpublished specs, unassigned numbers, unpinned prior art, unimplemented requirements, or out of scope items. CATE does not replace RFC 2119. beastdb, SSSSS, Slake, and CI are ongoing and not ready for use. Do not write that they never started or do not exist.
12. If a spec cites Proof of Keags or Formal Vibefication, keep the canonical URL on https://proofofkeags.com . Do not cite those ideas without a backlink. Write those URLs as list items with a bare `https://` line (same form as `0002_Systems_Lean.md` Acknowledgments), not as markdown `[text](url)` links. Do not write a possessive of McLelland. Do not write the bare token proofofkeags in prose; say Proof of Keags and the host `proofofkeags.com`.

## Encode loop

L2 runs this loop. L2 spawns an L3 only when the slice is hard. Easy work stays on the L2.

1. Read `0000_spec.md`, `0005_CATE.md`, the nearest existing numbered specification (`0002_Systems_Lean.md` or `0003_beastdb.md`), `AGENTS.md`, `RESIDUAL.md`, `lean/SpecRegistry.lean`.
2. Write the numbered specification with all of these: an RFC 2119 keyword paragraph, a SemVer cite (`ref/semver`), an RFC 2119 cite (`ref/rfc2119`), a changelog, Unlicense text, an informative subsection that says the numbered markdown is the contract that humans read, that the specification is also encoded in Lean as declarations of what must be true, that proofs live in separate Lean modules, and that Lean proofs are not the specification, and a Required Conformance clause that holds if and only if every listed item holds (not a loose claim that the product should probably conform).
3. Form: tabs for leading indent, do not wrap to a column, ASCII (word omega, not a Greek letter; `...` not unicode ellipsis), numbered or lettered lists (no `-`/`*`/`+` outside fences), aspell via `aspell_words.txt`. Leftover clauses keep Lean and product identifiers in backticks so spelling does not fail those tokens.
4. Dedicated **Residual** clause in the spec. Complete sentences. List unpublished specs, unassigned numbers, unpinned prior art, unimplemented requirements, and out of scope items this document names. A parenthetical planned file name in Scope is not enough. Update root `RESIDUAL.md` in the same effort.
5. Companion Lean: prefer the Formal Vibefication split (`lean/FormalVibeficationSpec.lean` encodings, `lean/FormalVibeficationProofs.lean` proofs). Add sibling `NNNN_descriptive_name.lean` next to the markdown (same basename, `.lean` in place of `.md`; the file name starts with a digit, so Lean uses a quoted module name) with explicit Lean `MdLine` or `String` literals, one per physical markdown line (`MdLine.ofLine` is the constructor with an optional role). Prefer one `encodedLines` array of `{ number, text }` values (as `0010_Surmount_Systems.lean` and `0011_Surmount_Systems_Tech_Tree.lean`) over hundreds of named `lineNNNN` defs. `include_str` is not a line encoding. `line_encodings_check` fails when that sibling contains `include_str`. Compiled `encodedLines` still must match the markdown bytes (LF lines). Proofs of that line encoding live in `lean/Proofs_NNNN.lean`. Existing models such as `lean/SystemsLean.lean` still mix encodings and proofs; that mash is remaining work, not a pattern to copy. No `sorry`. No mathlib. Wire a Lake executable and a flake check that run on surmount-1. Do not compile Lean or Lake on this laptop. Unrestricted multiplicity constructor is `unrestricted` (avoid Lean's `omega` tactic).
6. Update `SpecRegistry.lean` if numbers or file names changed. Stale tokens such as `0003_SSSSS` or `0003_systems_lean` must fail the scan. Tests that every published file is present SHALL use `publishedBasenames` rather than a hardcoded list in each meaning model suite.
7. Update README in the same effort (spec list, checks, residual). Update AGENTS if stack numbers or the Lean versus Nix split changed.
8. Gate: Horizon (this laptop) must not compile Lean or Lake. Run `just check-remote` on surmount-1. Iterate until green. Do not tell a specialist to compile tests on this laptop. No new Python or shell checkers that float free of Nix.
9. Always self improve the encode process in the same effort when friction appears (hyphen leftovers, incomplete questions, README wording that does not match the registry). Prove the improvement with a Lean check or a skill step, not a chat reminder. When a catalog becomes a numbered specification, `spec_check` spells every definition. Rephrase inflected forms that are not aspell tokens (for example lowercase `http` next to `HTTP`). Do not leave a numbered specification token such as `0005_fargo.md` in a definition; that token fails the registry scan.
10. Reports that describe a change: when the operator asked for size, run `scc --exclude-dir ref,.git,result,lean/.lake,.direnv --exclude-ext pdf .` before and after, including the COCOMO block. COCOMO is fun and is not a real cost or schedule. Do not pass `--no-cocomo`. When the operator asked for git status, run `git status --short`. Do not `git add` or `git commit`.

## Residual (must be complete)

Silence is nonconforming. Write residual on disk same turn: spec residual clause, `RESIDUAL.md`, and `~/.agents/reports/` when the list must survive compaction. Complete American English thoughts. Do not mention leftover work only in passing. If this specification (other than 0000) contains a planned or unpublished `NNNN_*.md` token, include a markdown heading titled Residual. `spec_check` fails that file without that heading.

## Todos

Merge upsert `feat:` / `bug:` only. Never wipe the board. Never `git add` / `git commit`.

## Done when

1. Numbered specification exists at the root with the file name the operator named.
2. `spec_check` accepts it (form plus registry) on surmount-1.
3. Meaning model tests pass on surmount-1 when this spec has a companion model.
4. Residual is written in full on disk.
5. README matches.
6. `just check-remote` on surmount-1 passed.

Reports under `~/.agents/reports/`. Call them reports, not joins.
