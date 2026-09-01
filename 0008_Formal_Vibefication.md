# Formal Vibefication

> v0.1.0 - 20260831
>
> Encode the specification in Lean as what must be true, keep proofs in separate modules, and keep numbered markdown as the contract humans read

## 1. Scope

This document specifies Formal Vibefication for this specifications repository: the specification SHALL be encoded in Lean as declarations of what must be true, proofs of those declarations SHALL live in separate Lean modules, and numbered markdown remains the contract humans read.

This specification is number 0008. The file name is `0008_Formal_Vibefication.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected claims are encoded in Lean under `lean/FormalVibeficationSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/FormalVibeficationProofs.lean`. Every published numbered markdown file at this repository root also has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. Those Lean files are not this specification.

This document does not claim that a conforming Surmount product exists. This document does not claim that Slake emit already matches object files as identical bytes. This document does not specify fargo. This document does not specify the Surmount Systems System Prompt (SSSP). This document does not specify the Carbonado Network Protocol. Lean Machine is specified in `0013_Lean_Machine.md`. Number 0009 is Unlicense (`0009_Unlicense.md`). The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 1.1 Status of this document

1. This document is normative for encoding the specification in Lean as structures and propositions that state what must be true, for keeping those encodings in modules whose names or comments mark them as spec encodings rather than proofs, for keeping proofs in separate Lean modules, for treating numbered markdown as the contract humans read and not as a substitute for those encodings, for treating Lean proofs as not the specification, for treating `spec_check` as form of numbered markdown rather than as a meaning encoding, for treating a mash of spec encodings and their proofs that hides the split as nonconforming in this specifications repository, for requiring a sibling `NNNN_descriptive_name.lean` at the repository root whose physical lines match each published numbered markdown file, for treating a mash of that sibling encoding with its proofs as nonconforming, and for treating product tree unification under Systems Lean and SSSSS as a different home whose mash with this repository's split is inconsistent.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0008. The file name is `0008_Formal_Vibefication.md`.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in `0006_RSI.md`. RSI is specification 0006. RSI is not this specification.
6. Continuous Integration and stack consistency is specified in `0007_CI.md`. That document is specification 0007. That document is not this specification.
7. Surmount Systems is specified in `0010_Surmount_Systems.md`. That document is specification 0010. That document is not this specification.
8. First publication of this specification as a numbered document is version 1.0.0 dated 20260825.

### 1.2 Spec encodings and proofs (informative)

This subsection is informative. It records how this specification relates to Lean encodings and to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication uses that split. Numbered markdown remains the contract humans read. That markdown is not a substitute for encoding the specification in Lean. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Lean spec encodings under `lean/FormalVibeficationSpec.lean` declare what must be true (structures, propositions, and identities of this document as specification 0008 with file name `0008_Formal_Vibefication.md`). That module is marked as a spec encoding. It is not a proof module.
3. Lean proofs under `lean/FormalVibeficationProofs.lean` import that spec encoding module and establish those propositions. That module is the proof. It is not the specification.
4. The Lean module `Surmount` composes human markdown, Lean spec encodings, Lean proofs, and product implementation. `surmountSpecNumber` remains 10. This document's identity in that composition is `formalVibeficationSpecNumber = 8`.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker.
6. Every published numbered markdown file `NNNN_descriptive_name.md` at this repository root has a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root. The encoding file uses the markdown basename with `.lean` in place of `.md` so a reader sees the pair immediately. The file name starts with a digit, so Lean uses a quoted module name that matches that stem. That sibling holds a Lean value for every physical line of the markdown (line numbers that start at 1, exact text, optional role). Proofs of those line encodings live in `lean/Proofs_NNNN.lean`.
7. The Lean program `line_encodings_check` fails when a markdown line has no encoding or an encoding has no matching markdown line. That program is an isomorphism of lines. It is not a second markdown form checker and it is not this specification.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Surmount Systems remains [0010_Surmount_Systems.md](0010_Surmount_Systems.md).
6. Unlicense remains [0009_Unlicense.md](0009_Unlicense.md). That document is specification 0009. That document is not this specification.
7. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
8. beastdb remains [0003_beastdb.md](0003_beastdb.md).
9. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
10. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo. This document does not specify how Rust is elevated with fargo.
11. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`). Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is this specification. Number 0009 is Unlicense (`0009_Unlicense.md`). The word catalog lives in CATE (`0005_CATE.md`). Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not steal those numbers for fargo or for Carbonado.
12. SSSP is named in residual. It is not specified here.
13. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. That document is not this specification.
14. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is Unlicense (`0009_Unlicense.md`). A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not assign 0009 to fargo or to Carbonado.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, and Rust are not pinned under this specifications repository's `ref/`. This document does not add Form 1 git submodules to this repository. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0005_CATE.md` (Concise American Technical English).
5. Surmount specification `0006_RSI.md` (Recursive Self Improvement).
6. Surmount specification `0007_CI.md` (Continuous Integration and stack consistency).
7. Surmount specification `0010_Surmount_Systems.md` (Surmount Systems stack composition).
8. Surmount specification `0002_Systems_Lean.md` (Systems Lean, Slake, CompCert verified compilation, and bootstrap typecheck), cited when this document names the product path that unifies specification, proof, and implementation.
9. Surmount specification `0004_SSSSS.md` (SSSSS), cited when this document names product tree unification.

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12 - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-25).
2. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20 - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-25).

Those pages are research. They are not Unlicense grants. They are not permission to vendor those essays as Form 2 copies under `ref/`. Citations of this work SHALL keep those publisher links (back linking). Lessons used here: a specification states what must be true and a proof states how that is established; those artifacts are separable; theorems cover exactly what they state.

## 3. Definitions

### 3.1 Formal Vibefication

The practice specified by this document: encode the specification in Lean as declarations of what must be true, keep proofs of those declarations in separate Lean modules, and keep numbered markdown as the contract humans read. Keagan McLelland (Proof of Keags) named Formal Vibefication. Canonical URL: https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .

### 3.2 Human contract

The numbered markdown file at this repository root that people read. For this specification that file is `0008_Formal_Vibefication.md`. The human contract is not a substitute for Lean spec encodings.

### 3.3 Spec encoding

A Lean module that declares what must be true, using structures, inductive types, and propositions, whose name or comments mark it as a spec encoding rather than a proof. For this specification that module is `lean/FormalVibeficationSpec.lean`. Identity equalities such as this document's number MAY use `rfl`. Proofs of the stack split SHALL NOT live in that module.

### 3.4 Proof module

A Lean module that imports a spec encoding and establishes the propositions that encoding states. For this specification that module is `lean/FormalVibeficationProofs.lean`. A proof module is not the specification.

### 3.5 Mash that hides the split

One Lean module that holds spec encoding declarations together with the proofs of those declarations so a reader cannot tell the specification from the proof. A mash that hides the split is nonconforming in this specifications repository.

### 3.6 Product tree unification

The path specified by `0002_Systems_Lean.md` and `0004_SSSSS.md` in which specification, proof, and implementation live in one typed language so a project can be shown logically consistent, after which Slake emits freestanding C ahead of time and MAY emit optional LLVM IR. That unification is for Systems Lean product trees. It is a different home from this specifications repository.

### 3.7 Mash of homes

Treating this specifications repository's split (Clause 3.1) and product tree unification (Clause 3.6) as if they were the same layer. A mash of homes is inconsistent. Lean SHALL treat that mash as `False`.

### 3.8 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.9 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown (line numbers that start at 1, exact text, optional role). The encoding file uses the markdown basename with `.lean` in place of `.md` so a reader sees the pair immediately. The file name starts with a digit, so Lean uses a quoted module name that matches that stem. For this specification that sibling is `0008_Formal_Vibefication.lean`.

### 3.10 Isomorphism of lines

The relation that holds when every physical line of a numbered markdown file has a matching Lean encoding and every encoding has a matching markdown line, in order, with the same exact text. The Lean program `line_encodings_check` checks that relation.

## 4. Core requirements

### 4.1 Human contract

1. Numbered markdown in this specifications repository is the contract humans read.
2. Numbered markdown SHALL NOT be treated as a substitute for Lean spec encodings.
3. Authors SHALL NOT paste theorem statements from `lean/FormalVibeficationProofs.lean` or from `lean/Surmount.lean` into this document as a substitute for those encodings or for those proofs.
4. Authors MAY cite theorem names and module names so readers can find the encodings and the proofs.

### 4.2 Lean spec encodings

1. The specification SHALL also be encoded in Lean as declarations of what must be true (structures, inductive types, and propositions).
2. Those encodings SHALL live in modules whose names or comments mark them as spec encodings, not proofs.
3. For this specification the spec encoding module is `lean/FormalVibeficationSpec.lean`.
4. Lean proofs SHALL NOT be treated as the specification.

### 4.3 Separate proof modules

1. Proofs SHALL live in separate Lean modules from the spec encodings they prove.
2. For this specification the proof module is `lean/FormalVibeficationProofs.lean`. That module SHALL import the spec encoding module.
3. A proof module MAY use `rfl`, `decide`, and ordinary Lean tactics. It SHALL NOT redefine the specification as a side effect of the proof.

### 4.4 Form checker

1. `spec_check` remains form of numbered markdown (ASCII, tabs, RFC 2119, spelling, leftover unstack, Residual heading, registry scan, Keagan back linking).
2. Spec encodings of meaning MUST NOT be treated as a second markdown form checker.
3. `spec_check` is not a spec encoding of meaning and is not a proof of meaning.

### 4.5 Mash that hides the split is nonconforming here

1. Mixing spec encoding declarations and their proofs in one mash that hides the split (Clause 3.5) is nonconforming for this specifications repository.
2. A fixture that places spec encodings and their proofs in one mashed module does not conform.
3. Separate modules that mark one file as the spec encoding and another file as the proof do conform for this split.
4. Companion Lean SHALL treat a mash of spec encoding and proof as `False` (see `mash_spec_and_proof`). This document does not paste that theorem.

### 4.6 Product trees unify; this repository does not mash homes

1. In this specifications repository, human markdown, Lean spec encodings, and Lean proofs SHALL stay distinct from each other and from product implementation (`thisRepoSeparates`).
2. `thisRepoSeparates` means spec encodings are not proofs and are not markdown form.
3. In Systems Lean product trees, Systems Lean (`0002_Systems_Lean.md`) and SSSSS (`0004_SSSSS.md`) MAY unify specification, proof, and implementation in one typed language so a project can be shown logically consistent, after which Slake emits freestanding C ahead of time and MAY emit optional LLVM IR (`productTreeUnifies`).
4. `thisRepoSeparates` and `productTreeUnifies` MAY both hold because they name different homes.
5. That unification SHALL NOT license mixing spec encodings with their proofs in this specifications repository, and SHALL NOT license mixing theorems into numbered markdown here.
6. A mash of homes (Clause 3.7) does not conform.
7. Companion Lean SHALL treat a mash of homes as `False`. This document does not paste that theorem.

### 4.7 Back linking and exact theorems

1. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
2. Citations of Taking Don't Trust. Verify. Seriously SHALL include the canonical URL https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html .
3. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
4. Theorems cover exactly what they state. Byte identity required is not a proof that emit equals `ELF`.
5. This repository does not vendor those essays as Form 2 copies under `ref/`.

### 4.8 Product honesty

1. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
2. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
3. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
4. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
5. This specification does not claim a conforming Formal Vibefication product exists beyond the encodings and proofs named here.

### 4.9 Unassigned numbers and unspecified products

1. fargo is unspecified. fargo has no numbered specification and no assigned number. Authors SHALL NOT invent a numbered specification file for fargo in this effort.
2. SSSP is unspecified. SSSP has no numbered specification file and no assigned number.
3. The Carbonado Network Protocol is unspecified. Carbonado has no numbered specification file and no assigned number.
4. Lean Machine is specified in `0013_Lean_Machine.md`. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 is Unlicense (`0009_Unlicense.md`). The word catalog lives in CATE (`0005_CATE.md`). Authors SHALL NOT assign 0009 to fargo or to Carbonado. Mentions of Vocabulary as a published specification 0009 do not conform.
6. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 4.10 Sibling line encodings for every published numbered specification

1. Every published numbered specification markdown `NNNN_descriptive_name.md` at this repository root SHALL have an adjacent Lean spec encoding `NNNN_descriptive_name.lean` at the same root (Clause 3.9).
2. Every physical line of that markdown, including blank lines, SHALL have a Lean encoding (line numbers that start at 1, exact text, optional role).
3. Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`, not in `NNNN_descriptive_name.lean`.
4. Mixing those encodings with their proofs in one file is a mash that hides the split (Clause 3.5) and is nonconforming in this specifications repository.
5. Encoded text SHALL match the file bytes' lines (LF). Authors SHALL NOT wrap encoded lines or change their breaks.
6. The Lean program `line_encodings_check` SHALL fail when a markdown line has no encoding or an encoding has no matching markdown line (Clause 3.10).
7. Identity equalities such as line counts MAY use `rfl` in the encoding module. Theorems about the specification SHALL live in the proof module.
8. `lean/FormalVibeficationSpec.lean` remains the meaning encoding of this specification. `0008_Formal_Vibefication.lean` is the line encoding of this markdown file. Those are not the same module.

### 4.11 Named gate

1. The named gate for this specifications repository remains the gate specified in `0007_CI.md`:

```text
nix flake check "path:$PWD" --print-build-logs
```

2. Lean 4 SHALL be used to surface logical inconsistency in the encodings and in the proofs.

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Numbered markdown is the contract humans read and is not treated as a substitute for Lean spec encodings (Clause 4.1).
2. The specification is encoded in Lean as declarations of what must be true, in modules marked as spec encodings rather than proofs (Clause 4.2).
3. Proofs live in separate Lean modules that import those encodings (Clause 4.3).
4. `spec_check` remains form of numbered markdown; spec encodings of meaning are not a second markdown form checker (Clause 4.4).
5. Mixing spec encoding declarations and their proofs in one mash that hides the split is treated as nonconforming for this repository; companion Lean treats that mash as `False` (Clause 4.5).
6. This specifications repository keeps human markdown, Lean spec encodings, and Lean proofs distinct; Systems Lean product trees may unify specification, proof, and implementation; a mash of those homes is treated as `False` (Clause 4.6).
7. Formal Vibefication citations keep the canonical Proof of Keags URLs; a numbered specification that names Keagan or Proof of Keags also contains the host `proofofkeags.com`; theorems cover exactly what they state (Clause 4.7).
8. beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use, and are not described as never started or as ready (Clause 4.8).
9. fargo, SSSP, and Carbonado remain unspecified; Lean Machine is specified in `0013_Lean_Machine.md`; number 0009 is Unlicense and is not assigned to fargo or Carbonado; a numbered Vocabulary file does not exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept (Clause 4.9).
10. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown; proofs of those encodings live in `lean/Proofs_NNNN.lean`; a mash of that sibling encoding with its proofs is nonconforming; `line_encodings_check` fails on drift (Clause 4.10).
11. The named gate in `0007_CI.md` remains the gate for this repository (Clause 4.11).

This specification is not itself a conforming Surmount product. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program; this clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo is not specified. fargo has no assigned specification number. This document does not invent a number for fargo. This document does not steal 0005, 0006, 0007, 0008, 0009, 0010, or 0011 for fargo. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.
2. The Surmount Systems System Prompt (SSSP) is not specified. It has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol is deferred. It has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`), not Carbonado. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is this specification. Number 0009 is Unlicense (`0009_Unlicense.md`). Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not create a file for Carbonado.
4. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 was briefly Vocabulary, then withdrawn, and is now Unlicense by operator order. The word catalog lives in CATE (`0005_CATE.md`). This document does not assign 0009 to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 6.2 Product claims that are not ready for use

1. This document specifies Formal Vibefication for this specifications repository. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in `0007_CI.md`. This document does not claim that match already holds. The match is not claimed done. Slake work is ongoing and is not ready for use.
3. The SSSSS and beastdb reality check named in `0007_CI.md` is a requirement on that stack. SSSSS and beastdb are ongoing and not ready for use. Do not write that they never started or do not exist. This document does not claim the check is done.
4. `lean/FormalVibeficationSpec.lean` encodes selected claims. `lean/FormalVibeficationProofs.lean` proves those claims. `lean/Surmount.lean` composes stack identities. `0008_Formal_Vibefication.lean` encodes the physical lines of this markdown file. `lean/Proofs_0008.lean` proves identities of that line encoding. Those modules are not a proof that Slake emit already matches `ELF`. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use.

### 6.3 Companion meaning models split encodings and proofs

1. This specification requires the split in Clause 4.2 and Clause 4.3 for spec encodings and proofs in this repository.
2. Companion models for CATE (`lean/CateSpec.lean` encodings, `lean/CateProofs.lean` theorems), RSI (`lean/RsiSpec.lean`, `lean/RsiProofs.lean`), Continuous Integration (`lean/CiSpec.lean`, `lean/CiProofs.lean`), beastdb (encodings and proofs under `lean/` for that product), SSSSS (`lean/SssssSpec.lean`, `lean/SssssProofs.lean`), Systems Lean (`lean/SystemsLeanSpec.lean`, `lean/SystemsLeanProofs.lean`), Formal Vibefication (`lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`), Unlicense (`lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`), Surmount Systems Tech Tree (`lean/TechTreeSpec.lean`, `lean/TechTreeProofs.lean`), Majestic Memex (`lean/MemexSpec.lean`, `lean/MemexProofs.lean`), Lean Machine (`lean/LeanMachineSpec.lean`, `lean/LeanMachineProofs.lean`), and the CATE word catalog (`lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`) place encodings in Spec modules and theorems in Proofs modules. Collision tags in `lean/Vocabulary.lean` are encodings with proofs in `lean/VocabularyCollisionProofs.lean`. Mixing encodings and proofs in one mash is `False`. It is not a claim that those products never started.
3. That split is present for the companion meaning models named in item 2.
4. Sibling line encodings `NNNN_descriptive_name.lean` and proof modules `lean/Proofs_NNNN.lean` exist for every published numbered markdown file. That split is not a claim that products are ready for use.

### 6.4 Pins this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. Formal Vibefication essays are cited by URL. They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Full license text is still not published on https://proofofkeags.com . Do not invent that license.
3. ISO 24495-1:2023 and the US Federal Plain Language Guidelines remain informative prior art of CATE. They are not pins of this document.

### 6.5 Informative items this document names

1. Formal Vibefication research pages in Clause 2.2 are not Clause 12 pins of this document.
2. CATE is specified in `0005_CATE.md`. CATE is not this specification.
3. RSI is specified in `0006_RSI.md`. RSI is not this specification.
4. Continuous Integration is specified in `0007_CI.md`. Continuous Integration is not this specification.
5. Surmount Systems is specified in `0010_Surmount_Systems.md`. Surmount Systems is not this specification.
6. Ahead of time emission is named in ordinary English. That phrasing is not a license to write leftover unstack.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed.

### 1.0.0 - 20260825

First publication of Formal Vibefication as numbered specification 0008 with file name `0008_Formal_Vibefication.md`. Records that numbered markdown is the contract humans read and is not a substitute for Lean spec encodings. Requires the specification to be encoded in Lean as declarations of what must be true, in modules marked as spec encodings. Requires proofs to live in separate Lean modules that import those encodings. Records that Lean proofs are not the specification. Records that `spec_check` is form of numbered markdown and is not a second meaning linter. Treats a mash of spec encodings and their proofs that hides the split as nonconforming in this specifications repository. Records that Systems Lean product trees may unify specification, proof, and implementation, and that mashing that home with this repository's split is `False`. Cites Formal Vibefication and Taking Don't Trust. Verify. Seriously with canonical Proof of Keags URLs and requires back linking. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.

This 1.0.0 also records: CATE is specification 0005; RSI is specification 0006; Continuous Integration is specification 0007; Surmount Systems is specification 0010; this specification is number 0008; number 0009 is Unlicense (`0009_Unlicense.md`) and the word catalog lives in CATE (`0005_CATE.md`); a numbered Vocabulary file MUST NOT exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept; fargo has no assigned specification number; SSSP is not specified; Carbonado has no assigned number; Lean Machine is specified as `0013_Lean_Machine.md`; companion meaning models named in Clause 6.3 split encodings from proofs and treat mash as False; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; this document does not claim that a conforming Surmount product exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).
