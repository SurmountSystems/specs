# Anunnaki Encoding

> v0.1.0 - 20260920
>
> Frequency ranked lossless language encoding that maps CATE identities onto rank pages, lets SSSSS language runs wear a compact skin, and is a candidate compact text encoding inside Majestic Memex

## 1. Scope

This document specifies Anunnaki Encoding: a lossless encoding of normalized language as a header that describes byte layout with a bit template, payload bytes that index frequency ranked vocabulary tables, and a residual plane that stores repeated surface characters so decode rebuilds the original text.

This specification is number 0014. The file name is `0014_Anunnaki_Encoding.md`.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims are encoded in Lean under `lean/AnunnakiSpec.lean` (see Clause 1.2). Proofs of those encodings live under `lean/AnunnakiProofs.lean`. Every published numbered markdown file at this repository root has a sibling line encoding `NNNN_descriptive_name.lean` at that same root, with proofs in `lean/Proofs_NNNN.lean`. This document's sibling is `0014_Anunnaki_Encoding.lean`. Those encodings are not this specification.

This document clarifies three published specifications. It does not replace them.

1. Concise American Technical English (CATE) remains `0005_CATE.md`. CATE owns LanguageID, WordID, and the word catalog. Anunnaki Encoding owns frequency rank pages and the bitstream. Adding a catalog token is a CATE event. Moving a lemma between rank pages is an Anunnaki migration.
2. Surmount Systems Smart Symbolic Supercompiler (SSSSS) remains `0004_SSSSS.md`. SSSSS owns language runs, sequential WordID as primary identity, and the neurosymbolic harness. Anunnaki Encoding is a compact skin those runs MAY wear. A neural path that attends rank codes MUST still reduce accepted proposals to sequential LanguageID and WordID values as specified in `0004_SSSSS.md` Clause 4.4.
3. Majestic Memex remains `0012_Majestic_Memex.md`. That document already names lossless ingest and encoding that tries to stay compact. Anunnaki Encoding is a candidate encoding for text inside a `.majestic` archive. It MUST NOT replace magic `MAJESTIC` plus byte `0x01`, extension `.majestic`, or Tech Tree `.sstt` files.

ENKI remains the index. Anunnaki Encoding is the bitstream. This document MUST NOT treat those two names as one object. ENKI has no numbered specification.

This document does not claim a conforming encoder. This document does not claim that a conforming Lean Machine exists. This document does not assign RDPS, FilterScript, or Carbonado Network Protocol. Number 0015 is not this specification and is not assigned here.

### 1.1 Status of this document

1. This document is normative for the identity of Anunnaki Encoding as specification 0014, the split between CATE identity and Anunnaki rank, the width template, ones padding of unused template bits, payload pages of 256 and 65536, repeat character run length as a residual plane, encode then decode identity, Huffman coding as measurement and not the lemma spine, the migration predicate that a later table is accepted only when a Lean check shows the new encoding is not longer on a pinned corpus, one LanguageID for one language, spelling tables that stay isomorphic at the frequency ranked word number, and decode that selects a spelling table by the user's preference.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.
3. This specification is number 0014. The file name is `0014_Anunnaki_Encoding.md`. First publication of this specification as a numbered document is version 0.1.0 dated 20260920.
4. Concise American Technical English (CATE) is specified in `0005_CATE.md`. CATE is specification 0005. CATE is not this specification.
5. SSSSS is specified in `0004_SSSSS.md`. SSSSS is specification 0004. SSSSS is not this specification.
6. Formal Vibefication is specified in `0008_Formal_Vibefication.md`. That document is specification 0008. That document is not this specification.
7. Public Domain Open Source Software is specified in `0009_PDOSS.md`. That document is specification 0009. That document is not this specification. Unlicense remains the license.
8. Majestic Memex is specified in `0012_Majestic_Memex.md`. That document is specification 0012. That document is not this specification.
9. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. That document is not this specification.
10. Huffman coding MAY be measured on a pinned corpus. Huffman coding MUST NOT replace payload bytes as the lemma spine.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md` and as stated by Keagan McLelland (Proof of Keags), requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

Canonical pages:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/AnunnakiSpec.lean` encode selected claims such as this document's identity as specification 0014 with file name `0014_Anunnaki_Encoding.md`, ENKI as the index, Anunnaki as the bitstream, CATE as specification 0005, SSSSS as specification 0004, Majestic Memex as specification 0012, ones padding that rejects a claimed pad containing a zero, payload pages of 256 and 65536, Huffman coding as measurement only, that one language keeps one LanguageID, that a dialect does not require a new LanguageID, that two spelling tables for one language are isomorphic at the frequency ranked word number, that the user's preference selects which table decode uses, and that a mash of spec encodings plus proofs in one module does not conform.
3. Proofs of those encodings live in `lean/AnunnakiProofs.lean`.
4. The sibling line encoding of this markdown is `0014_Anunnaki_Encoding.lean`. Proofs of that line encoding live in `lean/Proofs_0014.lean`.
5. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, leftover unstack phrases, Residual heading, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker. `spec_check` is form, not meaning.

### 1.3 Documents this specification does not replace

1. Form rules remain [0000_spec.md](0000_spec.md). That document points at `0005_CATE.md` for CATE. Clause 11.4 of that document requires markdown path links in this repository to resolve.
2. Systems Lean remains [0002_Systems_Lean.md](0002_Systems_Lean.md).
3. beastdb remains [0003_beastdb.md](0003_beastdb.md).
4. SSSSS remains [0004_SSSSS.md](0004_SSSSS.md).
5. Concise American Technical English remains [0005_CATE.md](0005_CATE.md). Leftover unstack remains nonconforming under that specification.
6. Formal Vibefication remains [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
7. Public Domain Open Source Software remains [0009_PDOSS.md](0009_PDOSS.md). Unlicense remains the license.
8. Majestic Memex remains [0012_Majestic_Memex.md](0012_Majestic_Memex.md).
9. Lean Machine remains [0013_Lean_Machine.md](0013_Lean_Machine.md).
10. ENKI has no numbered specification. This document names it only to keep the index distinct from this encoding.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.
3. Surmount specification `0000_spec.md`.
4. Surmount specification `0004_SSSSS.md`.
5. Surmount specification `0005_CATE.md`.
6. Surmount specification `0008_Formal_Vibefication.md`.
7. Surmount specification `0012_Majestic_Memex.md`.
8. Surmount specification `0013_Lean_Machine.md`.

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

## 3. Definitions

### 3.1 Anunnaki Encoding

The encoding specified by this document: header, width template, payload pages, repeat character residual, and the Lean migration predicate.

### 3.2 ENKI

The index named beside this encoding. ENKI is not the bitstream. ENKI has no numbered specification.

### 3.3 Stack program

A program in machine code that handles bits and bytes. It is the engine that walks a header and a payload. It is not the header. It is not the width template. This specification does not define an instruction set for that program.

### 3.4 Header

The language prefix together with the width template and the stored template bit length.

### 3.5 Language prefix

The field that selects which language's tables the following payload indices hit. LanguageID values remain as specified in `0004_SSSSS.md` and `0005_CATE.md`. One language keeps one LanguageID. A dialect does not get a different LanguageID. A dialect spelling is not a language change.

### 3.6 Width template

A sequence of bit arms that describe how many payload bytes each next item occupies.

### 3.7 Width arm

One of:

```
0        next payload item is 1 byte
10       next payload item is 2 bytes
110      next payload item is 3 bytes
1110     next payload item is 4 bytes
```

Zero terminates the count. Each one adds one payload byte. The same rule continues at five bytes and beyond as further ones then a zero, up to the cap in Clause 4.4.

### 3.8 Payload

Bytes only. Each item is an index into the frequency ranked table for that language and that width.

### 3.9 Page 0

The table of the 256 highest frequency lemmas of one language. A page 0 index is one payload byte.

### 3.10 Page 1

The table of the next 65536 lemmas of that language. A page 1 index is two payload bytes.

### 3.11 Rank

The position of a lemma in a page. Rank is not WordID. Variations of spelling are an isomorphism between vocabulary dictionary tables for one language. Different tables are maintained. The frequency ranked word number stays the same across those tables.

### 3.12 WordID

The sequential catalog identity specified in `0004_SSSSS.md` and `0005_CATE.md`. Hashing MUST NOT be primary identity.

### 3.13 Repeat character residual

A plane of (character, count) pairs that restores runs of spaces, tabs, and other repeated surface characters.

### 3.14 Symbol residual

A separate plane for capitalization, punctuation, and other marks that are not repeat runs.

### 3.15 Migration

A change of tables or of rank assignment. A migration is accepted only when a Lean check shows that re-encoding a pinned corpus is not longer than the previous encoding.

### 3.16 Ones padding

Unused bits in the last packed template byte set to one. A finished arm always ends in zero, so trailing ones with no closing zero are padding, not an arm.

## 4. Core clauses

### 4.1 Relation to CATE

1. A conforming Anunnaki encoder MUST treat CATE WordID and LanguageID as catalog identity.
2. A conforming Anunnaki encoder MUST treat page index as a rank of a WordID, not as a replacement WordID. Variations of spelling MUST be an isomorphism between vocabulary dictionary tables for one language. Different tables MUST be maintained. The frequency ranked word number MUST stay the same across those tables.
3. Adding a token to the catalog MUST be recorded as a CATE event.
4. Moving a lemma from one page to another MUST be recorded as an Anunnaki migration and MUST satisfy Clause 4.7.
5. This document MUST NOT publish a numbered Vocabulary file. That ban remains `0005_CATE.md`.
6. This document MUST NOT replace `0005_CATE.md`.

### 4.2 Relation to SSSSS

1. A language run as specified in `0004_SSSSS.md` MAY be serialized with Anunnaki Encoding.
2. A LanguageID prefix MUST appear when the language changes, including at the start of a stream, as specified in `0004_SSSSS.md` Clause 4.1 item 2. A dialect spelling is not a language change. A dialect MUST NOT get a different LanguageID.
3. Neural proposals that arise from attending Anunnaki ranks MUST be reduced to sequential LanguageID and WordID values before acceptance, as specified in `0004_SSSSS.md` Clause 4.4.
4. The symbolic interface MUST perform decode when the header, the tables, and the payload are well formed. The neural path MUST NOT be required for that decode.
5. This document MUST NOT be read as a second SSSSS specification. This document MUST NOT replace `0004_SSSSS.md`.

### 4.3 Relation to Majestic Memex

1. Anunnaki Encoding MAY later be used as the compact text encoding inside a `.majestic` archive.
2. Anunnaki Encoding MUST NOT change magic `MAJESTIC` plus byte `0x01`.
3. Anunnaki Encoding MUST NOT use extension `.sstt` as the Memex archive extension.
4. Whether compact Anunnaki is default ingest or a later `memex compress` command remains Residual.
5. This document MUST NOT replace `0012_Majestic_Memex.md`.

### 4.4 Width template and ones padding

1. Template bits MUST use the arms in Clause 3.7.
2. Template bits MUST pack into whole bytes with bit 7 of each byte consumed first.
3. Unused bits in the last template byte MUST be ones.
4. A claimed pad that contains a zero MUST be rejected.
5. If the last arm's zero is the last bit of a template byte, pad length MUST be zero. That case is perfectly efficient.
6. The header MUST store an explicit template bit length (or the byte count of the packed template). Ones padding fills unused bits inside that stored span. Ones padding MUST NOT be treated as a streaming end mark for an uncapped template.
7. A walker MUST cap width at 8 payload bytes unless a later published revision names a larger cap. Ones inside the stored span are pad. An unterminated run of ones that would pass that 8 byte cap MUST be rejected, never as pad and never as an infinite arm.

### 4.5 Payload pages

1. Page 0 MUST have 256 slots.
2. Page 1 MUST have 65536 slots.
3. A page 1 index MUST be little endian.
4. A page 2 or wider index MUST be little endian when present.
5. An index greater than or equal to the live size of that page MUST be rejected.
6. Huffman codes MUST NOT replace these payload bytes as the lemma spine.
7. Huffman coding MAY be measured on a pinned corpus as a length comparison. That measurement MUST NOT change the lemma spine.

### 4.6 Residuals and lossless surface

1. Encode MUST normalize first, then encode.
2. Decode MUST rebuild the original surface, not only the normalized lemmas. The rebuilt surface is the frequency ranked word, shown from the user's spelling table. The rank stays the same. Decode MUST use the user's spelling preference to choose which vocabulary dictionary table supplies the surface spelling, so that spelling can be the regional form. Code and materials on that computer MUST be presented in that preferred spelling at decode time. This selection is a requirement of the encoding. It is not a claim that a converter program is shipped. This item does not specify a spelling table byte layout.
3. Runs of space, tab, and other repeated characters MUST be stored in the repeat character residual as (character, count).
4. Capitalization, punctuation, and other marks MUST use the symbol residual, not the repeat character residual.
5. Vocabulary tables MUST NOT spend one slot per instance of a repeated indent character.

### 4.7 Encode, decode, and migration

1. Encode then decode of a well formed input MUST yield the original surface for the pinned rule set.
2. A later table set MUST NOT be accepted unless a Lean check shows that re-encoding every document in the pinned corpus is not longer than the previous encoding.
3. The pinned corpus and the exact Lean predicate remain Residual until the operator names them.
4. Systems Lean is the language in which that predicate SHALL later be stated. This document does not claim Slake typechecks the package.

### 4.8 Stack program

1. A stack program MUST be able to hold a bit cursor and a byte cursor.
2. This document MUST NOT publish an instruction listing for that program.
3. A later Lean Machine MAY emit such a program. This document does not claim that emission exists.

### 4.9 Science cycle

1. Work that claims this specification SHALL encode hypothesis, model, theory, proof, tests, and corollary experiments as specified in `0008_Formal_Vibefication.md`.
2. Tests are necessary. Tests alone are not sufficient.

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

1. Numbered markdown is the contract humans read; the specification is also encoded in Lean; proofs live in separate Lean modules; Formal Vibefication citations keep the canonical Proof of Keags URLs; `spec_check` remains form and is not meaning (Clause 1.2 and Clause 4.9).
2. CATE WordID and LanguageID remain catalog identity; page index is a rank, not a replacement WordID; one language keeps one LanguageID; a dialect does not get a different LanguageID; two spelling tables for one language are isomorphic at the frequency ranked word number; this document does not replace `0005_CATE.md` (Clause 4.1 and Clause 4.2).
3. Language runs remain as specified in `0004_SSSSS.md`; neural proposals reduce to sequential LanguageID and WordID before acceptance; this document is not a second SSSSS (Clause 4.2).
4. Magic `MAJESTIC` plus byte `0x01`, extension `.majestic`, and Tech Tree `.sstt` remain as specified in `0012_Majestic_Memex.md` (Clause 4.3).
5. Width arms are `0` / `10` / `110` / `1110` with zero terminating and each one adding one payload byte; unused bits in the last template byte are ones; a claimed pad that contains a zero is rejected; bit 7 is consumed first; width is capped at 8 payload bytes (Clause 4.4).
6. Page 0 has 256 slots; page 1 has 65536 slots; multi byte indices are little endian; payload is bytes; Huffman coding is not the lemma spine (Clause 4.5).
7. Encode normalizes first then encodes; decode rebuilds the original surface; decode uses the user's spelling preference to choose the vocabulary dictionary table so the surface spelling can be the regional form; code and materials on that computer are presented in that preferred spelling at decode time; that selection is not a claim that a converter program is shipped; repeat character residual is a plane of (character, count); symbol residual is separate (Clause 4.6).
8. Encode then decode yields the original surface; a later table is accepted only when a Lean check shows the new encoding is not longer on a pinned corpus (Clause 4.7).
9. No instruction listing for the stack program is published (Clause 4.8).
10. Every published numbered markdown file has a sibling `NNNN_descriptive_name.lean`; proofs of those encodings live in `lean/Proofs_NNNN.lean`; the named gate in `0007_CI.md` remains the gate (Clause 4.10).
11. ENKI is the index and is not this bitstream; ENKI has no numbered specification (Clause 1 and Clause 3.2).
12. A conforming encoder is not claimed. A spelling converter program is not claimed.

This specification is not itself a conforming encoder. Meeting these items is a claim about work that claims this specification, not about this markdown file as a shipped codec.

Optional recommendations (SHOULD, RECOMMENDED) and the MAY Huffman measurement do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record. The repository root `RESIDUAL.md` restates residual for the numbered specification program; this clause is the residual record for this specification.

### 6.1 Unpublished specifications and unassigned numbers

1. RDPS is unpublished. This document does not assign RDPS a number and does not create a numbered file for it.
2. FilterScript is unpublished. This document does not assign FilterScript a number and does not create a numbered file for it.
3. The Carbonado Network Protocol has no numbered specification file in this repository. It has no assigned specification number. This document does not create a file for Carbonado.
4. Number 0015 is not assigned in this document. This document MUST NOT steal number 0015. The next unassigned number after this specification is 0015. Number 0015 is not Anunnaki Encoding.
5. ENKI has no numbered specification. This document MUST NOT be read as creating `NNNN_ENKI.md`.
6. fargo has no numbered specification and no assigned number.
7. Lake wiring for this specification is in this repository: encodings in `lean/AnunnakiSpec.lean`, proofs in `lean/AnunnakiProofs.lean`, sibling `0014_Anunnaki_Encoding.lean`, and the `anunnaki_tests` check. Catalog tokens Anunnaki, bitstream, and ENKI live in `0005_CATE.md` and `aspell_words.txt`. This specification does not claim a conforming encoder.

### 6.2 Product that is not implemented

1. Anunnaki Encoding work is ongoing. A conforming encoder is not claimed. This specification records the contract. It does not ship an encoder. It does not ship a spelling converter program.
2. This specification does not define a stack program instruction set. Emission of such a program from Lean Machine is not claimed.
3. Nested language (English containing Lean containing a string) is in scope and is not specified here.
4. The on disk join from CATE WordID to Anunnaki rank is not specified here. Existence of that join is locked. On disk shape is not. The byte layout of a spelling table is not specified here. The isomorphism between those tables and the preference that selects a table at decode are specified in Clause 3.5, Clause 3.11, Clause 4.1, Clause 4.2, and Clause 4.6.
5. The pinned corpus for Clause 4.7 is not named here. The corpus remains Residual.
6. Compound word and technical term rules per language are not specified here.
7. Whether Anunnaki is default `.majestic` text or a later `memex compress` command is not specified here.
8. Who emits the stack program is not specified here.

### 6.3 Fixtures and languages that remain unpinned

1. v2 fixtures cover English and Lean 4 only.
2. C is named and unpinned.
3. Rust 1 is an unpinned grammar name.
4. Nix is named and unpinned.
5. C++ is named and unpinned.
6. Huffman versus pages length on a real corpus is not measured here.

### 6.4 Product claims that are not ready for use

1. beastdb, SSSSS, Slake, and Continuous Integration remain ongoing and not ready for use. This document MUST NOT be read as claiming that those products never started or do not exist.
2. `lean/AnunnakiSpec.lean` encodes selected claims. `lean/AnunnakiProofs.lean` proves those claims. `0014_Anunnaki_Encoding.lean` encodes the physical lines of this markdown file. `lean/Proofs_0014.lean` proves identities of that line encoding. Those modules are not a proof that a conforming encoder exists. They are not a proof that a spelling converter program is shipped. They are not a proof that CATE, SSSSS, or Majestic Memex are replaced.
3. Leftover residual facts in Clause 6.1 and Clause 6.2 are encoded in `lean/AnunnakiSpec.lean`. Proofs that leftover clashes are Cons False live in `lean/AnunnakiProofs.lean`.

### 6.5 Leftover clashes that are Cons False

1. Treating ENKI and Anunnaki Encoding as one object is Cons False in `lean/AnunnakiProofs.lean`.
2. Claiming a conforming encoder is Cons False in that same module. Claiming a spelling converter program is Cons False in that same module.
3. Treating number 0015 as this specification is Cons False in that same module. This document MUST NOT create `0015_*.md`.
4. Treating the Carbonado Network Protocol as assigned a number here is Cons False in that same module. Carbonado stays unnumbered.
5. Treating ENKI as having a numbered specification is Cons False in that same module. This document MUST NOT create `NNNN_ENKI.md`.
6. Treating RDPS as assigned a number here is Cons False in that same module.
7. Treating FilterScript as assigned a number here is Cons False in that same module. Treating a dialect as needing its own LanguageID is Cons False in that same module.

## 7. Changelog

### 0.1.0 - 20260920

First publication of Anunnaki Encoding as numbered specification 0014 with file name `0014_Anunnaki_Encoding.md`. Records ENKI as the index and Anunnaki as the bitstream. Records that this specification does not replace CATE (`0005_CATE.md`), SSSSS (`0004_SSSSS.md`), or Majestic Memex (`0012_Majestic_Memex.md`). Records width arms `0` / `10` / `110` / `1110`, ones padding that rejects a claimed pad containing a zero, bit 7 first, payload cap of 8 bytes, page 0 of 256 slots, page 1 of 65536 slots with little endian indices, repeat character residual as a plane of (character, count), separate symbol residual, normalize first then encode, decode that rebuilds the original surface, Huffman coding as measurement and not the lemma spine, and migration accepted only when a Lean check shows the new encoding is not longer. Records that a conforming encoder is not claimed. Records unpublished RDPS, FilterScript, and Carbonado Network Protocol. Records that number 0015 is not this specification. Records leftover clashes as Cons False in `lean/AnunnakiProofs.lean` for treating ENKI and Anunnaki Encoding as one object, claiming a conforming encoder, treating number 0015 as this specification, treating Carbonado as numbered, and treating ENKI, RDPS, or FilterScript as assigned a number here. Records that one language keeps one LanguageID, that a dialect does not get a different LanguageID, that variations of spelling are an isomorphism between vocabulary dictionary tables, and that the frequency ranked word number stays the same across those tables. Records that decode uses the user's spelling preference to choose the table, so code and materials on that computer are presented in that preferred spelling. Records that this selection is a requirement of the encoding and is not a claim that a converter program is shipped. Records that the byte layout of a spelling table is not specified. Records that treating a dialect as needing its own LanguageID is Cons False in that same module. Records that ones inside the stored span are pad and that an unterminated run of ones that would pass the 8 byte cap is rejected. Records that the rebuilt surface is the frequency ranked word, shown from the user's spelling table, and that the rank stays the same. Records that claiming a spelling converter program is Cons False in that same module.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

Hunter "cryptoquick" Beast designed the objects this document records: the stack program as machine code that handles bits and bytes, the header as language prefix plus layout template, ones padding as the end of unused template bits, repeat character run length for lossless surface, and the name Anunnaki Encoding.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html
3. https://proofofkeags.com

Those pages are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).
