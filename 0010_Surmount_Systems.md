# Surmount Systems

> v0.1.0 - 20260831
>
> Human contract for how numbered specifications, meaning models, and product paths fit in the Surmount Systems stack

## 1. Scope

This document is the human contract for Surmount Systems stack composition: how numbered specifications, companion Lean meaning models, and product paths fit.

This specification is number 0010. The file name is `0010_Surmount_Systems.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. It cites the composition proof in `lean/Surmount.lean` (`surmount_integrates` and related theorems). Formal Vibefication is specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md): spec encodings live in Lean; proofs live in separate Lean modules. Selected checkable claims have companion Lean encodings under `lean/` (see Clause 1.2). Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0010_Surmount_Systems.lean`. Those encodings are not this specification.

This document does not claim that a conforming Surmount Systems product exists. This document does not claim that Slake emit already matches object files as identical bytes. fargo has no assigned specification number. This document does not create a numbered file for fargo. The Surmount Systems System Prompt (SSSP) has no assigned specification number. This document does not create a numbered file for SSSP. The Carbonado Network Protocol has no assigned specification number. This document does not create a numbered file for the Carbonado Network Protocol. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md).

### 1.1 Status of this document

1. This document is normative for the split among numbered markdown, Lean spec encodings, and Lean proofs in this specifications repository, for the Systems Lean product path that unifies specification, proof, and implementation in product trees, for the ban on using that unification as a license to mix spec encodings with proofs here or to mix theorems into numbered markdown here, for the Lean module `Surmount` as the single composition proof that reconciles stack identities, for treating a mash of those identities as `False`, for requiring that every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown and that proofs of those encodings live in `lean/Proofs_NNNN.lean`, for residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use, for byte identity of Slake emit as a product requirement that is not claimed true, for Formal Vibefication as specification [0008](0008_Formal_Vibefication.md), for Public Domain Open Source Software (PDOSS) as specification [0009](0009_PDOSS.md), for the word catalog as owned by CATE as specification [0005](0005_CATE.md), for a numbered Vocabulary file as forbidden, and for leaving fargo, SSSP, and Carbonado unassigned, and for citing Lean Machine as specification [0013](0013_Lean_Machine.md). Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0010. The file name is `0010_Surmount_Systems.md`.
4. Concise American Technical English (CATE) is specified in [0005_CATE.md](0005_CATE.md). CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in [0006_RSI.md](0006_RSI.md). RSI is specification 0006. RSI is not this specification.
6. Continuous Integration and stack consistency is specified in [0007_CI.md](0007_CI.md). That document is specification 0007. That document is not this specification.
7. First publication of this specification as a numbered document is version 1.0.0 dated 20260825.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under [0000_spec.md](0000_spec.md).

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md) and as stated by Keagan McLelland (Proof of Keags), requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/` encode selected claims such as this document's identity as specification 0010 with file name `0010_Surmount_Systems.md`, CATE as specification [0005](0005_CATE.md), RSI as specification [0006](0006_RSI.md), Continuous Integration as specification [0007](0007_CI.md), Formal Vibefication as specification [0008](0008_Formal_Vibefication.md), Public Domain Open Source Software (PDOSS) as specification [0009](0009_PDOSS.md), the word catalog as owned by CATE as specification [0005](0005_CATE.md), a numbered Vocabulary file as forbidden, SSSSS as specification [0004](0004_SSSSS.md), beastdb as specification [0003](0003_beastdb.md), Systems Lean as specification [0002](0002_Systems_Lean.md), fargo as unassigned, leftover unstack as nonconforming, Lean spec encodings as CATE on the leftover unstack floor, byte identity as required and not claimed true, products as ongoing and not ready for use, this specifications repository as keeping spec encodings distinct from proofs and from markdown form, Systems Lean product trees as unifying specification, proof, and implementation, and every published numbered markdown file as having a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown with proofs in `lean/Proofs_NNNN.lean`.
3. The Lean module `Surmount` is the single composition proof over those models. The decidable conjunction is `stackIntegrates`. The theorem `surmount_integrates` states that conjunction. This document does not paste those theorems.
4. A Lean registry under `lean/` encodes published specification numbers, file names, and product names, and the form checker scans numbered markdown so wrong numbers, file name mismatches, and wrong capitalization of beastdb fail `nix flake check`.
5. Those modules prove facts about the model. They do not replace this document. This document does not replace those modules.
6. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in [0000_spec.md](0000_spec.md)) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at [0005_CATE.md](0005_CATE.md) for CATE.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
6. beastdb remains [0003_beastdb.md](0003_beastdb.md).
7. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
8. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo. fargo has no assigned specification number, so this document does not state how Rust is elevated with fargo.
9. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE ([0005_CATE.md](0005_CATE.md)). Number 0006 is RSI ([0006_RSI.md](0006_RSI.md)). Number 0007 is Continuous Integration ([0007_CI.md](0007_CI.md)). Number 0008 is Formal Vibefication ([0008_Formal_Vibefication.md](0008_Formal_Vibefication.md)). Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). Number 0010 is this specification. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. This document does not steal those numbers for fargo or for Carbonado.
10. SSSP has no assigned specification number. This document does not create a numbered file for SSSP.
11. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). That document is specification 0013. That document is not this specification.
12. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). That document is specification 0008. That document is not this specification.
13. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. That catalog is not this specification.
14. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). That document is specification 0009. That document is not this specification. Unlicense remains the license.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds [0000](0000_spec.md) Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, and Rust are not pinned under this specifications repository's `ref/`. This document does not add Form 1 git submodules to this repository. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`.

### 2.1 Pins in this specifications repository ([0000](0000_spec.md) Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification [0000_spec.md](0000_spec.md) (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification [0005_CATE.md](0005_CATE.md) (Concise American Technical English).
5. Surmount specification [0006_RSI.md](0006_RSI.md) (Recursive Self Improvement).
6. Surmount specification [0007_CI.md](0007_CI.md) (Continuous Integration and stack consistency).
7. Surmount specification [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md) (Formal Vibefication: Lean spec encodings separate from proofs).
8. Surmount specification [0002_Systems_Lean.md](0002_Systems_Lean.md) (Systems Lean, Slake, CompCert verified compilation, and bootstrap typecheck), cited when this document names the product path that unifies specification, proof, and implementation.
9. Surmount specification [0003_beastdb.md](0003_beastdb.md) (beastdb), cited when this document names the durable store used by the SSSSS reality check.
10. Surmount specification [0004_SSSSS.md](0004_SSSSS.md) (SSSSS), cited when this document names compilation that can be repeated as a check against reality.

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under [0000_spec.md](0000_spec.md) Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12, https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-25).
2. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20, https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-25).

Those pages are research. They are not Unlicense grants. They are not permission to vendor those essays as Form 2 copies under `ref/`. Citations of this work SHALL keep those publisher links (back linking).

## 3. Definitions

### 3.1 Surmount Systems stack composition

The fit specified by this document among numbered specifications at this repository root, sibling Lean line encodings `NNNN_descriptive_name.lean` next to those markdown files, Lean spec encodings under `lean/`, Lean proofs of those encodings, the form checker `spec_check`, the line encoding checker `line_encodings_check`, and Surmount product trees that implement Systems Lean, Slake, beastdb, SSSSS, and Continuous Integration.

### 3.2 Formal Vibefication (this repository)

The split specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md): numbered markdown is the contract humans read; the specification is also encoded in Lean as declarations of what must be true; proofs of those encodings live in separate Lean modules; product trees implement. Numbered markdown is not a substitute for those encodings. Lean proofs are not the specification. Keagan McLelland (Proof of Keags) named Formal Vibefication. Canonical URL: https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .

### 3.3 Systems Lean product path

The path specified by [0002_Systems_Lean.md](0002_Systems_Lean.md) in which specification, proof, and implementation live in one typed language so a project can be shown logically consistent, after which Slake emits freestanding C ahead of time and MAY emit optional LLVM IR. That unification is for Systems Lean product trees, including SSSSS as specified in [0004_SSSSS.md](0004_SSSSS.md). It is not a license to dump theorems into numbered markdown in this specifications repository.

### 3.4 Byte identity

Exact match of bytes (and of each file as a file) among emitted C, headers, archives, shared objects, LLVM IR, `ELF`, and other intermediates that a conforming Systems Lean and Slake product emits. Byte identity is a requirement on such a product, as [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3 requires. This document does not claim that match already holds.

### 3.5 Composition proof

The Lean module `Surmount` in `lean/Surmount.lean`. It is the single composition proof that reconciles the stack identities named in Clause 4.4. It is not this specification. It is not a proof that Slake emit already matches `ELF`. It is not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use.

### 3.6 Mash of homes

Treating the specifications repository split (Clause 3.2) and the Systems Lean product path (Clause 3.3) as if they were the same layer. A mash of homes is inconsistent. Lean SHALL treat that mash as `False`.

### 3.7 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.8 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). For this specification that sibling is `0010_Surmount_Systems.lean`. Proofs of that encoding live in `lean/Proofs_0010.lean`. `lean/Surmount.lean` is the composition proof. It is not the line encoding of this markdown file.

## 4. Core requirements

### 4.1 Human contract for composition

1. This document is the human contract for Surmount Systems stack composition.
2. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
3. Authors SHALL NOT paste theorem statements from `lean/Surmount.lean` into this document or into other numbered markdown in this repository as a substitute for the composition proof.
4. Authors MAY cite theorem names such as `surmount_integrates`, `thisRepoSeparates`, and `productTreeUnifies` so readers can find the proof.

### 4.2 Formal Vibefication and back linking

1. This specifications repository SHALL follow Formal Vibefication in the sense of Clause 3.2.
2. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
3. Citations of Taking Don't Trust. Verify. Seriously SHALL include the canonical URL https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html .
4. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
5. Theorems cover exactly what they state. Byte identity required is not a proof that emit equals `ELF`.
6. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, leftover unstack, Residual heading, registry scan, Keagan back linking). `spec_check` is not meaning.

### 4.3 This repository separates and product trees unify

1. In this specifications repository, numbered markdown, Lean spec encodings, and Lean proofs SHALL stay distinct from each other and from product implementation (`thisRepoSeparates`). `thisRepoSeparates` means spec encodings are not proofs and are not markdown form.
2. In Systems Lean product trees, Systems Lean ([0002_Systems_Lean.md](0002_Systems_Lean.md)) and SSSSS ([0004_SSSSS.md](0004_SSSSS.md)) SHALL unify specification, proof, and implementation in one typed language so a project can be shown logically consistent, after which Slake emits freestanding C ahead of time and MAY emit optional LLVM IR (`productTreeUnifies`).
3. `thisRepoSeparates` and `productTreeUnifies` MAY both hold because they name different homes.
4. That unification SHALL NOT license mixing spec encodings with their proofs in this specifications repository, and SHALL NOT license mixing theorems into numbered markdown here.
5. A mash of homes (Clause 3.6) does not conform.
6. Companion Lean SHALL treat a mash of homes as `False` (see `mash_layers_inconsistent` in `lean/Surmount.lean`). This document does not paste that theorem.

### 4.4 Single composition proof

1. The Lean module `Surmount` SHALL remain the single composition proof that reconciles stack identities.
2. Those identities include all of the following:
	1. CATE is specification [0005](0005_CATE.md).
	2. RSI is specification [0006](0006_RSI.md).
	3. Continuous Integration is specification [0007](0007_CI.md).
	4. SSSSS is specification [0004](0004_SSSSS.md).
	5. beastdb is specification [0003](0003_beastdb.md).
	6. Systems Lean is specification [0002](0002_Systems_Lean.md).
	7. This specification is specification 0010.
	8. Formal Vibefication is specification [0008](0008_Formal_Vibefication.md). Public Domain Open Source Software (PDOSS) is specification [0009](0009_PDOSS.md). Unlicense remains the license. The word catalog is owned by CATE as specification [0005](0005_CATE.md). A numbered Vocabulary file MUST NOT exist. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. Number 0013 is Lean Machine ([0013_Lean_Machine.md](0013_Lean_Machine.md)). Number 0014 is Anunnaki Encoding ([0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md)). The Operator assigned number [0015](0015_Session_Bus.md) to the session bus, and the numbered file is not in this tree because the draft is missing. Those identities remaining composed is not product readiness.
	9. fargo is unassigned.
	10. Leftover unstack is nonconforming.
	11. Byte identity is required for a conforming Systems Lean and Slake product and is not claimed true.
	12. beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.
	13. This specifications repository keeps spec encodings distinct from proofs and from markdown form.
	14. Systems Lean product trees do unify specification, proof, and implementation.
	15. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, and proofs of those encodings live in `lean/Proofs_NNNN.lean`.
3. If meaning models disagree on a stack identity, Lean SHALL treat that mash as `False`. Authors SHALL NOT hide the disagreement behind a `Bool` that stays true.
4. This document does not paste `stackIntegrates` or `surmount_integrates`. Those names are citations of the proof.

### 4.5 Product honesty

1. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
2. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
3. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
4. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
5. This specification does not claim a conforming Surmount Systems product exists.

### 4.6 Byte identity of emit

1. A conforming Systems Lean and Slake product MUST keep byte identity (Clause 3.4 and [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3) among emitted C, headers, archives, shared objects, LLVM IR, `ELF`, and other intermediates it emits.
2. That requirement is a requirement on the product. It is not a claim that the match already holds.
3. Residual for this specification MUST say the match is not claimed done.
4. Companion Lean SHALL encode the requirement and the honest residual as distinct facts. Companion Lean SHALL NOT treat emit equal to `ELF` as a proved identity.

### 4.7 Unassigned numbers and names with no assigned specification number

1. fargo has no numbered specification and no assigned number. Authors SHALL NOT invent a numbered specification file for fargo in this effort.
2. SSSP has no numbered specification file and no assigned number.
3. The Carbonado Network Protocol has no numbered specification file and no assigned number.
4. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). Authors SHALL NOT assign 0009 to fargo or to Carbonado.
6. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept.
7. Mentions of Vocabulary as a published specification [0009](0009_PDOSS.md) do not conform. The catalog is CATE.

### 4.8 Form versus meaning

1. Lean 4 SHALL be used to surface logical inconsistency in the models.
2. Meaning proofs MUST NOT be treated as a second markdown form checker.
3. `spec_check` remains the form checker.
4. The named gate for this specifications repository remains the gate specified in [0007_CI.md](0007_CI.md):

```text
nix flake check "path:$PWD" --print-build-logs
```

### 4.9 Sibling encodings for every published numbered specification

1. Every published numbered markdown file at this repository root SHALL have a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root whose physical lines match that markdown, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
2. Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`.
3. Mixing those encodings with their proofs in one file is nonconforming as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). Companion Lean SHALL treat that mash as `False`.
4. The Lean program `line_encodings_check` SHALL fail when a markdown line has no encoding or an encoding has no matching markdown line.
5. `lean/Surmount.lean` SHALL require that every published numbered markdown file has that sibling encoding and that proofs are separate modules.

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Numbered markdown is the contract humans read; the specification is also encoded in Lean; proofs live in separate Lean modules; theorem statements are not pasted into numbered markdown in this repository as a substitute for the composition proof (Clause 4.1).
2. Formal Vibefication citations keep the canonical Proof of Keags URLs; a numbered specification that names Keagan or Proof of Keags also contains the host `proofofkeags.com`; `spec_check` remains form and is not meaning (Clause 4.2).
3. This specifications repository keeps spec encodings distinct from proofs and from markdown form; Systems Lean product trees unify specification, proof, and implementation; that unification is not treated as a license to mix encodings with proofs here or to mix theorems into numbered markdown here; a mash of homes is treated as `False` (Clause 4.3).
4. The Lean module `Surmount` remains the single composition proof that reconciles the identities in Clause 4.4; a disagreement among models is treated as `False` (Clause 4.4).
5. beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use, and are not described as never started or as ready (Clause 4.5).
6. Byte identity of Slake emit is treated as a product requirement and is not claimed true in this document (Clause 4.6).
7. fargo, SSSP, and Carbonado have no assigned specification numbers; Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md); number [0009](0009_PDOSS.md) is Public Domain Open Source Software (PDOSS) and is not assigned to fargo or Carbonado; a numbered Vocabulary file does not exist; number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept (Clause 4.7).
8. Meaning proofs are not a second form checker; `spec_check` remains form; the named gate in [0007_CI.md](0007_CI.md) remains the gate for this repository (Clause 4.8).
9. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown; proofs of those encodings live in `lean/Proofs_NNNN.lean`; a mash of that sibling encoding with its proofs is treated as `False`; `line_encodings_check` fails on drift (Clause 4.9).

This specification is not itself a conforming Surmount Systems product. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. Checkable residual claims live in `lean/ResidualClaims.lean`, and this specification still carries its own residual clause.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no assigned specification number. This document does not create a numbered file for fargo. This document does not invent a number for fargo. This document does not steal [0005](0005_CATE.md), [0006](0006_RSI.md), [0007](0007_CI.md), [0008](0008_Formal_Vibefication.md), [0009](0009_PDOSS.md), 0010, 0011, 0012, 0013, or 0014 for fargo. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. Number 0013 is Lean Machine ([0013_Lean_Machine.md](0013_Lean_Machine.md)). Number 0014 is Anunnaki Encoding ([0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md)). The Operator assigned number [0015](0015_Session_Bus.md) to the session bus, and the numbered file is not in this tree because the draft is missing. This document does not create a numbered file for [0015](0015_Session_Bus.md). [0003_beastdb.md](0003_beastdb.md) still names fargo as the interoperability path; that is a requirement on a future product, not a claim that fargo is specified or implemented.
2. SSSP has no assigned specification number. This document does not create a numbered file for SSSP. It has no numbered specification file in this repository. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE ([0005_CATE.md](0005_CATE.md)). Number 0006 is RSI ([0006_RSI.md](0006_RSI.md)), not Carbonado. Number 0007 is Continuous Integration ([0007_CI.md](0007_CI.md)). Number 0008 is Formal Vibefication ([0008_Formal_Vibefication.md](0008_Formal_Vibefication.md)). Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. Number 0010 is this specification. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. Number 0013 is Lean Machine ([0013_Lean_Machine.md](0013_Lean_Machine.md)). Number 0014 is Anunnaki Encoding ([0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md)). The Operator assigned number [0015](0015_Session_Bus.md) to the session bus, and the numbered file is not in this tree because the draft is missing. This document does not steal [0015](0015_Session_Bus.md) for Carbonado. This document does not create a file for Carbonado.
4. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number [0009](0009_PDOSS.md) was briefly Vocabulary, then Unlicense, and is now Public Domain Open Source Software (PDOSS) by operator order. Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). This document does not assign [0009](0009_PDOSS.md) to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept. Number 0013 is Lean Machine ([0013_Lean_Machine.md](0013_Lean_Machine.md)). Number 0014 is Anunnaki Encoding ([0014_Anunnaki_Encoding.md](0014_Anunnaki_Encoding.md)). The Operator assigned number [0015](0015_Session_Bus.md) to the session bus, and the numbered file is not in this tree because the draft is missing. This document MUST NOT steal number [0015](0015_Session_Bus.md).
6. `SafeC` is part of specification 0002 ([0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.4 item 5) and is not a published specification number.

### 6.2 Product claims that are not ready for use

1. This document specifies Surmount Systems stack composition. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist. Composition is not product readiness. Treating `stackIntegrates` as a claim that those products are ready for use is Cons False in `lean/Surmount.lean`. Theorem `mash_layers_inconsistent` already proves that a mash of homes is `False` and remains the catalog row. This document does not duplicate that theorem.
2. Byte identity of Slake emit (Clause 3.4, Clause 4.6, and [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3) is a requirement on a conforming Systems Lean and Slake product. This document does not claim that match already holds. The match is not claimed done. Slake work is ongoing and is not ready for use.
3. The SSSSS and beastdb reality check named in [0007_CI.md](0007_CI.md) is a requirement on that stack. SSSSS and beastdb are ongoing and not ready for use. Do not write that they never started or do not exist. This document does not claim the check is done.
4. `lean/Surmount.lean` is a composition of stack identities among human markdown, Lean spec encodings, Lean proofs, and product implementation. `0010_Surmount_Systems.lean` encodes the physical lines of this markdown file. `lean/Proofs_0010.lean` proves identities of that line encoding. Those modules are not a proof that Slake emit already matches `ELF`. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use. `stackIntegrates` remaining true is leftover depth of identities, not a shipped engine.
5. Clause 4 states requirements on authors, agents, this specifications repository, and product trees that claim this specification. This document does not claim those requirements are already met by every session or every tree.

### 6.3 Pins this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. [0002_Systems_Lean.md](0002_Systems_Lean.md) places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. Formal Vibefication essays are cited by URL. They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Full license text is still not published on https://proofofkeags.com . Do not invent that license.
3. ISO 24495-1:2023 and the US Federal Plain Language Guidelines remain informative prior art of CATE. They are not pins of this document.

### 6.4 Informative items this document names

1. Formal Vibefication is named as the split used in this specifications repository. The research pages in Clause 2.2 are not Clause 12 pins of this document.
2. CATE is specified in [0005_CATE.md](0005_CATE.md). CATE is not this specification.
3. RSI is specified in [0006_RSI.md](0006_RSI.md). RSI is not this specification.
4. Continuous Integration is specified in [0007_CI.md](0007_CI.md). Continuous Integration is not this specification.
5. Ahead of time emission is named in ordinary English. That phrasing is not a license to write leftover unstack.
6. Companion models for CATE (`lean/CateSpec.lean` encodings, `lean/CateProofs.lean` theorems), RSI (`lean/RsiSpec.lean`, `lean/RsiProofs.lean`), Continuous Integration (`lean/CiSpec.lean`, `lean/CiProofs.lean`), beastdb (encodings and proofs under `lean/` for that product), SSSSS (`lean/SssssSpec.lean`, `lean/SssssProofs.lean`), Systems Lean (`lean/SystemsLeanSpec.lean`, `lean/SystemsLeanProofs.lean`), Formal Vibefication (`lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`), Unlicense (`lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`), Surmount Systems Tech Tree (`lean/TechTreeSpec.lean`, `lean/TechTreeProofs.lean`), Majestic Memex (`lean/MemexSpec.lean`, `lean/MemexProofs.lean`), Lean Machine (`lean/LeanMachineSpec.lean`, `lean/LeanMachineProofs.lean`), Anunnaki Encoding (`lean/AnunnakiSpec.lean`, `lean/AnunnakiProofs.lean`), and the CATE word catalog (`lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`) place encodings in Spec modules and theorems in Proofs modules. Collision tags in `lean/Vocabulary.lean` are encodings with proofs in `lean/VocabularyCollisionProofs.lean`. Mixing those in one mash is `False` under [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). Sibling line encodings `NNNN_descriptive_name.lean` and proof modules `lean/Proofs_NNNN.lean` remain a separate split.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed. Residual Clause 6 records leftover depth that composition is not product readiness, that number [0014](0014_Anunnaki_Encoding.md) is Anunnaki Encoding, and that the Operator assigned number [0015](0015_Session_Bus.md) to the session bus while the numbered file is not in this tree because the draft is missing.

### 1.0.0 - 20260825

First publication of Surmount Systems as numbered specification 0010 with file name `0010_Surmount_Systems.md`. Records that this document is the human contract for how numbered specifications, Lean spec encodings, Lean proofs, and product paths fit. Records Formal Vibefication as specification [0008](0008_Formal_Vibefication.md) with canonical Proof of Keags URLs and back linking. Records that numbered markdown is the contract humans read, that the specification is also encoded in Lean, that proofs live in separate Lean modules, and that Lean proofs are not the specification. Records that Systems Lean product trees unify specification, proof, and implementation and then Slake emits freestanding C ahead of time and MAY emit optional LLVM IR, and that this unification is not a license to mix encodings with proofs here or to mix theorems into numbered markdown here. Requires the Lean module `Surmount` as the single composition proof and requires Lean to treat a mash of identities as `False`. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use. Requires byte identity of emit for a conforming Systems Lean and Slake product and records that the match is not claimed done.

This 1.0.0 also records: CATE is specification [0005](0005_CATE.md); RSI is specification [0006](0006_RSI.md); Continuous Integration is specification [0007](0007_CI.md); Formal Vibefication is specification [0008](0008_Formal_Vibefication.md); Public Domain Open Source Software (PDOSS) is specification [0009](0009_PDOSS.md); Unlicense remains the license; the word catalog is owned by CATE as specification [0005](0005_CATE.md); a numbered Vocabulary file MUST NOT exist; number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` ([0012_Majestic_Memex.md](0012_Majestic_Memex.md)) and is specified. The command at `~/majestic` is still a proof of concept; SSSSS is specification [0004](0004_SSSSS.md); beastdb is specification [0003](0003_beastdb.md); Systems Lean is specification [0002](0002_Systems_Lean.md); this specification is number 0010; fargo has no assigned specification number; SSSP has no assigned specification number; Carbonado has no assigned number; Lean Machine is specified as [0013_Lean_Machine.md](0013_Lean_Machine.md); every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; this document does not claim that a conforming Surmount Systems product exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in [0009_PDOSS.md](0009_PDOSS.md). Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under [0000_spec.md](0000_spec.md) Clause 12. Citations of this work SHALL keep those publisher links (back linking).
