# Residual (numbered specification program)

This file is the residual record for the numbered specification program in this repository. It is written in complete sentences. A parenthetical planned file name in a Scope clause is not enough by itself. Numbered specification `0003_beastdb.md` Clause 6 is the residual record for that specification. Numbered specification `0004_SSSSS.md` Clause 6 is the residual record for SSSSS. Numbered specification `0005_CATE.md` Clause 6 is the residual record for Concise American Technical English. Numbered specification `0006_RSI.md` Clause 6 is the residual record for Recursive Self Improvement. Numbered specification `0007_CI.md` Clause 6 is the residual record for Continuous Integration and stack consistency. This file covers the program as a whole.

## 1. Unpublished numbered specifications

fargo is not specified. A previous plan that assigned number 0005 to fargo is withdrawn. Number 0005 is Concise American Technical English (`0005_CATE.md`). Number 0006 is Recursive Self Improvement (`0006_RSI.md`). fargo has no assigned specification number. This repository does not invent a new number for fargo. Do not steal 0005 or 0006 for fargo. Do not create `0005_fargo.md`. `0003_beastdb.md` names fargo as the interoperability path. That is a requirement on a future product, not a claim that fargo is specified or implemented. `0004_SSSSS.md` does not require fargo.

The Surmount Systems System Prompt (SSSP) is named in `0006_RSI.md` as possible later input. SSSP is not specified. It has no numbered specification file and no assigned number.

Holy Lean, Legal Lean, and Bio Lean are names only. They are not numbered specifications. A Lean Machine that persists as a shared pattern is named only. It is not specified.

## 2. Carbonado Network Protocol (number not finalized)

The Carbonado Network Protocol is deferred. It has no numbered specification file in this repository. It has no assigned specification number. Discussion has mentioned 0006 as a possible later number for Carbonado. That mention is not an assignment. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`). Do not create a numbered specification for Carbonado. Network peering, replication, high availability, and distribution belong there, not in `0003_beastdb.md`.

## 3. Product tree pins versus this repository's `ref/`

`0000_spec.md` Clause 12 binds external specifications this specifications repository cites to `ref/` in this repository (Form 1 publisher git or Form 2 official publisher artifact). RFC 2119 and SemVer are pins of this repository. ECMA-48 and ITU-T T.416 are Form 2 pins used by DOGE.

Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. That product tree is `/home/hunter/Projects/ai/iso`. Lean 4, CompCert, Idris 2, and Rust are already git submodules there. This repository MUST NOT copy those four trees into this repository's `ref/`. Existing pins here remain (RFC 2119, SemVer, ECMA-48, ITU-T T.416). New pins are added when the cited artifact is present. A PDF permission note is not yet written by the operator; residual names that missing note. Do not invent the note.

The git submodule at `skills/lean4-skills` is the Lean 4 agent skill pack. It is original work under the MIT license. It is not Unlicense. It is not a Clause 12 pin. It is not under `ref/`. It is not mathlib. This repository does not add mathlib to the Lake package. The Grok Build wrapper is `.agents/skills/lean4/SKILL.md` (slash `/lean4`).

beastdb work is ongoing and is not ready for use. This program MUST NOT be read as claiming that beastdb never started or does not exist.

SSSSS work is ongoing and is not ready for use. This program MUST NOT be read as claiming that SSSSS never started or does not exist.

## 4. beastdb is ongoing and not ready for use

`0003_beastdb.md` specifies beastdb. The work is ongoing and is not ready for use. It MUST NOT be read as claiming that beastdb never started or does not exist. Proven ACID, tries that do not use locks, fencing by generation, mmap, SIMD, zerocopy, LanguageID, WordID, Rosetta, mandatory schema with proven migrations, access by ordered keys and values, time series access, and vector access, compatibility shims through fargo, and a freestanding libbeastdb built by a bootstrapped Slake that fully typechecks and compiled with CompCert are requirements, not done work.

## 5. Prior art named by 0003 is not pinned here

LMDB, LevelDB, RocksDB, SQLite, and heed are informative prior art in `0003_beastdb.md`. They are not 0000 Clause 12 pins. They are not under this repository's `ref/`. This program does not add git submodules for them.

## 6. SSSSS is ongoing and not ready for use

`0004_SSSSS.md` specifies SSSSS. The work is ongoing and is not ready for use. It MUST NOT be read as claiming that SSSSS never started or does not exist. Encoding as sequential language runs, sequential LanguageID and WordID as primary identity, the hashing ban, Rosetta relations, a deterministic pipeline, reduction of neural proposals to sequential integers, provisional natural language translation, durable state in beastdb, and a Systems Lean core with CompCert verified compilation and a bootstrapped Slake that fully typechecks for components that are safety critical, that run in environments with tight resources, and that are freestanding are requirements, not done work. Residual honesty does not substitute for those 0002 validation steps. The hashing ban is a requirement. It is not proof that an engine already obeys it.

Neural proposals are optional. Natural language translation is optional, best effort, and provisional unless Lean proven or high confidence.

The five consecutive S letters are an informative cultural marker. Television canon is not a conformance item.

## 7. Lean Machine is unnumbered

Lean Machine is named as a substrate in `0002_Systems_Lean.md` and in `0004_SSSSS.md`. It has no numbered specification in this repository. It has no assigned specification number. Do not invent a numbered file for Lean Machine.

## 8. Stack numbers (authoritative)

1. 0000 is the spec spec (`0000_spec.md`).
2. 0001 is DOGE (`0001_DOGE.md`).
3. 0002 is Systems Lean (`0002_Systems_Lean.md`).
4. 0003 is beastdb (`0003_beastdb.md`). The product name is the lowercase form beastdb.
5. 0004 is the Smart Symbolic Supercompiler (`0004_SSSSS.md`).
6. 0005 is Concise American Technical English (`0005_CATE.md`).
7. 0006 is Recursive Self Improvement (`0006_RSI.md`).
8. 0007 is Continuous Integration and stack consistency (`0007_CI.md`).
9. fargo has no assigned number. Do not create `0005_fargo.md`. Do not create `0006_fargo.md`.
10. Carbonado Network Protocol is not assigned. Discussion of Carbonado as a possible 0006 was never an assignment. Number 0005 is CATE. Number 0006 is RSI. Number 0007 is CI. Do not steal 0005, 0006, or 0007 for fargo or Carbonado. SSSP and Lean Machine remain unassigned.

The Lean registry in `lean/SpecRegistry.lean` encodes those published and planned rows. `spec_check` scans root numbered markdown so drift fails `nix flake check`.

## 9. Concise American Technical English (CATE)

CATE is numbered specification `0005_CATE.md` (version 1.1.0). It is not numbered specification 0006. Number 0006 is Recursive Self Improvement (`0006_RSI.md`). `0000_spec.md` version 1.3.0 keeps a short pointer only and does not restate CATE. This document does not claim that every agent already conforms.

ISO 24495-1:2023 Plain language is informative prior art. It is not a 0000 Clause 12 pin. It is not under this repository's `ref/`. ISO does not publish that standard as free canonical git. This program does not add a paid ISO pin.

The US Federal Plain Language Guidelines at https://www.plainlanguage.gov/ (accessed: 2026-08-25) are informative prior art. They are not a 0000 Clause 12 pin. They are not under this repository's `ref/`.

CATE does not replace RFC 2119. Requirement keywords in numbered specifications remain as in `0000_spec.md` Clause 4.

The leftover unstack list in `0005_CATE.md` Clause 3.5 is a floor, not a complete English checker. Complete sentence quality is not fully mechanical. `spec_check` flags the listed leftover phrases and requires a Residual heading when a numbered specification other than 0000 contains a planned file token. It does not prove that every sentence is complete.

`VOCABULARY.md` is the human map of domain words the spelling list allows. Companion Lean proves it matches `aspell_words.txt`. That map is not ISO 24495-1:2023. Filling those definitions is prose, not a second numbered specification.

## 10. RSI implementation is not claimed

`0006_RSI.md` specifies Recursive Self Improvement for Surmount numbered specifications and for agents that encode or revise those specifications. It does not claim that every agent already conforms. SSSP is not specified. Scripture named in that document is not a conformance item for Slake, beastdb, or SSSSS. `bitmask-core`, `bitmask-next`, and RGB are out of scope as product. Agents who prove companion Lean meaning models SHALL follow the project skill `/lean4`. That requirement does not claim every agent already follows it.

## 11. Continuous Integration (0007)

`0007_CI.md` specifies Continuous Integration and stack consistency. The work is ongoing and is not ready for use. It MUST NOT be read as claiming that Continuous Integration never started or does not exist. The unsigned commit exception is unique: it applies only to a product that keeps two source trees, Grok Build source that people can read and a distinct Open Source version that is published, and only when that product's residual names the unsigned history or the history signed with a different key. This specifications repository does not claim that exception.

Byte identity of Slake emit among C, headers, archives, shared objects, LLVM IR, `ELF`, and other intermediates is a requirement on a conforming Systems Lean and Slake product. It is not claimed done.

The SSSSS and beastdb reality check is a requirement on that stack. It is not claimed done. SSSSS and beastdb are ongoing and not ready for use. Do not write that they never started or do not exist. Slake work is ongoing and is not ready for use. Byte identity of emit remains not claimed true.

fargo remains unspecified. fargo has no numbered specification and no assigned number. The exact process for elevating Rust with fargo is not specified in `0007_CI.md`. Do not invent a numbered file for fargo.

SSSP remains unspecified. It has no numbered specification file and no assigned number.

## 12. Proof of Keags research (back linking)

On 2026-08-25, Keagan McLelland (Proof of Keags, @ProofOfKeags) was asked how to handle citing, quoting, or building on his essays and research, because his site listed no license, and which jurisdiction applies. He answered "USA", then "Back linking is ideal". Surmount will backlink his work.

This is not an Unlicense grant. It is not permission to vendor those essays as Form 2 copies under `ref/`. When this program cites, quotes, or builds on those ideas, it includes a backlink to the canonical page on https://proofofkeags.com .

Full license text is still not published on his site. PDF permission notes for Ecma and ITU remain a separate wait. Do not invent those notes.
