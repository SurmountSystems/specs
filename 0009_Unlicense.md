# Unlicense

> v0.1.0 - 20260831
>
> Explain why this repository dedicates numbered specifications and the Lean in this tree to the public domain under the Unlicense, and encode that dedication in Lean

## 1. Scope

This document specifies the Unlicense for this specifications repository: a grant that keeps copyright still lets a later contract take the work; the most important Surmount work SHALL be dedicated to the public domain under the Unlicense so it stays the common heritage of anyone who seeks it, outside a later private claim; ideas are not scarce; two people can hold the same idea at once; authors in this repository SHALL release numbered specifications and the Lean in this tree under the Unlicense except where residual names a different license.

This specification is number 0009. The file name is `0009_Unlicense.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected claims are encoded in Lean under `lean/UnlicenseSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/UnlicenseProofs.lean`. Every published numbered markdown file at this repository root also has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0009_Unlicense.lean`. Those Lean files are not this specification.

This document does not claim that a conforming Surmount product exists. This document does not claim that every product tree is Unlicense. This document does not claim that essays by Keagan McLelland (Proof of Keags) are Unlicense. This document does not specify fargo. This document does not specify the Surmount Systems System Prompt (SSSP). This document does not specify the Carbonado Network Protocol. Lean Machine is specified in `0013_Lean_Machine.md`. Number 0009 is this specification. The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 1.1 Status of this document

1. This document is normative for treating a grant that keeps copyright as still leaving a copyright holder, for treating the Unlicense as a dedication to the public domain rather than as a grant that keeps copyright, for requiring that numbered specifications and the Lean in this tree be released under the Unlicense except where residual names a different license, for treating ideas as not scarce and as ideas that two people can hold at once, for treating generosity of ideas as the default this repository chooses, for treating Formal Vibefication as the split that encodes this specification in Lean and keeps proofs in separate modules, for treating a mash of spec encodings and their proofs that hides the split as nonconforming in this specifications repository, for requiring a sibling `NNNN_descriptive_name.lean` at the repository root whose physical lines match this numbered markdown file, and for treating the Lean 4 agent skill pack and essays by Keagan McLelland (Proof of Keags) as named residual licenses that this repository's Unlicense does not replace.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0009. The file name is `0009_Unlicense.md`.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in `0006_RSI.md`. RSI is specification 0006. RSI is not this specification.
6. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
7. Surmount Systems is specified in `0010_Surmount_Systems.md`. That document is specification 0010. That document is not this specification.
8. First publication of this specification as a numbered document is version 1.0.0 dated 20260826.

### 1.2 Spec encodings and proofs (informative)

This subsection is informative. It records how this specification relates to Lean encodings and to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication uses that split. Numbered markdown remains the contract humans read. That markdown is not a substitute for encoding the specification in Lean. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Local copy of that essay for readers: `ref/philosophy/proofofkeags/Proof of Keags - Formal Vibefication.pdf`

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Lean spec encodings under `lean/UnlicenseSpec.lean` declare what must be true (structures, propositions, and identities of this document as specification 0009 with file name `0009_Unlicense.md`). That module is marked as a spec encoding. It is not a proof module.
3. Lean proofs under `lean/UnlicenseProofs.lean` import that spec encoding module and establish those propositions. That module is the proof. It is not the specification.
4. The Lean module `Surmount` composes human markdown, Lean spec encodings, Lean proofs, and product implementation. `surmountSpecNumber` remains 10. This document's identity in that composition is `unlicenseSpecNumber = 9`.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker.
6. Every published numbered markdown file `NNNN_descriptive_name.md` at this repository root has a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root. The encoding file uses the markdown basename with `.lean` in place of `.md` so a reader sees the pair immediately. The file name starts with a digit, so Lean uses a quoted module name that matches that stem. That sibling holds a Lean value for every physical line of the markdown (line numbers that start at 1, exact text, optional role). Proofs of those line encodings live in `lean/Proofs_NNNN.lean`.
7. The Lean program `line_encodings_check` fails when a markdown line has no encoding or an encoding has no matching markdown line. That program is an isomorphism of lines. It is not a second markdown form checker and it is not this specification.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE. That document already records that the repository Unlicense applies unless a specification states otherwise.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md). A person who builds tools SHALL refuse a tool they cannot improve is process residual under RSI. It is not a claim that every product is Unlicense.
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
6. Surmount Systems remains [0010_Surmount_Systems.md](0010_Surmount_Systems.md).
7. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
8. beastdb remains [0003_beastdb.md](0003_beastdb.md).
9. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
10. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo.
11. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`). Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is this specification. The word catalog lives in CATE (`0005_CATE.md`). Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not steal those numbers for fargo or for Carbonado.
12. SSSP is named in residual. It is not specified here.
13. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. That document is not this specification.
14. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is this specification. A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not assign 0009 to fargo or to Carbonado.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, and Rust are not pinned under this specifications repository's `ref/`. This document does not add Form 1 git submodules to this repository. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not treat those essays as Unlicense grants. This repository does not treat those essays as Clause 12 Form 2 pins of external specifications.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document, including that the repository Unlicense applies unless a specification states otherwise).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0005_CATE.md` (Concise American Technical English).
5. Surmount specification `0006_RSI.md` (Recursive Self Improvement), cited when this document names refusing a tool the author cannot improve as process residual.
6. Surmount specification `0008_Formal_Vibefication.md` (Formal Vibefication: Lean spec encodings separate from proofs).
7. Surmount specification `0010_Surmount_Systems.md` (Surmount Systems stack composition).
8. The repository Unlicense text at `UNLICENSE.md`.

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12 - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-26).
2. Local copy of that essay for readers: `ref/philosophy/proofofkeags/Proof of Keags - Formal Vibefication.pdf`. Honesty notes: `ref/philosophy/proofofkeags/SOURCE.md`.
3. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20 - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-26).
4. The Unlicense, https://unlicense.org (accessed: 2026-08-26). This repository's copy of that dedication is `UNLICENSE.md`.

Those Proof of Keags pages are research. They are not Unlicense grants. They are not permission to treat those essays as public domain. Citations of that work SHALL keep those publisher links (back linking). Lessons used here: a specification states what must be true and a proof states how that is established; those artifacts are separable; theorems cover exactly what they state.

The Unlicense site is informative. It is not a Clause 12 pin. The binding dedication for this repository is `UNLICENSE.md`.

## 3. Definitions

### 3.1 Copyright held

The status in which a work still has a copyright holder. A later contract can still take that work because the holder, or a successor, can still grant, sell, or wrap the work in private terms.

### 3.2 Public domain dedication

The status in which the author dedicated copyright interest in the work to the public domain, as an overt act of relinquishment, so the work stays the common heritage of anyone who seeks it, outside a later private claim by that author or by that author's heirs.

### 3.3 Grant that keeps copyright

A grant that lets others use, copy, or change a work while the author still holds copyright. Such a grant is not a public domain dedication. Remaining copyright still lets a later contract take the work.

### 3.4 Unlicense

The public domain dedication recorded in `UNLICENSE.md`. In jurisdictions that recognize copyright, the author dedicated copyright interest in the covered work to the public domain. The Unlicense is not a grant that keeps copyright. The Unlicense is not a claim that every file on disk in this clone is covered (Clause 4.5 names residual licenses).

### 3.5 Ideas that are not scarce

The claim that an idea is not used up when it is shared. Two people can hold the same idea at once. This repository chooses generosity of ideas as the default.

### 3.6 Named residual license

A license named in residual that is not the Unlicense of this repository. Today that includes the Lean 4 agent skill pack at `skills/lean4-skills` (MIT license) and essays by Keagan McLelland (Proof of Keags) (not an Unlicense grant; this repository does not apply the Unlicense to those essays).

### 3.7 Mash that hides the split

One Lean module that holds spec encoding declarations together with the proofs of those declarations so a reader cannot tell the specification from the proof. A mash that hides the split is nonconforming in this specifications repository.

### 3.8 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.9 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown (line numbers that start at 1, exact text, optional role). The encoding file uses the markdown basename with `.lean` in place of `.md` so a reader sees the pair immediately. The file name starts with a digit, so Lean uses a quoted module name that matches that stem. For this specification that sibling is `0009_Unlicense.lean`.

### 3.10 Most important Surmount work (this repository)

Numbered specifications at this repository root and the Lean in this tree that encodes and proves those specifications. Product trees outside this repository MAY name a different license in their own residual. This definition is not a claim that those products are ready for use.

## 4. Core requirements

### 4.1 A grant that keeps copyright still lets a later contract take the work

1. A grant that keeps copyright (Clause 3.3) SHALL be treated as still leaving a copyright holder.
2. Remaining copyright SHALL be treated as still letting a later contract take the work.
3. Authors SHALL NOT treat a grant that keeps copyright as if it were a public domain dedication.
4. Companion Lean SHALL encode remaining copyright on a grant that keeps copyright and has no dedication (`ossWithoutDedication`). This document does not paste that encoding.

### 4.2 Dedication under the Unlicense

1. The most important Surmount work in this repository (Clause 3.10) SHALL be dedicated to the public domain under the Unlicense so it stays the common heritage of anyone who seeks it, outside a later private claim.
2. The Unlicense SHALL be treated as a public domain dedication (Clause 3.2 and Clause 3.4), not as a grant that keeps copyright.
3. Companion Lean SHALL encode that an Unlicense dedication has no remaining copyright in the model (`unlicenseDedication`). This document does not paste that encoding.
4. Anyone is free to copy, modify, publish, use, compile, sell, or distribute covered work, either in source form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means, as `UNLICENSE.md` records.

### 4.3 Ideas are not scarce

1. Ideas SHALL be treated as not scarce.
2. Two people SHALL be treated as able to hold the same idea at once.
3. Generosity of ideas SHALL be the default this repository chooses.
4. Companion Lean SHALL encode `ideasNonScarce` and `ideasNotRivalrous`. This document does not paste those encodings.

### 4.4 This repository Unlicense except named residual licenses

1. Authors in this repository SHALL release numbered specifications and the Lean in this tree under the Unlicense except where residual names a different license.
2. The Lean 4 agent skill pack at `skills/lean4-skills` remains original work under the MIT license. This repository's Unlicense SHALL NOT be read as replacing that MIT license.
3. Essays by Keagan McLelland (Proof of Keags) are not Unlicense grants. This repository's Unlicense SHALL NOT be read as applying the Unlicense to those essays.
4. Companion Lean SHALL encode `thisRepoUnlicenseExceptNamedResidual`. This document does not paste that encoding.

### 4.5 Refuse a tool the author cannot improve

1. A person who builds tools SHALL refuse a tool they cannot improve.
2. That requirement is process residual under `0006_RSI.md`. It is not a claim that every product is Unlicense.
3. Companion Lean SHALL encode that refusing a tool the author cannot improve is RSI process and is not a license claim on every product. This document does not paste that encoding.

### 4.6 Formal Vibefication split

1. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in `0008_Formal_Vibefication.md`.
2. For this specification the spec encoding module is `lean/UnlicenseSpec.lean`. The proof module is `lean/UnlicenseProofs.lean`.
3. Mixing spec encoding declarations and their proofs in one mash that hides the split (Clause 3.7) is nonconforming for this specifications repository.
4. Companion Lean SHALL treat a mash of spec encoding and proof as `False` (see `mash_spec_and_proof`). This document does not paste that theorem.
5. Every published numbered specification markdown `NNNN_descriptive_name.md` at this repository root SHALL have an adjacent Lean spec encoding `NNNN_descriptive_name.lean` at the same root (Clause 3.9). Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`, not in `NNNN_descriptive_name.lean`.
6. `lean/UnlicenseSpec.lean` remains the meaning encoding of this specification. `0009_Unlicense.lean` is the line encoding of this markdown file. Those are not the same module.

### 4.7 Back linking and exact theorems

1. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
2. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
3. Theorems cover exactly what they state. Dedication of this repository is not a proof that essays by Keagan McLelland (Proof of Keags) are public domain. Dedication of this repository is not a proof that the Lean 4 agent skill pack is Unlicense.
4. On 2026-08-25, Keagan McLelland (Proof of Keags) was asked which jurisdiction applies. He answered USA. He said back linking is ideal. This is not an Unlicense grant of those essays.

### 4.8 Product honesty

1. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
2. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
3. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
4. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
5. This specification does not claim a conforming Unlicense product exists beyond the dedication, encodings, and proofs named here.

### 4.9 Unassigned numbers and unspecified products

1. fargo is unspecified. fargo has no numbered specification and no assigned number. Authors SHALL NOT invent a numbered specification file for fargo in this effort.
2. SSSP is unspecified. SSSP has no numbered specification file and no assigned number.
3. The Carbonado Network Protocol is unspecified. Carbonado has no numbered specification file and no assigned number.
4. Lean Machine is specified in `0013_Lean_Machine.md`. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 is this specification. The word catalog lives in CATE (`0005_CATE.md`). Authors SHALL NOT assign 0009 to fargo or to Carbonado. Mentions of Vocabulary as a published specification 0009 do not conform.
6. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 4.10 Named gate

1. The named gate for this specifications repository remains the gate specified in `0007_CI.md`:

```text
nix flake check "path:$PWD" --print-build-logs
```

2. Lean 4 SHALL be used to surface logical inconsistency in the encodings and in the proofs.

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. A grant that keeps copyright is treated as still leaving a copyright holder, and remaining copyright is treated as still letting a later contract take the work (Clause 4.1).
2. The most important Surmount work in this repository is dedicated to the public domain under the Unlicense; companion Lean treats an Unlicense dedication as having no remaining copyright in the model (Clause 4.2).
3. Ideas are treated as not scarce; two people can hold the same idea at once; generosity of ideas is the default this repository chooses (Clause 4.3).
4. Numbered specifications and the Lean in this tree are released under the Unlicense except where residual names a different license; the Lean 4 agent skill pack remains MIT; essays by Keagan McLelland (Proof of Keags) are not Unlicense (Clause 4.4).
5. Refusing a tool the author cannot improve is treated as RSI process residual and is not treated as a claim that every product is Unlicense (Clause 4.5).
6. Numbered markdown is the contract humans read; the specification is encoded in Lean as declarations of what must be true; proofs live in separate Lean modules; a mash that hides the split is treated as `False`; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` (Clause 4.6).
7. Formal Vibefication citations keep the canonical Proof of Keags URL; a numbered specification that names Keagan or Proof of Keags also contains the host `proofofkeags.com`; theorems cover exactly what they state (Clause 4.7).
8. beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use, and are not described as never started or as ready (Clause 4.8).
9. fargo, SSSP, and Carbonado remain unspecified; Lean Machine is specified in `0013_Lean_Machine.md`; number 0009 is this specification and is not assigned to fargo or Carbonado; a numbered Vocabulary file does not exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept (Clause 4.9).
10. The named gate in `0007_CI.md` remains the gate for this repository (Clause 4.10).

This specification is not itself a conforming Surmount product. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program; this clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo is not specified. fargo has no assigned specification number. This document does not invent a number for fargo. This document does not steal 0005, 0006, 0007, 0008, 0009, 0010, or 0011 for fargo. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.
2. The Surmount Systems System Prompt (SSSP) is not specified. It has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol is deferred. It has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`), not Carbonado. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is this specification. Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not create a file for Carbonado.
4. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 was briefly Vocabulary, then withdrawn, and is now Unlicense by operator order. The word catalog lives in CATE (`0005_CATE.md`). This document does not assign 0009 to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 6.2 Product claims that are not ready for use

1. This document specifies the Unlicense for this specifications repository. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in `0007_CI.md`. This document does not claim that match already holds. The match is not claimed done. Slake work is ongoing and is not ready for use.
3. `lean/UnlicenseSpec.lean` encodes selected claims. `lean/UnlicenseProofs.lean` proves those claims. `lean/Surmount.lean` composes stack identities including this specification as number 0009. `0009_Unlicense.lean` encodes the physical lines of this markdown file. `lean/Proofs_0009.lean` proves identities of that line encoding. Those modules are not a proof that Slake emit already matches `ELF`. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use. They are not a proof that every file in a clone is Unlicense.

### 6.3 Named residual licenses this Unlicense does not replace

1. The Lean 4 agent skill pack at `skills/lean4-skills` is original work under the MIT license. It is not under `ref/`. It is not a Clause 12 pin. It is not `mathlib`. This repository's Unlicense does not replace that MIT license.
2. Essays by Keagan McLelland (Proof of Keags) are cited by URL. They are not Clause 12 pins. They are not Unlicense grants. Local copies under `ref/philosophy/proofofkeags/` are for readers. They are not a public domain grant of those essays. `ref/philosophy/proofofkeags/SOURCE.md` records that back linking is ideal, that the jurisdiction he named is USA, and that the Unlicense of this repository does not apply the Unlicense to those essays. Full license text is still not published on https://proofofkeags.com . Do not invent that license.
3. Product trees outside this repository MAY name a different license in their own residual. This document does not claim those trees are Unlicense.

### 6.4 Pins this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. https://unlicense.org is informative prior art. It is not a Clause 12 pin. This repository does not add a Form 1 or Form 2 pin of that site. The binding dedication is `UNLICENSE.md`.
3. ISO 24495-1:2023 and the US Federal Plain Language Guidelines remain informative prior art of CATE. They are not pins of this document.

### 6.5 Informative items this document names

1. Formal Vibefication research pages in Clause 2.2 are not Clause 12 pins of this document.
2. CATE is specified in `0005_CATE.md`. CATE is not this specification.
3. RSI is specified in `0006_RSI.md`. RSI is not this specification.
4. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. Formal Vibefication is not this specification.
5. Surmount Systems is specified in `0010_Surmount_Systems.md`. Surmount Systems is not this specification.
6. Companion models for CATE (`lean/CateSpec.lean` encodings, `lean/CateProofs.lean` theorems), RSI (`lean/RsiSpec.lean`, `lean/RsiProofs.lean`), Continuous Integration (`lean/CiSpec.lean`, `lean/CiProofs.lean`), beastdb (encodings and proofs under `lean/` for that product), SSSSS (`lean/SssssSpec.lean`, `lean/SssssProofs.lean`), Systems Lean (`lean/SystemsLeanSpec.lean`, `lean/SystemsLeanProofs.lean`), Formal Vibefication (`lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`), Unlicense (`lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`), Surmount Systems Tech Tree (`lean/TechTreeSpec.lean`, `lean/TechTreeProofs.lean`), Majestic Memex (`lean/MemexSpec.lean`, `lean/MemexProofs.lean`), Lean Machine (`lean/LeanMachineSpec.lean`, `lean/LeanMachineProofs.lean`), and the CATE word catalog (`lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`) place encodings in Spec modules and theorems in Proofs modules. Collision tags in `lean/Vocabulary.lean` are encodings with proofs in `lean/VocabularyCollisionProofs.lean`. Mixing those in one mash is `False` under `0008_Formal_Vibefication.md`. Sibling line encodings remain a separate split.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed.

### 1.0.0 - 20260826

First publication of Unlicense as numbered specification 0009 with file name `0009_Unlicense.md`. The operator assigned 0009 to fill the gap after Vocabulary was folded into CATE. Number 0009 was briefly Vocabulary, then withdrawn; it is now Unlicense by operator order. A numbered Vocabulary file remains forbidden. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. Records that a grant that keeps copyright still lets a later contract take the work. Requires the most important Surmount work in this repository (numbered specifications and the Lean in this tree) to be dedicated to the public domain under the Unlicense so it stays the common heritage of anyone who seeks it, outside a later private claim. Records that ideas are not scarce and that two people can hold the same idea at once. Requires authors to release numbered specifications and the Lean in this tree under the Unlicense except where residual names a different license. Records that the Lean 4 agent skill pack remains MIT and that essays by Keagan McLelland (Proof of Keags) are not Unlicense. Records that refusing a tool the author cannot improve is RSI process residual and is not a claim that every product is Unlicense. Records Formal Vibefication as the split that encodes this specification in Lean and keeps proofs in separate modules, with canonical Proof of Keags URLs and back linking. Treats a mash of spec encodings and their proofs that hides the split as nonconforming. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.

This 1.0.0 also records: CATE is specification 0005; RSI is specification 0006; Formal Vibefication is specification 0008; Surmount Systems is specification 0010; this specification is number 0009; the word catalog lives in CATE (`0005_CATE.md`); a numbered Vocabulary file MUST NOT exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept; fargo has no assigned specification number; SSSP is not specified; Carbonado has no assigned number; Lean Machine is specified as `0013_Lean_Machine.md`; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; honesty notes for Proof of Keags copies live at `ref/philosophy/proofofkeags/SOURCE.md`; this document does not claim that a conforming Surmount product exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking). He named USA as the jurisdiction. He said back linking is ideal. That is not an Unlicense grant of those essays.
