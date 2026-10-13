---
name: lean4
description: Prove companion Lean meaning models in this specs repository using the lean4-skills pack. Use when writing or repairing lean/*.lean, proving numbered specification meaning, running /lean4, or repairing SystemsLean, BeastDb, Sssss, Cate, Rsi, Ci, VocabAspell, SpecRegistry, FormalVibeficationSpec, FormalVibeficationProofs, UnlicenseSpec, UnlicenseProofs, MemexSpec, LeanMachineSpec, AnunnakiSpec, or Surmount.
argument-hint: Lean meaning model to prove
---

# lean4

Prove or repair companion Lean meaning models in this repository. Authority is `0006_RSI.md` (tools that build tools), `0005_CATE.md`, and `0008_Formal_Vibefication.md`. Formal Vibefication: numbered specification markdown is the contract humans read; the specification is also encoded in Lean as declarations of what must be true; proofs live in separate Lean modules; Lean proofs are not the specification. This skill is this repository only. Home: `.agents/skills/lean4/`. Real file, not a symlink. Slash `/lean4`. Do not copy it to `~/.agents/skills`. Do not set the nested plugin tree as the only skill discovery root; that would hide `/rsi` and `/surmount-specify`.

## Agent depth

1. L1 coordinates only.
2. L2 does the work (greps, reads, edits). L2 spawns an L3 only when the slice is hard. Easy work stays on the L2.
3. An L3 implements, researches, or reviews. An L3 does not spawn. There is no L4.
4. Horizon (this laptop) must not compile Lean or Lake. The gate is `just check-remote` on surmount-1.

## Pack

Read `skills/lean4-skills/plugins/lean4/skills/lean4/SKILL.md`. The prove cycle below names the synced commands `/lean4:prove`, `/lean4:autoprove`, `/lean4:checkpoint`, `/lean4:review`, and `/lean4:golf` in `skills/lean4-skills/plugins/lean4/commands/`. Use those commands when writing or repairing `lean/*.lean` in this repository. Init the pack with `git submodule update --init skills/lean4-skills`. The pack is original work under the MIT license. This repository's Unlicense does not relicense that pack. Do not paste the pack into this wrapper.

## This Lake package

1. This Lake package has no mathlib. Do not add mathlib.
2. Constructor for multiplicity omega is `unrestricted` (not `omega`; that name clashes with the tactic).
3. No `sorry` in shipped theorems.
4. The pack's mathlib search and mathlib style rules do not apply here as a dependency.

## Surmount root proof

1. Numbered specification `0010_Surmount_Systems.md` is the human contract for stack composition. Companion Lean is `lean/Surmount.lean` (`surmountSpecNumber = 10`, `formalVibeficationSpecNumber = 8`, `unlicenseSpecNumber = 9`, `techTreeSpecNumber = 11`, `memexSpecNumber = 12`, `leanMachineSpecNumber = 13`, `anunnakiSpecNumber = 14`, `specFileName = "0010_Surmount_Systems.md"`, `surmount_integrates`, `thisRepoSeparates`, `productTreeUnifies`). Numbered markdown is the contract humans read. Spec encodings are Lean. Proofs are separate Lean modules. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` at the repository root (same basename as the markdown, `.lean` in place of `.md`); proofs of those line encodings live in `lean/Proofs_NNNN.lean`. Unification in a product tree is not a license to mix spec encodings with proofs in this repository, and is not a license to mix theorems into numbered markdown here. Horizon (this laptop) must not compile Lean or Lake. The gate is `just check-remote` on surmount-1.
2. Formal Vibefication is specification 0008 (`0008_Formal_Vibefication.md`, `lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`, sibling `0008_Formal_Vibefication.lean`). Public Domain Open Source Software (PDOSS) is specification 0009 (`0009_PDOSS.md`, `lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`, sibling `0009_PDOSS.lean`). Unlicense remains the license. The Unlicense numbered markdown file for specification 0009 MUST NOT exist. Do not create `0005_fargo.md`. Do not create `0009_VOCABULARY.md`. Do not create `0009_Unlicense.md`. Do not create `0011_Unlicense.md`. The word catalog is owned by CATE as specification 0005 (`0005_CATE.md`, `lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`, sibling `0005_CATE.lean`). Root `VOCABULARY.md` is a pointer. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic Memex (`0012_Majestic_Memex.md`). It is published. It is not planned. Number 0013 is Lean Machine (`0013_Lean_Machine.md`). Number 0014 is Anunnaki Encoding (`0014_Anunnaki_Encoding.md`). Number 0015 is unassigned. Do not invent 0015.

## Form versus meaning

1. `spec_check` is form (ASCII, tabs, RFC 2119, spelling, leftover unstack, residual heading, registry scan).
2. `SystemsLean`, `BeastDb`, `Sssss`, `Cate`, `Rsi`, `Ci`, `VocabularySpec`, `VocabularyProofs`, `VocabAspell`, `MemexSpec`, `LeanMachineSpec`, and `AnunnakiSpec` are meaning models. Prefer the Formal Vibefication split for new encodings (`FormalVibeficationSpec` versus `FormalVibeficationProofs`, `VocabularySpec` versus `VocabularyProofs`).
3. Registry scan is `SpecRegistry`.
4. `Surmount` is the composition proof over those models (`lean/Surmount.lean`).

## Prove cycle

Plan, then Work, then Checkpoint, then Review, then golf. On disk those steps are `/lean4:prove` (`skills/lean4-skills/plugins/lean4/commands/prove.md`, guided, asks before each cycle), `/lean4:autoprove` (`skills/lean4-skills/plugins/lean4/commands/autoprove.md`, autonomous, with stop budgets), `/lean4:checkpoint` (`skills/lean4-skills/plugins/lean4/commands/checkpoint.md`, save point), `/lean4:review` (`skills/lean4-skills/plugins/lean4/commands/review.md`, read only), and `/lean4:golf` (`skills/lean4-skills/plugins/lean4/commands/golf.md`, improve proofs that already compile). Work uses `/lean4:prove` or `/lean4:autoprove`. After that work, use `/lean4:checkpoint`, then `/lean4:review`, then `/lean4:golf`. Read those command files. Do not paste their bodies here. A `/lean4:checkpoint` line that says to commit is host pack advice. This repository forbids agent commits. Sibling line encodings and `lean/Proofs_NNNN.lean` follow this cycle. Do not mash those proofs into `NNNN_descriptive_name.lean`. `include_str` is not a line encoding. Use explicit `MdLine` or `String` literals, one per physical markdown line.

Horizon (this laptop) must not compile Lean or Lake. Do not run `lake build`, `lean`, or flake Lean checks on this laptop. Do not tell a specialist to compile tests on this laptop. The gate is `just check-remote` on surmount-1.

## Always use better tools

If a Lean theorem can state the claim, do not fall back to a shovel test or a Python checker. Improve `spec_check` or a meaning model rather than a disposable script.

## Never git commit

Never `git commit` from this skill. Never `git add` except when the operator explicitly asked for that git work. A Checkpoint step in the upstream pack that says to commit is host pack advice. This repository forbids agent commits.

## Do not

1. Hide `/rsi` or `/surmount-specify` by making the nested plugin tree the only discovery root.
2. Treat the pack as a `0000_spec.md` Clause 12 pin. It is not under `ref/`.
3. Add mathlib. Do not write `sorry` in shipped theorems.
4. Claim every agent already conforms to `0006_RSI.md`.
5. Compile Lean or Lake on this laptop (horizon), or tell a specialist to compile tests here.
6. Invent specification 0015.
7. Create `0005_fargo.md`, `0009_VOCABULARY.md`, `0009_Unlicense.md`, or `0011_Unlicense.md`.
8. Say L2 never product-edits and always spawns L3 for greps. L2 does the work. L2 spawns an L3 only when the slice is hard. Easy work stays on the L2. An L3 implements, researches, or reviews. An L3 does not spawn. There is no L4.
