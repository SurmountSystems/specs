# Public Domain Open Source Software

> v0.1.0 - 20260920
>
> Explain why Public Domain Open Source Software (PDOSS) is the ideal, why Unlicense remains the license, define the PDOSS test, encode that test in Lean, and state who may contribute original expression

## 1. Scope

This document specifies Public Domain Open Source Software (PDOSS): the ideal that software is dedicated to the public domain and remains open, so a later contract cannot take the work by remaining copyright. Unlicense remains the license of this repository. The Unlicense text is `UNLICENSE.md`. This document defines the PDOSS test, records that the Unlicense meets that test, records that MIT as used by the Lean 4 agent skill pack and Apache 2.0 as used by the `btc-verified` pin do not meet a public domain dedication test, treats a claim that MIT meets PDOSS as `False`, and states the contributor nationality condition for original expression offered for inclusion in a Work.

This specification is number 0009. The file name is `0009_PDOSS.md`. The Unlicense numbered markdown file for specification 0009 MUST NOT exist. A numbered Vocabulary file MUST NOT exist.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected claims are encoded in Lean under `lean/UnlicenseSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/UnlicenseProofs.lean`. Every published numbered markdown file at this repository root also has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0009_PDOSS.lean`. Those Lean files are not this specification.

This document does not claim that a conforming Surmount product exists. This document does not claim that every product tree is Unlicense. This document does not claim that essays by Keagan McLelland (Proof of Keags) are Unlicense. fargo has no assigned specification number. This document does not create a numbered file for fargo. The Surmount Systems System Prompt (SSSP) has no assigned specification number. This document does not create a numbered file for SSSP. The Carbonado Network Protocol has no assigned specification number. This document does not create a numbered file for the Carbonado Network Protocol. Lean Machine is specified in `0013_Lean_Machine.md`. Number 0009 is this specification. The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 1.1 Status of this document

1. This document is normative for treating Public Domain Open Source Software (PDOSS) as the ideal, for defining the PDOSS test as a public domain dedication of software that is open (source available; use, copy, modify, and distribute without a grant that keeps copyright), for treating the Unlicense as the license that meets that test, for treating MIT as used by the Lean 4 agent skill pack and Apache 2.0 as used by the `btc-verified` pin as grants that keep copyright and therefore as failing a public domain dedication test, for treating a mash that claims MIT meets PDOSS as `False`, for treating a grant that keeps copyright as still leaving a copyright holder, for requiring that numbered specifications and the Lean in this tree be released under the Unlicense except where residual names a different license, for treating ideas as not scarce and as ideas that two people can hold at once, for treating generosity of ideas as the default this repository chooses, for treating Formal Vibefication as the split that encodes this specification in Lean and keeps proofs in separate modules, for treating a mash of spec encodings and their proofs that hides the split as nonconforming in this specifications repository, for requiring a sibling `NNNN_descriptive_name.lean` at the repository root whose physical lines match this numbered markdown file, for treating the Lean 4 agent skill pack and essays by Keagan McLelland (Proof of Keags) as named residual licenses that this repository's Unlicense does not replace, and for accepting a Contribution only when it is dedicated under the Unlicense and every nationality the Contributor holds is on the Allow list.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0009. The file name is `0009_PDOSS.md`. The Unlicense numbered markdown file for specification 0009 MUST NOT exist.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in `0006_RSI.md`. RSI is specification 0006. RSI is not this specification.
6. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
7. Surmount Systems is specified in `0010_Surmount_Systems.md`. That document is specification 0010. That document is not this specification.
8. First publication of Unlicense as a numbered document was version 1.0.0 dated 20260826. This document is version 0.1.0 of Public Domain Open Source Software (PDOSS) as specification 0009.

### 1.2 Spec encodings and proofs (informative)

This subsection is informative. It records how this specification relates to Lean encodings and to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication uses that split. Numbered markdown remains the contract humans read. That markdown is not a substitute for encoding the specification in Lean. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Local copy of that essay for readers: `ref/philosophy/proofofkeags/Proof of Keags - Formal Vibefication.pdf`

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Lean spec encodings under `lean/UnlicenseSpec.lean` declare what must be true (structures, propositions, and identities of this document as specification 0009 with file name `0009_PDOSS.md`, including the PDOSS test, the contributor nationality classes, and that this meaning model requires the Formal Vibefication science cycle). That module is marked as a spec encoding. It is not a proof module. Lake keeps the library name `UnlicenseSpec`. The product name of this specification is PDOSS.
3. Lean proofs under `lean/UnlicenseProofs.lean` import that spec encoding module and establish those propositions. That module is the proof. It is not the specification.
4. The Lean module `Surmount` composes human markdown, Lean spec encodings, Lean proofs, and product implementation. `surmountSpecNumber` remains 10. This document's identity in that composition is `pdossSpecNumber = 9`. The identifier `unlicenseSpecNumber` MAY remain 9 because Unlicense remains the license.
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
12. SSSP has no assigned specification number. This document does not create a numbered file for SSSP.
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
8. The repository Unlicense text at `UNLICENSE.md`. Unlicense remains the license.
9. The `btc-verified` pin at `ref/btc-verified` (Apache 2.0), cited when this document records that Apache 2.0 does not meet a public domain dedication test.

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12 - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-26).
2. Local copy of that essay for readers: `ref/philosophy/proofofkeags/Proof of Keags - Formal Vibefication.pdf`. Honesty notes: `ref/philosophy/proofofkeags/SOURCE.md`.
3. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20 - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-26).
4. The Unlicense, https://unlicense.org (accessed: 2026-08-26). This repository's copy of that dedication is `UNLICENSE.md`.
5. The MIT license as used by the Lean 4 agent skill pack at `skills/lean4-skills` (accessed: 2026-09-01). That pack is not Unlicense.
6. Apache License 2.0 as used by the `btc-verified` pin at `ref/btc-verified` (accessed: 2026-09-01). That pin is not Unlicense.

Those Proof of Keags pages are research. They are not Unlicense grants. They are not permission to treat those essays as public domain. Citations of that work SHALL keep those publisher links (back linking). Lessons used here: a specification states what must be true and a proof states how that is established; those artifacts are separable; theorems cover exactly what they state.

The Unlicense site is informative. It is not a Clause 12 pin. The binding dedication for this repository is `UNLICENSE.md`. Other public domain instruments (for example CC0) are named in residual and are not pinned here.

## 3. Definitions

### 3.1 Copyright held

The status in which a work still has a copyright holder. A later contract can still take that work because the holder, or a successor, can still grant, sell, or wrap the work in private terms.

### 3.2 Public domain dedication

The status in which the author dedicated copyright interest in the work to the public domain, as an overt act of relinquishment, so the work stays the common heritage of anyone who seeks it, outside a later private claim by that author or by that author's heirs.

### 3.3 Grant that keeps copyright

A grant that lets others use, copy, or change a work while the author still holds copyright. Such a grant is not a public domain dedication. Remaining copyright still lets a later contract take the work. MIT and Apache 2.0 are grants that keep copyright.

### 3.4 Public Domain Open Source Software

Public Domain Open Source Software (PDOSS) is the ideal: software dedicated to the public domain that remains open (source available; use, copy, modify, and distribute without a grant that keeps copyright). PDOSS is this specification. Unlicense remains the license that this repository uses to meet PDOSS.

### 3.5 PDOSS test

The PDOSS test is the named test of this specification. A dedication meets the PDOSS test if and only if it is a public domain dedication of software that is open (source available; use, copy, modify, and distribute without a grant that keeps copyright). A license that keeps copyright is not a public domain dedication and does not meet the PDOSS test. Companion Lean encodes that test as `meetsPdoss`.

### 3.6 Unlicense

The public domain dedication recorded in `UNLICENSE.md`. In jurisdictions that recognize copyright, the author dedicated copyright interest in the covered work to the public domain. The Unlicense is not a grant that keeps copyright. The Unlicense is not a claim that every file on disk in this clone is covered (Clause 4.5 names residual licenses). Unlicense remains the license. The Unlicense meets the PDOSS test.

### 3.7 Ideas that are not scarce

The claim that an idea is not used up when it is shared. Two people can hold the same idea at once. This repository chooses generosity of ideas as the default.

### 3.8 Named residual license

A license named in residual that is not the Unlicense of this repository. Today that includes the Lean 4 agent skill pack at `skills/lean4-skills` (MIT license) and essays by Keagan McLelland (Proof of Keags) (not an Unlicense grant; this repository does not apply the Unlicense to those essays). The `btc-verified` pin at `ref/btc-verified` remains Apache 2.0. MIT and Apache 2.0 do not meet the PDOSS test.

### 3.9 Mash that hides the split

One Lean module that holds spec encoding declarations together with the proofs of those declarations so a reader cannot tell the specification from the proof. A mash that hides the split is nonconforming in this specifications repository. A mash that claims MIT meets PDOSS is also `False`.

### 3.10 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.11 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown (line numbers that start at 1, exact text, optional role). The encoding file uses the markdown basename with `.lean` in place of `.md` so a reader sees the pair immediately. The file name starts with a digit, so Lean uses a quoted module name that matches that stem. For this specification that sibling is `0009_PDOSS.lean`.

### 3.12 Most important Surmount work (this repository)

Numbered specifications at this repository root and the Lean in this tree that encodes and proves those specifications. Product trees outside this repository MAY name a different license in their own residual. This definition is not a claim that those products are ready for use.

### 3.13 Author

The Author is the natural person who created original expression in a Work.

### 3.14 User

The User is any person who runs, copies, studies, modifies, or distributes a Work that Surmount Systems has already published under the Unlicense.

### 3.15 Contributor

The Contributor is a natural person who submits their own original expression for inclusion in a Work.

### 3.16 Contribution

A Contribution is that submitted original expression.

### 3.17 Nationality

Nationality is citizenship. Nationality is not residence, visa status, employer, or the location of a computer.

### 3.18 Allow list

The Allow list is the list of jurisdictions whose statute lets an Author waive the moral right of attribution for software, or carves software out of that right. Nationals of those jurisdictions MAY contribute if they dedicate the Contribution under the Unlicense.

### 3.19 Specific consent list

The Specific consent list is the list of jurisdictions whose statute requires consent that identifies the Work and the uses. A blanket Unlicense is not that consent.

### 3.20 Residual attribution list

The Residual attribution list is the list of jurisdictions whose statute keeps the moral right of attribution after a public domain dedication or after assignment of copyright.

### 3.21 Unread list

The Unread list is the list of jurisdictions whose copyright statute has not been classified into Allow, Specific consent, or Residual attribution in this specification. Unread is not a finding that attribution cannot be waived. Unread is not a finding that attribution can be waived. Unread is refusal until classification.

### 3.22 Moral right of attribution

The moral right of attribution is the Author's right to be identified as the Author of the Work, also called the right of paternity, or droit de paternite (French moral right of authorship). It is distinct from economic copyright. It is distinct from the moral right of integrity.

### 3.23 Waiver

A Waiver is a written act by which the Author gives up the power to enforce a right, including the moral right of attribution.

### 3.24 Assignment

An Assignment is a transfer of a right to another person. A right that cannot be assigned may still be waivable, or it may not. Those are different operations.

## 4. Core requirements

### 4.1 A grant that keeps copyright still lets a later contract take the work

1. A grant that keeps copyright (Clause 3.3) SHALL be treated as still leaving a copyright holder.
2. Remaining copyright SHALL be treated as still letting a later contract take the work.
3. Authors SHALL NOT treat a grant that keeps copyright as if it were a public domain dedication.
4. Companion Lean SHALL encode remaining copyright on a grant that keeps copyright and has no dedication (`ossWithoutDedication`). This document does not paste that encoding.

### 4.2 The PDOSS test and Unlicense

1. Public Domain Open Source Software (PDOSS) SHALL be treated as the ideal.
2. A dedication SHALL meet the PDOSS test (Clause 3.5) if and only if it is a public domain dedication of software that is open (source available; use, copy, modify, and distribute without a grant that keeps copyright).
3. Unlicense remains the license. The most important Surmount work in this repository (Clause 3.12) SHALL be dedicated to the public domain under the Unlicense so it stays the common heritage of anyone who seeks it, outside a later private claim.
4. The Unlicense SHALL be treated as a public domain dedication (Clause 3.2 and Clause 3.6), not as a grant that keeps copyright.
5. Companion Lean SHALL encode that an Unlicense dedication has no remaining copyright in the model (`unlicenseDedication`) and that Unlicense meets the PDOSS test (`meetsPdoss`). This document does not paste those encodings.
6. Anyone is free to copy, modify, publish, use, compile, sell, or distribute covered work, either in source form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means, as `UNLICENSE.md` records.

### 4.3 MIT and Apache 2.0 do not meet a public domain dedication test

1. MIT as used by the Lean 4 agent skill pack at `skills/lean4-skills` SHALL be treated as a grant that keeps copyright. MIT SHALL NOT meet a public domain dedication test. MIT SHALL NOT meet the PDOSS test.
2. Apache 2.0 as used by the `btc-verified` pin at `ref/btc-verified` SHALL be treated as a grant that keeps copyright. Apache 2.0 SHALL NOT meet a public domain dedication test. Apache 2.0 SHALL NOT meet the PDOSS test.
3. Companion Lean SHALL encode MIT and Apache 2.0 as distinct constructors (`mitGrant` and `apacheTwo`). Companion Lean SHALL prove those constructors do not meet the PDOSS test. This document does not paste those proofs.
4. A mash that claims MIT meets PDOSS (`mitMeetsPdoss`) SHALL be treated as `False`. Companion Lean SHALL prove `mash_mit_meets_pdoss`. This document does not paste that theorem.

### 4.4 Ideas are not scarce

1. Ideas SHALL be treated as not scarce.
2. Two people SHALL be treated as able to hold the same idea at once.
3. Generosity of ideas SHALL be the default this repository chooses.
4. Companion Lean SHALL encode `ideasNonScarce` and `ideasNotRivalrous`. This document does not paste those encodings.

### 4.5 This repository Unlicense except named residual licenses

1. Authors in this repository SHALL release numbered specifications and the Lean in this tree under the Unlicense except where residual names a different license.
2. The Lean 4 agent skill pack at `skills/lean4-skills` remains original work under the MIT license. This repository's Unlicense SHALL NOT be read as replacing that MIT license.
3. Essays by Keagan McLelland (Proof of Keags) are not Unlicense grants. This repository's Unlicense SHALL NOT be read as applying the Unlicense to those essays.
4. The `btc-verified` pin at `ref/btc-verified` remains Apache 2.0. This repository's Unlicense SHALL NOT be read as replacing that Apache 2.0 license.
5. Companion Lean SHALL encode `thisRepoUnlicenseExceptNamedResidual`. This document does not paste that encoding.

### 4.6 Refuse a tool the author cannot improve

1. A person who builds tools SHALL refuse a tool they cannot improve.
2. That requirement is process residual under `0006_RSI.md`. It is not a claim that every product is Unlicense.
3. Companion Lean SHALL encode that refusing a tool the author cannot improve is RSI process and is not a license claim on every product. This document does not paste that encoding.

### 4.7 Formal Vibefication split

1. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in `0008_Formal_Vibefication.md`.
2. For this specification the spec encoding module is `lean/UnlicenseSpec.lean`. The proof module is `lean/UnlicenseProofs.lean`. Lake keeps those library names. The product name of this specification is PDOSS.
3. Mixing spec encoding declarations and their proofs in one mash that hides the split (Clause 3.9) is nonconforming for this specifications repository.
4. Companion Lean SHALL treat a mash of spec encoding and proof as `False` (see `mash_spec_and_proof`). This document does not paste that theorem.
5. Every published numbered specification markdown `NNNN_descriptive_name.md` at this repository root SHALL have an adjacent Lean spec encoding `NNNN_descriptive_name.lean` at the same root (Clause 3.11). Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`, not in `NNNN_descriptive_name.lean`.
6. `lean/UnlicenseSpec.lean` remains the meaning encoding of this specification. `0009_PDOSS.lean` is the line encoding of this markdown file. Those are not the same module.

### 4.8 Back linking and exact theorems

1. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
2. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
3. Theorems cover exactly what they state. Dedication of this repository is not a proof that essays by Keagan McLelland (Proof of Keags) are public domain. Dedication of this repository is not a proof that the Lean 4 agent skill pack is Unlicense. Dedication of this repository is not a proof that the `btc-verified` pin is Unlicense.
4. On 2026-08-25, Keagan McLelland (Proof of Keags) was asked which jurisdiction applies. He answered USA. He said back linking is ideal. This is not an Unlicense grant of those essays.

### 4.9 Product honesty

1. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
2. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
3. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
4. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
5. Lean Machine work is ongoing and is not ready for use. Authors MUST NOT write that Lean Machine never started or does not exist.
6. Majestic Memex work is ongoing and is not ready for use. Authors MUST NOT write that Majestic Memex never started or does not exist.
7. This specification does not claim a conforming PDOSS product exists beyond the dedication, encodings, and proofs named here.

### 4.10 Names with no assigned specification number

1. fargo has no numbered specification and no assigned number. Authors SHALL NOT invent a numbered specification file for fargo in this effort.
2. SSSP has no numbered specification file and no assigned number.
3. The Carbonado Network Protocol has no numbered specification file and no assigned number.
4. Lean Machine is specified in `0013_Lean_Machine.md`. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 is this specification. The word catalog lives in CATE (`0005_CATE.md`). Authors SHALL NOT assign 0009 to fargo or to Carbonado. Mentions of Vocabulary as a published specification 0009 do not conform.
6. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present. The Unlicense numbered markdown file for specification 0009 MUST NOT exist. The form checker MUST fail if that file is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 4.11 Named gate

1. The named gate for this specifications repository remains the gate specified in `0007_CI.md`:

```text
nix flake check "path:$PWD" --print-build-logs
```

2. Lean 4 SHALL be used to surface logical inconsistency in the encodings and in the proofs.

### 4.12 Contributor nationality condition

This clause is the contributor facing text of this specification. It does not change the Unlicense text applied to published Works. The Unlicense numbered markdown file for specification 0009 MUST NOT exist. The license text of each Work remains `UNLICENSE.md`.

1. A User of a published Work MAY run, copy, study, modify, and distribute that Work under the Unlicense. No permission, payment, or authorship credit is required. Nationality SHALL NOT restrict use of a published Work. Companion Lean encodes `usersRestrictedByNationality` as false.
2. A Contribution is a different act. A Contribution SHALL be accepted only if both of the following hold:
	1. the Contributor dedicates it under the Unlicense; and
	2. every nationality the Contributor holds is on the Allow list (Clause 3.18 and Clause 4.13).
3. A Contribution SHALL be refused if the Contributor holds any nationality on the Residual attribution list, the Specific consent list, or the Unread list.
4. If any one citizenship is on the Residual attribution list, the Specific consent list, or the Unread list, the Contribution SHALL be refused. Dual or multiple nationality is that any not Allow class, not a separate license.
5. Residence, visa, employer, and server location SHALL NOT change the condition. Nationality is citizenship (Clause 3.17). Companion Lean encodes `nationalityIsCitizenship`.
6. Companion Lean SHALL encode `NationalityClass` as Allow, specific consent, residual attribution, and unread, SHALL encode a `Contribution` as Unlicense dedication plus a list of those classes, and SHALL treat `contributionAccepted` as true if and only if the Contribution is dedicated under the Unlicense and every nationality class is Allow. Companion Lean SHALL prove `mash_residual_attribution_contribution_accepted` as `False`. This document does not paste those encodings.
7. Surmount Systems SHALL refuse inbound licenses other than the Unlicense. MIT, Apache 2.0, and GPL are grants that keep copyright. A grant that keeps copyright SHALL NOT meet the PDOSS test (Clause 4.3). The nationality filter is a separate rule because, in some jurisdictions, a moral right of attribution can survive a dedication.
8. This specification does not require government identity documents, a copyright office filing, or proof of citizenship from a state. The Contributor attests nationality. A false attestation SHALL be treated as a refused Contribution.

### 4.13 Allow list

Nationals of these jurisdictions MAY contribute if they dedicate the Contribution under the Unlicense. Hong Kong is included although it is not a United Nations member. The other forty five named United Nations members on this list are United Nations members. This list is the Allow list. The map in Clause 4.19 is not this list.

1. Bahamas. `Copyright Act` s.16. Consent and waiver of moral rights.
2. Barbados. `Copyright Act` s.19. Waiver by signed writing.
3. Belize. `Copyright Act` s.20. Waiver by signed writing; may cover works generally and future works.
4. Canada. `Copyright Act` s.14.1(2) to (4). Moral rights may be waived in whole or in part.
5. Dominica. `Copyright Act 2003` s.15(4). Written waiver specifying the rights and the circumstances.
6. Hong Kong. `Copyright Ordinance Cap. 528` s.91 and s.98. Computer programs excluded from attribution and integrity; signed waiver for moral rights that do apply.
7. Ireland. `Copyright and Related Rights Act 2000` s.116. Written waiver.
8. Israel. `Copyright Law 2007` s.45(a). Moral rights do not apply to computer programs.
9. Jamaica. `Copyright Act 1993` Part III. Waiver of moral rights.
10. Netherlands. `Auteurswet` Art. 25(3). The right of attribution may be waived.
11. New Zealand. `Copyright Act 1994` ss.94 to 97. Written waiver.
12. Philippines. `Intellectual Property Code, Republic Act No. 8293` s.195. The Author may waive s.193 moral rights by a written instrument, except false attribution and use of the name on a damaging adaptation.
13. Saint Lucia. `Copyright Act` s.19. Waiver by signed writing; may cover works generally and future works.
14. Singapore. `Copyright Act 2021` s.382. Formal signed waiver.
15. South Africa. `Copyright Act 98 of 1978` s.20. Moral rights may be waived.
16. Trinidad and Tobago. `Copyright Act` s.18(3). Written waiver specifying the rights and the circumstances.
17. United Kingdom. `Copyright, Designs and Patents Act 1988` s.87. Waiver by signed writing.
18. United States. `17 U.S.C. section 106A`. Computer programs are outside the Visual Artists Rights Act.
19. Antigua and Barbuda. `Copyright Act 2003` section 19. Waiver by signed writing; may cover works generally and future works.
20. Botswana. `Copyright and Neighbouring Rights Act` section 8(3). Written waiver that specifies the right and the circumstances.
21. Luxembourg. `Law of 18 April 2001` Article 12. Moral rights and economic rights are freely assignable except the right to object to prejudice to honor or reputation. Attribution may be assigned. Official statement of the Ministry of Culture.
22. Saint Vincent and the Grenadines. `Copyright Act 2003` section 18. Consent and waiver of moral rights.
23. Fiji. `Copyright Act 1999` section 96. Consent and waiver of moral rights.
24. Saint Kitts and Nevis. `Copyright Act` section 19. Waiver by signed writing; may cover works generally and future works.
25. Grenada. `Copyright Act 2011` section 20(3). Written waiver specifying the rights waived and the circumstances.
26. Papua New Guinea. `Copyright and Neighbouring Rights Act 2000` section 7(4). Written waiver specifying the rights and the circumstances.
27. Zimbabwe. `Copyright and Neighbouring Rights Act Chapter 26:05` section 62(a)(i) and 62(e). The right of identification does not apply to a computer program; the author may also waive the right.
28. Brunei Darussalam. `Emergency (Copyright) Order 1999` section 90. Waiver by signed writing; may cover works generally and future works.
29. Sierra Leone. `Copyright Act 2011` section 11(3). Written waiver specifying the right waived and the circumstances.
30. Samoa. `Copyright Act 1998` section 7(3). Written waiver specifying the rights waived and the circumstances.
31. Sri Lanka. `Intellectual Property Act No. 36 of 2003` section 11(3). Written waiver specifying the rights waived and the circumstances.
32. Seychelles. `Copyright Act 2014` section 8(3). Written waiver specifying the rights waived and the circumstances.
33. Tonga. `Copyright Act 2002 (2020 Revised Edition)` section 7(3). Written waiver specifying the rights and the circumstances.
34. Vanuatu. `Copyright and Related Rights Act` section 9(4) and 9(5). Written waiver specifying the rights and the circumstances.
35. Kiribati. `Copyright Act 2018` section 27. Written waiver specifying the rights waived and the circumstances.
36. Eswatini. `Copyright and Neighbouring Rights Act 2018`. Identification and integrity exceptions include anything to which the author has consented or in regard to which he has waived his right.
37. Palau. Copyright statute section 6. The author may waive enumerated moral rights.
38. Andorra. `Llei sobre drets d'autor i drets veins` of 10 June 1999 Article 6(3) (Andorran law on copyright and neighboring rights). The author may waive any of the moral rights in Article 6(1) if the waiver is in writing and clearly specifies the right waived and the case or cases where the waiver applies.
39. Cook Islands. `Copyright Act 2013` section 27. Written waiver specifying the rights waived and the circumstances.
40. Maldives. `Copyright and Related Rights Act Law No. 23/2010` section 11(c). Written waiver specifying the rights waived and the circumstances.
41. Bhutan. `Copyright Act of the Kingdom of Bhutan 2001` section 9(3). Written waiver specifying the rights waived and the case or cases where the waiver applies.
42. Gambia. `Copyright Act 2004` section 10(3). The author may waive any of the moral rights mentioned in subsection (1) if the waiver is in writing and clearly specifies the right waived and the circumstances in which the waiver applies.
43. Guyana. `Copyright Act 1956` as extended by the `Copyright (British Guiana) Order 1966`. The Act has no moral rights paternity chapter. There is no leftover right to demand a name after a dedication.
44. Marshall Islands. No general copyright statute found. There is no leftover right to demand a name after a dedication.
45. Micronesia (Federated States of). `Code Title 35 Chapter 1` section 106. Exclusive rights are economic. There is no moral rights paternity article for literary or software works. There is no leftover right to demand a name after a dedication.
46. Solomon Islands. `Copyright Act Cap. 138` section 37. False attribution of authorship is a civil action against putting another person's name on a work. False attribution is not a leftover right to demand credit after a dedication.
47. Tuvalu. `Copyright Act Cap. 40.24 Revised Edition 2008`. A 1917 shaped enforcement statute. There is no moral rights paternity article. There is no leftover right to demand a name after a dedication.
48. Niue. `Niue Act 1966` applies the New Zealand `Copyright Act 1994`. Section 107. Any of the Part 4 moral rights may be waived by instrument in writing signed by the person waiving the right.
49. Jersey. `Intellectual Property (Unregistered Rights) (Jersey) Law 2011` Article 115(2). Any of the rights conferred by that Chapter may be waived by instrument in writing signed by the person giving up the right.
50. Guernsey. `Copyright (Bailiwick of Guernsey) Ordinance, 2005` section 109. Waiver of moral rights by instrument in writing signed by the person giving up the right.
51. Isle of Man. `Copyright Act 1991` section 87. Waiver of moral rights by instrument in writing signed by the person giving up the right.
52. Sahrawi Arab Democratic Republic. No copyright statute found. Open Law Africa records that the SADR has no law regulating copyright. There is no leftover moral right of attribution after a dedication.
53. Gibraltar. `Intellectual Property (Copyright and Related Rights) Act 2005` section 104(2). Any of those rights may be waived by instrument in writing signed by the person giving up the right.
54. Northern Cyprus. `Chapter 264 Copyright Law` refers the rest of the subject to the United Kingdom `Copyright Act 1911`. The 1911 Act has no moral rights paternity chapter. There is no leftover right to demand a name after a dedication.

### 4.14 Specific consent list

A blanket Unlicense SHALL NOT be accepted from nationals of these jurisdictions. The statute requires consent that identifies the Work and the uses.

1. Australia. `Copyright Act 1968` Part IX. Consent must be specific. `McCallum v Projector Films` (2026) FCA 173: a blanket waiver is unenforceable.
2. Malaysia. `Copyright Act 1987` s.25(2). The restricted acts require the Author's consent. Whether a blanket waiver is valid is unsettled.

### 4.15 Residual attribution list

Nationals of these jurisdictions SHALL NOT contribute. After a public domain dedication, the statute still lets the Author enforce the moral right of attribution.

#### 4.15.1 Unwaivable or inalienable attribution

The statute states that the moral right of attribution cannot be waived, that a waiver is void, that the right is inalienable or cannot be given up, or that a waiver is valid only for a use limited in kind and extent (which a worldwide perpetual dedication is not).

1. Algeria. `Ordinance 03-05` Art. 21. Cannot be waived.
2. Angola. `Law 4/90` Art. 18. Inalienable.
3. Austria. `Urheberrechtsgesetz` section 19(2). Waiver of the right to claim authorship is ineffective.
4. Belgium. `Code de droit economique` Art. XI.165 section 2 (Belgian Code of Economic Law). Inalienable; a global waiver of future exercise is void.
5. Benin. `Bangui Agreement Annex VII` Art. 7(4). Perpetual, inalienable, cannot expire by time. This Agreement is national law in the OAPI states.
6. Bolivia. `Andean Community Decision 351` Art. 11. Paternity inalienable, cannot expire by time, cannot be given up.
7. Brazil. `Lei 9.610/1998` Arts. 24 and 27. Inalienable and cannot be waived.
8. Burkina Faso. `Bangui Agreement Annex VII` Art. 7(4).
9. Cameroon. `Bangui Agreement Annex VII` Art. 7(4).
10. Central African Republic. `Bangui Agreement Annex VII` Art. 7(4).
11. Chad. `Bangui Agreement Annex VII` Art. 7(4).
12. Chile. `Ley 17.336` Arts. 14 and 16. The right to the name is inalienable; a contrary pact is void.
13. China. `Copyright Law` Art. 10. Authorship is a personal right; the transfer language covers economic rights only.
14. Colombia. `Ley 23 de 1982` Art. 30. The right to the name is perpetual, inalienable, and cannot be waived.
15. Comoros. `Bangui Agreement Annex VII` Art. 7(4).
16. Congo. `Bangui Agreement Annex VII` Art. 7(4).
17. Cote d'Ivoire. `Bangui Agreement Annex VII` Art. 7(4).
18. Czechia. `Act No. 121/2000` section 11(4). The Author may not waive moral rights; they cannot be transferred.
19. Denmark. `Ophavsretsloven` section 3. A waiver binds only for a use limited in nature and extent.
20. Ecuador. `Andean Community Decision 351` Art. 11.
21. Egypt. `Law 82 of 2002` Arts. 143 and 145. Inalienable; any disposal of those rights is void.
22. Equatorial Guinea. `Bangui Agreement Annex VII` Art. 7(4).
23. Estonia. `Copyright Act` section 11(2). Moral rights are inseparable from the person and cannot be transferred.
24. Finland. `Tekijanoikeuslaki 404/1961` section 3 (Finnish Copyright Act). A binding waiver only for a use limited in character and extent.
25. France. `Code de la propriete intellectuelle` Art. L121-1 (French Intellectual Property Code). Perpetual, inalienable, cannot expire by time.
26. Gabon. `Bangui Agreement Annex VII` Art. 7(4).
27. Germany. `Urheberrechtsgesetz` sections 13, 14, 29. Attribution remains with the Author; copyright itself cannot be transferred.
28. Greece. `Law 2121/1993` Arts. 4 and 12. Paternity remains after transfer of economic rights.
29. Guinea. `Bangui Agreement Annex VII` Art. 7(4).
30. Guinea-Bissau. `Bangui Agreement Annex VII` Art. 7(4).
31. Hungary. `Act LXXVI of 1999` Art. 9(2). Moral rights may not be transferred, devolve, or be renounced.
32. Iceland. `Hofundarrettarlog nr. 73/1972` Art. 4 (Icelandic Copyright Act). Waiver only for a use limited in character and extent.
33. Indonesia. `Copyright Law` Art. 5(1). Moral rights are eternally inherent in the Author.
34. Italy. `Legge 22 aprile 1941 n. 633` Arts. 20 to 22. Perpetual; cannot be transferred; cannot be waived.
35. Japan. `Copyright Act` Art. 59. Exclusively personal and inalienable.
36. Kazakhstan. `Law 6-I` Art. 15(4). Personal non property rights are inalienable.
37. Macao. `Decree-Law 43/99/M` Arts. 7(d) and 41. Perpetual, inalienable, cannot be given up, cannot expire by time. Not a United Nations member.
38. Mali. `Bangui Agreement Annex VII` Art. 7(4).
39. Mauritania. `Bangui Agreement Annex VII` Art. 7(4).
40. Mexico. `Ley Federal del Derecho de Autor` Arts. 19 and 21. Inalienable, cannot expire by time, cannot be waived, cannot be seized, including recognition as Author.
41. Republic of Moldova. `Law on Copyright` Art. 9. Inalienable.
42. Niger. `Bangui Agreement Annex VII` Art. 7(4).
43. Norway. `Andsverkloven` section 5 (Norwegian Copyright Act). Waiver only for a use limited in character and extent.
44. Oman. `Royal Decree 65/2008` Art. 5. Perpetual, inalienable, cannot be assigned.
45. Peru. `Andean Community Decision 351` Art. 11.
46. Poland. `Act on Copyright and Related Rights 1994` Art. 16. Unlimited in time; not subject to waiver or transfer; includes authorship and naming.
47. Portugal. `Codigo do Direito de Autor e dos Direitos Conexos` Art. 56 (Portuguese Copyright Code). Inalienable, cannot be waived, cannot expire by time.
48. Romania. `Law 8/1996` Arts. 10 and 11(1). May not be waived or transferred.
49. Russian Federation. `Civil Code` Art. 1265. Authorship and the right to a name are inalienable; a waiver is void.
50. Saudi Arabia. Copyright Law published 13 February 2026 in `Umm Al Qura`. Moral rights perpetual, cannot be transferred, cannot be waived.
51. Senegal. `Bangui Agreement Annex VII` Art. 7(4).
52. Slovakia. `Copyright Act` Art. 17(2). The Author may not waive; cannot be transferred.
53. Spain. `Ley de Propiedad Intelectual` Art. 14. Cannot be waived and inalienable, including recognition as Author.
54. Sweden. `Upphovsrattsslagen 1960:729` 3 section (Swedish Copyright Act). Waiver only for a use limited as to character and scope.
55. Togo. `Bangui Agreement Annex VII` Art. 7(4).
56. Turkey. `Law 5846` Arts. 14 to 16. Inalienable; contractual waiver of honor protection is void.
57. United Arab Emirates. `Federal Decree-Law 38 of 2021` Art. 5. Moral rights are not subject to prescription or assignment; commentary treats them as not waivable.
58. Viet Nam. `Law on Intellectual Property (2022)`. Naming, attribution, and integrity are perpetual and cannot be transferred.

#### 4.15.2 Attribution that survives assignment

The statute keeps the moral right of attribution after assignment of copyright, or states that the right cannot be assigned during the Author's life. The pinned text does not contain a sentence that a waiver is void. The Contribution is still refused, because the Unlicense is not shown to extinguish attribution.

59. Albania. `Law 7564` Arts. 17 to 21. Perpetual moral rights; waiver clause not pinned.
60. Armenia. `Law of 2006` Art. 12. Unlimited moral rights; waiver clause not pinned.
61. Azerbaijan. `Law of 1996` Arts. 14 and 27. Unlimited moral rights; waiver clause not pinned.
62. Belarus. `Copyright Law` Art. 15. Unlimited moral rights; waiver clause not pinned.
63. Bulgaria. `Authors Rights and Related Rights Act` Art. 17 with Arts. 27 to 30. Attribution excepted from the ordinary term; waiver clause not pinned.
64. Ghana. `Copyright Act 2005` ss.6, 9, 18. A transfer of copyright does not include moral rights; moral rights are perpetual; no clause that a waiver is void is pinned.
65. India. `Copyright Act 1957` s.57. Special rights survive assignment and, after 2012, survive expiry of copyright; not an article that a waiver is void.
66. Kenya. `Copyright Act` s.32. Not transmissible during the Author's life.
67. Latvia. `Copyright Law`. Cannot be transferred during the Author's life; article that a waiver is void is not pinned.
68. Lithuania. `Law on Copyright` Art. 38(4) and Art. 34. Cannot be transferred; protected in perpetuity.
69. Malta. `Copyright Act Cap. 415` s.12. Not transmissible during life; integrity requires consent.
70. Nigeria. `Copyright Act 2022` s.14(3). Not transmissible during the Author's life.
71. North Macedonia. `Author's Right Act 2010` Arts. 61(2) and 75. Unlimited moral rights; waiver clause not pinned.
72. Qatar. `Law 7 of 2002` Arts. 10 to 11. Moral rights cannot expire by time and are perpetual.
73. Republic of Korea. `Copyright Act` Art. 14. Moral rights belong exclusively to the Author.
74. Switzerland. `Urheberrechtsgesetz` Arts. 9 and 11. Authorship and integrity recognized; no United Kingdom style waiver clause pinned.
75. Taiwan. `Copyright Act` Arts. 21, 25, 26. Perpetual attribution; survives after economic rights end. Not a United Nations member.
76. Uganda. `Copyright and Neighbouring Rights Act` s.9(3). Not assignable except for enforcement.
77. Ukraine. `Law 2811-IX`. Moral rights vest in the Author and cannot be transferred; ICLG 2026 states they cannot be waived.
78. Slovenia. `Copyright and Related Rights Act` Articles 70(1) and 79. Moral rights may not be assigned; a contract transferring moral rights is null.
79. Georgia. `Law on Copyright and Related Rights` Article 17(4). Alienation of personal non property rights during life is inadmissible.
80. Kuwait. `Law 75/2019` Article 6. Moral rights are inalienable and not subject to assignment or attachment; any act relating to them is void.
81. Costa Rica. `Ley 6683` Article 13. Moral right is personal, inalienable, cannot be given up, and perpetual.
82. Uruguay. `Ley 9.739` Articles 12 and 13. Whatever the assignment contract says, the author keeps listed faculties over the work; withdrawal is personal and cannot be transferred.
83. Morocco. `Law 2-00` Articles 9, 25, and 39. Moral rights cannot expire by time and are inalienable; cannot be transferred during life.
84. Pakistan. `Copyright Ordinance` section 62. Author's special rights survive assignment and relinquishment of copyright.
85. Tunisia. `Law 94-36` Article 8. Moral rights cannot expire by time, cannot be the object of a waiver, and are inalienable.
86. Serbia. `Law on Copyright and Related Rights` Articles 14, 15, and 60. Paternity and attribution inalienable; cannot be waived or alienated by contract.
87. Honduras. `Decreto 4-99-E` Article 35. Moral right personal, inalienable, cannot be given up, and cannot expire by time.
88. Panama. `Law 15 of 1994` Article 29. Moral rights inalienable, cannot be attached, cannot be given up, and cannot expire by time.
89. Paraguay. `Law 1.328/98` Article 17. Moral rights perpetual, inalienable, cannot be attached, cannot be given up, and cannot expire by time.
90. Dominican Republic. `Law 65-00` Article 17. Perpetual, inalienable, cannot expire by time, and cannot be given up, including paternity.
91. Venezuela. `Ley sobre el Derecho de Autor` Article 5. Moral rights inalienable, cannot be attached, cannot be given up.
92. Iran. `1970 Copyright Law` Article 4. Intellectual rights have no place or time limit and cannot be transferred.
93. Thailand. `Copyright Act B.E. 2537` section 18. The author is entitled to identify himself as author even against the assignee. The written agreement clause governs heir enforcement after death, not a living author's waiver.
94. Lebanon. `Law 75/1999`. Moral rights perpetual, inalienable, and cannot expire by time. Article 53: moral rights enjoy perpetual protection not subject to prescription.
95. El Salvador. `Decreto 66/2024` Article 10. Moral right cannot expire by time, inalienable, cannot be attached, and cannot be given up.
96. Guatemala. `Ley de Derecho de Autor` Article 19. Inalienable, cannot expire by time, and cannot be given up.
97. Mauritius. `Copyright Act 2014` section 7(3). Moral right cannot be assigned.
98. Nauru. `Copyright Act 2019` section 13(3). Moral rights not capable of being assigned.
99. Nicaragua. `Ley 312` Article 20. Moral rights cannot be given up and are inalienable.
100. Bahrain. `Law 22/2006` Article 5. Eternal inalienable intangible rights including attribution. Alienation of any literary right is invalid.
101. Bosnia and Herzegovina. `2010 Law` Article 31. Moral rights inalienable and not transmissible, including recognition as creator.
102. Cambodia. `Law on Copyright and Related Rights 2003` Article 19. Moral right perpetual, inalienable, cannot be seized, cannot expire by time.
103. Malawi. `Copyright Act 2016` section 30(4)(b). Moral rights may not be waived except for a use limited in nature and extent.
104. Uzbekistan. `Law on Copyright and Related Rights` Article 17. Any agreement or statement in which the author renounces the exercise of moral rights is null and void.
105. Lesotho. `Copyright Order 1989` section 8(2). Moral rights shall not be transferred.
106. Rwanda. `Law 31/2009` Articles 216 and 228. Moral rights cannot expire by time and are inalienable; not transmissible during the author's life.
107. Lao People's Democratic Republic. `Intellectual Property Law` Articles 100 and 101. Moral rights remain with the author and cannot be transferred.
108. Namibia. `Copyright and Neighbouring Rights Protection Act 6 of 1994` section 25. The right to claim authorship survives transfer of copyright. No waiver article in the Act in force.
109. Croatia. `Copyright and Related Rights Act` Article 64. The author cannot renounce his copyright. Article 56: copyright cannot be transferred except by inheritance. Article 15 written declaration only opts out of name indication for a particular use.
110. Mongolia. `Law on Copyright` Article 12.1.3. The author may require his name to be mentioned whenever the work is published or exploited. Article 14.2: moral rights have no time limitation. Article 15.4: moral rights shall not be inherited.
111. Kyrgyzstan. `Law on Copyright and Related Rights` Article 15(3). Moral rights are independent of property rights and are retained after assignment of the exclusive rights to use the work.
112. Tajikistan. `Law on Copyright and Related Rights` Article 15. Moral rights belong to the author independently of economic rights and are retained after assignment of the exclusive right to exploit the work.
113. Nepal. `Copyright Act 2059 (2002)` section 8(2). Moral rights shall not be transferable during the life of the author.
114. Cuba. `Ley 154/2022` Article 17. Moral faculties include the right to recognition of authorship. Article 35.1 permits express waiver of economic faculties only.
115. Zambia. `Copyright and Performance Rights Act Chapter 406` section 24. The right to be identified as author survives transfer of copyright and expires on the death of the author. No waiver article.
116. Haiti. `Decree of 9 January 1968` Article 5. Moral extra patrimonial right inalienable and cannot be seized.
117. Mozambique. `Lei 4/2001`. Moral rights inalienable, cannot be given up, cannot expire by time. `Lei 9/2022` Article 8: the right to claim authorship at any time after transfer of economic rights.
118. Madagascar. Copyright statute Article 22. Moral rights perpetual, inalienable, cannot expire by time.
119. Yemen. `Law 15/2012` Article 7. Moral rights eternal, cannot be assigned, not subject to disposition.
120. Cyprus. `Law 59/1976` Article 7(4). During the author's life the author has the right to claim paternity of the work and to object to alteration. No waiver article in the Act as amended.
121. Montenegro. `Law on Copyright and Related Rights` Article 71. The author may not assign moral rights. Article 80: a contract assigning moral rights is null and void.
122. Jordan. `Copyright Protection Law No. 22 of 1992` Article 8(a). The author has the exclusive right to have the work attributed to him. Article 13: only economic rights may be transferred in writing.
123. Liechtenstein. `Urheberrechtsgesetz` Article 9. The author has the exclusive right in the work and the right to recognition of authorship. No written waiver article.
124. Syrian Arab Republic. `Legislative Decree 62 of 2013`. Moral rights of the author are perpetual and are not subject to limitation or disposal.
125. Liberia. `Copyright Law` section 2.7(d). The moral rights of attribution and integrity shall not be transmissible during the life of the author.
126. San Marino. `Law 8 of 25 January 1991` Article 27. The moral right of the author is personal, perpetual, inalienable, and cannot expire by time.
127. Afghanistan. `Copyright Law 2008` Article 11(1). Moral rights of the work are confined to the author and cannot be transferred. Article 11(2) includes mention or no mention of name.
128. Burundi. `Law No. 1/021 of 30 December 2005` Article 22. Moral rights attach to the author's person; perpetual, inalienable, and cannot expire by time.
129. Ethiopia. `Copyright and Neighboring Rights Protection Proclamation 410/2004`. Moral rights exist irrespective of economic ownership and cannot be transferred during the author's life.
130. Myanmar. `Copyright Law 2019` sections 18 to 21. Moral rights remain even if economic rights are transferred and cannot be transferred.
131. United Republic of Tanzania. `Copyright and Neighbouring Rights Act Cap. 218` section 11. The author has the right to claim authorship and to have authorship indicated. No waiver article in the Act.
132. Iraq. `Law No. 3 of 1971` Article 8. Right of paternity perpetual, inalienable, cannot expire by time. Article 40: any disposal by a person other than the author of the rights in Articles 7, 8 and 10 is null.
133. Bangladesh. `Copyright Act 2000` section 78. Author's special rights of attribution and integrity. The Act contains no waiver article.
134. Democratic Republic of the Congo. `Ordonnance-loi n. 86-033 of 5 April 1986` Article 22. Moral rights attached to the person of the author; perpetual, cannot expire by time, and inalienable.
135. Cabo Verde. `Decreto-legislativo n. 1/2009` Article 39. Moral rights inalienable, cannot be given up, and cannot expire by time.
136. Monaco. `Loi n. 491 of 24 November 1948` Articles 19 and 20. The right of paternity is attached to the person of the author; perpetual and inalienable; its exercise cannot expire by time.
137. Timor-Leste. `Codigo do Direito de Autor` Article 32. Moral rights inalienable, cannot be given up, and cannot expire by time.
138. Libya. `Law No. 9 of 1968` Article 9. The author has the exclusive right to have the work attributed to him. No waiver article in the Act.
139. Argentina. `Ley 11.723` Article 52. Although the author alienates the property of the work, he retains the right to demand fidelity of the text and title and the mention of his name or pseudonym as author.
140. Sudan. `Copyright and Neighbouring Rights Protection Act 1996` section 8(1). Moral rights include attribution. Section 15(2) permits transfer of moral rights only if written, signed, and registered with period, place, and remuneration specified. The Unlicense is not that instrument.
141. Democratic People's Republic of Korea. `Copyright Law` Article 20. The author's personal rights are not transferred nor inherited and have an unlimited period.
142. Djibouti. `Law 154/AN/06` Article 9(5). Moral rights perpetual, inalienable, cannot expire by time.
143. Sao Tome and Principe. `Codigo do Direito de Autor` Article 56(2). Moral rights inalienable, may not be waived, cannot expire by time.
144. Suriname. `Auteurswet 1913` Article 25. Even after transfer of copyright the maker retains personality rights, including the right to oppose publication of the work under a name other than the maker's and the right to oppose a change in the designation of the maker.
145. South Sudan. Constitution Article 198 keeps existing laws in force. The `Copyright and Neighbouring Rights Protection Act 1996` of Sudan remains the statute applied. Section 8(1) includes the right to claim authorship. Section 15(2) permits transfer of moral rights only if written, signed, and registered. The Unlicense is not that instrument.
146. Turkmenistan. `Law No. 257-IV of 10 January 2012` Article 15(2). Personal non property rights, including the right of authorship and the right to a name, belong to the author independently of property rights and remain after assignment of the exclusive rights to use the work.
147. Somalia. `Law No. 66 of 7 September 1977` Article 15(3) and 15(4). Moral rights of attribution and integrity subsist after transfer of economic rights and are inalienable and cannot be assigned.
148. Eritrea. `Transitional Civil Code` Article 1665. Notwithstanding any stipulation to the contrary, the author may prevent his work, if altered by a third party, from being presented as his own. Article 1671: that right may be exercised after death by the author's spouse, ascendants, children, and grandchildren.
150. Holy See. `Law CXXXII of 19 March 2011` Article 1, as continued by `Law CXCVII of 1 September 2017`. Unless otherwise provided, Vatican City observes Italian copyright legislation. Italy `Legge 22 aprile 1941 n. 633` Articles 20 to 22: the right of paternity is inalienable and cannot be waived.
151. Kosovo. `Law No. 08/L-205 on Copyright and Related Rights` Article 19(1). Independently of economic rights and even after assignment the author has the right to claim authorship. Article 22(1): moral rights shall not be transferable by assignment or license.
152. State of Palestine. No successor waiver statute opened. West Bank practice applies Jordan `Copyright Protection Law No. 22 of 1992` Article 8(a). Gaza historically applied Egyptian `Law No. 354 of 1954`. Jordan and Egypt are already on the Residual attribution list.
153. Somaliland. Somalia `Law No. 66 of 7 September 1977` Article 15(3) and 15(4), treated as the copyright statute in Somaliland (`somalilandlaw.com`). Moral rights of attribution and integrity subsist after transfer of economic rights and are inalienable and cannot be assigned.
154. Abkhazia. `Law No. 1227-c-XIV on Copyright and Related Rights` Article 15(3). Personal non property rights belong to the author independently of property rights and are retained after assignment of exclusive rights of use.
155. South Ossetia. `Law on Copyright and Related Rights` Article 15(3). Personal non property rights belong to the author independently of property rights and are retained after assignment of exclusive rights of use. `parliamentrso.org`.
156. Transnistria. `Civil Code of the Pridnestrovian Moldavian Republic` Article 1292. The author has the right of authorship and the author's right to a name. Official commentary: the right of authorship, the right to a name, and the right to protect reputation are perpetual.

The numbering skips 149 because the source list has no item 149. The named count is 155 jurisdictions (146 United Nations members plus Macao, Taiwan, the Holy See, Kosovo, the State of Palestine, Somaliland, Abkhazia, South Ossetia, and Transnistria).

### 4.16 Unread list

The copyright statute of each jurisdiction on the Unread list has not been classified into Clause 4.13, Clause 4.14, or Clause 4.15. Nationals of those jurisdictions SHALL NOT contribute until the statute is read and the jurisdiction is placed on the Allow list. Unread is not a finding either way. Unread is refusal until classification.

1. United Nations members not classified in Clause 4.13, Clause 4.14, or Clause 4.15: 0 United Nations members. Every United Nations member is named in those clauses.
2. Non member jurisdictions and observers not classified in those clauses: 0 jurisdictions. Every named non member and de facto jurisdiction in this specification is in those clauses, or is closed under the parent state rule in item 3 of this clause.
3. A Contributor who is a national of the parent state is classified under that parent state:
	1. Faroe Islands and Greenland follow Denmark.
	2. Aland follows Finland.
	3. Svalbard follows Norway.
	4. French overseas collectivities follow France.
	5. Puerto Rico and other United States territories follow the United States, for persons who are United States nationals.
	6. Crown Dependencies and British Overseas Territories follow the United Kingdom, for persons who are British citizens. Jersey, Guernsey, and the Isle of Man also have their own statutes of waiver in writing and are named on the Allow list.
	7. Tokelau follows New Zealand. The people of Tokelau are New Zealand citizens.
4. A person who holds only a local status that is not citizenship of an Allow list state is unread.
5. Stating that unread United Nations members remaining is none is a classification claim, not a statute pin.

### 4.17 Attestation

The Contributor SHALL state, in writing with the Contribution:

1. each nationality they hold;
2. that every such nationality is on the Allow list;
3. that they dedicate the Contribution under the Unlicense.

No passport, national identity card, or copyright registration is requested or accepted as a condition of contribution.

### 4.18 Request to re-read a statute

A national of a jurisdiction named on any list in this specification who wants a statute re-read, or who wants a classification clarified, MAY write to `legal@surmount.systems`.

`legal@surmount.systems` is not a private mailbox. Mail sent to that address is published on the Surmount website. It is not a confidential communication and MUST NOT be treated as one. Authors SHALL NOT send passports, national identity cards, copyright registrations, or other government identity documents to that address.

### 4.19 Informative figure (contributor nationality map)

This subsection is informative. Numbered specifications SHALL NOT embed binary image assets. This ASCII markdown cannot embed SVG. The file [contributor-nationality-map.svg](contributor-nationality-map.svg) is a supporting figure at this repository root. It is not a numbered specification. Geometry is Natural Earth 1:110m public domain. Classification colors follow this specification. The map is not the Allow list. Normative lists remain the numbered lists in Clause 4.13, Clause 4.14, Clause 4.15, and Clause 4.16.

### 4.20 Counts and scale (informative)

This subsection is informative. Figures of population and GDP are scale, not a legal test. A Contribution is accepted or refused by nationality and statute, not by these totals.

| List | Effect on contribution | Named jurisdictions |
|---|---|---|
| Allow | accepted with the Unlicense | 54 |
| Specific consent | refused on the Unlicense alone | 2 |
| Residual attribution | refused | 155 (146 United Nations members plus Macao, Taiwan, the Holy See, Kosovo, the State of Palestine, Somaliland, Abkhazia, South Ossetia, and Transnistria) |
| Unread United Nations members | refused until classified onto Allow | 0 |
| Unread other jurisdictions | refused until classified onto Allow | 0 |

193 United Nations members equal 45 Allow plus 2 specific consent plus 146 residual attribution plus 0 unread.

| List | Population (UN WPP 2024 mid 2026) | Share of UN WPP world | GDP (IMF WEO April 2026) | Share of IMF world GDP |
|---|---|---|---|---|
| Allow (United Nations members plus Hong Kong SAR) | about 773 million | 9.4% | about $44.1 trillion | 34.9% |
| Specific consent | about 62 million | 0.8% | about $2.43 trillion | 1.9% |
| Residual attribution (remainder) | about 7.40 billion | 89.8% | about $79.7 trillion | 63.1% |
| World | 8.23 billion (UN) / 8.05 billion (IMF pop) | 100% | $126.30 trillion | 100% |

Allow is small in population and large in GDP because the United States, the United Kingdom, Canada, the Netherlands, Ireland, and Singapore sit on Allow. Residual attribution is most of the world's people, including China and India. Sources: United Nations World Population Prospects 2024; International Monetary Fund World Economic Outlook, April 2026. Those sources are not Clause 12 pins.

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Public Domain Open Source Software (PDOSS) is treated as the ideal, and the PDOSS test is the public domain dedication of software that is open (Clause 3.4, Clause 3.5, and Clause 4.2).
2. Unlicense remains the license; the most important Surmount work in this repository is dedicated to the public domain under the Unlicense; companion Lean treats an Unlicense dedication as having no remaining copyright in the model and as meeting the PDOSS test (Clause 4.2).
3. MIT as used by the Lean 4 agent skill pack does not meet a public domain dedication test and does not meet the PDOSS test; Apache 2.0 as used by the `btc-verified` pin does not meet a public domain dedication test and does not meet the PDOSS test; a mash that claims MIT meets PDOSS is `False` (Clause 4.3).
4. A grant that keeps copyright is treated as still leaving a copyright holder, and remaining copyright is treated as still letting a later contract take the work (Clause 4.1).
5. Ideas are treated as not scarce; two people can hold the same idea at once; generosity of ideas is the default this repository chooses (Clause 4.4).
6. Numbered specifications and the Lean in this tree are released under the Unlicense except where residual names a different license; the Lean 4 agent skill pack remains MIT; the `btc-verified` pin remains Apache 2.0; essays by Keagan McLelland (Proof of Keags) are not Unlicense (Clause 4.5).
7. Refusing a tool the author cannot improve is treated as RSI process residual and is not treated as a claim that every product is Unlicense (Clause 4.6).
8. Numbered markdown is the contract humans read; the specification is encoded in Lean as declarations of what must be true; proofs live in separate Lean modules; a mash that hides the split is treated as `False`; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` (Clause 4.7).
9. Formal Vibefication citations keep the canonical Proof of Keags URL; a numbered specification that names Keagan or Proof of Keags also contains the host `proofofkeags.com`; theorems cover exactly what they state (Clause 4.8).
10. beastdb, SSSSS, Slake, Continuous Integration, Lean Machine, and Majestic Memex are treated as ongoing and not ready for use, and are not described as never started or as ready (Clause 4.9).
11. fargo, SSSP, and Carbonado have no assigned specification numbers; Lean Machine is specified in `0013_Lean_Machine.md`; number 0009 is this specification and is not assigned to fargo or Carbonado; a numbered Vocabulary file does not exist; the Unlicense numbered markdown file for specification 0009 does not exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept (Clause 4.10).
12. The named gate in `0007_CI.md` remains the gate for this repository (Clause 4.11).
13. A Contribution is accepted only if it is dedicated under the Unlicense and every nationality the Contributor holds is on the Allow list; a Contribution is refused if any nationality is on the Residual attribution list, the Specific consent list, or the Unread list; dual or multiple nationality refuses if any one citizenship is not Allow; Users of a published Work are not restricted by nationality; companion Lean treats a mash that a residual attribution national Contribution is accepted as `False` (Clause 4.12 through Clause 4.16).

This specification is not itself a conforming Surmount product. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program; this clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no assigned specification number. This document does not create a numbered file for fargo. This document does not invent a number for fargo. This document does not steal 0005, 0006, 0007, 0008, 0009, 0010, or 0011 for fargo. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.
2. SSSP has no assigned specification number. This document does not create a numbered file for SSSP. It has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`), not Carbonado. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is this specification. Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not create a file for Carbonado.
4. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 was briefly Vocabulary, then Unlicense, and is now Public Domain Open Source Software (PDOSS) by operator order. The word catalog lives in CATE (`0005_CATE.md`). This document does not assign 0009 to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The Unlicense numbered markdown file for specification 0009 MUST NOT exist. The form checker MUST fail if either of those files is present. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 6.2 Product claims that are not ready for use

1. This document specifies Public Domain Open Source Software (PDOSS) and records that Unlicense remains the license. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in `0007_CI.md` ([0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3). This document does not claim that match already holds. The match is not claimed done. Slake work is ongoing and is not ready for use.
3. `lean/UnlicenseSpec.lean` encodes selected claims. `lean/UnlicenseProofs.lean` proves those claims. `lean/Surmount.lean` composes stack identities including this specification as number 0009. `0009_PDOSS.lean` encodes the physical lines of this markdown file. `lean/Proofs_0009.lean` proves identities of that line encoding. Those modules are not a proof that Slake emit already matches `ELF`. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use. They are not a proof that every file in a clone is Unlicense.

### 6.3 Named residual licenses this Unlicense does not replace

1. The Lean 4 agent skill pack at `skills/lean4-skills` is original work under the MIT license. It is not under `ref/`. It is not a Clause 12 pin. It is not `mathlib`. This repository's Unlicense does not replace that MIT license. MIT does not meet the PDOSS test.
2. The `btc-verified` pin at `ref/btc-verified` is Apache 2.0. This repository's Unlicense does not replace that Apache 2.0 license. Apache 2.0 does not meet the PDOSS test.
3. Essays by Keagan McLelland (Proof of Keags) are cited by URL. They are not Clause 12 pins. They are not Unlicense grants. Local copies under `ref/philosophy/proofofkeags/` are for readers. They are not a public domain grant of those essays. `ref/philosophy/proofofkeags/SOURCE.md` records that back linking is ideal, that the jurisdiction he named is USA, and that the Unlicense of this repository does not apply the Unlicense to those essays. Full license text is still not published on https://proofofkeags.com . Do not invent that license.
4. Product trees outside this repository MAY name a different license in their own residual. This document does not claim those trees are Unlicense.
5. Treating this repository Unlicense as replacing those named residual licenses is Cons False in the PDOSS proofs module. Theorems that MIT meets PDOSS and that Apache 2.0 meets PDOSS already exist. This proof is not those theorems.

### 6.4 Pins this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. https://unlicense.org is informative prior art. It is not a Clause 12 pin. This repository does not add a Form 1 or Form 2 pin of that site. The binding dedication is `UNLICENSE.md`.
3. ISO 24495-1:2023 and the US Federal Plain Language Guidelines remain informative prior art of CATE. They are not pins of this document.
4. Other public domain instruments (for example CC0) are not pinned here. Companion Lean MUST NOT encode CC0 as meeting the PDOSS test. This document does not claim CC0 fails or meets PDOSS as a pinned instrument. CC0 remains residual.
5. Mapping constructor `cc0` to `meetsPdoss` false is residual honesty that CC0 is unpinned. It is not a Clause 12 pin of CC0. It is not a legal evaluation of CC0 as a published instrument. Treating CC0 as a pinned instrument that meets the PDOSS test is Cons False in the PDOSS proofs module. That proof is not a theorem that MIT meets PDOSS and is not a theorem that Apache 2.0 meets PDOSS.

### 6.5 Informative items this document names

1. Formal Vibefication research pages in Clause 2.2 are not Clause 12 pins of this document.
2. CATE is specified in `0005_CATE.md`. CATE is not this specification.
3. RSI is specified in `0006_RSI.md`. RSI is not this specification.
4. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. Formal Vibefication is not this specification.
5. Surmount Systems is specified in `0010_Surmount_Systems.md`. Surmount Systems is not this specification.
6. Companion models for CATE (`lean/CateSpec.lean` encodings, `lean/CateProofs.lean` theorems), RSI (`lean/RsiSpec.lean`, `lean/RsiProofs.lean`), Continuous Integration (`lean/CiSpec.lean`, `lean/CiProofs.lean`), beastdb (encodings and proofs under `lean/` for that product), SSSSS (`lean/SssssSpec.lean`, `lean/SssssProofs.lean`), Systems Lean (`lean/SystemsLeanSpec.lean`, `lean/SystemsLeanProofs.lean`), Formal Vibefication (`lean/FormalVibeficationSpec.lean`, `lean/FormalVibeficationProofs.lean`), PDOSS (`lean/UnlicenseSpec.lean`, `lean/UnlicenseProofs.lean`), Surmount Systems Tech Tree (`lean/TechTreeSpec.lean`, `lean/TechTreeProofs.lean`), Majestic Memex (`lean/MemexSpec.lean`, `lean/MemexProofs.lean`), Lean Machine (`lean/LeanMachineSpec.lean`, `lean/LeanMachineProofs.lean`), and the CATE word catalog (`lean/VocabularySpec.lean`, `lean/VocabularyProofs.lean`) place encodings in Spec modules and theorems in Proofs modules. Collision tags in `lean/Vocabulary.lean` are encodings with proofs in `lean/VocabularyCollisionProofs.lean`. Mixing those in one mash is `False` under `0008_Formal_Vibefication.md`. Sibling line encodings remain a separate split.

### 6.6 Contributor nationality residual

1. Stating that unread United Nations members remaining is none, and that unread other jurisdictions remaining is none, is a classification claim. It is not a statute pin. Unread remains refusal until classification. A later re-read MAY move a jurisdiction.
2. Population and GDP tables in Clause 4.20 are scale, not the legal test. A Contribution is accepted or refused by nationality and statute, not by those totals. United Nations World Population Prospects 2024 and IMF World Economic Outlook April 2026 are not Clause 12 pins of this document.
3. The file `contributor-nationality-map.svg` is an informative figure. Geometry is Natural Earth 1:110m public domain. The map is not the Allow list. Normative lists remain the numbered lists in this specification.
4. Statute cites in Clause 4.13, Clause 4.14, and Clause 4.15 are not Clause 12 `ref/` pins unless the operator pins them. This document does not add those statutes under `ref/`. Treating those statute cites as Clause 12 pins is Cons False in the PDOSS proofs module.
5. The contributor nationality condition is inbound only. Users of a published Work are not restricted by nationality. Dual or multiple nationality refuses if any one citizenship is not on the Allow list. That refuse is any not Allow class, not a separate license.
6. Unlicense remains the license. The Unlicense numbered markdown file for specification 0009 MUST NOT exist.

## 7. Changelog

### 0.1.0 - 20260920

Current version line is 0.1.0 by operator order. Number 0009 is Public Domain Open Source Software (PDOSS). The file name is `0009_PDOSS.md`. Unlicense remains the license. Defines the PDOSS test. Records that Unlicense meets that test. Records that MIT as used by the Lean 4 agent skill pack and Apache 2.0 as used by the `btc-verified` pin do not meet a public domain dedication test. Records that a mash that claims MIT meets PDOSS is `False`. Records the contributor nationality agreement: a Contribution is accepted only if dedicated under the Unlicense and every nationality is on the Allow list; Specific consent, Residual attribution, and Unread refuse; dual nationality refuses if any one citizenship is not Allow; Users of a published Work are not restricted by nationality. Residual records that other public domain instruments (for example CC0) are not pinned here, that mapping `cc0` to `meetsPdoss` false is unpinned honesty and not a legal evaluation, that treating CC0 as a pinned instrument that meets PDOSS is Cons False, that treating this Unlicense as replacing named residual licenses is Cons False, that unread remaining none is a classification claim, that GDP and population tables are scale, that the Natural Earth map is informative, that statute cites are not Clause 12 pins, and that treating those statute cites as Clause 12 pins is Cons False. Those Cons False proofs are not the MIT, Apache 2.0, or mash spec and proof catalog claims. Changelog history records that a 1.0.0 line existed for Unlicense as numbered specification 0009, and that number 0009 was briefly Vocabulary, then Unlicense, and is now PDOSS.

### 1.0.0 - 20260826

First publication of Unlicense as numbered specification 0009. The operator assigned 0009 to fill the gap after Vocabulary was folded into CATE. Number 0009 was briefly Vocabulary, then withdrawn; it was then Unlicense by operator order. A numbered Vocabulary file remains forbidden. Number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). This document does not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. Records that a grant that keeps copyright still lets a later contract take the work. Requires the most important Surmount work in this repository (numbered specifications and the Lean in this tree) to be dedicated to the public domain under the Unlicense so it stays the common heritage of anyone who seeks it, outside a later private claim. Records that ideas are not scarce and that two people can hold the same idea at once. Requires authors to release numbered specifications and the Lean in this tree under the Unlicense except where residual names a different license. Records that the Lean 4 agent skill pack remains MIT and that essays by Keagan McLelland (Proof of Keags) are not Unlicense. Records that refusing a tool the author cannot improve is RSI process residual and is not a claim that every product is Unlicense. Records Formal Vibefication as the split that encodes this specification in Lean and keeps proofs in separate modules, with canonical Proof of Keags URLs and back linking. Treats a mash of spec encodings and their proofs that hides the split as nonconforming. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.

This 1.0.0 also records: CATE is specification 0005; RSI is specification 0006; Formal Vibefication is specification 0008; Surmount Systems is specification 0010; this specification is number 0009; the word catalog lives in CATE (`0005_CATE.md`); a numbered Vocabulary file MUST NOT exist; number 0011 is Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`); this document does not steal 0011 for fargo; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept; fargo has no assigned specification number; SSSP has no assigned specification number; Carbonado has no assigned number; Lean Machine is specified as `0013_Lean_Machine.md`; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; honesty notes for Proof of Keags copies live at `ref/philosophy/proofofkeags/SOURCE.md`; this document does not claim that a conforming Surmount product exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense. Unlicense remains the license. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html
3. https://proofofkeags.com

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking). He named USA as the jurisdiction. He said back linking is ideal. That is not an Unlicense grant of those essays.
