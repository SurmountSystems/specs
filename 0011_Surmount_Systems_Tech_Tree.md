# Surmount Systems Tech Tree

> v0.1.0 - 20260831
>
> Graph of relationships among numbered specifications, sibling Lean encodings, materials under `ref/`, `SOURCE.md`, skills, and other files this repository cites, with no directed cycle, for lookup in the style of a later personal archive

## 1. Scope

This document specifies the Surmount Systems Tech Tree: a graph of relationships among numbered specifications, sibling Lean line encodings, materials under `ref/`, `SOURCE.md` pin notes, project skills, and other files this repository cites, with no directed cycle, so a later `memex` product can look those relationships up.

This specification is number 0011. The file name is `0011_Surmount_Systems_Tech_Tree.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/TechTreeSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/TechTreeProofs.lean`. Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0011_Surmount_Systems_Tech_Tree.lean`. Those encodings are not this specification.

This document specifies a binary file format whose extension is `.sstt`. This Lake package includes a Lean writer and reader of `.sstt` files (`lean/Sstt.lean`, command `sstt_write`). That writer is not a shipped Surmount product. This document does not claim that a conforming Surmount Systems product exists. This document does not claim that Slake emit already matches object files as identical bytes. fargo has no assigned specification number. This document does not create a numbered file for fargo. The Surmount Systems System Prompt (SSSP) has no assigned specification number. This document does not create a numbered file for SSSP. The Carbonado Network Protocol has no assigned specification number. This document does not create a numbered file for the Carbonado Network Protocol. Lean Machine is specified in `0013_Lean_Machine.md`. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

### 1.1 Status of this document

1. This document is normative for the Tech Tree as a graph of those relationships with no directed cycle, for the `.sstt` binary format (magic bytes, Bitcoin canonical count prefixes, nodes, directed edges), for treating the encoded graph as a graph with no directed cycle, for citing Bitcoin canonical count encoding as prior Lean proof outside this repository, for requiring markdown path links in this repository to resolve to a path that exists as specified in `0000_spec.md`, and for residual honesty that a Surmount product writer is not shipped, that this Lake package includes a `.sstt` writer, that number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified while the command at `~/majestic` is still a proof of concept, and that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0011. The file name is `0011_Surmount_Systems_Tech_Tree.md`.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. Recursive Self Improvement (RSI) is specified in `0006_RSI.md`. RSI is specification 0006. RSI is not this specification.
6. Continuous Integration and stack consistency is specified in `0007_CI.md`. That document is specification 0007. That document is not this specification.
7. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
8. Public Domain Open Source Software is specified in `0009_PDOSS.md`. That document is specification 0009. That document is not this specification. Unlicense remains the license.
9. Surmount Systems stack composition is specified in `0010_Surmount_Systems.md`. That document is specification 0010. That document is not this specification.
10. First publication of this specification as a numbered document is version 1.0.0 dated 20260826.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md` and as stated by Keagan McLelland (Proof of Keags), requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/TechTreeSpec.lean` encode selected claims such as this document's identity as specification 0011 with file name `0011_Surmount_Systems_Tech_Tree.md`, the magic bytes `SSTECHTREE01`, the file extension `.sstt`, `CompactSize` markers and shortest form, node kinds, edge kinds, and that the encoded graph MUST be a graph with no directed cycle.
3. Proofs of those encodings live in `lean/TechTreeProofs.lean`. Golden `CompactSize` vectors and encode then decode for small values live there and in the test executable. Full `UInt64` `CompactSize` proof remains in `btc-verified`, not in this Lake package.
4. The Lean module `Surmount` remains the single composition proof over stack identities. This specification's identity in that composition is specification 0011.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.
6. The Lean program `repo_links_check` fails when a numbered specification (and README) contains a markdown path link to material in this repository whose target does not exist. That program is not a writer of `.sstt` files.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
3. Recursive Self Improvement remains [0006_RSI.md](0006_RSI.md).
4. Continuous Integration and stack consistency remains [0007_CI.md](0007_CI.md).
5. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
6. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license.
7. Surmount Systems stack composition remains [0010_Surmount_Systems.md](0010_Surmount_Systems.md).
8. Systems Lean and Slake remain [0002_Systems_Lean.md](0002_Systems_Lean.md).
9. beastdb remains [0003_beastdb.md](0003_beastdb.md).
10. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
11. fargo has no numbered specification in this repository and no assigned number. This document does not invent a number for fargo.
12. The Carbonado Network Protocol has no numbered specification in this repository and no assigned number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`). Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is this specification. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document does not steal those numbers for fargo or for Carbonado.
13. SSSP has no assigned specification number. This document does not create a numbered file for SSSP.
14. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. That document is not this specification.
15. The word catalog remains [0005_CATE.md](0005_CATE.md). CATE is specification 0005. Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. A numbered Vocabulary file MUST NOT exist. Mentions of Vocabulary as a published specification 0009 do not conform.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, Form 1 `ref/btc-verified`, and the Form 2 artifacts used by other numbered specifications). Git, GitHub Actions, Lean 4, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Formal Vibefication research pages are cited by URL (Clause 2.2). They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Bitcoin `CompactSize` as proved in `btc-verified` is prior Lean proof (Clause 2.2). The Form 1 pin is `ref/btc-verified` (pin notes: `ref/btc-verified.SOURCE`).

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document, including Clause 11.4 on markdown path links in this repository).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
4. Surmount specification `0005_CATE.md` (Concise American Technical English).
5. Surmount specification `0006_RSI.md` (Recursive Self Improvement).
6. Surmount specification `0008_Formal_Vibefication.md` (Formal Vibefication: Lean spec encodings separate from proofs).
7. Surmount specification `0010_Surmount_Systems.md` (Surmount Systems stack composition).

### 2.2 Prior art (informative)

This subsection is informative. It names works a reader may already know. It does not cite them as external specifications under `0000_spec.md` Clause 12. They SHALL NOT be treated as indispensable for the application of this document as Clause 12 pins.

1. Formal Vibefication, Keagan McLelland (Proof of Keags), 2026-05-12, https://proofofkeags.com/research/2026-05-12-formal-vibefication.html (accessed: 2026-08-26).
2. Taking Don't Trust. Verify. Seriously, Keagan McLelland (Proof of Keags), 2026-07-20, https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html (accessed: 2026-08-26).
3. Bitcoin `CompactSize` as specified and proved in Lean in `btc-verified`, Lean module `BtcVerified.CompactSize`, theorems `decode_encode`, `decode_canonical`, and `encode_length_le`. That tree is not copied into this Lake package. The Form 1 pin is `ref/btc-verified`.

Those Proof of Keags pages are research. They are not Unlicense grants. They are not permission to vendor those essays as Form 2 copies under `ref/`. Citations of that work SHALL keep those publisher links (back linking).

## 3. Definitions

### 3.1 Surmount Systems Tech Tree

The graph with no directed cycle specified by this document whose nodes are numbered specifications, sibling Lean line encodings, materials under `ref/`, `SOURCE.md` pin notes, project skills, and other files this repository cites, and whose directed edges are the relationship kinds in Clause 3.5.

### 3.2 Encoded graph

The graph written in a `.sstt` file: magic, `CompactSize` counts, node records, and directed edge records. The encoded graph MUST be a graph with no directed cycle. It is not the same object as the markdown citation graph among numbered specifications.

### 3.3 Markdown citation graph

The graph whose vertices are files this repository authors, and whose edges are markdown `[text](target)` path links after skipping `http://` and `https://`. Numbered specifications MAY cite each other in both directions (for example `0000_spec.md` and `0005_CATE.md`). That citation graph MAY contain directed cycles. It is not the encoded graph.

### 3.4 `CompactSize`

Bitcoin canonical `CompactSize`: a variable length unsigned integer used as a count or length prefix. Markers and shortest form are Clause 4.3. Prior machine checked proof of the `UInt64` encoding lives in `btc-verified` (Clause 2.2). This Lake package restates the laws and proves encode then decode for small values named in Clause 4.3.

### 3.5 Node kinds and edge kinds

Node kinds:

1. Numbered specification markdown at this repository root.
2. Sibling Lean line encoding `NNNN_descriptive_name.lean` at this repository root.
3. A pin under `ref/` (Form 1 submodule or Form 2 official publisher artifact).
4. A `SOURCE.md` pin note (or Form 1 sibling `.SOURCE` file).
5. A project skill under `.agents/skills/`.
6. Another file this repository cites that is none of the kinds above.

Edge kinds:

1. `link`: a markdown path link from one file to another file in this repository.
2. `cites`: a citation of another numbered specification or pin.
3. `siblingEncoding`: the pair of numbered markdown and its sibling `NNNN_descriptive_name.lean`.
4. `pin`: an edge from a specification to a Clause 12 pin under `ref/`.

### 3.6 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.7 Sibling line encoding

A Lean module named `NNNN_descriptive_name.lean` that sits next to numbered markdown `NNNN_descriptive_name.md` at this repository root and holds a Lean value for every physical line of that markdown, as specified in `0008_Formal_Vibefication.md`. For this specification that sibling is `0011_Surmount_Systems_Tech_Tree.lean`. Proofs of that encoding live in `lean/Proofs_0011.lean`. `lean/TechTreeSpec.lean` is the meaning encoding. It is not the line encoding of this markdown file.

### 3.8 Producer

A program that writes a `.sstt` file from the files in this repository. This document specifies the format. This Lake package includes a Lean writer (`lean/Sstt.lean`, command `sstt_write`). A Surmount product writer is not shipped.

## 4. Core requirements

### 4.1 Human contract and Formal Vibefication

1. This document is the human contract for the Surmount Systems Tech Tree.
2. Numbered markdown in this specifications repository is the contract humans read. The specification SHALL also be encoded in Lean as declarations of what must be true. Proofs SHALL live in separate Lean modules. Lean proofs are not the specification. Numbered markdown is not a substitute for those encodings. They SHALL stay separate in this repository as specified in `0008_Formal_Vibefication.md`.
3. Authors SHALL NOT paste theorem statements from `lean/TechTreeProofs.lean` into this document as a substitute for those proofs.
4. Citations of Formal Vibefication SHALL include the canonical URL https://proofofkeags.com/research/2026-05-12-formal-vibefication.html .
5. Citations of Taking Don't Trust. Verify. Seriously SHALL include the canonical URL https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html .
6. A numbered specification that names Keagan or Proof of Keags MUST also contain the host `proofofkeags.com`.
7. `spec_check` remains form (ASCII, tabs, RFC 2119, spelling, leftover unstack, Residual heading, registry scan, Keagan back linking). `spec_check` is not meaning.

### 4.2 Binary format (`.sstt`)

A Tech Tree file SHALL use the extension `.sstt`. The payload SHALL be, in this order:

1. Magic: twelve ASCII bytes `SSTECHTREE01` and no zero byte in those twelve bytes.
2. A `CompactSize` count of nodes.
3. That many node records. Each node record SHALL include a `CompactSize` node identity, a `CompactSize` node kind (Clause 3.5), a `CompactSize` byte length of the path, and that many path bytes as UTF-8 that is also pure ASCII in this repository.
4. A `CompactSize` count of directed edges.
5. That many edge records. Each edge record SHALL include a `CompactSize` source node identity, a `CompactSize` destination node identity, and a `CompactSize` edge kind (Clause 3.5).

A writer of `.sstt` files exists in this Lake package (`lean/Sstt.lean`). Authors MUST NOT claim a Surmount product writer is shipped.

### 4.3 `CompactSize`

Lengths and counts in a `.sstt` file SHALL use Bitcoin canonical `CompactSize`.

1. For a value `n` less than 253, the encoding is one byte whose value is `n` (markers `0x00` through `0xfc`).
2. For a value `n` at least 253 and less than 65536, the encoding is marker `0xfd` followed by two payload bytes in least significant byte first order holding `n`.
3. For a value `n` at least 65536 and less than 4294967296, the encoding is marker `0xfe` followed by four payload bytes in least significant byte first order holding `n`.
4. For a value `n` at least 4294967296, the encoding is marker `0xff` followed by eight payload bytes in least significant byte first order holding `n`.
5. The encoding MUST be the shortest form that can hold the value. A decoder MUST reject a longer form of a value that fits a shorter form.

Golden vectors that a companion encoding and test SHALL match (same bytes as `btc-verified`):

1. `0` encodes as the single byte `0x00`.
2. `252` encodes as the single byte `0xfc`.
3. `253` encodes as `0xfd 0xfd 0x00`.
4. `65535` encodes as `0xfd 0xff 0xff`.
5. `65536` encodes as `0xfe 0x00 0x00 0x01 0x00`.

A decoder MUST reject the non shortest form `0xfd 0xfc 0x00`.

This Lake package SHALL restate those laws as spec encodings and SHALL prove encode then decode for the golden values and for values less than 253 that this package can prove without `mathlib`. Full `UInt64` theorems `decode_encode`, `decode_canonical`, and `encode_length_le` remain in `btc-verified`. This repository pins that tree as Form 1 at `ref/btc-verified`. This Lake package does not vendor those theorems.

### 4.4 Encoded graph MUST be a graph with no directed cycle

1. The encoded graph (Clause 3.2) MUST be a graph with no directed cycle: there SHALL be no directed cycle in the edge relation used as the tree.
2. If a producer would emit a cycle, that output does not conform.
3. The markdown citation graph (Clause 3.3) MAY contain directed cycles. Those cycles do not by themselves make this specification fail. A producer (when one exists) SHALL choose an orientation with no directed cycle or drop edges so the encoded graph has no directed cycle.
4. Companion Lean SHALL encode a cycle check on finite graphs of natural number identities and SHALL prove small fixtures: the empty graph has no directed cycle, a chain has no directed cycle, and a two node loop has a directed cycle.
5. This slice does not require `repo_links_check` to fail the whole repository when numbered specifications cite each other in both directions.

### 4.5 Markdown path links in this repository

1. Markdown links that reference material present in this repository (relative links, paths under `ref/`, sibling `.lean` files, numbered specifications, and similar path targets) SHALL resolve to a path that exists.
2. That rule is also Clause 11.4 of `0000_spec.md`. Authors of numbered specifications SHALL follow it.
3. The Lean program `repo_links_check` SHALL scan numbered `NNNN_*.md` files at the repository root, and SHALL scan `README.md`, for markdown links of the form `[text](target)`.
4. That program SHALL skip targets that begin with `http://` or `https://`.
5. That program SHALL resolve remaining targets relative to the file that contains the link, or relative to the repository root, and SHALL fail when the resolved path does not exist.
6. A target that is only a fragment (`#heading`) is the same file and SHALL NOT fail for missing path.
7. A target that combines a path and a fragment SHALL be checked on the path before the fragment.
8. Residual: this floor does not parse every HTML `href`. It does not parse reference style markdown links. It does not treat a remote URL as a path in this repository.

### 4.6 Product honesty and unassigned work

1. beastdb work is ongoing and is not ready for use. Authors MUST NOT write that beastdb never started or does not exist.
2. SSSSS work is ongoing and is not ready for use. Authors MUST NOT write that SSSSS never started or does not exist.
3. Slake work is ongoing and is not ready for use. Authors MUST NOT write that Slake never started or does not exist.
4. Continuous Integration work is ongoing and is not ready for use. Authors MUST NOT write that Continuous Integration never started or does not exist.
5. This Lake package includes a Lean writer of `.sstt` files. A Surmount product writer is not shipped. Authors MUST NOT write that a finished product writer is shipped.
6. fargo has no numbered specification and no assigned number.
7. SSSP has no numbered specification file and no assigned number.
8. The Carbonado Network Protocol has no numbered specification file and no assigned number.
9. Lean Machine is specified in `0013_Lean_Machine.md`. Legal Lean and Holy Lean remain named components without separate numbered specifications.
10. Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.
11. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. Authors MUST NOT write that the command is finished.

### 4.7 Sibling encodings and named gate

1. Every published numbered markdown file at this repository root SHALL have a sibling Lean spec encoding `NNNN_descriptive_name.lean` at that same root whose physical lines match that markdown, as specified in `0008_Formal_Vibefication.md`.
2. Proofs of those encodings SHALL live in `lean/Proofs_NNNN.lean`.
3. Mixing those encodings with their proofs in one file is nonconforming as specified in `0008_Formal_Vibefication.md`.
4. The Lean program `line_encodings_check` SHALL fail when a markdown line has no encoding or an encoding has no matching markdown line.
5. The named gate for this specifications repository remains the gate specified in `0007_CI.md`:

```text
nix flake check "path:$PWD" --print-build-logs
```

## 5. Conformance

Work that claims this specification conforms if and only if all of the following hold:

1. Numbered markdown is the contract humans read; the specification is also encoded in Lean; proofs live in separate Lean modules; Formal Vibefication citations keep the canonical Proof of Keags URLs; `spec_check` remains form and is not meaning (Clause 4.1).
2. A `.sstt` file uses magic `SSTECHTREE01`, `CompactSize` counts, node records, and directed edge records as in Clause 4.2; a Surmount product writer is not claimed shipped; this Lake package includes a Lean writer (Clause 4.2).
3. Lengths and counts use canonical `CompactSize` shortest form; golden vectors match; this Lake package restates the laws and proves small encode then decode cases; full `UInt64` proof remains in `btc-verified` (Clause 4.3).
4. The encoded graph is a graph with no directed cycle; markdown citation cycles are not treated as that encoded graph (Clause 4.4).
5. Markdown path links in this repository resolve to a path that exists; `repo_links_check` fails on a missing path target; remote `http://` and `https://` targets are skipped (Clause 4.5).
6. beastdb, SSSSS, Slake, and Continuous Integration are treated as ongoing and not ready for use; a Surmount product `.sstt` writer is not shipped; this Lake package includes a Lean writer; fargo, SSSP, and Carbonado have no assigned specification numbers; Lean Machine is specified in `0013_Lean_Machine.md`; a numbered Vocabulary file does not exist; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified while the command at `~/majestic` is still a proof of concept (Clause 4.6).
7. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean`; proofs of those encodings live in `lean/Proofs_NNNN.lean`; the named gate in `0007_CI.md` remains the gate (Clause 4.7).

This specification is not itself a conforming Tech Tree producer. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped engine.

Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. Checkable residual claims live in `lean/ResidualClaims.lean`, and this specification still carries its own residual clause.

### 6.1 Unpublished specifications and unassigned numbers

1. fargo has no assigned specification number. This document does not create a numbered file for fargo. This document does not invent a number for fargo. This document does not steal 0005, 0006, 0007, 0008, 0009, 0010, or 0011 for fargo.
2. SSSP has no assigned specification number. This document does not create a numbered file for SSSP. It has no numbered specification file in this repository. It has no assigned specification number. This document MUST NOT be read as creating SSSP.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. Number 0005 is CATE (`0005_CATE.md`). Number 0006 is RSI (`0006_RSI.md`), not Carbonado. Number 0007 is Continuous Integration (`0007_CI.md`). Number 0008 is Formal Vibefication (`0008_Formal_Vibefication.md`). Number 0009 is Public Domain Open Source Software (PDOSS) (`0009_PDOSS.md`). Unlicense remains the license. Number 0010 is Surmount Systems (`0010_Surmount_Systems.md`). Number 0011 is this specification. This document does not create a file for Carbonado.
4. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Legal Lean and Holy Lean remain named components without separate numbered specifications.
5. Number 0009 was briefly Vocabulary, then Unlicense, and is now Public Domain Open Source Software (PDOSS) by operator order. Unlicense remains the license. The word catalog lives in CATE (`0005_CATE.md`). This document does not assign 0009 to fargo or to Carbonado. A numbered Vocabulary file MUST NOT exist. The form checker MUST fail if that file is present.
6. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept. This document MUST NOT be read as claiming that product is ready for use.

### 6.2 Format and proof that are not shipped as product

1. This document specifies the `.sstt` format. This Lake package includes a Lean writer and reader of `.sstt` files (`lean/Sstt.lean`, command `sstt_write`). That writer is not a shipped memex product. Number 0012 is specified. The command at `~/majestic` is still a proof of concept. Work on the writer and on CompactSize in this Lake package is not finished. Treating that Lake writer as a shipped Surmount product is Cons False in the Tech Tree proofs module. Wiring a producer into a product tree stays leftover.
2. Bitcoin `CompactSize` is specified and proved for `UInt64` in `btc-verified` (`BtcVerified.CompactSize`, theorems `decode_encode`, `decode_canonical`, `encode_length_le`). The Form 1 pin is `ref/btc-verified`. This specifications repository does not vendor that tree into this Lake package. This Lake package restates the markers, least significant byte first payload, and shortest form, and proves golden vectors and small encode then decodes without `mathlib`. Full `UInt64` coverage remains residual to `btc-verified`. Copying those full `UInt64` theorems into this Lake package is Cons False in that same module. Full `UInt64` CompactSize theorems stay in `ref/btc-verified`. This Lake package MUST NOT copy those theorems.
3. The encoded graph MUST be a graph with no directed cycle. Markdown citation among numbered specifications MAY cycle. `repo_links_check` in this slice checks that path targets exist. It does not fail the repository because `0000_spec.md` and `0005_CATE.md` cite each other. A producer, when one exists, still MUST emit an encoded graph with no directed cycle.
4. `repo_links_check` does not parse every HTML `href`. The floor is markdown `[text](target)` links. Reference style links are residual.

### 6.3 Product claims that are not ready for use

1. The products named here are ongoing and are not ready for use. It MUST NOT be read as claiming that those products never started or do not exist.
2. Byte identity of Slake emit is a requirement on a conforming Systems Lean and Slake product as specified in `0007_CI.md` and in [0002_Systems_Lean.md](0002_Systems_Lean.md) Clause 6.3. This document does not claim that match already holds.
3. `lean/TechTreeSpec.lean` encodes selected claims. `lean/TechTreeProofs.lean` proves those claims. `0011_Surmount_Systems_Tech_Tree.lean` encodes the physical lines of this markdown file. `lean/Proofs_0011.lean` proves identities of that line encoding. Those modules are not a proof that a `.sstt` producer exists. They are not a proof that beastdb, SSSSS, Slake, or Continuous Integration are ready for use. Mixing those encodings with their proofs in one mash is Cons False in the Tech Tree proofs module. Those modules are not a proof that a producer is wired into a product tree.

### 6.4 Pins this document does not add

1. Lean 4, Idris 2, CompCert, and Rust are not pins of this specifications repository's `ref/`. `0002_Systems_Lean.md` places those Form 1 pins in the Systems Lean product tree. This repository MUST NOT copy those four trees into this repository's `ref/`.
2. `btc-verified` is a Form 1 pin of this repository's `ref/` at `ref/btc-verified`. Full `UInt64` CompactSize theorems remain in that tree. This Lake package does not restate those theorems.
3. Formal Vibefication essays are cited by URL. They are not Clause 12 pins. This repository does not vendor those essays as Form 2 copies under `ref/`. Full license text is still not published on https://proofofkeags.com . Do not invent that license.

### 6.5 Earlier numbered specifications name this document

Numbered specifications `0005_CATE.md`, `0008_Formal_Vibefication.md`, `0009_PDOSS.md`, and `0010_Surmount_Systems.md` name number 0011 as Surmount Systems Tech Tree (`0011_Surmount_Systems_Tech_Tree.md`). They do not steal 0011 for fargo. Number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed.

### 1.0.0 - 20260826

First publication of Surmount Systems Tech Tree as numbered specification 0011 with file name `0011_Surmount_Systems_Tech_Tree.md`. Records that this document is the human contract for a graph of relationships among numbered specifications, sibling Lean encodings, materials under `ref/`, `SOURCE.md`, skills, and other cited files, with no directed cycle, for lookup in the style of a `memex`. Specifies the `.sstt` binary format with magic `SSTECHTREE01`, `CompactSize` counts, nodes, and directed edges. Requires the encoded graph to be a graph with no directed cycle. Records that markdown citation among numbered specifications MAY cycle and is not that encoded graph. Restates Bitcoin canonical `CompactSize` and golden vectors; full `UInt64` proof remains in `btc-verified` and is pinned as Form 1 at `ref/btc-verified`. Requires markdown path links in this repository to resolve, checked by `repo_links_check`. Records that a Surmount product writer is not shipped and that this Lake package includes a Lean writer. Records Formal Vibefication with canonical Proof of Keags URLs and back linking. Requires residual honesty that beastdb, SSSSS, Slake, and Continuous Integration are ongoing and not ready for use.

This 1.0.0 also records: CATE is specification 0005; RSI is specification 0006; Continuous Integration is specification 0007; Formal Vibefication is specification 0008; Public Domain Open Source Software (PDOSS) is specification 0009; Unlicense remains the license; the word catalog is owned by CATE as specification 0005; a numbered Vocabulary file MUST NOT exist; Surmount Systems is specification 0010; this specification is number 0011; number 0012 is Majestic `Memex` (`0012_Majestic_Memex.md`) and is specified. The command at `~/majestic` is still a proof of concept; fargo has no assigned specification number; SSSP has no assigned specification number; Carbonado has no assigned number; Lean Machine is specified as `0013_Lean_Machine.md`; every published numbered markdown file has a sibling `NNNN_descriptive_name.lean` whose physical lines match that markdown, with proofs in `lean/Proofs_NNNN.lean`, checked by `line_encodings_check`; this document does not claim that a conforming Tech Tree producer exists.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).
