# beastdb

> v0.1.0 - 20260831
>
> Durable ordered store for Surmount high assurance components

## 1. Scope

This document specifies beastdb, the durable ordered store required by Surmount high assurance components. The Smart Symbolic Supercompiler is specified in `0004_SSSSS.md`. Recursive Self Improvement is specified in `0006_RSI.md`. Interoperability through fargo is specified later. fargo has no assigned specification number. That specification has not been published and this document does not assign it a shipped version.

The product name is always the lowercase form beastdb.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims have a companion Lean model under `lean/` (see Clause 1.2). That model is not this specification.

This document does not claim that a conforming implementation exists.

### 1.1 Status of this document

1. This document is normative for the product name beastdb, the freestanding product library libbeastdb, the language and compiler bootstrap requirements stated herein, the durability and concurrency requirements stated herein, the schema requirements stated herein, the access pattern and interoperability requirements stated herein, the stack role stated herein, and the limit that the store is local first, stated herein.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0003. The file name is `0003_beastdb.md`.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md`, requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/` (the beastdb meaning model, distinct from the `spec_check` form checker) encode selected claims such as the lowercase product name, the freestanding library name libbeastdb, Systems Lean and Slake bootstrap typecheck, proven ACID and tries that do not use locks as required, mandatory schema with two modes, interoperability through fargo rather than a traditional foreign function interface, the scope of a store that is local first with network features out of scope, and this document's identity as specification 0003.
3. A Lean registry under `lean/` encodes published and planned specification numbers, file names, and product names, and the form checker scans numbered markdown so wrong numbers, file name mismatches, and wrong capitalization of beastdb fail `nix flake check`.
4. Those modules prove facts about the model. They do not replace this document. This document does not replace those modules.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Meaning proofs MUST NOT be treated as a second markdown form checker.

### 1.3 Product name

1. The product name MUST be exactly the seven ASCII letters b, e, a, s, t, d, b in lowercase, written `beastdb`.
2. Package names and command line interfaces MUST use that same lowercase form.
3. A capital letter MUST NOT appear in the product name. An internal space MUST NOT appear in the product name.
4. The freestanding product library name MUST be `libbeastdb` (the prefix lib plus the lowercase product name). A capital letter MUST NOT appear in that library name.

### 1.4 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md).
2. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. The Smart Symbolic Supercompiler remains [0004_SSSSS.md](0004_SSSSS.md).
4. fargo remains a later specification. fargo has no assigned specification number. That specification has not been published.
5. Network peering, replication, high availability, and distribution are out of scope here. Those topics belong to the Carbonado Network Protocol, which has no numbered specification in this repository and no assigned number (see Clause 6).

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Lean 4, Idris 2, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Their Form 1 pins live in the Systems Lean product tree as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.3. This document does not add Form 1 git submodules to this repository.

LMDB, LevelDB, RocksDB, SQLite, and heed are named only as informative prior art in Clause 2.3. They are not 0000 Clause 12 pins of this specifications repository. They are not present under this repository's `ref/`. This document does not add git submodules for them.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0002_Systems_Lean.md` (Systems Lean, Slake, the freestanding product wire, CompCert verified compilation, and bootstrap typecheck).

### 2.2 Pins in the Systems Lean product tree

The Systems Lean product tree is the implementation home for Systems Lean and Slake. Form 1 pins named by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 2.2 and Clause 4.3 are directories in that product tree, not in this specifications repository. This document does not repeat those directory names as if they were pins of this repository's `ref/`.

A beastdb product tree, when one exists, is likewise not this specifications repository. This document does not claim that such a product tree exists.

### 2.3 Prior art (informative)

This subsection is informative. It names stores a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12.

1. LMDB, LevelDB, RocksDB, SQLite, and heed are prior art for durable ordered maps, embedded engines, and related binding layers.
2. Those names are not present under this specifications repository's `ref/`.
3. This document does not treat an empty `ref/` path as a pin of those stores, and it does not instruct implementers to look under `ref/` for them.

## 3. Definitions

### 3.1 beastdb

The durable ordered store specified by this document. The name is the lowercase form defined in Clause 1.3.

### 3.2 libbeastdb

The freestanding product library for beastdb. It is the prefix lib plus the lowercase product name. It is the library that high assurance persistent storage targets (Clause 4.6).

### 3.3 Systems Lean

The language specified in [0002_Systems_Lean.md](0002_Systems_Lean.md): Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities 0, 1, and omega.

### 3.4 Slake

The compiler specified in [0002_Systems_Lean.md](0002_Systems_Lean.md): the compiler written in Systems Lean that emits freestanding products.

### 3.5 Freestanding product library

A library binary or C source emitted by Slake that contains no managed Lean runtime and performs no garbage collection, matching the freestanding product wire in [0002_Systems_Lean.md](0002_Systems_Lean.md).

### 3.6 Proven ACID

Atomicity, consistency, isolation, and durability as machine checked properties of the store, not as marketing language. This document requires those properties of a conforming implementation. This document is not those proofs, and it does not claim the proofs exist yet. Specification 0003 keeps ownership of proved ACID for beastdb. [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.38 names that owner and does not move those theorems into Systems Lean.

### 3.7 Trie that does not use locks

A trie in which progress of a reader or writer does not depend on another thread being scheduled to release a mutual exclusion lock on that trie. This document requires a conforming implementation to use tries that do not use locks. It does not claim such tries are implemented. Specification 0003 keeps ownership of that requirement. [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.37 names `LockFree`. This document does not move that requirement into Systems Lean.

### 3.8 SWMR

Single writer, multiple reader. One writer at a time, with concurrent readers. This is the required default concurrency for a conforming implementation.

### 3.9 Fencing by generation

A discipline in which structural operations (rebalance, relocate, map growth, and similar) carry a generation so that a reader cannot observe torn structure from a prior generation as if it were current.

### 3.10 Schema

A declared structure for keys, values, and related types stored by beastdb. Schema is mandatory (Clause 4.4). This document defines two modes: predefined and inferred.

### 3.11 Predefined schema

A schema declared before data that uses it is written.

### 3.12 Inferred schema

A schema derived from stored data and then declared so later access and migration can be proved against it. Inferred is a mode of mandatory schema, not a license to remain without a schema.

### 3.13 fargo

The Surmount interoperability layer to be specified in a later numbered specification. fargo has no assigned specification number. That specification has not been published and this document does not assign it a shipped version. Compatibility with other stores and language ecosystems SHALL go through fargo (Clause 4.5). The owning clause for that interoperability is [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.47, and that clause does not assign fargo a specification number.

### 3.14 LanguageID

A dense identifier for a language in the store. It is not a Unicode code point used as the primary key.

### 3.15 WordID

A dense identifier for a word in the store. It is not a Unicode code point used as the primary key.

### 3.16 Rosetta

A mapping between LanguageID and WordID values across languages, persisted so the Smart Symbolic Supercompiler specified in `0004_SSSSS.md` can use dense symbols.

### 3.17 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.18 Slake that fully typechecks

A bootstrapped Slake compiler that typechecks the Systems Lean and Slake sources it is bootstrapped from, including theorems, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.10. A named subset of modules is not enough. Emitting freestanding C without that typecheck is not enough.

### 3.19 CompCert verified compilation

Compilation of the freestanding C emit by CompCert (`ccomp`) such that the generated assembly is the CompCert verified compilation of that C, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.9.

### 3.20 Traditional foreign function interface

A language native binding layer that calls into libbeastdb (or a shim) through the host platform calling convention as the primary interoperability path. This document forbids that path as the interoperability path (Clause 4.5). fargo is the interoperability path.

## 4. Core requirements

### 4.1 Language, bootstrap, freestanding library, and name

1. The core of beastdb MUST be implemented in Systems Lean as specified in [0002_Systems_Lean.md](0002_Systems_Lean.md).
2. That core MUST be able to target the freestanding Slake path in that specification.
3. libbeastdb MUST be a freestanding product library: it MUST contain no managed Lean runtime and MUST NOT perform garbage collection.
4. The product name and library name MUST follow Clause 1.3.
5. CompCert verified compilation (Clause 3.19) is a REQUIRED core validation step for the freestanding C emit of that core, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.9 and as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.2 item 6. Naming a residual MUST NOT substitute for this step. This document does not claim CompCert is pinned under this specifications repository's `ref/`.
6. Bootstrapping a Slake compiler that fully typechecks (Clause 3.18) is a REQUIRED core validation step, as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.2 item 7. A conforming build MUST use a Slake that typechecks the Systems Lean and Slake sources it is bootstrapped from, including theorems. A named subset of modules is not enough. Naming a residual MUST NOT substitute for this step. A claim that the freestanding product hosts itself from generated C is a distinct claim and does not satisfy this step by itself.

### 4.2 Proven ACID, tries that do not use locks, concurrency, and fencing by generation

1. A conforming implementation MUST provide proven ACID transactions (Clause 3.6). This is a requirement. This document does not claim those proofs have been written. Specification 0003 keeps ownership of that claim, as [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.38 states, and this document does not move those theorems into Systems Lean.
2. The durable map MUST be a trie that does not use locks (Clause 3.7). This is a requirement. This document does not claim such a trie is implemented.
3. The required default concurrency MUST be SWMR (Clause 3.8).
4. A conforming implementation MAY provide more than one writer, each operating only on disjoint leaves of the trie. That capability is optional. It is not required for conformance. When it is absent, SWMR remains required. When it is present, writers MUST NOT share a leaf.
5. Structural operations MUST be fenced by generation (Clause 3.9). This is a requirement. This document does not claim fencing by generation is implemented.

### 4.3 Memory mapping, SIMD, zerocopy, and dense identifiers

1. A conforming implementation MUST use memory mapping (mmap) for the durable image.
2. A conforming implementation MUST use single instruction, multiple data (SIMD) facilities for scans and bulk operations where those facilities improve those operations. The instruction set family is defined by the implementation.
3. A conforming implementation MUST offer zerocopy views of mapped data for reads. A bounce buffer MUST NOT be required for a read that can be served by a mapped view.
4. A conforming implementation MUST persist dense LanguageID and WordID values (Clauses 3.14 and 3.15).
5. A Rosetta mapping (Clause 3.16) for the Smart Symbolic Supercompiler specified in `0004_SSSSS.md` MUST be representable in the store.
6. Items 1 through 5 are requirements. This document does not claim mmap, SIMD, zerocopy, LanguageID, WordID, or Rosetta are implemented.

### 4.4 Mandatory schema

1. Schema is mandatory. A conforming implementation MUST NOT offer a product mode that stores application data without a schema.
2. A conforming implementation MUST support both predefined schema (Clause 3.11) and inferred schema (Clause 3.12).
3. Inferred schema MUST become a declared schema. Inference MUST NOT leave data permanently without a schema.
4. Every migration MUST be proven. A migration that cannot be proved MUST NOT be applied.
5. Items 1 through 4 are requirements. This document does not claim schema proofs exist yet.

### 4.5 Access patterns and interoperability

1. A conforming implementation MUST provide access by ordered keys and values.
2. A conforming implementation MUST provide time series access.
3. A conforming implementation MUST provide vector access.
4. Compatibility with SQLite, RocksDB, and other stores named as prior art in Clause 2.3, and compatibility with other language ecosystems, SHALL be expressed through fargo (Clause 3.13; unpublished; no assigned specification number) as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.47.
5. A conforming implementation MUST NOT use a traditional foreign function interface (Clause 3.20) as the interoperability path. There is no traditional foreign function binding layer in this design. Interoperability goes through fargo, as [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.47 states, and fargo has no assigned specification number.
6. Exact layout of time series points and vectors is defined by the implementation provided items 1 through 3 hold.
7. Items 1 through 5 are requirements. This document does not claim access by ordered keys and values, time series access, vector access, or fargo shims are implemented. fargo itself has no numbered specification file in this repository.

### 4.6 Stack role

1. beastdb is the REQUIRED durable store for the Smart Symbolic Supercompiler specified in `0004_SSSSS.md`.
2. All high assurance persistent storage that claims conformance to this stack role MUST target libbeastdb.
3. Systems Lean remains the REQUIRED implementation language for the core of beastdb, as stated in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.4.

### 4.7 Store that is local first; network features out of scope

1. beastdb is a store that is local first: a conforming implementation MUST operate as a local durable store without requiring a network peer.
2. Network peering is out of scope for this specification.
3. Replication is out of scope for this specification.
4. High availability as a distributed property is out of scope for this specification.
5. Distribution of the store across machines is out of scope for this specification.
6. Those network topics belong to the Carbonado Network Protocol. That protocol has no numbered specification file in this repository. It has no assigned specification number. Discussion has mentioned 0006 as a possible later number. This document does not assign 0006. This document MUST NOT be read as specifying peering, replication, high availability, or distribution.

## 5. Conformance

A beastdb implementation or libbeastdb product conforms to this specification if and only if all of the following hold:

1. It uses the lowercase product name beastdb and the library name libbeastdb (Clause 1.3). The core is implemented in Systems Lean, targets the freestanding Slake path, and libbeastdb is a freestanding product library (Clause 4.1 items 1 through 4).
2. CompCert verified compilation of the freestanding C emit has been performed (Clause 4.1 item 5). A bootstrapped Slake compiler fully typechecks the Systems Lean and Slake sources it is bootstrapped from (Clause 4.1 item 6). A named subset of modules is not enough. Naming a residual MUST NOT substitute for either step.
3. It provides proven ACID transactions, tries that do not use locks, SWMR, and structural operations fenced by generation (Clause 4.2 items 1, 2, 3, and 5). More than one writer on disjoint leaves MAY be present (Clause 4.2 item 4) and is not required.
4. It uses mmap, SIMD as required, and zerocopy reads, and it persists LanguageID, WordID, and a representable Rosetta mapping (Clause 4.3).
5. Schema is mandatory, both predefined and inferred modes are supported, inferred schema becomes declared, and every migration is proven (Clause 4.4).
6. It provides access by ordered keys and values, time series access, and vector access; interoperability goes through fargo and not through a traditional foreign function interface; and high assurance persistent storage that claims this stack role targets libbeastdb (Clauses 4.5 and 4.6).

Optional access by more than one writer on disjoint leaves (Clause 4.2 item 4) is not required for conformance.

Network peering, replication, high availability, and distribution (Clause 4.7) are out of scope. An implementation that offers those features may still conform to this specification only for the local store. Those features are not conformance items here and MUST NOT be claimed as this specification.

This specification is not itself a conforming implementation. Meeting these items is a claim about a product, not about this markdown file.

## 6. Residual

This section is normative for residual honesty of this document. It does not add product behavior beyond Clauses 4 and 5. Silence about an unpublished specification, an unassigned number, an unpinned prior art name, an unimplemented requirement, or an out of scope network feature named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. Checkable residual claims live in `lean/ResidualClaims.lean`, and this specification still carries its own residual clause.

### 6.1 Related specifications and unassigned numbers

1. The Smart Symbolic Supercompiler is specified in `0004_SSSSS.md`. That specification does not claim a conforming SSSSS implementation exists.
2. fargo has no assigned specification number. A previous plan that assigned number 0005 to fargo is withdrawn. Number 0005 is Concise American Technical English (`0005_CATE.md`). Number 0006 is Recursive Self Improvement (`0006_RSI.md`). This document does not invent a new number for fargo. Clause 4.5 names fargo as the interoperability path; that is a requirement on a future product, not a claim that fargo is specified or implemented.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Discussion has mentioned 0006 as a possible later number. That mention is not an assignment. This document does not create a file for it.

### 6.2 Unpinned prior art

1. LMDB, LevelDB, RocksDB, SQLite, and heed are informative prior art (Clause 2.3). They are not 0000 Clause 12 pins. They are not under this specifications repository's `ref/`. This document does not add git submodules for them.

### 6.3 Product tree pins versus this repository's `ref/`

1. `0000_spec.md` Clause 12 binds external specifications this specifications repository cites to `ref/` in this repository.
2. Lean 4, Idris 2, CompCert, and Rust are cited by [0002_Systems_Lean.md](0002_Systems_Lean.md) as Form 1 pins of the Systems Lean product tree, not of this specifications repository's `ref/`. This document does not move those pins here.
3. There is no beastdb product tree pin in this repository. beastdb work is ongoing and is not ready for use. This document MUST NOT be read as claiming that beastdb never started or does not exist.

### 6.4 Product requirements that are not ready for use

This document specifies beastdb. The product is real, incomplete, and not ready for use. The work is ongoing. It MUST NOT be read as claiming that beastdb never started or does not exist. The following are requirements in Clause 4, not done work:

1. Proven ACID transactions (Clause 3.6 and Clause 4.2 item 1) remain a requirement. This document does not claim those proofs exist. Treating marketing ACID as proven ACID is Cons False in the beastdb proofs module. Specification 0003 remains the owner of beastdb ACID. This document does not move ACID into specification 0002.
2. Tries that do not use locks (Clause 3.7 and Clause 4.2 item 2) remain a requirement. This document does not claim such tries are implemented. Treating a trie whose progress waits on a mutual exclusion lock as conforming is Cons False in the beastdb proofs module.
3. `SWMR` (Clause 3.8) remains the required default concurrency. This document does not claim `SWMR` is implemented.
4. Optional access by more than one writer on disjoint leaves remains allowed and not required (Clause 4.2 item 4). This document does not specify that capability as done work.
5. Structural operations fenced by generation remain a requirement (Clause 4.2 item 5). This document does not claim fencing by generation is implemented.
6. Memory mapping (`mmap`) of the durable image remains a requirement (Clause 4.3 item 1). This document does not claim `mmap` is implemented. Treating a bounce buffer as required for a mapped read is Cons False in the beastdb proofs module.
7. SIMD scans and bulk operations remain a requirement (Clause 4.3 item 2). This document does not claim those operations are implemented.
8. Zerocopy reads remain a requirement (Clause 4.3 item 3). This document does not claim zerocopy is implemented.
9. Dense `LanguageID` and `WordID` remain a requirement (Clause 4.3 item 4). This document does not claim those identifiers are persisted.
10. A representable Rosetta mapping for the Smart Symbolic Supercompiler specified in `0004_SSSSS.md` remains a requirement (Clause 4.3 item 5). This document does not claim that mapping is implemented.
11. Mandatory schema with predefined and inferred modes remains a requirement (Clause 4.4). This document does not claim schema proofs exist. Treating inferred schema as a license to remain without a schema is Cons False in the beastdb proofs module.
12. Proven migrations remain a requirement (Clause 4.4 item 4). This document does not claim those proofs exist.
13. Access by ordered keys and values, time series access, and vector access remain requirements (Clause 4.5 items 1 through 3). This document does not claim those access patterns are implemented.
14. Compatibility shims through fargo remain a requirement (Clause 4.5 item 4). fargo has no assigned specification number. Treating a traditional foreign function interface as the interoperability path is Cons False in the beastdb proofs module.
15. A freestanding `libbeastdb` built by a bootstrapped Slake that fully typechecks and compiled with CompCert remains a requirement (Clause 4.1). This document does not claim that library exists as a shipped product.
16. beastdb is a real product, incomplete, and not ready for use. Claiming that beastdb never started is Cons False in the beastdb proofs module. Claiming that beastdb is ready for use is Cons False in that same module.
17. Encodings of leftover not done flags and Cons fixtures belong in `lean/BeastDbSpec.lean` and proofs belong in `lean/BeastDbProofs.lean`. A mash of those modules is nonconforming. Companion proofs that those fixtures are False are not a claim that beastdb is ready for use. A theorem closed with `sorry` MUST NOT be counted as success.
18. The 0002 and 0003 boundary stays on specification 0002. This document MUST NOT copy the durability call list as beastdb ACID, Cons on beastdb `Props` that do not attach, or `TSX` as beastdb ACID fixtures into `lean/BeastDbSpec.lean`. Specification 0003 still owns beastdb ACID as product meaning.

### 6.5 Out of scope items this document names

1. Network peering.
2. Replication.
3. High availability as a distributed property.
4. Distribution of the store across machines.
5. A traditional foreign function interface as the interoperability path (forbidden as that path, not promised later in this document).

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed.

This 0.1.0 entry also records leftover depth on proven ACID, tries that do not use locks, `mmap`, mandatory schema, and fargo as the interoperability path. fargo has no assigned specification number. Clause 6.4 items 1 through 18 name those requirements as not done work, name Cons False for clashes this specification already states, keep the 0002 and 0003 boundary on specification 0002, and record that beastdb is real, incomplete, and not ready for use. Version remains 0.1.0. These sentences do not publish a new SemVer.

### 1.0.0 - 20260824

First publication of this specification text. Defines beastdb as specification 0003 with file name `0003_beastdb.md` and lowercase product name beastdb; names libbeastdb as the freestanding product library; requires Systems Lean, a bootstrapped Slake that fully typechecks, and CompCert verified compilation as in `0002_Systems_Lean.md`; requires proven ACID, tries that do not use locks, SWMR, optional access by more than one writer on disjoint leaves, and fencing by generation; requires mmap, SIMD, zerocopy, LanguageID, WordID, and a representable Rosetta mapping; requires mandatory schema with predefined and inferred modes and proven migrations; requires access by ordered keys and values, time series access, and vector access with interoperability through fargo rather than a traditional foreign function interface; requires libbeastdb as the durable store target for later high assurance components including the Smart Symbolic Supercompiler; and limits this specification to a store that is local first.

This unpublished 1.0.0 also records: this document does not claim a conforming implementation exists; LMDB, LevelDB, RocksDB, SQLite, and heed are informative prior art and not Clause 12 pins of this repository; the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md`; Recursive Self Improvement is specified in `0006_RSI.md`; fargo has no assigned specification number; the Carbonado Network Protocol has no assigned number.

This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository. Novel beastdb source, when it exists, is likewise Unlicensed. Upstream components retain their original licenses.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

Stores named in Clause 2.3 are prior art a reader may know. They are not contributors to this text and are not pins of this repository.
