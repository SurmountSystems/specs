---
name: lean4
description: Prove companion Lean meaning models in this specs repository using the lean4-skills pack. Use when writing or repairing lean/*.lean, proving numbered specification meaning, running /lean4, or repairing SystemsLean, BeastDb, Sssss, Cate, Rsi, Ci, VocabAspell, SpecRegistry, FormalVibeficationSpec, FormalVibeficationProofs, UnlicenseSpec, UnlicenseProofs, or Surmount.
argument-hint: Lean meaning model to prove
---

# lean4

Prove or repair companion Lean meaning models in this repository. Authority is `0006_RSI.md` (tools that build tools), `0005_CATE.md`, and `0008_Formal_Vibefication.md`. Formal Vibefication: numbered specification markdown is the contract humans read; the specification is also encoded in Lean as declarations of what must be true; proofs live in separate Lean modules; Lean proofs are not the specification. This skill is this repository only. Home: `.agents/skills/lean4/`. Real file, not a symlink. Slash `/lean4`. Do not copy it to `~/.agents/skills`. Do not set the nested plugin tree as the only skill discovery root; that would hide `/rsi` and `/surmount-specify`.

## Pack

Read `skills/lean4-skills/plugins/lean4/skills/lean4/SKILL.md` and the prove, review, golf, and autoprove workflows. Use those loops when writing or repairing `lean/*.lean` in this repository. Init the pack with `git submodule update --init skills/lean4-skills`. The pack is original work under the MIT license. This repository's Unlicense does not relicense that pack.

## This Lake package

1. This Lake package has no mathlib. Do not add mathlib.
2. Constructor for multiplicity omega is `unrestricted` (not `omega`; that name clashes with the tactic).
3. No `sorry` in shipped theorems.
4. The pack's mathlib search and mathlib style rules do not apply here as a dependency.

## Surmount root proof

1. Numbered specification `0010_Surmount_Systems.md` is the human contract for stack composition. Companion Lean is `lean/Surmount.lean` (`surmountSpecNumber = 10`, `formalVibeficationSpecNumber = 8`, `unlicenseSpecNumber = 9`, `specFileName = "0010_Surmount_Systems.md"`, `surmount_integrates`, `thisRepoSeparates`, `productTreeUnifies`). Numbered markdown is the contract humans read. Spec encodings are Lean. Proofs are separate Lean modules. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` at the repository root (same basename as the markdown, `.lean` in place of `.md`); proofs of those line encodings live in `lean/Proofs_NNNN.lean`. Unification in a product tree is not a license to mix spec encodings with proofs in this repository, and is not a license to mix theorems into numbered markdown here. The gate is `nix flake check`.
2. Formal Vibefication is specification 0008 (`0008_Formal_Vibefication.md`, `lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`, sibling `0008_Formal_Vibefication.lean`). Unlicense is specification 0009 (`0009_Unlicense.md`, `lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`, sibling `0009_Unlicense.lean`). The word catalog is owned by CATE as specification 0005 (`0005_CATE.md`, `lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`, sibling `0005_CATE.lean`). Root `VOCABULARY.md` is a pointer. The file `0009_VOCABULARY.md` MUST NOT exist. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic Memex (`0012_Majestic_Memex.md`).

## Form versus meaning

1. `spec_check` is form (ASCII, tabs, RFC 2119, spelling, leftover unstack, residual heading, registry scan).
2. `SystemsLean`, `BeastDb`, `Sssss`, `Cate`, `Rsi`, `Ci`, `VocabularySpec`, `VocabularyProofs`, and `VocabAspell` are meaning models. Prefer the Formal Vibefication split for new encodings (`FormalVibeficationSpec` versus `FormalVibeficationProofs`, `VocabularySpec` versus `VocabularyProofs`).
3. Registry scan is `SpecRegistry`.
4. `Surmount` is the composition proof over those models (`lean/Surmount.lean`).

## Prove cycle

Plan, then Work, then Checkpoint, then Review. Use the pack prove and autoprove loops for the Work step. Use the pack review and golf workflows after a checkpoint. Sibling line encodings and `lean/Proofs_NNNN.lean` follow this cycle. Do not mash those proofs into `NNNN_descriptive_name.lean`. `include_str` is not a line encoding. Use explicit `MdLine` or `String` literals, one per physical markdown line.

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
