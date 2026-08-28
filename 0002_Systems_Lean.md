# Systems Lean

> v1.0.0 - 20260824
>
> Language and compiler substrate for Surmount high assurance components

## 1. Scope

This document specifies Systems Lean, the language and compiler substrate required by Surmount high assurance components, including the Surmount Systems Smart Symbolic Supercompiler specified in `0004_SSSSS.md`.

Systems Lean is Lean 4 extended with linear and affine ownership and the minimum Quantitative Type Theory (QTT) multiplicities needed for freestanding systems programming. Its freestanding compiler product is named Slake.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims have a companion Lean model under `lean/` (see Clause 1.2). That model is not this specification.

### 1.1 Status of this document

1. This document is normative for Systems Lean, Slake, the freestanding product wire, hygiene rules for novel Systems Lean and Slake source trees, and the stack targeting requirements stated herein.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md`, requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/` (the Systems Lean meaning model, distinct from the `spec_check` form checker) encode selected claims such as the multiplicity set, erasure of multiplicity 0, the freestanding product wire, residual honesty, CompCert verified compilation as a required validation step, bootstrapping a Slake compiler that fully typechecks as a required validation step, the novel language set, hygiene including product tree `ref/` directory names, stack targeting, this document's identity as specification 0002, the fact that the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` (not 0003), the fact that beastdb is specified in `0003_beastdb.md`, and the fact that Recursive Self Improvement is specified in `0006_RSI.md`.
3. Those modules encode selected claims and prove facts about the model. They do not replace this document. This document does not replace those modules. Mixing spec encodings with their proofs in one mash that hides the split is nonconforming under `0008_Formal_Vibefication.md`; encodings live in `lean/SystemsLeanSpec.lean` and proofs live in `lean/SystemsLeanProofs.lean`.
4. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Lean 4, Idris 2, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Those publishers maintain canonical git, so a Form 2 copy here would be dishonest, and this document does not add Form 1 git submodules to this repository. Their Form 1 pins live in the Systems Lean product tree under that tree's own `ref/` directory. Clause 4.3 names the real directories.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.

### 2.2 Pins in the Systems Lean product tree

The Systems Lean product tree is the implementation home for Systems Lean and Slake. That product tree is `/home/hunter/Projects/ai/iso`. Lean 4, CompCert, Idris 2, and Rust are already git submodules there. Form 1 pins named in this clause are directories in that product tree, not in this specifications repository. This specifications repository MUST NOT copy those four trees into this repository's `ref/`.

1. Lean 4 compiler source. Publisher git: https://github.com/leanprover/lean4.git . Form 1 pin in the product tree: `ref/lean4`. Developer docs in that pin: `ref/lean4/doc/`. The Lean 4 language reference is a separate publisher work, published at [Lean 4 Language Reference](https://lean-lang.org/doc/reference/latest/) (accessed: 2026-08-24). The product tree's `ref/lean4/README.md` and `ref/lean4/doc/dev/ffi.md` link that reference. This document does not claim the language reference is a second Form 1 directory under the product tree `ref/`.
2. Idris 2 Quantitative Type Theory documentation. Publisher git: https://github.com/idris-lang/Idris2.git . Form 1 pin in the product tree: `ref/Idris2`. Local QTT and multiplicity text in that pin: `ref/Idris2/docs/source/tutorial/multiplicities.rst` (multiplicities 0, 1, and unrestricted) and `ref/Idris2/docs/source/implementation/overview.rst` (core TT based on quantitative type theory). Published HTML: [Idris 2 documentation](https://idris2.readthedocs.io/en/latest/) (accessed: 2026-08-24). Those Idris documents cite Atkey and McBride, Quantitative Type Theory, https://bentnib.org/quantitative-type-theory.html ; that paper is not a Form 1 pin under the product tree `ref/`.
3. CompCert, the formally verified C compiler. Publisher git: https://github.com/AbsInt/CompCert.git . Form 1 pin in the product tree: `ref/CompCert`. README in that pin: `ref/CompCert/README.md`. Local doc surface: `ref/CompCert/doc/` (including `ccomp.1`). User's manual: [CompCert user's manual](https://compcert.org/man/) (accessed: 2026-08-24). CompCert is not Unlicense; see Clause 4.3 item 2.
4. Rust (layout and ABI reference for the optional LLVM path). Publisher git: https://github.com/rust-lang/rust.git . Form 1 pin in the product tree: `ref/rust`.

Multiplicities 0, 1, and omega remain defined in Clause 3 so this document states the Systems Lean restriction in one place. Idris 2 documents unrestricted (unlimited) as the third grade; this document names that grade omega and treats multiplicity 1 as linear or affine.

## 3. Definitions

### 3.1 Systems Lean

Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities restricted to 0, 1, and omega as defined in this clause.

### 3.2 Slake

The compiler written in Systems Lean that emits freestanding products.

### 3.3 Freestanding product wire

The binary or C source emitted by Slake that contains no managed Lean runtime and performs no garbage collection.

### 3.4 Multiplicity 0

Erased at compile time. A multiplicity 0 quantity MUST NOT appear in the freestanding product.

### 3.5 Multiplicity 1

Linear or affine use: exactly once or at most once.

### 3.6 Multiplicity omega

Unrestricted use. In this ASCII document the name is the word omega, not a Greek letter.

### 3.7 Residual

A named, tracked fact that prevents a product from being fully freestanding. Residual honesty means such a fact is explicit. Silence about a remaining managed runtime, garbage collector, or other blocker is nonconforming. Residual honesty does not replace CompCert verified compilation (Clause 4.2 item 6) or a bootstrapped Slake that fully typechecks (Clause 4.2 item 7).

### 3.8 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.9 CompCert verified compilation

Compilation of the freestanding C emit by CompCert (`ccomp`) such that the generated assembly is the CompCert verified compilation of that C. This is a core validation step that the emit was compiled correctly. It is not a speed claim and it is not comparison language.

### 3.10 Slake that fully typechecks

A bootstrapped Slake compiler that typechecks the Systems Lean and Slake sources it is bootstrapped from, including theorems. A named subset of modules is not enough. Emitting freestanding C without that typecheck is not enough.

## 4. Core requirements

### 4.1 Language core

1. Systems Lean MUST support only the three Quantitative Type Theory multiplicities 0, 1, and omega defined in Clause 3. No other multiplicity is permitted.
2. Multiplicity 1 MUST enforce linear or affine resource discipline (exactly once or at most once).
3. Any definition intended for the freestanding product wire MUST NOT require managed heap allocation that needs a runtime, MUST NOT require garbage collection, and MUST NOT require residual Lean runtime services.

### 4.2 Compiler product (Slake)

1. The compiler named in this specification MUST be written in Systems Lean.
2. The primary emission target of Slake MUST be freestanding, runtimeless C.
3. A secondary LLVM IR emission path MAY be provided later for use with the Rust ecosystem. That path is optional and is not required for conformance.
4. The freestanding product wire MUST contain no managed Lean runtime and MUST NOT perform garbage collection.
5. The compiler MUST maintain residual honesty: any residual that prevents a fully freestanding product MUST be explicitly named and tracked.
6. CompCert verified compilation (Clause 3.9) is a REQUIRED core validation step. The freestanding C emit MUST be compiled with CompCert (`ccomp`) as high assurance evidence that the emit was compiled correctly. Naming a residual MUST NOT substitute for this step. This document does not claim CompCert is pinned under this specifications repository's `ref/`. The Form 1 pin lives in the Systems Lean product tree at `ref/CompCert`.
7. Bootstrapping a Slake compiler that fully typechecks (Clause 3.10) is a REQUIRED core validation step. A conforming Slake MUST typecheck the Systems Lean and Slake sources it is bootstrapped from, including theorems. Naming a residual MUST NOT substitute for this step. A claim that the freestanding product hosts itself from generated C is a distinct claim and does not satisfy this step by itself.

### 4.3 Repository and hygiene rules

These rules apply to novel Systems Lean and Slake source trees (product repositories). They are distinct from the citation pins of this specifications repository under `0000_spec.md` Clause 12. This specifications repository's `ref/` holds external specifications this repository cites as 0000 Clause 12 pins. The Systems Lean product tree's `ref/` is where Lean 4, Idris 2, CompCert, Rust, and similar upstream language and compiler trees live as Form 1 git submodules. This document does not claim that Lean 4, Idris 2, CompCert, or Rust are pinned under this specifications repository's `ref/`.

1. Novel Systems Lean and Slake source MUST be released under the Unlicense.
2. Upstream reference trees MUST live under a clearly separated `ref/` directory of that product tree, MUST use these directory names, and MUST retain their original licenses:
	1. `ref/Idris2` for Idris 2 (publisher git https://github.com/idris-lang/Idris2.git).
	2. `ref/lean4` for Lean 4 (publisher git https://github.com/leanprover/lean4.git).
	3. `ref/CompCert` for CompCert (publisher git https://github.com/AbsInt/CompCert.git). CompCert is not Unlicense.
	4. `ref/rust` for Rust (publisher git https://github.com/rust-lang/rust.git).
	Agent skill packs MUST NOT be placed under that product tree's `ref/`; they live under `skills/` when present.
3. Novel work MUST be expressed in at most three languages: Idris 2, Lean 4 (including Systems Lean), and pure Nix flakes.
4. Shell scripts that float free of Nix MUST NOT be used for novel product paths. Pure Nix is REQUIRED for build and packaging of novel components.

### 4.4 Relationship to the Surmount stack

1. Systems Lean is the REQUIRED implementation language for the core of beastdb (specified in `0003_beastdb.md`), the Lean Machine formalization layer, components of the Smart Symbolic Supercompiler specified in `0004_SSSSS.md` that are safety critical, and future high assurance rewrites under the FixOS vision.
2. All such components MUST be able to target the freestanding Slake path.
3. Recursive Self Improvement is specified in `0006_RSI.md`. That document is practice for Surmount specifications and agents. It is not a compiler requirement of this document.

## 5. Conformance

A Systems Lean implementation or Slake product conforms to this specification if and only if all of the following hold:

1. It restricts Quantitative Type Theory multiplicities to 0, 1, and omega as defined in Clause 3.
2. It emits freestanding products free of managed Lean runtime and garbage collection, or it names and tracks every residual that prevents a fully freestanding product (Clause 4.2 item 5). Residual honesty in this item applies to the freestanding product wire. It does not excuse a missing CompCert validation step or a missing Slake bootstrap typecheck.
3. It places novel source under the Unlicense and keeps upstream trees under that product tree's `ref/` with the directory names in Clause 4.3 and with original licenses (Clause 4.3 items 1 and 2).
4. It uses only the three permitted languages for novel work (Clause 4.3 item 3) and does not use shell scripts that float free of Nix for novel product paths (Clause 4.3 item 4).
5. Named high assurance components that claim conformance to Clause 4.4 can target the freestanding Slake path.
6. CompCert verified compilation of the freestanding C emit has been performed (Clause 4.2 item 6).
7. A bootstrapped Slake compiler fully typechecks the Systems Lean and Slake sources it is bootstrapped from (Clause 4.2 item 7).

Optional LLVM IR emission (Clause 4.2 item 3) is not required for conformance.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, or an unimplemented requirement named in this document is nonconforming for this specification as a document.

### 6.1 Product tree and language pins

1. Systems Lean and Slake work is ongoing and is not ready for use. This document MUST NOT be read as claiming that Systems Lean or Slake never started or do not exist.
2. The Systems Lean product tree that already holds Lean 4, CompCert, Idris 2, and Rust as git submodules is `/home/hunter/Projects/ai/iso`. This specifications repository MUST NOT copy those four trees into this repository's `ref/`. Existing pins of this repository remain. New pins are added when the cited artifact is present.
3. Recursive Self Improvement is specified in `0006_RSI.md`. That document is practice for Surmount specifications and agents. It is not a compiler requirement of this document.

### 6.2 Unassigned names

1. Lean Machine is named as a substrate. It has no numbered specification and no assigned number.
2. fargo, Carbonado, and SSSP are not specified here and have no assigned numbers.

### 6.3 Product requirements that are not ready for use

CompCert verified compilation of the freestanding C emit and a bootstrapped Slake compiler that fully typechecks are required validation steps. They are not claimed done. Byte identity of emit is required for a conforming product and is not claimed true.

## 7. Changelog

### 1.0.0 - 20260824

First publication. Defines Systems Lean as Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities 0, 1, and omega; names Slake as the freestanding compiler product; requires a freestanding product wire without managed Lean runtime or garbage collection; requires residual honesty; states Unlicense and language set hygiene for novel Systems Lean and Slake source trees; and requires named high assurance stack components to be able to target Slake.

This unpublished 1.0.0 also records: CompCert verified compilation of the freestanding C emit is a required core validation step, not comparison language; bootstrapping a Slake compiler that fully typechecks is a required core validation step; Lean 4, Idris 2, CompCert, and Rust Form 1 pins live in the Systems Lean product tree (`ref/lean4`, `ref/Idris2`, `ref/CompCert`, `ref/rust`) and are not pins of this specifications repository's `ref/`; the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` (not 0003, and not this document); beastdb is specified in `0003_beastdb.md`; Recursive Self Improvement is specified in `0006_RSI.md` and is not a compiler requirement of this document.

This specification is number 0002. The Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` and is not this document. It is not specification 0003.

This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough.

This unpublished 1.0.0 also records that citations of Keagan McLelland (Proof of Keags) research SHALL keep the publisher links on those pages (back linking).

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository. Novel Systems Lean source is likewise Unlicensed. Upstream components retain their original licenses.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html
3. Formal Verification of Bitcoin BitDevs talk (2026-07-14) - https://www.youtube.com/watch?v=E0VjopN2sgg

Those pages and that talk are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).

The author first encountered a clear explanation of the Curry-Howard isomorphism through the work of Keagan McLelland.
