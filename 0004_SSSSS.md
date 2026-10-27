# Surmount Systems Smart Symbolic Supercompiler

> v0.1.0 - 20260831
>
> Deterministic high assurance translation among Turing complete programming languages

## 1. Scope

This document specifies the Surmount Systems Smart Symbolic Supercompiler (SSSSS): deterministic high assurance translation of any Turing complete programming language into any other, with written natural language translation that is best effort and that improves itself. SSSSS is built on encoding as sequential language runs, a Rosetta isomorphism layer, Systems Lean as specified in `0002_Systems_Lean.md`, beastdb as specified in `0003_beastdb.md`, and a Lean Machine substrate. This document also specifies neurosymbolic integration: the pairing of a symbolic interface and a neural path inside a harness so that neural work is not spent on an action the symbolic interface can already perform. This document also specifies delta reconciliation (Clause 4.8). The Supercompiler is a symbolic set of rules. Delta reconciliation gives the same input to the Lean symbolic rules and to the reference compiler. A delta is not accepted as a rule until Lean proves the rules remain consistent.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims have a companion Lean model under `lean/` (see Clause 1.2). That model is not this specification.

This document does not claim that a conforming SSSSS implementation exists.

### 1.1 Status of this document

1. This document is normative for the product short name SSSSS, encoding as sequential language runs, LanguageID and WordID as primary identity, the Rosetta relation shape and provenance tags, pipeline determinism, neural proposal acceptance, natural language translation marking, durable state in beastdb, Systems Lean as the core implementation language, the inheritance of `0002_Systems_Lean.md` core validation for SSSSS components that are safety critical, that run in environments with tight resources, and that are freestanding, neurosymbolic integration when a product claims the neurosymbolic harness interface (Clause 4.7), and delta reconciliation (Clause 4.8).
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0004. The file name is `0004_SSSSS.md`.
4. The current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed as unpublished working text.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md`, requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/` (the SSSSS meaning model, distinct from the `spec_check` form checker) encode selected claims such as this document's identity as specification 0004 with file name `0004_SSSSS.md`, Systems Lean as specification 0002, beastdb as specification 0003, Recursive Self Improvement as specification 0006, fargo as not specification 0005, sequential WordID rather than hashing as primary identity, LanguageID prefix only on language change, a language run as a LanguageID plus a WordID list, the Rosetta relation shape and provenance tags, pipeline determinism given the same vocabulary and relation set, durable state in beastdb, neural proposals reduced to sequential integers before acceptance, natural language translation marked provisional unless proven or high confidence, Lean Machine as specification 0013, and neurosymbolic integration predicates (a deterministic symbolic interface, a neural path used only when that interface cannot complete the action, tool improvements reduced to sequential integers, training a model not substituting for tool improvement inside the harness, and a claimed integration), and delta reconciliation predicates (the same input to the Lean symbolic rules and to the reference compiler, a delta not accepted as a rule without a Lean consistency proof, byte identity of emit pursued and not claimed to already hold, an objective of both allowed, an objective of either security or performance allowed, and security alone and performance alone each not the only permitted objective).
3. A Lean registry under `lean/` encodes published and planned specification numbers, file names, and product names, and the form checker scans numbered markdown so wrong numbers, file name mismatches, a Systems Lean file name attached to specification number 0003, and wrong capitalization of beastdb fail `nix flake check`.
4. Those modules prove facts about the model. They do not replace this document. This document does not replace those modules.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Meaning proofs MUST NOT be treated as a second markdown form checker.

### 1.3 Cultural marker (informative)

This subsection is informative. It is not a conformance item.

The product short name is five consecutive S letters: SSSSS. Those five letters are a permanent cultural marker. They refer to snake civilizations in the television series Rick and Morty. Television canon is not a requirement. An implementation MUST NOT be judged conforming or nonconforming by television continuity.

### 1.4 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md).
2. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. beastdb remains [0003_beastdb.md](0003_beastdb.md).
4. fargo remains a later specification. fargo has no assigned specification number. This document does not require fargo. Recursive Self Improvement is specified in `0006_RSI.md`.
5. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Application and neurosymbolic integration live in this document, not in `0002_Systems_Lean.md`.
6. Network peering, replication, high availability, and distribution are out of scope here. Those topics belong to the Carbonado Network Protocol, which has no numbered specification in this repository and no assigned number.
7. Recursive Self Improvement of tools is specified in `0006_RSI.md`. A tool improvement call in this document is that practice applied to harness tools.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Lean 4, Idris 2, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Their Form 1 pins live in the Systems Lean product tree as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.3. This document does not add Form 1 git submodules to this repository.

beastdb is a Surmount numbered specification in this repository (`0003_beastdb.md`). It is not an unpinned upstream tree under this repository's `ref/`.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0002_Systems_Lean.md` (Systems Lean, Slake, the freestanding product wire, CompCert verified compilation, and bootstrap typecheck).
5. Surmount specification `0003_beastdb.md` (beastdb, libbeastdb, LanguageID, WordID, and a representable Rosetta mapping).
6. Surmount specification `0006_RSI.md` (Recursive Self Improvement of tools, including a tool improvement call in this document).

### 2.2 Pins in the Systems Lean product tree

The Systems Lean product tree is the implementation home for Systems Lean and Slake. Form 1 pins named by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 2.2 and Clause 4.3 are directories in that product tree, not in this specifications repository. This document does not repeat those directory names as if they were pins of this repository's `ref/`.

An SSSSS product tree, when one exists, is likewise not this specifications repository. This document does not claim that such a product tree exists.

## 3. Definitions

### 3.1 SSSSS

The Surmount Systems Smart Symbolic Supercompiler specified by this document. The short name is the five ASCII letters S, S, S, S, S.

### 3.2 Language run

A LanguageID together with an ordered list of WordID values in that language. A language run is the unit of sequential encoding after tokens are split and vocabulary is assigned.

### 3.3 LanguageID

A 64 bit sequential integer that names a language. It is assigned from the unused LanguageID space in increasing order. It is not a hash of a language name. It is not a Unicode code point used as the primary key. The LanguageID space has capacity `2^64`.

### 3.4 WordID

A 64 bit sequential integer that names a word or other vocabulary atom in one language. For each LanguageID, WordID values are assigned from that language's unused WordID space in increasing order. A WordID is not a hash of surface text. It is not a Unicode code point used as the primary key. Each language has WordID capacity `2^64`. Combined capacity is `2^64` languages times `2^64` WordIDs.

### 3.5 Primary identity

The stored identifier used to look up, persist, and relate a language or a word. In this specification primary identity is sequential LanguageID and sequential WordID. Hashing MUST NOT be primary identity (Clause 4.1).

### 3.6 Rosetta layer

The set of accepted Rosetta relations that relate vocabulary atoms across languages so translation and other correspondences can be expressed as integer edges rather than as hashed surface strings.

### 3.7 Rosetta relation

A record with six fields: LanguageID of language A, WordID in language A, RelationType, LanguageID of language B, WordID in language B, and Provenance.

### 3.8 RelationType

A name for the correspondence a Rosetta relation asserts. This specification does not freeze a closed list of kinds. Examples include translation, synonymy, and hypernymy. Additional kinds MAY be defined by the implementation. A RelationType MUST be present on every Rosetta relation.

### 3.9 Provenance

The origin tag on a Rosetta relation. It MUST be one of the following:

1. `neural-proposed`
2. `human-confirmed`
3. `Lean-proven`

### 3.10 Vocabulary

The assigned mapping from surface tokens in a language to sequential WordID values for that LanguageID, together with the assigned LanguageID values themselves.

### 3.11 Intermediate representation

The pipeline's working form after ingest: language runs plus accepted Rosetta relations. This document MAY abbreviate that form as IR after this definition.

### 3.12 Neural proposal

A suggested vocabulary assignment or Rosetta relation produced by a neural method. Neural proposals are optional (Clause 4.4). They are not primary identity.

### 3.13 Natural language translation

Best effort translation among written natural languages. It is optional (Clause 4.5). It is not a substitute for deterministic programming language translation.

### 3.14 High confidence mark

A named mark an implementation attaches to a natural language translation to mean the implementation treats that translation as high confidence. The threshold and name are defined by the implementation. Absence of Lean proof and absence of a high confidence mark requires the translation to be marked provisional (Clause 4.5).

### 3.15 Lean Machine substrate

The Lean Machine formalization layer named in Scope as a substrate of SSSSS. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013.

### 3.16 Systems Lean

The language specified in [0002_Systems_Lean.md](0002_Systems_Lean.md): Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities 0, 1, and omega.

### 3.17 Slake

The compiler specified in [0002_Systems_Lean.md](0002_Systems_Lean.md): the compiler written in Systems Lean that emits freestanding products.

### 3.18 beastdb

The durable ordered store specified in [0003_beastdb.md](0003_beastdb.md). The product name is the lowercase form beastdb.

### 3.19 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.20 CompCert verified compilation

Compilation of the freestanding C emit by CompCert (`ccomp`) such that the generated assembly is the CompCert verified compilation of that C, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.9.

### 3.21 Slake that fully typechecks

A bootstrapped Slake compiler that typechecks the Systems Lean and Slake sources it is bootstrapped from, including theorems, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.10. A named subset of modules is not enough. Emitting freestanding C without that typecheck is not enough.

### 3.22 Named hole

An explicit, tracked absence of a target WordID when emit cannot find an accepted Rosetta relation for a source WordID under the target LanguageID.

### 3.23 Harness

The SSSSS product environment that exposes tools, translation, and calls that change those tools. This document does not claim a harness is implemented.

### 3.24 Symbolic interface

Lean programs in the harness that perform a tool or translation action only when proved consistent, constructive, and deterministic, using sequential LanguageID and WordID and accepted Rosetta relations.

### 3.25 Neural path

A neural model used only when the symbolic interface cannot complete that action.

### 3.26 Tool improvement call

A call native to the harness that changes a tool so a later symbolic path can succeed. That is Recursive Self Improvement of tools as specified in `0006_RSI.md`.

### 3.27 Neurosymbolic combination

The pairing of the symbolic interface and the neural path so work is not repeated: do not spend neural work on an action the symbolic interface can already perform.

### 3.28 Delta reconciliation

The loop that gives the same input to the Lean symbolic rules and to the reference compiler. Both outputs are decompiled. Comparison tools label the outputs and highlight the deltas. Byte identity of emit is the match this loop pursues. The loop does not claim the match already holds (Clause 4.8).

### 3.29 Reconciliation objective

The choice the neural reconciliation step uses when it ranks and weights rules. The choice MAY be security, performance, or both. Security and performance often complement each other. Security alone is not the only permitted objective. Performance alone is not the only permitted objective.

## 4. Core requirements

### 4.1 Representation

1. A conforming SSSSS MUST encode programs as language runs (Clause 3.2).
2. In a serialized stream of language runs, a LanguageID prefix MUST appear when the language of the following WordID sequence differs from the previous language in that stream, including at the start of the stream. A LanguageID prefix MUST NOT be repeated before every WordID when the language has not changed.
3. LanguageID values MUST be 64 bit sequential integers (Clause 3.3).
4. WordID values MUST be 64 bit sequential integers assigned per LanguageID (Clause 3.4).
5. Hashing MUST NOT be primary identity for languages or words (Clause 3.5). A digest of surface text MAY exist as an auxiliary index. An auxiliary index MUST NOT replace sequential LanguageID or sequential WordID as the stored identifier used for lookup, persistence, or Rosetta relations.
6. Combined identifier capacity MUST be `2^64` languages times `2^64` WordIDs.
7. Items 1 through 6 are requirements. This document does not claim an encoder, a vocabulary store, or sequential WordID assignment is implemented.

### 4.2 Rosetta

1. A conforming SSSSS MUST represent each accepted cross language correspondence as a Rosetta relation (Clause 3.7) with fields LanguageID of language A, WordID in language A, RelationType, LanguageID of language B, WordID in language B, and Provenance.
2. Provenance MUST be `neural-proposed`, `human-confirmed`, or `Lean-proven` (Clause 3.9).
3. A RelationType MUST be present (Clause 3.8).
4. Rosetta relations MUST use sequential LanguageID and WordID values. They MUST NOT use hashing as primary identity of either endpoint.
5. Items 1 through 4 are requirements. This document does not claim a Rosetta store is implemented.

### 4.3 Pipeline

1. Given the same vocabulary and the same set of accepted Rosetta relations, the pipeline MUST be deterministic: the same source token sequence and the same target LanguageID MUST produce the same emit.
2. The pipeline MUST ingest source text and tokenize it into candidate surface tokens.
3. The pipeline MUST look up each token in the vocabulary for the current LanguageID, or insert a new sequential WordID when the token is new in that language.
4. The intermediate representation MUST be language runs plus accepted Rosetta relations (Clause 3.11).
5. The pipeline MAY formalize fragments of that intermediate representation into Systems Lean as specified in [0002_Systems_Lean.md](0002_Systems_Lean.md).
6. Emit MUST map source WordID values to target WordID values by inverse lookup under the target LanguageID through accepted Rosetta relations.
7. If no accepted Rosetta relation provides a target WordID, a conforming implementation MUST NOT invent hashing as the identity of that token. It MUST either fail the translation of that token or emit a named hole (Clause 3.22). Choosing between those two outcomes is defined by the implementation.
8. Items 1 through 4, 6, and 7 are requirements. Item 5 is optional. This document does not claim a pipeline is implemented.

### 4.4 Neural proposals

1. A conforming SSSSS MAY accept neural proposals (Clause 3.12).
2. A neural proposal MUST be reduced to sequential integers (LanguageID, WordID, and any other integers this specification uses as identity) before it is accepted into the vocabulary or the Rosetta relation set.
3. A neural proposal that has not been reduced to sequential integers MUST NOT be accepted.
4. When a neural proposal would become authoritative for semantics or for behavior that is safety critical, it SHOULD be Lean proven before it is treated as authoritative. That SHOULD is not a substitute for item 2.
5. Items 2 and 3 are requirements. Item 1 is optional. Item 4 is a SHOULD. This document does not claim a neural proposer exists.

### 4.5 Natural language translation

1. A conforming SSSSS MAY offer written natural language translation (Clause 3.13).
2. Natural language translation is best effort and is not required to be deterministic in the sense of Clause 4.3 item 1.
3. A natural language translation MUST be marked provisional unless it is Lean proven or it carries a high confidence mark (Clause 3.14).
4. Best effort natural language translation MUST NOT be treated as a substitute for deterministic programming language translation (Clause 4.3).
5. Items 3 and 4 are requirements when natural language translation is offered. Item 1 is optional. This document does not claim a natural language translator exists.

### 4.6 Durable state, Systems Lean core, and 0002 validation

1. Durable SSSSS state MUST be stored in beastdb as specified in [0003_beastdb.md](0003_beastdb.md).
2. The core of SSSSS MUST be implemented in Systems Lean as specified in [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. SSSSS components that are safety critical, SSSSS components that run in environments with tight resources, and SSSSS components that are freestanding MUST be able to target the freestanding Slake path in [0002_Systems_Lean.md](0002_Systems_Lean.md). Those components MUST contain no managed Lean runtime and MUST NOT perform garbage collection on the freestanding product wire.
4. CompCert (`ccomp`) is one metric for the freestanding C emit of the components named in item 3, as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 3.9 and Clause 4.2 item 6. It is optional. It is not the only metric. `FastSafeC` can include `ccomp` and is not required to include it. An unmarked freestanding emit is not required to be compiled with `ccomp`. Naming a residual does not make CompCert verified compilation done. This document does not claim CompCert is pinned under this specifications repository's `ref/`.
5. Bootstrapping a Slake compiler that fully typechecks (Clause 3.21) is a REQUIRED core validation step for those same components, as required by [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 4.2 item 7. A named subset of modules is not enough. Naming a residual MUST NOT substitute for this step. A claim that the freestanding product hosts itself from generated C is a distinct claim and does not satisfy this step by itself.
6. Residual honesty as defined in [0002_Systems_Lean.md](0002_Systems_Lean.md) remains required for the freestanding product wire. Residual honesty MUST NOT replace items 4 and 5.
7. Items 1 through 6 are requirements. This document does not claim an SSSSS backed by beastdb, an SSSSS core built by Slake, CompCert validation of an SSSSS emit, or a Slake bootstrap that fully typechecks for SSSSS is implemented.

### 4.7 Neurosymbolic integration

This clause specifies how a claimed SSSSS harness combines the symbolic interface (Clause 3.24) and the neural path (Clause 3.25). It is not a one line pointer. Translation that only maps language runs, without a harness, is unchanged by this clause. Clause 4.4 neural proposals stay optional and distinct from this interface.

A neurosymbolic combination (Clause 3.27) is the rule that work is not repeated: the product MUST NOT spend neural work on an action the symbolic interface can already perform.

When a product claims the neurosymbolic harness interface, all of the following MUST hold:

1. The product MUST expose the symbolic interface in the harness as an alternative deterministic interface for tool and translation actions.
2. That symbolic interface MUST be implemented in Systems Lean as specified in [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. Recipe lookup and emit MUST be deterministic given the same vocabulary and the same set of accepted Rosetta relations. The same source, the same target LanguageID, the same vocabulary, and the same accepted Rosetta set MUST produce the same emit (Clause 4.3 item 1).
4. The neural path MUST NOT be used for an action the symbolic interface can complete.
5. When the symbolic interface cannot complete an action, the product MAY use the neural path to improve tools through calls native to the harness (Clause 3.26). Those improvements MUST be reduced to sequential integers before they are accepted, the same reduction as Clause 4.4 items 2 and 3.
6. Training a model, or further training of a model, MUST NOT substitute for tool improvement inside the harness. This document MUST NOT invent a training cost number unless that number is cited with a markdown link and an access date. Prefer qualitative English about cost.
7. Neural proposals under Clause 4.4 remain optional and distinct. Accepting a neural proposal under Clause 4.4 is not by itself a claim of this harness interface.

Items 1 through 6 are requirements if and only if the product claims the neurosymbolic harness interface. Item 7 keeps Clause 4.4 optional when that claim is absent.

This document does not claim that a neurosymbolic harness is implemented. The integration is specified here. It is not a shipped product.

#### 4.7.1 Other wires (informative)

This subsection is informative. Model Context Protocol and Agent Client Protocol MAY be named as other wires that a product uses next to this interface. This specification does not forbid those wires. This specification does not require those wires.

### 4.8 Delta reconciliation

The Supercompiler is a symbolic set of rules. Lean proofs show those rules and their concepts stay consistent.

Delta reconciliation is not one reference compiler. The Supercompiler MUST support the major compilers and their quirks. The compilers already named in specification 0002 are in that set: CompCert `ccomp`, `CompCertTSO`, gcc, LLVM, and `cc`. The set of major compilers is not closed, and a quirk list is not specified yet. Being a reference target does not mean that compiler satisfies Clause 4.2 item 6 of specification 0002. `CompCertTSO`, gcc, LLVM, and `cc` do not satisfy that item. Delta reconciliation gives the same input to the Lean symbolic rules and to the reference compiler. Both outputs are decompiled. Comparison tools label the outputs and highlight the deltas.

The neural reconciliation step ranks and weights rules toward security, toward performance, or toward both. Security and performance complement each other. They are not the same priority. An objective of both is allowed. An objective of either security or performance is allowed. Security alone is not the only permitted objective. Performance alone is not the only permitted objective. Specifications 0002, 0004, 0006, and 0007 work together and complement each other. None replaces the others.

A delta is not accepted as a rule until Lean proves the rules remain consistent. The neural step does not replace that proof.

Byte identity of emit is the match this loop pursues. The loop does not claim the match already holds. This document does not claim that byte identity of emit already holds. CompCert (`ccomp`) is one metric. It is optional. It is not the only metric. An unmarked freestanding C emit is not required to be compiled with `ccomp`. For `FastSafeC`, `ccomp` is also optional. When `SafeC` is not combined with `FastC`, inclusion of `ccomp` is optional. A freestanding C emit marked `FastC` that is not combined with `SafeC` does not require `ccomp`. A `FastSafeC` mark does not waive byte identity. Byte identity stays required and is not claimed true. A `FastC` mark does not waive byte identity. Continued improvement is delta reconciliation together with Recursive Self Improvement, specification `0006_RSI.md`. Improvement is not claimed finished.

1. The same input MUST be given to the Lean symbolic rules and to the reference compiler.
2. Both outputs MUST be decompiled. Comparison tools MUST label the outputs and highlight the deltas.
3. The neural reconciliation step MAY rank and weight rules toward security, toward performance, or toward both. It MUST NOT treat security alone as the only permitted objective. It MUST NOT treat performance alone as the only permitted objective.
4. A delta MUST NOT be accepted as a rule until Lean proves the rules remain consistent. The neural step MUST NOT replace that proof.
5. Byte identity of emit is the match this loop pursues. This document does not claim the match already holds. Claiming that the loop has already established byte identity does not conform to this clause.
6. Items 1 through 5 are requirements of this loop. Delta reconciliation is not one reference compiler. The Supercompiler MUST support the major compilers and their quirks. The compilers already named in specification 0002 are in the set of major compilers: CompCert `ccomp`, `CompCertTSO`, gcc, LLVM, and `cc`. The set of major compilers is not closed, and a quirk list is not specified yet. Being a reference target does not mean that compiler satisfies Clause 4.2 item 6 of specification 0002. CompCert (`ccomp`) is one metric. It is optional. It is not the only metric. An unmarked freestanding C emit is not required to be compiled with `ccomp`. For `FastSafeC`, `ccomp` is also optional. When `SafeC` is not combined with `FastC`, inclusion of `ccomp` is optional. A freestanding C emit marked `FastC` that is not combined with `SafeC` does not require `ccomp`. A `FastSafeC` mark does not waive byte identity. The decompiler tool is not named yet. The weight formula is not specified yet. This document does not invent the decompiler name or the weight formula (Clause 6.7).

## 5. Conformance

An SSSSS implementation conforms to this specification if and only if all of the following hold:

1. It encodes programs as language runs, emits a LanguageID prefix only when the language changes (including at stream start), uses 64 bit sequential LanguageID and per language sequential WordID values, does not use hashing as primary identity, and provides combined capacity `2^64` languages times `2^64` WordIDs (Clause 4.1).
2. It represents accepted cross language correspondences as Rosetta relations with RelationType and provenance `neural-proposed`, `human-confirmed`, or `Lean-proven`, using sequential LanguageID and WordID at both endpoints (Clause 4.2).
3. Given the same vocabulary and the same accepted Rosetta relation set, its pipeline is deterministic; it ingests and tokenizes, looks up or inserts sequential WordIDs, uses language runs plus Rosetta relations as intermediate representation, emits by inverse WordID lookup under the target LanguageID, and on a missing mapping fails that token or emits a named hole without inventing hash identity (Clause 4.3 items 1 through 4, 6, and 7). Formalizing fragments into Systems Lean (Clause 4.3 item 5) is not required.
4. Every accepted neural proposal has been reduced to sequential integers (Clause 4.4 items 2 and 3). When natural language translation is offered, each such translation is marked provisional unless it is Lean proven or carries a high confidence mark, and natural language translation is not treated as a substitute for deterministic programming language translation (Clause 4.5). Neural proposals and natural language translation MAY be absent.
5. Durable state is stored in beastdb (Clause 4.6 item 1). The core is implemented in Systems Lean (Clause 4.6 item 2). SSSSS components that are safety critical, that run in environments with tight resources, and that are freestanding target the freestanding Slake path without managed Lean runtime or garbage collection, CompCert verified compilation of their freestanding C emit has been performed, and a bootstrapped Slake fully typechecks the Systems Lean and Slake sources it is bootstrapped from (Clause 4.6 items 3 through 6). A named residual MUST NOT substitute for CompCert verified compilation or for the bootstrap typecheck.
6. If and only if the product claims the neurosymbolic harness interface, Clause 4.7 items 1 through 6 hold: the symbolic interface is exposed in the harness as an alternative deterministic interface, that interface is implemented in Systems Lean, recipe lookup and emit are deterministic given the same vocabulary and the same accepted Rosetta set, the neural path is not used for an action the symbolic interface can complete, tool improvements accepted from the neural path are reduced to sequential integers, and training a model is not a substitute for tool improvement inside the harness. Translation that only maps language runs, without a harness, is unchanged. Clause 4.7 item 7 keeps Clause 4.4 neural proposals optional and distinct.
7. Delta reconciliation gives the same input to the Lean symbolic rules and to the reference compiler, both outputs are decompiled, and comparison tools label the outputs and highlight the deltas (Clause 4.8). A delta is not accepted as a rule until Lean proves the rules remain consistent. The neural step does not replace that proof. The neural reconciliation step MAY rank and weight rules toward security, toward performance, or toward both. Security alone is not the only permitted objective. Performance alone is not the only permitted objective. An objective of both is allowed. An objective of either security or performance is allowed. Byte identity of emit is the match the loop pursues. The loop does not claim the match already holds.

The cultural marker in Clause 1.3 is not a conformance item.

Optional neural proposals (Clause 4.4 item 1), optional Systems Lean formalization of fragments (Clause 4.3 item 5), and optional natural language translation (Clause 4.5 item 1) are not required for conformance when absent. When they are present, the MUST clauses that apply to them in Clause 5 items 3 and 4 still hold. Clause 5 item 6 applies if and only if the product claims the neurosymbolic harness interface. Clause 5 item 7 requires delta reconciliation as specified in Clause 4.8.

This specification is not itself a conforming implementation. Meeting these items is a claim about a product, not about this markdown file. This document does not claim that a neurosymbolic harness exists.

## 6. Residual

This section is normative for residual honesty of this document. It does not add product behavior beyond Clauses 4 and 5. Silence about an unpublished specification, an unassigned number, an unnumbered substrate, an unimplemented requirement, or an optional path named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. Checkable residual claims live in `lean/ResidualClaims.lean`, and this specification still carries its own residual clause.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no assigned specification number. A previous plan that assigned number 0005 to fargo is withdrawn. Number 0005 is Concise American Technical English (`0005_CATE.md`). Number 0006 is Recursive Self Improvement (`0006_RSI.md`). This document does not invent a new number for fargo. This document does not require fargo.
2. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Discussion has mentioned 0006 as a possible later number. That mention is not an assignment. This document does not create a file for it.

### 6.2 Lean Machine numbered as 0013

1. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. This document MUST NOT be read as restating Lean Machine or as assigning Legal Lean or Holy Lean a separate number. Neurosymbolic integration remains in this document.

### 6.3 Product tree pins versus this repository's `ref/`

1. `0000_spec.md` Clause 12 binds external specifications this specifications repository cites to `ref/` in this repository.
2. Lean 4, Idris 2, CompCert, and Rust are cited by [0002_Systems_Lean.md](0002_Systems_Lean.md) as Form 1 pins of the Systems Lean product tree, not of this specifications repository's `ref/`. This document does not move those pins here.
3. There is no SSSSS product tree pin in this repository. SSSSS is a real product. The work is incomplete, ongoing, and is not ready for use. This document MUST NOT be read as claiming that SSSSS never started or does not exist.
4. beastdb is specified in this repository as `0003_beastdb.md`. That numbered specification is not a `ref/` pin of an upstream store.

### 6.4 Product requirements that are not ready for use

This document specifies SSSSS. SSSSS is a real product. The work is incomplete, ongoing, and is not ready for use. It MUST NOT be read as claiming that SSSSS never started or does not exist. Claiming that SSSSS never started is Cons False in the SSSSS proofs module. Claiming that SSSSS is ready for use is Cons False in that same module. The following are requirements in Clause 4, not done work:

1. Encoding as sequential language runs with a `LanguageID` prefix only on change is a requirement. Sequential identity of those runs is not a claim that a store already assigns sequential integers. This document does not claim those runs are implemented.
2. Sequential `LanguageID` and sequential `WordID` are primary identity. The hashing ban is a requirement in Clause 4.1 item 5. That ban is not a proof that an engine already obeys it. Treating the hashing ban as proof that an engine already uses sequential identity is Cons False in the SSSSS proofs module. An auxiliary digest that replaces sequential stored identity is already Cons False in that module. Do not wrap that `Bool` a second time. SSSSS remains ongoing and is not ready for use.
3. Combined capacity `2^64` languages times `2^64` `WordID` values is a requirement. This document does not claim that capacity is implemented.
4. Rosetta relations with `RelationType` and provenance tags are a requirement. This document does not claim a Rosetta store is implemented.
5. A deterministic pipeline given the same vocabulary and relation set, including ingest, tokenize, vocabulary lookup or insert, intermediate representation, and emit by inverse lookup, is a requirement. This document does not claim a pipeline is implemented.
6. Failure or a named hole when no accepted mapping exists, without inventing hash identity, is a requirement. This document does not claim that emit path is implemented.
7. Reduction of any accepted neural proposal to sequential integers is a requirement. This document does not claim a neural proposer exists.
8. Provisional marking of natural language translation unless Lean proven or high confidence is a requirement when that translation is offered. This document does not claim a natural language translator exists.
9. Durable state in `beastdb` is a requirement. This document does not claim an SSSSS backed by `beastdb` is implemented.
10. A Systems Lean core that can target the freestanding Slake path for components that are safety critical, that run in environments with tight resources, and that are freestanding, with CompCert verified compilation and a bootstrapped Slake that fully typechecks as required by Clause 4.6. Residual honesty does not substitute for those validation steps. Those steps remain requirements. They are not claimed done.
11. Neurosymbolic integration as specified in Clause 4.7, including a symbolic interface in Systems Lean, a neural path used only when that interface cannot complete the action, tool improvements reduced to sequential integers, and a ban on substituting model training for tool improvement inside the harness. That integration is specified. It is not a shipped product. Claiming the harness is a distinct claim from optional neural proposals. Treating that specified harness as a shipped product is Cons False in the SSSSS proofs module. A claimed harness that spends neural work when the symbolic interface can complete the action is already Cons False in that module. Do not wrap that `Bool` a second time. SSSSS remains ongoing and is not ready for use.
12. Delta reconciliation as specified in Clause 4.8 is a requirement, not done work. The same input goes to the Lean symbolic rules and to the reference compiler. Both outputs are decompiled. Comparison tools label the outputs and highlight the deltas. A delta is not accepted as a rule until Lean proves the rules remain consistent. The neural step does not replace that proof. Byte identity of emit is the match this loop pursues. That match is not claimed to already hold. Claiming the delta loop has already established byte identity is Cons False in the SSSSS proofs module. The compilers already named in specification 0002 are in the set of major compilers: CompCert `ccomp`, `CompCertTSO`, gcc, LLVM, and `cc`. The set of major compilers is not closed, and a quirk list is not specified yet. The decompiler tool is not named yet. The weight formula is not specified yet. Improvement is not claimed finished. Claiming there is exactly one reference compiler is Cons False in the SSSSS proofs module. Claiming specification 0004 replaces specification 0002 is Cons False in that same module. Claiming specification 0006 replaces specification 0004 is Cons False in that same module.

### 6.5 Informative and optional items this document names

1. The Rick and Morty cultural marker (Clause 1.3) is informative. Television canon is not a conformance item.
2. Neural proposals are MAY (Clause 4.4). Lean proving a neural proposal before it becomes authoritative for semantics or behavior that is safety critical is SHOULD, not MUST.
3. Natural language translation is MAY, best effort, and provisional unless proven or high confidence (Clause 4.5).
4. Formalizing fragments into Systems Lean is MAY (Clause 4.3 item 5).
5. An auxiliary hash index is allowed only as an index that is not primary (Clause 4.1 item 5).
6. Model Context Protocol and Agent Client Protocol MAY be named as other wires (Clause 4.7.1). This specification does not forbid them and does not require them.
7. Neural proposals remain MAY (Clause 4.4). Claiming the neurosymbolic harness interface is a distinct claim (Clause 4.7).

### 6.6 Neurosymbolic integration is specified and is not shipped

The neurosymbolic integration in Clause 4.7 is specified in this document. It is not a shipped product. SSSSS is a real product. The work is incomplete, ongoing, and is not ready for use. This document MUST NOT be read as claiming that SSSSS never started or does not exist. This document MUST NOT be read as claiming that a conforming neurosymbolic harness exists. Treating that specified harness as a shipped product is Cons False in the SSSSS proofs module.

### 6.7 Delta reconciliation names that are not specified yet

Delta reconciliation is specified in Clause 4.8. It is not claimed done. Delta reconciliation is not one reference compiler. The compilers already named in specification 0002 are in the set of major compilers: CompCert `ccomp`, `CompCertTSO`, gcc, LLVM, and `cc`. The set of major compilers is not closed, and a quirk list is not specified yet. Being a reference target does not mean that compiler satisfies Clause 4.2 item 6 of specification 0002. `CompCertTSO`, gcc, LLVM, and `cc` do not satisfy that item. The decompiler tool is not named yet. The weight formula is not specified yet. This document does not invent the decompiler name or the weight formula. Improvement is not claimed finished. Byte identity of emit is the match this loop pursues. The loop does not claim the match already holds. Claiming the delta loop has already established byte identity is Cons False in the SSSSS proofs module. Claiming the neural step may accept a rule without a Lean consistency proof is Cons False in that same module. Claiming the objective must be security alone is Cons False. Claiming the objective must be performance alone is Cons False. An objective of both is allowed. An objective of either security or performance is allowed. SSSSS is a real product. The work is incomplete, ongoing, and is not ready for use. This document MUST NOT be read as claiming that SSSSS never started or does not exist.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed as unpublished working text.

Adds neurosymbolic integration as Clause 4.7 with definitions of harness, symbolic interface, neural path, tool improvement call, and neurosymbolic combination. When a product claims that harness interface, it MUST expose the symbolic interface as an alternative deterministic interface, implement that interface in Systems Lean, keep recipe lookup and emit deterministic given the same vocabulary and Rosetta set, MUST NOT use the neural path for an action the symbolic interface can complete, MUST reduce tool improvements to sequential integers before acceptance, and MUST NOT substitute training a model for tool improvement inside the harness. Model Context Protocol and Agent Client Protocol MAY be named as other wires and are not forbidden. Lean Machine is specified in `0013_Lean_Machine.md`. The integration is specified and is not a shipped product. SSSSS is a real product. The work is incomplete and is not ready for use. Clause 6.4 records sequential identity and the hashing ban as requirements, not as proof that an engine already obeys them. Treating the hashing ban as that proof is Cons False. Treating the specified neurosymbolic harness as a shipped product is Cons False. This document does not invent a number for fargo.

This version records delta reconciliation: the Supercompiler is a symbolic set of rules, Lean proofs show those rules and their concepts stay consistent, the same input goes to the Lean symbolic rules and to the reference compiler, both outputs are decompiled, a delta is not accepted as a rule until Lean proves the rules remain consistent, the neural step does not replace that proof, and byte identity of emit is the match this loop pursues and is not claimed to already hold. This same version records that delta reconciliation is not one reference compiler, that the Supercompiler supports the major compilers and their quirks, that CompCert `ccomp`, `CompCertTSO`, gcc, LLVM, and `cc` are in that set, that the set is not closed and a quirk list is not specified yet, that being a reference target does not satisfy specification 0002 Clause 4.2 item 6, that continued improvement with `0006_RSI.md` is not claimed finished, and that specifications 0002, 0004, 0006, and 0007 complement each other and none replaces the others, and that a `FastC` mark does not waive byte identity. This same version records that `CompCertTSO`, gcc, LLVM, and `cc` do not satisfy specification 0002 Clause 4.2 item 6.

### 1.0.0 - 20260824

First publication of this specification text. Defines SSSSS as specification 0004 with file name `0004_SSSSS.md`; requires sequential language runs with LanguageID prefix only on change; requires 64 bit sequential LanguageID and per language sequential WordID as primary identity and forbids hashing as primary identity; states combined capacity `2^64` languages times `2^64` WordIDs; requires Rosetta relations with RelationType and provenance `neural-proposed`, `human-confirmed`, or `Lean-proven`; requires a deterministic pipeline given the same vocabulary and relation set; permits neural proposals only after reduction to sequential integers; permits natural language translation as best effort work that MUST be marked provisional unless Lean proven or high confidence; requires durable state in beastdb as specified in `0003_beastdb.md`; requires a Systems Lean core as specified in `0002_Systems_Lean.md`; and requires CompCert verified compilation and a bootstrapped Slake that fully typechecks for SSSSS components that are safety critical, that run in environments with tight resources, and that are freestanding, with residual honesty not substituting for those steps.

This 1.0.0 also records: this document does not claim a conforming implementation exists; Lean Machine is specified in `0013_Lean_Machine.md`; fargo has no assigned specification number and is not required here; Recursive Self Improvement is specified in `0006_RSI.md`; the Carbonado Network Protocol has no assigned number; the five consecutive S letters are an informative cultural marker and not a conformance item.

This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough.

This unpublished 1.0.0 also records that citations of Keagan McLelland (Proof of Keags) research SHALL keep the publisher links on those pages (back linking).

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository. Novel SSSSS source, when it exists, is likewise Unlicensed. Upstream components retain their original licenses.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html
3. Formal Verification of Bitcoin BitDevs talk (2026-07-14) - https://www.youtube.com/watch?v=E0VjopN2sgg

Those pages and that talk are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).

The author first encountered a clear explanation of the Curry-Howard isomorphism through the work of Keagan McLelland.
