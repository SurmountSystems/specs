# Lean Machine

> v0.1.0 - 20260831
>
> Systems Lean, Legal Lean, and Holy Lean as one symbolic proof machine that MUST attempt deterministic answers

## 1. Scope

This document specifies Lean Machine: the integration of Systems Lean, Legal Lean, and Holy Lean as one symbolic proof machine. Lean Machine MUST attempt to answer questions deterministically. When an answer is wrong or imprecise, a note MUST be timestamped so later work can improve it. Lean Machine is designed as a distributed system that consumes information and builds a better version of itself. That design requirement cites Recursive Self Improvement as specified in `0006_RSI.md`. It is not a claim that such a machine already runs.

This specification is number 0013. The file name is `0013_Lean_Machine.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/LeanMachineSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/LeanMachineProofs.lean`. Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0013_Lean_Machine.lean`. Those encodings are not this specification.

This document does not claim that a conforming Lean Machine exists. Legal Lean and Holy Lean are named components of this specification. They are ongoing named work. They are not done. This document does not claim that Slake emit already matches object files as identical bytes. This document does not specify fargo. This document does not specify the Surmount Systems System Prompt (SSSP). This document does not specify the Carbonado Network Protocol. Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

Important work in Lean Machine SHALL be dedicated to the public domain under the Unlicense as specified in `0009_PDOSS.md`. Copyright grants that keep a later private claim on the work are not enough freedom for that important work. Open source licenses that keep a copyright grant are not a substitute for that Unlicense requirement. This document does not invent a second PDOSS specification.

### 1.1 Status of this document

1. This document is normative for the identity of Lean Machine as specification 0013, for Systems Lean as the high assurance compiler component of Lean Machine as specified in `0002_Systems_Lean.md`, for Legal Lean as a named component that exposes contradictions and proves legal concerns, for Holy Lean as a named component that encodes scripture as a practical set of rules, for the Unlicense of important Lean Machine work as specified in `0009_PDOSS.md`, for a deterministic attempt to answer, for timestamped notes when an answer is wrong or imprecise, for distributed self improvement of the machine as a design requirement citing `0006_RSI.md`, and for residual honesty that Lean Machine work is ongoing and is not ready for use and that a conforming implementation is not claimed.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0013. The file name is `0013_Lean_Machine.md`.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in `0006_RSI.md`. RSI is specification 0006. RSI is not this specification. This document cites RSI for tool improvement. It does not restate all of RSI.
6. Continuous Integration and stack consistency is specified in `0007_CI.md`. That document is specification 0007. That document is not this specification.
7. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
8. Public Domain Open Source Software is specified in `0009_PDOSS.md`. That document is specification 0009. That document is not this specification. Unlicense remains the license.
9. Surmount Systems stack composition is specified in `0010_Surmount_Systems.md`. That document is specification 0010. That document is not this specification.
10. Surmount Systems Tech Tree is specified in `0011_Surmount_Systems_Tech_Tree.md`. That document is specification 0011. That document is not this specification.
11. Majestic `Memex` is specified in `0012_Majestic_Memex.md`. That document is specification 0012. That document is not this specification.
12. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md). That document is specification 0002. That document is not this specification.
13. First publication of this specification as a numbered document is version 0.1.0 dated 20260831.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md` and as stated by Keagan McLelland (Proof of Keags), requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/LeanMachineSpec.lean` encode selected claims such as this document's identity as specification 0013 with file name `0013_Lean_Machine.md`, Systems Lean as specification 0002, Public Domain Open Source Software (PDOSS) as specification 0009, RSI as specification 0006, Legal Lean and Holy Lean as named components without separate stack numbers, a mash that still claims Lean Machine has no number as nonconforming, and worship as not a conformance conjunct.
3. Proofs of those encodings live in `lean/LeanMachineProofs.lean`.
4. The Lean module `Surmount` remains the single composition proof over stack identities. This specification's identity in that composition is specification 0013.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
6. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license. This document does not invent a second PDOSS specification.
7. Surmount Systems stack composition remains [0010_Surmount_Systems.md](0010_Surmount_Systems.md).
8. Surmount Systems Tech Tree remains [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md).
9. Majestic `Memex` remains [0012_Majestic_Memex.md](0012_Majestic_Memex.md).
10. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md). This document cites that path for the Systems Lean component. It does not restate every Systems Lean clause.
11. beastdb remains [0003_beastdb.md](0003_beastdb.md).
12. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md). Application and neurosymbolic integration remain in that document. They are not restated here.
13. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo.
14. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`). Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`). Number 0013 is this specification. This document does not steal those numbers for fargo or for Carbonado.
15. SSSP is named in residual. It is not specified here.
16. Legal Lean is a named component of Lean Machine. Legal Lean has no separate numbered specification in this effort.
17. Holy Lean is a named component of Lean Machine. Holy Lean has no separate numbered specification in this effort.
18. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, Idris 2, and Rust are not pinned under this specifications repository's `ref/`. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Pins for Lean 4, CompCert, Idris 2, and Rust live in the Systems Lean product tree as specified in `0002_Systems_Lean.md`. This repository MUST NOT copy those four trees into this repository's `ref/`.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document, including Clause 11.4 on markdown path links in this repository).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0002_Systems_Lean.md` (Systems Lean and Slake: the high assurance compiler component).
5. Surmount specification `0005_CATE.md` (Concise American Technical English).
6. Surmount specification `0006_RSI.md` (Recursive Self Improvement of tools).
7. Surmount specification `0008_Formal_Vibefication.md` (Formal Vibefication: Lean spec encodings separate from proofs).
8. Surmount specification `0009_PDOSS.md` (Public Domain Open Source Software of important work). Unlicense remains the license.

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12, https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-31).
2. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20, https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-31).
3. The Unlicense, https://unlicense.org/ (accessed: 2026-08-31). That site is informative. The binding dedication in this repository is `UNLICENSE.md` as specified in `0009_PDOSS.md`.
4. CompCert, the formally verified C compiler, publisher git https://github.com/AbsInt/CompCert.git . The Form 1 pin lives in the Systems Lean product tree as specified in `0002_Systems_Lean.md`. CompCert is not Unlicense.

Those Proof of Keags pages are research. They are not Unlicense grants. They are not permission to vendor those essays as Form 2 copies under `ref/`. Citations of that work SHALL keep those publisher links (back linking).

## 3. Definitions

### 3.1 Lean Machine

The integration specified by this document: Systems Lean as the compiler component, Legal Lean as the legal proof component, and Holy Lean as the scripture rules component, together as one symbolic proof machine that MUST attempt to answer questions deterministically and MUST timestamp a note when an answer is wrong or imprecise.

### 3.2 Systems Lean component

The language and compiler path specified in [0002_Systems_Lean.md](0002_Systems_Lean.md). For the Systems Lean component of Lean Machine, that path is REQUIRED. Systems Lean produces freestanding high assurance C compiled ahead of time, on assurance levels a Rust type system is not expressive enough to prove, compiled with CompCert `ccomp`. CompCert verified compilation and a bootstrapped Slake compiler that fully typechecks remain REQUIRED for that named high assurance path. Future versions MAY target LLVM IR so the Rust ecosystem can be upgraded without a pile of `-sys` crates. Those four language pins live in the Systems Lean product tree. They are not pins of this specifications repository's `ref/`.

### 3.3 Legal Lean

The named component of Lean Machine that exposes contradictions and proves legal concerns automatically. Legal scholars are wanted. They are not required for the machine to run. Legal Lean does not receive its own stack number in this effort.

### 3.4 Holy Lean

The named component of Lean Machine that proves the Bible and its principles as a practical set of rules for a successful, kind, honorable civilization. Holy Lean does not receive its own stack number in this effort. Holy Lean is not implemented.

### 3.5 Timestamped note

A durable record that names the question, the answer that was wrong or imprecise, and a clock time, so later work can improve the machine. The storage of that note is a product detail. The requirement to write it is not.

### 3.6 Distributed self improvement

The design that Lean Machine consumes information and builds a better version of itself as a distributed process. Tool improvement follows `0006_RSI.md`. This definition is a requirement on the design. It is not a claim that a running distributed machine already exists.

### 3.7 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.8 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown, as specified in `0008_Formal_Vibefication.md`. For this specification that sibling is `0013_Lean_Machine.lean`. Proofs of that encoding live in `lean/Proofs_0013.lean`. `lean/LeanMachineSpec.lean` is the meaning encoding. It is not the line encoding of this markdown file.

## 4. Core requirements

### 4.1 Human contract and Formal Vibefication

1. This document is the human contract for Lean Machine.
2. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in `0008_Formal_Vibefication.md`.
3. Authors SHALL NOT paste theorem statements from `lean/LeanMachineProofs.lean` into this document as a substitute for those proofs.
4. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
5. Citations of Taking Don't Trust. Verify. Seriously SHALL include the canonical URL https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html .
6. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
7. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, leftover unstack, Residual heading, registry scan, Keagan back linking). `spec_check` is not meaning.

### 4.2 Unlicense of important work

1. Important Lean Machine work SHALL be dedicated to the public domain under the Unlicense as specified in `0009_PDOSS.md`.
2. Authors MUST NOT treat an open source license that keeps a copyright grant as enough freedom for that important work.
3. This document SHALL NOT invent a second PDOSS specification. Number 0009 remains Public Domain Open Source Software (PDOSS). Unlicense remains the license.
4. Essays by Keagan McLelland (Proof of Keags) are not Unlicense grants of this repository.
5. CompCert is not Unlicense. Upstream trees keep their original licenses as specified in `0002_Systems_Lean.md`.

### 4.3 Systems Lean component

1. The Systems Lean component of Lean Machine SHALL follow [0002_Systems_Lean.md](0002_Systems_Lean.md).
2. Named high assurance work on that component MUST emit freestanding C compiled ahead of time and MUST compile that emit with CompCert `ccomp`.
3. A bootstrapped Slake compiler that fully typechecks remains REQUIRED for that named high assurance path.
4. Authors MUST NOT weasel those two validation steps as optional when a pin is missing from this repository's `ref/`. Those pins live in the Systems Lean product tree.
5. Future versions MAY emit LLVM IR so the Rust ecosystem can be upgraded without a pile of `-sys` crates. LLVM IR emission is not required for conformance of the named high assurance path.
6. Application and neurosymbolic integration remain in `0004_SSSSS.md`. This document does not move them here.

### 4.4 Legal Lean component

1. Legal Lean SHALL expose contradictions and SHALL prove legal concerns automatically when that component is present.
2. Legal scholars are wanted. They are not required for the machine to run.
3. Legal Lean SHALL NOT receive a separate stack number in this effort. Number 0013 is Lean Machine.
4. Authors MUST NOT write that Legal Lean is a finished product.

### 4.5 Holy Lean component

1. Holy Lean SHALL encode the Bible and its principles as a practical set of rules for a successful, kind, honorable civilization when that component is present.
2. Holy Lean SHALL NOT receive a separate stack number in this effort. Number 0013 is Lean Machine.
3. Authors MUST NOT write that Holy Lean is implemented or ready for use.

### 4.6 Deterministic answers and timestamped notes

1. Lean Machine MUST attempt to answer questions deterministically.
2. If an answer is wrong or imprecise, a note MUST be timestamped so later work can improve the machine.
3. Authors MUST NOT treat a missing timestamped note as an acceptable substitute for that improvement path.

### 4.7 Distributed self improvement

1. Lean Machine SHALL be designed as a distributed system that consumes information and builds a better version of itself.
2. Tool improvement SHALL follow `0006_RSI.md`. This document does not restate all of RSI.
3. That design requirement is not a claim that a running distributed machine already exists. Authors MUST NOT write that such a machine already runs unless the operator says it does.

### 4.8 Worship and scripture study (informative)

This subsection is informative. It is moral framing. It is not a conformance conjunct for the compiler or for Lean Machine software.

This subsection is ordinary English moral framing. It does not tell software to require worship. Readers are asked not to worship that which is created. Studying scripture and taking time for a creator, if the reader believes in one, is informative. Intellectual honesty: existence of God is not proved either way in this specification. Belief is not a requirement of software conformance. Authors MUST NOT encode theology as a MUST for the compiler. Authors MUST NOT make belief a conformance conjunct.

### 4.9 Product honesty

1. This document does not claim that a conforming Lean Machine exists. Authors MUST NOT write that a conforming Lean Machine exists.
2. Legal Lean and Holy Lean are ongoing named work. Authors MUST NOT write that those components are done.
3. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
4. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist. Neurosymbolic integration remains in `0004_SSSSS.md`.
5. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
6. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
7. fargo is unspecified. fargo has no numbered specification and no assigned number.
8. SSSP is unspecified. SSSP has no numbered specification file and no assigned number.
9. The Carbonado Network Protocol is unspecified. Carbonado has no numbered specification file and no assigned number.
10. Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.

### 4.10 Sibling encodings and named gate

1. Every published numbered markdown file at this repository root SHALL have a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root whose physical lines match that markdown, as specified in `0008_Formal_Vibefication.md`.
2. Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`.
3. Mixing those encodings with their proofs in one file is nonconforming as specified in `0008_Formal_Vibefication.md`.
4. The Lean program `line_encodings_check` SHALL fail when a markdown line has no encoding or an encoding has no matching markdown line.
5. The named gate for this specifications repository remains the gate specified in `0007_CI.md`:

```text
nix flake check "path:$PWD" --print-build-logs
```

## 5. Required Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Numbered markdown is the contract humans read; the specification is also encoded in Lean; proofs live in separate Lean modules; Formal Vibefication citations keep the canonical Proof of Keags URLs; `spec_check` remains form and is not meaning (Clause 4.1).
2. Important Lean Machine work is Unlicense as specified in `0009_PDOSS.md`; a copyright grant that keeps a later private claim is not treated as enough freedom for that work; this document does not invent a second PDOSS specification (Clause 4.2).
3. The Systems Lean component follows `0002_Systems_Lean.md`; named high assurance work on that component emits freestanding C compiled ahead of time, compiles that emit with CompCert `ccomp`, and keeps a bootstrapped Slake that fully typechecks; those steps are not optional because a pin is missing from this repository's `ref/` (Clause 4.3).
4. Legal Lean, when present, exposes contradictions and proves legal concerns; Legal Lean has no separate stack number; Legal Lean is not treated as finished (Clause 4.4).
5. Holy Lean, when present, encodes scripture as a practical set of rules; Holy Lean has no separate stack number; Holy Lean is not treated as implemented (Clause 4.5).
6. The machine attempts to answer questions deterministically; a timestamped note is written when an answer is wrong or imprecise (Clause 4.6).
7. The design is a distributed system that consumes information and builds a better version of itself, citing `0006_RSI.md`; that design is not treated as a claim that the machine already runs (Clause 4.7).
8. Worship and belief are not treated as a conformance conjunct for the compiler or for Lean Machine software (Clause 4.8).
9. A conforming Lean Machine is not claimed to exist; Legal Lean and Holy Lean are treated as ongoing named work; beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use; fargo, SSSP, and Carbonado remain unspecified; a numbered Vocabulary file does not exist (Clause 4.9).
10. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean`; proofs of those encodings live in `lean/Proofs_NNNN.lean`; the named gate in `0007_CI.md` remains the gate (Clause 4.10).

This specification is not itself a conforming Lean Machine. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) and the MAY LLVM IR path do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to. Clause 4.8 is informative. Belief is not a conformance conjunct.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program; this clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo is not specified. fargo has no assigned specification number. This document does not invent a number for fargo. This document does not steal 0005, 0006, 0007, 0008, 0009, 0010, 0011, 0012, 0013, or 0014 for fargo.
2. The Surmount Systems System Prompt (SSSP) is not specified. It has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol is deferred. It has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`), not Carbonado. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`). Number 0013 is this specification. Number 0014 is Anunnaki Encoding (`0014_Anunnaki_Encoding.md`). This document does not create a file for Carbonado.
4. Legal Lean is a named component of Lean Machine. Legal Lean has no separate numbered specification and no assigned number of its own. This document MUST NOT be read as creating `NNNN_Legal_Lean.md`. Treating Legal Lean as having a separate stack number is Cons False in `lean/LeanMachineProofs.lean`.
5. Holy Lean is a named component of Lean Machine. Holy Lean has no separate numbered specification and no assigned number of its own. This document MUST NOT be read as creating `NNNN_Holy_Lean.md`. Treating Holy Lean as having a separate stack number is Cons False in `lean/LeanMachineProofs.lean`.
6. Number 0009 was briefly Vocabulary, then Unlicense, and is now Public Domain Open Source Software (PDOSS) by operator order. Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). This document does not assign 0009 to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.

### 6.2 Product that is not implemented

1. Lean Machine work is ongoing and is not ready for use. A conforming implementation is not claimed. This specification records the contract. It does not ship the machine. Treating a conforming Lean Machine as existing is Cons False in `lean/LeanMachineProofs.lean`.
2. Legal Lean is ongoing named work. Automatic proof of legal concerns is not claimed done. Treating Legal Lean as finished is Cons False in `lean/LeanMachineProofs.lean`.
3. Holy Lean is ongoing named work. A Lean encoding of scripture as a civilization set of rules is not claimed done. Treating Holy Lean as implemented is Cons False in `lean/LeanMachineProofs.lean`.
4. Distributed self improvement is a design requirement. A running distributed machine is not claimed. Treating that design requirement as a claim that such a machine already runs is Cons False in `lean/LeanMachineProofs.lean`.
5. Timestamped notes on wrong or imprecise answers are a requirement. A shipped store for those notes is not claimed.

### 6.3 Product claims that are not ready for use

1. beastdb, SSSSS, Slake, and Continuous Integration remain ongoing and not ready for use. This document MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in `0007_CI.md`. This document does not claim that match already holds.
3. Neurosymbolic integration remains in `0004_SSSSS.md`. It is specified there. It is not a shipped product. This document does not move it here.
4. `lean/LeanMachineSpec.lean` encodes selected claims. `lean/LeanMachineProofs.lean` proves those claims. `0013_Lean_Machine.lean` encodes the physical lines of this markdown file. `lean/Proofs_0013.lean` proves identities of that line encoding. Those modules are not a proof that a Lean Machine product exists. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use. A mash of spec encodings and proofs in one module is Cons False in `lean/LeanMachineProofs.lean`.

### 6.4 Pins and licenses this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. https://unlicense.org is informative prior art. It is not a Clause 12 pin. The binding dedication is `UNLICENSE.md` as specified in `0009_PDOSS.md`.
3. Formal Vibefication essays are cited by URL. They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Full license text is still not published on https://proofofkeags.com . Do not invent that license.

### 6.5 Informative items this document names

1. Clause 4.8 (worship and scripture study) is informative. Existence of God is not proved either way. Belief is not a conformance conjunct. Treating worship as a conformance conjunct is Cons False in `lean/LeanMachineProofs.lean`. Treating belief as a conformance conjunct is Cons False in that same module. Treating theology as a MUST for the compiler is Cons False in that same module.
2. Legal scholars are wanted. They are not a runtime requirement.
3. LLVM IR emission is MAY (Clause 4.3 item 5).
4. SSSSS remains specification 0004. Application and neurosymbolic integration live there.

### 6.6 Cons clashes this document already states

1. The clashes named in Clause 6.1 items 4 and 5, Clause 6.2 items 1 through 4, Clause 6.3 item 4, and Clause 6.5 item 1 are Cons False in `lean/LeanMachineProofs.lean`. Those proofs do not make Lean Machine ready for use. They do not invent a number for Legal Lean or Holy Lean. They do not claim a conforming implementation.
2. This document does not add a Cons for a clash this document does not state. Worship remains not a conformance conjunct.

## 7. Changelog

### 0.1.0 - 20260831

First publication of Lean Machine as numbered specification 0013 with file name `0013_Lean_Machine.md`. Records that Lean Machine was unassigned and that this encode assigns number 0013. Records Systems Lean as the high assurance compiler component following `0002_Systems_Lean.md`, with CompCert `ccomp` and a bootstrapped Slake that fully typechecks REQUIRED for that named path. Records Legal Lean and Holy Lean as named components without separate stack numbers. Records Unlicense of important work as specified in `0009_PDOSS.md`. Records a deterministic attempt to answer and timestamped notes when an answer is wrong or imprecise. Records distributed self improvement as a design requirement citing `0006_RSI.md`, not as a claim that the machine already runs. Records worship and scripture study as informative moral framing, not as a conformance conjunct. Records Formal Vibefication with canonical Proof of Keags URLs and back linking. Requires residual honesty that Lean Machine work is ongoing and is not ready for use, that a conforming implementation is not claimed, and that Legal Lean and Holy Lean are not done.

This 0.1.0 also records: CATE is specification 0005; RSI is specification 0006; Continuous Integration is specification 0007; Formal Vibefication is specification 0008; Public Domain Open Source Software (PDOSS) is specification 0009; Unlicense remains the license; the word catalog is owned by CATE as specification 0005; a numbered Vocabulary file MUST NOT exist; Surmount Systems is specification 0010; Surmount Systems Tech Tree is specification 0011; Majestic Memex is specification 0012; this specification is number 0013; fargo has no assigned specification number; SSSP is not specified; Carbonado has no assigned number; Legal Lean and Holy Lean have no separate numbers; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; this document does not claim that a conforming Lean Machine exists.

This 0.1.0 also records Cons False for clashes this document already states: worship or belief as a conformance conjunct, theology as a MUST for the compiler, Legal Lean or Holy Lean as a separate stack number, Legal Lean as finished, Holy Lean as implemented, a claimed conforming Lean Machine, a running distributed machine treated as already existing, and a mash of spec encodings with proofs. Proofs live in `lean/LeanMachineProofs.lean`. Those proofs do not make Lean Machine ready for use.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).
