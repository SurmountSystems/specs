# Majestic `Memex`

> v0.1.0 - 20260831
>
> Personal archive: crate `majestic`, on disk magic `MAJESTIC` plus byte `0x01`; a proof of concept still being built

## 1. Scope

This document specifies Majestic `Memex`: a personal `memex` with agent support for lossless ingest, encoding that tries to stay compact, and search in the style of `ripgrep` over account data exports. The crate name is `majestic`. The installed command is `memex`. On disk archives use magic `MAJESTIC` plus byte `0x01`. Archive data lives under `$HOME/memex`.

This specification is number 0012. The file name is `0012_Majestic_Memex.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/MemexSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/MemexProofs.lean`. Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0012_Majestic_Memex.lean`. Those encodings are not this specification.

Tech Tree files are specification 0011 ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)), magic `SSTECHTREE01`, extension `.sstt`. This document's on disk archives use magic `MAJESTIC` plus byte `0x01` and extension `.majestic`. Those formats are different. A `memex` product MAY later load a `.sstt` file. Loading a Tech Tree file does not make a `.majestic` archive a Tech Tree file. This Lake package includes a Lean writer of `.sstt` files. That writer is not a shipped memex product. This document does not claim that Majestic `Memex` is finished or ready for use. This document does not claim that a conforming Surmount Systems product exists. This document does not claim that Slake emit already matches object files as identical bytes. fargo has no assigned specification number. This document does not create a numbered file for fargo. The Surmount Systems System Prompt (SSSP) has no assigned specification number. This document does not create a numbered file for SSSP. The Carbonado Network Protocol has no assigned specification number. This document does not create a numbered file for the Carbonado Network Protocol. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md).

### 1.1 Status of this document

1. This document is normative for the crate name `majestic`, the command name `memex`, the on disk magic `MAJESTIC` plus byte `0x01`, the archive extension `.majestic`, the data root `$HOME/memex`, the split between that archive format and Tech Tree `.sstt` files, the permission that `memex` MAY later load a `.sstt` file without mixing the formats, Formal Vibefication of this specification, residual honesty that the crate is a version 0.1 proof of concept still being built and is not ready for use, and residual honesty that the Unlicense of this specifications repository does not by itself dedicate the crate tree at `~/majestic`.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0012. The file name is `0012_Majestic_Memex.md`.
4. Concise American Technical English (CATE) is specified in [0005_CATE.md](0005_CATE.md). CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in [0006_RSI.md](0006_RSI.md). RSI is specification 0006. RSI is not this specification.
6. Continuous Integration and stack consistency is specified in [0007_CI.md](0007_CI.md). That document is specification 0007. That document is not this specification.
7. Formal Vibefication is specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). That document is specification 0008. That document is not this specification.
8. Public Domain Open Source Software is specified in [0009_PDOSS.md](0009_PDOSS.md). That document is specification 0009. That document is not this specification. Unlicense remains the license.
9. Surmount Systems stack composition is specified in [0010_Surmount_Systems.md](0010_Surmount_Systems.md). That document is specification 0010. That document is not this specification.
10. Surmount Systems Tech Tree is specified in [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md). That document is specification 0011. That document is not this specification.
11. First publication of this specification as a numbered document is version 1.0.0 dated 20260827.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under [0000_spec.md](0000_spec.md).

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md) and as stated by Keagan McLelland (Proof of Keags), requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/MemexSpec.lean` encode selected claims such as this document's identity as specification 0012 with file name `0012_Majestic_Memex.md`, crate name `majestic`, command name `memex`, magic bytes `MAJESTIC` plus `0x01`, archive extension `.majestic`, data root `$HOME/memex`, distinction from Tech Tree magic `SSTECHTREE01` and extension `.sstt`, and that the crate is still being built.
3. Proofs of those encodings live in `lean/MemexProofs.lean`.
4. The Lean module `Surmount` remains the single composition proof over stack identities. This specification's identity in that composition is specification 0012.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in [0000_spec.md](0000_spec.md)) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at [0005_CATE.md](0005_CATE.md) for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
6. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license.
7. Surmount Systems stack composition remains [0010_Surmount_Systems.md](0010_Surmount_Systems.md).
8. Surmount Systems Tech Tree remains [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md). That document specifies `.sstt` files. This document does not restate that format.
9. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
10. beastdb remains [0003_beastdb.md](0003_beastdb.md).
11. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
12. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo.
13. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE ([0005_CATE.md](0005_CATE.md)). Number 0006 is RSI ([0006_RSI.md](0006_RSI.md)). Number 0007 is Continuous Integration ([0007_CI.md](0007_CI.md)). Number 0008 is Formal Vibefication ([0008_Formal_Vibefication.md](0008_Formal_Vibefication.md)). Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). Number 0010 is Surmount Systems ([0010_Surmount_Systems.md](0010_Surmount_Systems.md)). Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). Number 0012 is this specification. This document does not steal those numbers for fargo or for Carbonado.
14. SSSP is named in residual. SSSP has no assigned specification number. This document does not create a numbered file for SSSP.
15. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). That document is specification 0013. That document is not this specification.
16. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds [0000](0000_spec.md) Clause 12 citation pins of this repository (RFC 2119, SemVer, Form 1 `ref/btc-verified`, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. The crate at `~/majestic` is not a Clause 12 pin of this repository. Bush 1945 is informative prior art (Clause 2.2). It is not a Clause 12 pin.

### 2.1 Pins in this specifications repository ([0000](0000_spec.md) Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification [0000_spec.md](0000_spec.md) (the form rules that govern this document, including Clause 11.4 on markdown path links in this repository).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification [0005_CATE.md](0005_CATE.md) (Concise American Technical English).
5. Surmount specification [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md) (Formal Vibefication: Lean spec encodings separate from proofs).
6. Surmount specification [0009_PDOSS.md](0009_PDOSS.md) (Public Domain Open Source Software of this specifications repository). Unlicense remains the license.
7. Surmount specification [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md) (Tech Tree `.sstt` format, which this document does not restate).

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under [0000_spec.md](0000_spec.md) Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12, https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-27).
2. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20, https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-27).
3. As We May Think, `Vannevar` Bush, The Atlantic, July 1945. That essay is the usual English source of the word `memex`. It is not under this repository's `ref/`. This effort does not add a Form 2 pin of that essay.
4. The crate README at `~/majestic/README.md` (read 2026-08-27) describes a version 0.1 proof of concept still being built. That README is not a Clause 12 pin. That crate is not this specifications repository.

Those Proof of Keags pages are research. They are not Unlicense grants. They are not permission to vendor those essays as Form 2 copies under `ref/`. Citations of that work SHALL keep those publisher links (back linking).

## 3. Definitions

### 3.1 Majestic `Memex`

The personal `memex` specified by this document: crate `majestic`, command `memex`, on disk magic `MAJESTIC` plus byte `0x01`, data under `$HOME/memex`.

### 3.2 Crate `majestic`

The Rust crate whose package name is `majestic`. The crate tree the operator named lives at `~/majestic`. That tree is not this specifications repository.

### 3.3 Command `memex`

The installed binary name. Authors SHALL use the `memex` command. There is no requirement that a bare `majestic` binary exist.

### 3.4 On disk archive

A file whose payload begins with eight ASCII bytes `MAJESTIC` followed by one byte `0x01`, and whose name uses extension `.majestic`. That file is not a Tech Tree `.sstt` file.

### 3.5 Data root

The directory `$HOME/memex`. Archives live under that root, typically as `$HOME/memex/{service}/{account}.majestic`. `$HOME/memex` is data. It is not the crate tree.

### 3.6 Tech Tree file

A file specified by [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md): extension `.sstt`, magic twelve ASCII bytes `SSTECHTREE01`. A Tech Tree file is not a Majestic `Memex` archive.

### 3.7 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.8 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md). For this specification that sibling is `0012_Majestic_Memex.lean`. Proofs of that encoding live in `lean/Proofs_0012.lean`. `lean/MemexSpec.lean` is the meaning encoding. It is not the line encoding of this markdown file.

### 3.9 Proof of concept still being built

The crate at `~/majestic` is version 0.1. It is still being built. It is not finished. It is not ready for use as a finished product. This specification records that honesty. It does not freeze every ingest shape the crate may later add.

## 4. Core requirements

### 4.1 Human contract and Formal Vibefication

1. This document is the human contract for Majestic `Memex`.
2. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
3. Authors SHALL NOT paste theorem statements from `lean/MemexProofs.lean` into this document as a substitute for those proofs.
4. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
5. Citations of Taking Don't Trust. Verify. Seriously SHALL include the canonical URL https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html .
6. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
7. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, leftover unstack, Residual heading, registry scan, Keagan back linking). `spec_check` is not meaning.

### 4.2 Crate and command

1. The crate name SHALL be `majestic`.
2. The installed command SHALL be `memex`.
3. Authors MUST NOT require a binary whose name is `majestic` in place of `memex`.
4. Search, ingest, stats, compress, decompress, local remote call, and HTTP serve SHALL be `memex` commands when those surfaces exist. This specification does not require a `memex PATTERN` alias that collides with those commands.

### 4.3 On disk magic and extension

1. An uncompressed Majestic `Memex` archive SHALL begin with eight ASCII bytes `MAJESTIC` followed by one version byte `0x01`.
2. Those nine bytes SHALL NOT be the Tech Tree magic `SSTECHTREE01`.
3. The archive file name SHALL use extension `.majestic`.
4. The archive file name SHALL NOT use extension `.sstt` as the Majestic `Memex` archive extension.
5. Authors MUST NOT treat a `.zst` companion as the mmap target. Default ingest SHALL write uncompressed `.majestic` when ingest exists.
6. Companion Lean SHALL encode the magic string, the version byte, the nine byte prefix length, and the `.majestic` extension, and SHALL prove those encodings distinct from Tech Tree magic and `.sstt`.

### 4.4 Data root

1. Archive data SHALL live under `$HOME/memex` unless an explicit output path is given for a single ingest.
2. A home scan of export sources SHALL NOT walk `$HOME/memex` as a source tree.
3. Authors MUST NOT copy live export JSON, live vaults, or live SQLite into the crate tree as the archive.
4. There is no silent default archive at `$HOME/memex/archive.majestic`.

### 4.5 Distinct from Tech Tree files

1. This specification is not the Tech Tree format. Tech Tree files remain specification [0011](0011_Surmount_Systems_Tech_Tree.md).
2. A conforming `memex` MAY later load a `.sstt` file for lookup. That load does not change the magic or extension of `.majestic` archives.
3. Authors SHALL NOT treat this specifications repository's Lake writer of `.sstt` files as a finished memex product.
4. This repository pins `btc-verified` as Form 1 under `ref/btc-verified`. Authors SHALL NOT vendor that tree into this Lake package.

### 4.6 Product honesty

1. The crate is a version 0.1 proof of concept still being built. Authors MUST NOT write that Majestic `Memex` is finished or ready for use.
2. Authors MUST NOT write that the crate never started or does not exist.
3. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
4. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
5. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
6. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
7. This Lake package includes a Lean writer of `.sstt` files. A Surmount product writer is not shipped. Authors MUST NOT write that a finished product writer is shipped.
8. fargo has no numbered specification and no assigned number.
9. SSSP has no numbered specification file and no assigned number.
10. Carbonado has no numbered specification file and no assigned number.
11. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). Legal Lean and Holy Lean remain named components without separate numbered specifications.
12. Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.

### 4.7 License of this specification versus the crate

1. This numbered specification and the Lean in this specifications repository are released under the Unlicense of this repository (`UNLICENSE.md`, as specified in [0009_PDOSS.md](0009_PDOSS.md)).
2. The Unlicense of this specifications repository SHALL NOT be read as a silent dedication of the crate tree at `~/majestic`.
3. The crate README tree includes `UNLICENSE.md`. That file is the crate's own dedication when present. It is not this repository dedicating that tree by citation.
4. Essays by Keagan McLelland (Proof of Keags) are not Unlicense grants of this repository.

### 4.8 Sibling encodings and named gate

1. Every published numbered markdown file at this repository root SHALL have a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root whose physical lines match that markdown, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
2. Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`.
3. Mixing those encodings with their proofs in one file is nonconforming as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
4. The Lean program `line_encodings_check` SHALL fail when a markdown line has no encoding or an encoding has no matching markdown line.
5. The named gate for this specifications repository remains the gate specified in [0007_CI.md](0007_CI.md):

```text
nix flake check "path:$PWD" --print-build-logs
```

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Numbered markdown is the contract humans read; the specification is also encoded in Lean; proofs live in separate Lean modules; Formal Vibefication citations keep the canonical Proof of Keags URLs; `spec_check` remains form and is not meaning (Clause 4.1).
2. The crate name is `majestic` and the installed command is `memex` (Clause 4.2).
3. Uncompressed archives begin with `MAJESTIC` plus byte `0x01`, use extension `.majestic`, and are not Tech Tree `.sstt` files (Clause 4.3).
4. Archive data lives under `$HOME/memex` except for an explicit single ingest output path; a home scan does not walk that data root as a source (Clause 4.4).
5. Tech Tree `.sstt` remains specification [0011](0011_Surmount_Systems_Tech_Tree.md); `memex` MAY later load a `.sstt` file; this Lake package includes a `.sstt` writer; `btc-verified` is a Form 1 pin at `ref/btc-verified`; the command at `~/majestic` is still a proof of concept (Clause 4.5).
6. The crate is treated as a version 0.1 proof of concept still being built and not ready for use; beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use; a `.sstt` producer is not shipped; fargo, SSSP, and Carbonado have no assigned specification numbers; Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md); a numbered Vocabulary file does not exist (Clause 4.6).
7. The Unlicense of this specifications repository is not treated as a silent grant over `~/majestic` (Clause 4.7).
8. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean`; proofs of those encodings live in `lean/Proofs_NNNN.lean`; the named gate in [0007_CI.md](0007_CI.md) remains the gate (Clause 4.8).

This specification is not itself a finished `memex` product. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. Checkable residual claims live in `lean/ResidualClaims.lean`, and this specification still carries its own residual clause. This clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no assigned specification number. This document does not invent a number for fargo. This document does not steal [0005](0005_CATE.md), [0006](0006_RSI.md), [0007](0007_CI.md), [0008](0008_Formal_Vibefication.md), [0009](0009_PDOSS.md), [0010](0010_Surmount_Systems.md), [0011](0011_Surmount_Systems_Tech_Tree.md), or 0012 for fargo.
2. The Surmount Systems System Prompt (SSSP) has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE ([0005_CATE.md](0005_CATE.md)). Number 0006 is RSI ([0006_RSI.md](0006_RSI.md)), not Carbonado. Number 0007 is Continuous Integration ([0007_CI.md](0007_CI.md)). Number 0008 is Formal Vibefication ([0008_Formal_Vibefication.md](0008_Formal_Vibefication.md)). Number 0009 is Public Domain Open Source Software (PDOSS) ([0009_PDOSS.md](0009_PDOSS.md)). Unlicense remains the license. Number 0010 is Surmount Systems ([0010_Surmount_Systems.md](0010_Surmount_Systems.md)). Number 0011 is Surmount Systems Tech Tree ([0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md)). Number 0012 is this specification. This document does not create a file for Carbonado.
4. Lean Machine is specified in [0013_Lean_Machine.md](0013_Lean_Machine.md). That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number [0009](0009_PDOSS.md) was briefly Vocabulary, then Unlicense, and is now Public Domain Open Source Software (PDOSS) by operator order. Unlicense remains the license. The word catalog lives in CATE ([0005_CATE.md](0005_CATE.md)). This document does not assign [0009](0009_PDOSS.md) to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.

### 6.2 Crate still being built

1. The crate at `~/majestic` is version 0.1. It is still being built. Ingest shapes, search flags, `MCP` tools, `ACP` local functions, HTTP bind, and `zstd` helpers named in that crate README may change. This specification does not freeze that README as a wire.
2. Named export shapes in that README (Grok dump JSON, `ChatGPT` conversations JSON, Telegram Desktop JSON, `grok-oss` session `JSONL`, `grok-oss` `sqlite` chats, agent reports, `Obsidian` vault, markdown tree) are crate work in progress. They are not a claim that every service export already ingests without loss.
3. Leftover `{account}.archive` files, `memex compress` writing `FILE.majestic.zst`, and `memex decompress` are crate details. They are not a second on disk magic.
4. Search uses an embedded `ripgrep` engine in that crate. It does not spawn `rg`. That engine is not the full `rg` CLI.
5. This document MUST NOT be read as claiming that product is ready for use.
6. This specifications repository does not wait on a finished `memex` command. The crate at `~/majestic` remains a version 0.1 proof of concept still being built. This document does not freeze a finished command as a named gate. Companion Lean encodes a mash of waiting on a finished `memex` command as `False`.

### 6.3 Format and product that are not shipped here

1. Specification [0011](0011_Surmount_Systems_Tech_Tree.md) specifies `.sstt`. This format is not `.sstt`. This Lake package includes a Lean writer (`lean/Sstt.lean`). That writer is not a shipped memex product. Magic `MAJESTIC` plus byte `0x01` and extension `.majestic` remain distinct from Tech Tree magic `SSTECHTREE01` and extension `.sstt`. A later load of a `.sstt` file does not mix those formats. Companion Lean encodes a mash of those formats as `False`. This document does not claim that product is finished.
2. Bitcoin `CompactSize` as proved in `btc-verified` is prior Lean proof for Tech Tree files. The Form 1 pin is `ref/btc-verified`. This Lake package does not vendor those theorems.
3. `repo_links_check` does not parse every HTML `href`. The floor is markdown `[text](target)` links. Reference style links are residual.
4. Bush 1945 is unpinned prior art. It is not under `ref/`. This effort does not add a Form 2 pin of that essay. Companion Lean does not encode Bush 1945 as a Clause 12 pin.

### 6.4 Product claims that are not ready for use

1. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in [0007_CI.md](0007_CI.md) ([0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3). This document does not claim that match already holds.
3. `lean/MemexSpec.lean` encodes selected claims. `lean/MemexProofs.lean` proves those claims. `0012_Majestic_Memex.lean` encodes the physical lines of this markdown file. `lean/Proofs_0012.lean` proves identities of that line encoding. Those modules are not a proof that the crate is finished. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use.
4. Companion Lean encodes clashes this document already states as `False`. A mash of `.majestic` archives with `.sstt` files is `False`. A mash of magic `MAJESTIC` with `SSTECHTREE01` is `False`. A mash of crate name `majestic` with command `memex` is `False`. A mash of this repository Unlicense covering `~/majestic` is `False`. A mash of spec encodings with proofs is `False`. A mash that the crate is ready for use is `False`. A mash that the crate never started is `False`. A mash of waiting on a finished `memex` command is `False`. A mash that a later load of `.sstt` makes a `.majestic` archive a Tech Tree file is `False`. A mash that the Lake `.sstt` writer is a shipped memex product is `False`. A mash that companion Lean proves the crate is finished is `False`. Those encodings are not a finished `memex` command.

### 6.5 Pins and licenses this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. [0002_Systems_Lean.md](0002_Systems_Lean.md) places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. `btc-verified` is a Form 1 pin of this repository's `ref/` at `ref/btc-verified`.
3. Formal Vibefication essays are cited by URL. They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Full license text is still not published on https://proofofkeags.com . Do not invent that license.
4. The Unlicense of this specifications repository does not silently cover `~/majestic`. That crate has its own `UNLICENSE.md`. Citing the crate README does not move that tree into this repository.

### 6.6 Earlier numbered specifications name this document

Numbered specifications [0005_CATE.md](0005_CATE.md), [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md), [0009_PDOSS.md](0009_PDOSS.md), [0010_Surmount_Systems.md](0010_Surmount_Systems.md), and [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md) name number 0012 as Majestic `Memex` (`0012_Majestic_Memex.md`) and as specified. The command at `~/majestic` is still a proof of concept. This 1.0.0 created `0012_Majestic_Memex.md` as a published registry file.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed.

This 0.1.0 later records leftover residual depth: this format is not `.sstt`; this specifications repository does not wait on a finished `memex` command; Bush 1945 stays unpinned; companion Lean encodes named clashes this document already states as `False`.

### 1.0.0 - 20260827

First publication of Majestic `Memex` as numbered specification 0012 with file name `0012_Majestic_Memex.md`. Records that this document is the human contract for crate `majestic`, command `memex`, on disk magic `MAJESTIC` plus byte `0x01`, extension `.majestic`, and data under `$HOME/memex`. Records that this format is not Tech Tree `.sstt` (specification [0011](0011_Surmount_Systems_Tech_Tree.md), magic `SSTECHTREE01`). Records that `memex` MAY later load a `.sstt` file. Records that the crate is a version 0.1 proof of concept still being built and is not ready for use. Records Formal Vibefication with canonical Proof of Keags URLs and back linking. Records that the Unlicense of this specifications repository does not silently dedicate `~/majestic`. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.

This 1.0.0 also records: CATE is specification [0005](0005_CATE.md); RSI is specification [0006](0006_RSI.md); Continuous Integration is specification [0007](0007_CI.md); Formal Vibefication is specification [0008](0008_Formal_Vibefication.md); Public Domain Open Source Software (PDOSS) is specification [0009](0009_PDOSS.md); Unlicense remains the license; the word catalog is owned by CATE as specification [0005](0005_CATE.md); a numbered Vocabulary file MUST NOT exist; Surmount Systems is specification [0010](0010_Surmount_Systems.md); Surmount Systems Tech Tree is specification [0011](0011_Surmount_Systems_Tech_Tree.md); this specification is number 0012; fargo has no assigned specification number; SSSP has no assigned specification number; Carbonado has no assigned number; Lean Machine is specified as [0013_Lean_Machine.md](0013_Lean_Machine.md); every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; this document does not claim that a finished `memex` product exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in [0009_PDOSS.md](0009_PDOSS.md). Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository. This grant does not by itself dedicate the crate tree at `~/majestic`.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under [0000_spec.md](0000_spec.md) Clause 12. Citations of this work SHALL keep those publisher links (back linking).
