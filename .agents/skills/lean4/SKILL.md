---
name: lean4
description: Prove companion Lean meaning models in this specs repository using the lean4-skills pack. Use when writing or repairing lean/*.lean, proving numbered specification meaning, running /lean4, or repairing SystemsLean, BeastDb, Sssss, Cate, Rsi, Ci, VocabAspell, or SpecRegistry.
argument-hint: Lean meaning model to prove
---

# lean4

Prove or repair companion Lean meaning models in this repository. Authority is `0006_RSI.md` (tools that build tools) and `0005_CATE.md`. Formal Vibefication: numbered specification markdown is the contract humans read; Lean is the model of selected clauses. This skill is this repository only. Home: `.agents/skills/lean4/`. Real file, not a symlink. Slash `/lean4`. Do not copy it to `~/.agents/skills`. Do not set the nested plugin tree as the only skill discovery root; that would hide `/rsi` and `/surmount-specify`.

## Pack

Read `skills/lean4-skills/plugins/lean4/skills/lean4/SKILL.md` and the prove, review, golf, and autoprove workflows. Use those loops when writing or repairing `lean/*.lean` in this repository. Init the pack with `git submodule update --init skills/lean4-skills`. The pack is original work under the MIT license. This repository's Unlicense does not relicense that pack.

## This Lake package

1. This Lake package has no mathlib. Do not add mathlib.
2. Constructor for multiplicity omega is `unrestricted` (not `omega`; that name clashes with the tactic).
3. No `sorry` in shipped theorems.
4. The pack's mathlib search and mathlib style rules do not apply here as a dependency.

## Form versus meaning

1. `spec_check` is form (ASCII, tabs, RFC 2119, spelling, leftover unstack, residual heading, registry scan).
2. `SystemsLean`, `BeastDb`, `Sssss`, `Cate`, `Rsi`, `Ci`, and `VocabAspell` are meaning models.
3. Registry scan is `SpecRegistry`.

## Prove cycle

Plan, then Work, then Checkpoint, then Review. Use the pack prove and autoprove loops for the Work step. Use the pack review and golf workflows after a checkpoint.

The gate is:

```
nix flake check "path:$PWD" --print-build-logs
```

`lake build` alone is not the gate.

## Always use better tools

If a Lean theorem can state the claim, do not fall back to a shovel test or a Python checker. Improve `spec_check` or a meaning model rather than a disposable script.

## Never git commit

Never `git commit` from this skill. Never `git add` except when the operator explicitly asked for that git work. A Checkpoint step in the upstream pack that says to commit is host pack advice. This repository forbids agent commits.

## Do not

1. Hide `/rsi` or `/surmount-specify` by making the nested plugin tree the only discovery root.
2. Treat the pack as a `0000_spec.md` Clause 12 pin. It is not under `ref/`.
3. Add mathlib. Do not write `sorry` in shipped theorems.
4. Claim every agent already conforms to `0006_RSI.md`.
