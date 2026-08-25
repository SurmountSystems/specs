---
name: surmount-specify
description: Encode a Surmount numbered specification in this specs repository. Applies 0000_spec.md form rules, keeps spec markdown separate from Lean proofs, updates SpecRegistry cross links, writes residual in full, and runs nix flake check. Use when the user pastes a spec draft, asks to add or encode a numbered specification, says encode this spec, or runs /surmount-specify.
argument-hint: spec draft or NNNN name
---

# surmount-specify

Encode or revise a numbered specification in this repository. This is the Grok Build skill for that work. Authority for form is `0000_spec.md`. Authority for stack numbers is `AGENTS.md` plus `lean/SpecRegistry.lean`. Do not paste those files into chat.

This skill is this repository only. Home: `.agents/skills/surmount-specify/`. Not `~/.grok` (host Grok config). Not `.grok/skills/` (not the project skill home). Do not copy it to `~/.agents/skills`.

## Hard stop

Encoding a spec is implement work across more than one file. L1 coordinates only.

1. Track a `feat:` board item. Write a remaining work pointer under `~/.agents/reports/`.
2. First tool: `spawn_agent` (Zed/Surmount). Grok: `spawn_subagent`.
3. L2 orchestrates. This job is hard: L2 spawns L3 for greps, reads, edits, and `nix flake check`. No L4.
4. L1 reads short reports under `~/.agents/reports/` only. Hierarchical fast path stays on L1 (one command host question, one path already named, asked for report).
5. Never `git`. This repository forbids git unless the operator explicitly asks for that git work. Form 1 `ref/` submodules wait for that ask. Do not invent Form 2 mirrors of publisher git.

Deep guide: `~/.agents/skills/shared/references/subagent-token-strategy.md` (Hard stop). Do not paste it here.

## Agent depth (not session board L0 to L2)

| Depth | Does | Does not |
|-------|------|----------|
| L1 | Status, spawn, wait, board, read asked for reports | Encode the spec, greps, flake check |
| L2 | Parallelize, spawn L3, write the L2 report | Product edits |
| L3 | Read 0000, encode, Lean model, registry, residual, gate | Spawn L4 |

## Do not rubber stamp the draft

Repair the pasted draft against living files before writing `NNNN_*.md`.

1. Filename is `NNNN_descriptive_name.md` at repository root only. Match `^[0-9]{4}_[A-Za-z0-9_]+\.md$`.
2. First publication is version 1.0.0. Do not invent 0.x or a 1.0.1 that was never published. Changelog stays in that unpublished 1.0.0 until the operator publishes.
3. Stack numbers: read `AGENTS.md` and `lean/SpecRegistry.lean`. Do not guess. Today: 0000 spec spec, 0001 DOGE, 0002 Systems Lean, 0003 beastdb, 0004 SSSSS published (`0004_SSSSS.md`), 0005 fargo planned, Carbonado unassigned.
4. Do not create planned files (`0005_fargo.md`, any Carbonado numbered file) unless the operator asks.
5. Product name **beastdb** is always the lowercase closed form in normative text, package names, and CLIs. `libbeastdb` is the library name. Mixed case, `Beast DB`, `beast-db`, and `LibBeastDB` fail `spec_check`.
6. Compiler name is Slake.
7. Drop "when present under ref/" weasels. Either cite a real pin (this repo `ref/` or a product tree Form 1 path named as such) or name the thing as informative prior art and list the missing pin in residual.
8. Comparison language is not a core validation step. If the operator says CompCert or Slake bootstrap typecheck is required, encode it as REQUIRED and as a conformance conjunct.
9. Spec versus proof (Formal Vibefication): numbered markdown is the contract people read. Lean theorems do not go in the spec body. Companion model under `lean/`. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, wrapping to a column, kebab, bullets, registry scan).
10. Do not claim a conforming implementation exists unless the operator says the product exists.

## Encode loop (L3)

1. Read `0000_spec.md`, the nearest existing numbered specification (`0002_Systems_Lean.md` or `0003_beastdb.md`), `AGENTS.md`, `RESIDUAL.md`, `lean/SpecRegistry.lean`.
2. Write the numbered specification with all of these: an RFC 2119 keyword paragraph, a SemVer cite (`ref/semver`), an RFC 2119 cite (`ref/rfc2119`), a changelog, Unlicense text, an informative subsection that says the numbered markdown is the contract that humans read and Lean theorems are a separate model of selected clauses rather than the spec itself, and a Required Conformance clause that holds if and only if every listed item holds (not a loose claim that the product should probably conform).
3. Form: tabs for leading indent, do not wrap to a column, ASCII (word omega, not a Greek letter; `...` not unicode ellipsis), numbered or lettered lists (no `-`/`*`/`+` outside fences), aspell via `aspell_words.txt`.
4. Dedicated **Residual** clause in the spec. Complete sentences. List unpublished specs, unassigned numbers, unpinned prior art, unimplemented requirements, and out of scope items this document names. A parenthetical planned file name in Scope is not enough. Update root `RESIDUAL.md` in the same effort.
5. Companion Lean meaning model for selected clauses (pattern: `lean/SystemsLean.lean`, `lean/BeastDb.lean`). No `sorry`. No mathlib. Wire a Lake executable and a flake check. Unrestricted multiplicity constructor is `unrestricted` (avoid Lean's `omega` tactic).
6. Update `SpecRegistry.lean` if numbers or file names changed. Stale tokens such as `0003_SSSSS` or `0003_systems_lean` must fail the scan.
7. Update README in the same effort (spec list, checks, residual). Update AGENTS if stack numbers or the Lean versus Nix split changed.
8. Gate: `nix flake check "path:$PWD" --print-build-logs`. Iterate until green. No new Python or shell checkers that float free of Nix.

## Residual (must be complete)

Silence is nonconforming. Write residual on disk same turn: spec residual clause, `RESIDUAL.md`, and `~/.agents/reports/` when the list must survive compaction. Complete American English thoughts. Do not mention leftover work only in passing.

## Todos

Merge upsert `feat:` / `bug:` only. Never wipe the board. Never `git add` / `git commit`.

## Done when

1. Numbered specification exists at the root with the file name the operator named.
2. `spec_check` accepts it (form plus registry).
3. Meaning model tests pass when this spec has a companion model.
4. Residual is written in full on disk.
5. README matches.
6. `nix flake check "path:$PWD" --print-build-logs` passed.

Reports under `~/.agents/reports/`. Call them reports, not joins.
