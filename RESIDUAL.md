# Residual (numbered specification program)

This file is the residual record for the numbered specification program in this repository. It is written in complete sentences. A parenthetical planned file name in a Scope clause is not enough by itself. Numbered specification `0003_beastdb.md` Clause 6 is the residual record for that specification. Numbered specification `0004_SSSSS.md` Clause 6 is the residual record for SSSSS. This file covers the program as a whole.

## 1. Unpublished numbered specifications

fargo is planned as specification 0005 with file name `0005_fargo.md`. That file does not exist. That specification has not been published. This repository does not assign it a shipped version. Do not create that file until the operator asks. `0003_beastdb.md` names fargo as the interoperability path. That is a requirement on a future product, not a claim that fargo is specified or implemented. `0004_SSSSS.md` does not require fargo.

## 2. Carbonado Network Protocol (number not finalized)

The Carbonado Network Protocol is deferred. It has no numbered specification file in this repository. It has no assigned specification number. Discussion has mentioned 0006 as a possible later number. That mention is not an assignment. Do not create a numbered specification for Carbonado. Do not treat 0006 as assigned until a numbered specification exists. Network peering, replication, high availability, and distribution belong there, not in `0003_beastdb.md`.

## 3. Product tree pins versus this repository's `ref/`

`0000_spec.md` Clause 12 binds external specifications this specifications repository cites to `ref/` in this repository (Form 1 publisher git or Form 2 official publisher artifact). RFC 2119 and SemVer are pins of this repository. ECMA-48 and ITU-T T.416 are Form 2 pins used by DOGE.

Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository does not add git submodules for them.

There is no beastdb product tree pin in this repository. This program does not claim that a beastdb product tree exists.

There is no SSSSS product tree pin in this repository. This program does not claim that an SSSSS product tree exists.

## 4. beastdb implementation is not claimed

`0003_beastdb.md` specifies beastdb. It does not claim that a conforming implementation exists. Proven ACID, tries that do not use locks, fencing by generation, mmap, SIMD, zerocopy, LanguageID, WordID, Rosetta, mandatory schema with proven migrations, access by ordered keys and values, time series access, and vector access, compatibility shims through fargo, and a freestanding libbeastdb built by a bootstrapped Slake that fully typechecks and compiled with CompCert are requirements, not done work.

## 5. Prior art named by 0003 is not pinned here

LMDB, LevelDB, RocksDB, SQLite, and heed are informative prior art in `0003_beastdb.md`. They are not 0000 Clause 12 pins. They are not under this repository's `ref/`. This program does not add git submodules for them.

## 6. SSSSS implementation is not claimed

`0004_SSSSS.md` specifies SSSSS. It does not claim that a conforming implementation exists. Encoding as sequential language runs, sequential LanguageID and WordID as primary identity, the hashing ban, Rosetta relations, a deterministic pipeline, reduction of neural proposals to sequential integers, provisional natural language translation, durable state in beastdb, and a Systems Lean core with CompCert verified compilation and a bootstrapped Slake that fully typechecks for components that are safety critical, that run in environments with tight resources, and that are freestanding are requirements, not done work. Residual honesty does not substitute for those 0002 validation steps. The hashing ban is a requirement. It is not proof that an engine already obeys it.

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
6. 0005 is fargo, planned file `0005_fargo.md` (file not created).
7. Carbonado Network Protocol is not assigned. A later 0006 has been discussed. 0006 is not assigned.

The Lean registry in `lean/SpecRegistry.lean` encodes those published and planned rows. `spec_check` scans root numbered markdown so drift fails `nix flake check`.
