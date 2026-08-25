# Vocabulary

This file is the human map of domain words the spelling list allows. Companion Lean proves it matches `aspell_words.txt`. It is not a replacement for numbered specifications.

The spelling list is `aspell_words.txt` at the repository root. That list is the personal aspell word list used when Lean `spec_check` spells numbered specifications. This map assigns each token exactly one id of the form `L_n` under the first letter of the token.

Letter ids restart at 1 for each letter. Words under a letter are sorted by ASCII without regard to case, then by ASCII code when the folded forms tie. `Changelog` and `changelog` are two tokens and two ids. If a word is added, later ids of that letter are renumbered so ids stay `L_1` through `L_k` with no gaps.

The product name beastdb is always lowercase. Multiplicity omega in Systems Lean prose is an ASCII word. The companion Lean constructor for that multiplicity is `unrestricted`.

This file is not ISO 24495. Filling these definitions is prose, not a second numbered specification.

## Parseable headings

The Lean checker MUST parse each entry heading with this regular expression. A wrapping backtick is written as hex 60 so this file can show the pattern without a raw backtick ending a fence.

````text
^### ([A-Z])_([0-9]+) \x60([^`]+)\x60$
````

That pattern is a heading with three hash marks, then a space, then an uppercase letter, an underscore, a positive decimal index, a space, a backtick, the aspell token, and a closing backtick, and nothing else on the line. An example that matches is the heading for entry A_1 whose token is ABI. Entry headings live outside fenced code. Adding a word under letter L inserts it in that sort and renumbers that letter.

## Table of contents

1. [A](#a)
2. [B](#b)
3. [C](#c)
4. [D](#d)
5. [E](#e)
6. [F](#f)
7. [G](#g)
8. [H](#h)
9. [I](#i)
10. [J](#j)
11. [K](#k)
12. [L](#l)
13. [M](#m)
14. [N](#n)
15. [O](#o)
16. [P](#p)
17. [Q](#q)
18. [R](#r)
19. [S](#s)
20. [T](#t)
21. [U](#u)
22. [V](#v)
23. [W](#w)
24. [Y](#y)
25. [Z](#z)

## A

### A_1 `ABI`

ABI is the application binary interface named when Systems Lean cites Rust layout for the optional LLVM path. It is not a second language in this repository.

### A_2 `AbsInt`

AbsInt is the publisher named on the CompCert git URL in `0002_Systems_Lean.md`. CompCert is not Unlicense. The Form 1 pin lives in the Systems Lean product tree, not under this repository's `ref/`.

### A_3 `ACID`

ACID is atomicity, consistency, isolation, and durability. Numbered specification `0003_beastdb.md` requires those properties as machine checked facts of a conforming store, and it does not claim the proofs exist yet.

### A_4 `Acknowledgments`

Acknowledgments is the heading used in numbered specifications for author credit and named talks. Entries there are informative. They are not conformance items.

### A_5 `affine`

Affine ownership in Systems Lean is at most one use of a resource. Multiplicity 1 covers linear use (exactly once) and affine use (at most once) as specified in `0002_Systems_Lean.md`.

### A_6 `ANSI`

ANSI here names the family of terminal color controls that ECMA-48 SGR parameters map onto. DOGE maps its eight colors onto those SGR values.

### A_7 `APIs`

APIs are application programming interfaces named when a specification forbids a traditional foreign function interface and sends interoperability through fargo instead.

### A_8 `ASCII`

ASCII is the required character set for numbered specifications and for this file. Allowed bytes are tab, line feed, and printable 32 through 126. Carriage return is forbidden.

### A_9 `aspell`

aspell is the en_US spelling program Lean `spec_check` runs on numbered specifications. The flake check puts `aspellWithDicts` on PATH.

### A_10 `aspellWithDicts`

aspellWithDicts is the nixpkgs wrapper that ships English word lists with aspell. Bare `nixpkgs#aspell` cannot find `en_US` lists without that wrapper.

### A_11 `Atkey`

Atkey is named with McBride as an author of Quantitative Type Theory in the Idris 2 citation in `0002_Systems_Lean.md`. That paper is not a Form 1 pin under this repository's `ref/`.

### A_12 `Atomicity`

Atomicity is the A in ACID. In beastdb it is a required machine checked property of a conforming store, not marketing language.

## B

### B_1 `basename`

A basename is the final path component of a file name. Numbered specifications match `NNNN_descriptive_name.md` on the basename at the repository root.

### B_2 `basenames`

Basenames is the plural. Style exclusions such as `UNLICENSE.md` are decided on the basename.

### B_3 `beastdb`

beastdb is the durable ordered store specified in `0003_beastdb.md`. The product name is always the seven lowercase letters b, e, a, s, t, d, b. Mixed case forms are forbidden.

### B_4 `Beatitudes`

Beatitudes names the eight Beatitudes in the informative honorable society clause of `0006_RSI.md`. That naming is not a proven cosmology and is not a conformance item for Slake, beastdb, or SSSSS.

### B_5 `BG`

BG is the SGR background column in the DOGE mapping table in `0001_DOGE.md`. Bright BG values sit beside Bright FG values for the eight palette colors.

### B_6 `bin`

bin is the directory where flake packages install Lean binaries such as `spec_check`. Lake writes those programs under `.lake/build/bin` before install.

### B_7 `bips`

bips names the bitcoin/bips layout that this repository copies in spirit: numbered documents at the repository root, not under a nested `specs/` folder.

### B_8 `BitDevs`

BitDevs is named in acknowledgments for a Formal Verification of Bitcoin talk. Television canon and meetup continuity are not conformance items.

### B_9 `bitmask`

bitmask appears in `0006_RSI.md` as out of scope product trees (`bitmask-core`, `bitmask-next`). RSI is not a bitmask specification.

### B_10 `blockquote`

A blockquote is a markdown block beginning with `>`. Version lines in numbered specifications use that form. Deliberate blockquotes are structure, not wrapping to a column.

### B_11 `blockquotes`

Blockquotes is the plural of that markdown block. They remain allowed as structure in numbered specifications.

### B_12 `bootstrapped`

Bootstrapped describes a Slake compiler built from Systems Lean and Slake sources that then typechecks those sources, including theorems, as required by `0002_Systems_Lean.md`.

## C

### C_1 `cachix`

cachix is the GitHub org that publishes git-hooks.nix, which this flake uses to install the Lean `spec_check` pre-commit hook.

### C_2 `Carbonado`

Carbonado is the deferred Carbonado Network Protocol. It has no numbered specification and no assigned number. Number 0005 is CATE. Number 0006 is RSI, not Carbonado.

### C_3 `cargo`

cargo is the Rust package tool named when residual talks about other trees. This specifications repository does not use cargo across a crate as a check. Form rules here are Lean and pure Nix.

### C_4 `CATE`

CATE is Concise American Technical English, numbered specification `0005_CATE.md`. It is not specification 0006. Number 0006 is Recursive Self Improvement.

### C_5 `ccomp`

ccomp is the CompCert compiler driver. CompCert verified compilation means the freestanding C emit is compiled with `ccomp` so the assembly is that verified compilation.

### C_6 `Changelog`

Changelog with a capital C is the heading some numbered specifications use for SemVer history, such as `0005_CATE.md` Clause 7. It is a distinct token from `changelog`.

### C_7 `changelog`

changelog in lowercase is the same English word as a common noun or path segment. It is a distinct aspell token from `Changelog` and therefore a distinct id.

### C_8 `check`

check names `nix flake check` and the optional `just check` wrapper. Nix is the primary validation interface for this repository.

### C_9 `checkability`

Checkability is the 0000 clause that numbered specifications stay checkable for spelling, character set, list form, hyphenation, and whitespace. Domain terms missing from stock en_US may be listed in `aspell_words.txt`.

### C_10 `checkable`

Checkable means a claim is encoded so Lean or Nix can accept or reject it. Companion meaning models encode selected checkable claims. They are not a second markdown form checker.

### C_11 `checks`

checks are the separate flake check outputs. `nix flake check` runs all of them, including form rules, meaning tests, whitespace, pre-commit, and the vocabulary isomorphism.

### C_12 `checksummed`

Checksummed describes Form 2 `SOURCE` pins that record a checksum of the official publisher artifact under `ref/`.

### C_13 `CLI`

CLI is a command line interface. Package names and command line interfaces for beastdb MUST use the lowercase product name.

### C_14 `COCOMO`

COCOMO is the cost model block `scc` can print. When the operator asked for size, reports include that block. COCOMO is fun and is not a real cost or schedule.

### C_15 `codebase`

A codebase is a source tree. This repository's numbered specifications live only at the root of this codebase.

### C_16 `commit`

commit names a git commit object. Agents MUST NOT run `git commit` in this repository unless the operator explicitly asked for that git work.

### C_17 `CompCert`

CompCert is the formally verified C compiler required as a core validation step for freestanding emit in `0002_Systems_Lean.md`. Its Form 1 pin lives in the Systems Lean product tree.

### C_18 `conformant`

conformant means an implementation or document meets the named SHALL and MUST clauses of a specification. Meeting 0000 form rules is a separate checklist from product conformance.

### C_19 `cryptoquick`

cryptoquick is an author handle in acknowledgments.

### C_20 `Curry`

Curry is named in the Curry-Howard isomorphism, which acknowledgments credit through talks. It is not a conformance item for Slake, beastdb, or SSSSS.

## D

### D_1 `darwin`

darwin is the Apple kernel name used in flake system strings `x86_64-darwin` and `aarch64-darwin`.

### D_2 `deterministic`

deterministic means the same inputs yield the same outputs. SSSSS requires a deterministic pipeline given the same vocabulary and relation set. Floyd-Steinberg dithering in DOGE is chosen because it is deterministic.

### D_3 `DIN`

DIN is named in `0005_CATE.md` as a body that has adopted ISO 24495-1:2023. That ISO standard is informative prior art, not a Clause 12 pin in this repository.

### D_4 `direnv`

direnv is local environment tooling. The whitespace checker skips `.direnv/` as generated host state.

### D_5 `DOGE`

DOGE is Digital Octal Graphical Emissive, numbered specification `0001_DOGE.md`. It is a pure 3 bit RGB palette of eight colors with fixed sRGB values.

## E

### E_1 `ECMA`

ECMA names Ecma International as the publisher of ECMA-48. The Form 2 pin is the official PDF under `ref/ecma48`.

### E_2 `Ecma`

Ecma is the short publisher name used in Form 2 notes for ECMA-48. Community reformats are not the Ecma publisher source.

### E_3 `Emissive`

Emissive with a capital E appears in the DOGE expansion Digital Octal Graphical Emissive. The palette targets emissive displays such as OLED.

### E_4 `emissive`

emissive in lowercase is the common adjective for displays that emit their own light. Soft LCD style light bleed is a reason DOGE prefers those displays.

### E_5 `EOF`

EOF is end of file. Checkers read whole files as bytes and split on line feed. They do not treat a missing final newline as a second specification language.

### E_6 `EOL`

EOL is end of line. Numbered specifications use line endings that use LF and never CR.

## F

### F_1 `fargo`

fargo is the Surmount interoperability layer named by beastdb. It has no numbered specification and no assigned number. Do not create `0005_fargo.md`. Do not steal 0006 for fargo.

### F_2 `FFI`

FFI is a traditional foreign function interface. beastdb interoperability goes through fargo rather than that interface.

### F_3 `FG`

FG is the SGR foreground column in the DOGE mapping table in `0001_DOGE.md`. Bright FG values sit beside Bright BG values.

### F_4 `FixOS`

FixOS is the vision named in `0002_Systems_Lean.md` for future high assurance rewrites. It is not a numbered specification in this repository.

### F_5 `flake`

A flake is a Nix flake. This repository's `flake.nix` packages Lean checkers and runs them as flake checks.

### F_6 `flakes`

flakes is the plural. Novel Systems Lean product work is expressed in at most Idris 2, Lean 4 including Systems Lean, and pure Nix flakes.

### F_7 `Floyd`

Floyd is the first name in Floyd-Steinberg error diffusion, one of two DOGE quantization methods. The hyphen stays because it is an official designation.

### F_8 `freestanding`

freestanding means a product wire with no managed Lean runtime and no garbage collection. Systems Lean residual is a named fact that still blocks that wire.

## G

### G_1 `GitHub`

GitHub hosts some publisher git URLs and this project's Actions workflow. CI runs `nix flake check` directly after installing Nix.

### G_2 `gitignore`

gitignore names ignore files. This repository does not gitignore throwaway compiler probes to hide them.

### G_3 `gitignored`

gitignored describes paths an ignore file excludes. The whitespace checker still has its own skip list for vendor blobs and generated trees.

### G_4 `GitLab`

GitLab is another git host. Form 1 pins may use any host the publisher maintains. This repository does not assume GitHub.

### G_5 `gitlinks`

gitlinks are git submodule entries. Form 1 pins under `ref/` use submodule gitlinks. Form 2 pins are ordinary files.

### G_6 `grainier`

grainier is how `0001_DOGE.md` describes Gaussian dithering compared with Floyd-Steinberg. Gaussian dithering is not the selected method.

### G_7 `grayscale`

grayscale colors are outside the DOGE palette. A conforming DOGE implementation permits only the eight pure 3 bit RGB colors.

### G_8 `Grok`

Grok is named in acknowledgments as assistance on some specifications. Project skills for this repository live under `.agents/skills/`, not under a project `.grok/` tree.

### G_9 `GUI`

GUI is a graphical user interface. DOGE is intended for high contrast GUIs, terminal emulators, and emissive displays.

## H

### H_1 `HA`

HA is high availability. Network peering, replication, high availability, and distribution are out of scope for beastdb and belong to the deferred Carbonado Network Protocol.

### H_2 `heed`

heed is informative prior art for durable ordered maps named in `0003_beastdb.md`. It is not a Clause 12 pin and is not under this repository's `ref/`.

### H_3 `hook`

A hook is a git or git-hooks.nix hook. The development shell installs a Lean `spec_check` hook on numbered specifications.

### H_4 `hooks`

hooks is the plural. Whitespace across the tree is a pure Nix flake check, not a bash pre-commit hook.

### H_5 `Howard`

Howard is named in the Curry-Howard isomorphism in acknowledgments. That naming is not a conformance item.

### H_6 `href`

href is the HTML hyperlink attribute that markdown links compile to. Publisher hyperlinks still matter as publisher links in SOURCE and citations.

### H_7 `HTTP`

HTTP is the unencrypted web scheme. Spec_check strips `http://` URLs before hyphenation scans.

### H_8 `HTTPS`

HTTPS is the encrypted web scheme used in publisher git URLs and citation links.

### H_9 `hypernymy`

hypernymy is an example RelationType on a SSSSS Rosetta relation. This repository does not freeze a closed list of relation kinds.

## I

### I_1 `Idris`

Idris names Idris 2, a Quantitative Type Theory language cited by Systems Lean. The Form 1 pin lives in the Systems Lean product tree as `ref/Idris2`.

### I_2 `IEC`

IEC is named in ISO/IEC designations such as ISO/IEC 8613-6 (identical text to ITU-T T.416) and ISO/IEC 6429 (ECMA-48). Those hyphens stay as official designations.

### I_3 `implementer`

An implementer is a person or agent who implements a numbered specification. The numbered markdown is the contract implementers read.

### I_4 `implementers`

implementers is the plural. Silent gaps that implementers must fill are nonconforming in numbered specifications.

### I_5 `INRIA`

INRIA is associated with CompCert's academic lineage. CompCert itself is cited by publisher git and the CompCert user's manual, not by a second INRIA pin here.

### I_6 `IR`

IR is intermediate representation. Systems Lean may later emit LLVM IR as an optional path. That path is not required for conformance.

### I_7 `ISO`

ISO is the International Organization for Standardization. ISO 24495-1:2023 is informative prior art for CATE and is not a Clause 12 pin. Official designations such as ISO/IEC keep their hyphens.

### I_8 `isomorphism`

isomorphism in this file is the pair of inverse maps between `aspell_words.txt` tokens and `L_n` entries. SSSSS also names a Rosetta isomorphism layer. Curry-Howard is named only in acknowledgments.

### I_9 `ITU`

ITU names ITU-T Recommendation T.416, pinned as a Form 2 official PDF under `ref/itu_t416`. The hyphen in ITU-T stays as an official designation.

## J

### J_1 `JSON`

JSON is a structured text format. This repository does not treat JSON as a numbered specification language. Lean and markdown remain the contract surfaces.

## K

### K_1 `Keagan`

Keagan is named in acknowledgments as Keagan McLelland. That credit is informative. Credit uses a backlink to the canonical page.

### K_2 `Keags`

Keags appears as Proof of Keags in those same acknowledgments. It is not a conformance item. Credit uses a backlink to the canonical page.

### K_3 `KV`

KV is key and value. beastdb is a durable ordered store for keys and values with mandatory schema.

## L

### L_1 `Lake`

Lake is the Lean build tool. This repository's `lean/lakefile.toml` defines `spec_check` and the meaning-test executables, including the vocabulary isomorphism tests.

### L_2 `LanguageID`

LanguageID is a dense identifier for a language in beastdb and SSSSS. It is not a Unicode code point used as the primary key. SSSSS prefixes a run with LanguageID only when the language changes.

### L_3 `LanguageIDs`

LanguageIDs is the plural. Sequential LanguageID values are primary identity together with per language WordID values.

### L_4 `LCD`

LCD names liquid crystal displays. DOGE prefers emissive hardware in part because some readers are sensitive to older LCD style light bleed.

### L_5 `Lean`

Lean is Lean 4, the language of companion meaning models and of `spec_check`. Systems Lean is Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities. The Lake package id `SystemsLean` is not a second language name.

### L_6 `LevelDB`

LevelDB is informative prior art in `0003_beastdb.md`. It is not a Clause 12 pin and is not under this repository's `ref/`.

### L_7 `LF`

LF is the line feed character (byte 10). Numbered specifications use line endings that use LF and never CR.

### L_8 `libbeastdb`

libbeastdb is the freestanding product library for beastdb. It is the prefix lib plus the lowercase product name. A capital letter MUST NOT appear in that library name.

### L_9 `linux`

linux is the kernel name in flake system strings `x86_64-linux` and `aarch64-linux`.

### L_10 `LLVM`

LLVM is the optional secondary emit path in Systems Lean for use with the Rust ecosystem. It is not required for conformance.

### L_11 `LMDB`

LMDB is informative prior art in `0003_beastdb.md`. It is not a Clause 12 pin and is not under this repository's `ref/`.

### L_12 `lockfile`

A lockfile here is `flake.lock` or Lean's `lake-manifest.json`. Host `.lake` caches are dropped from the Lean source filter so the Nix sandbox does not replay them.

## M

### M_1 `Markdown`

Markdown with a capital M is the markup language of numbered specifications. Numbered markdown at the repository root is the contract humans read.

### M_2 `markdown`

markdown in lowercase is the same language as a common noun or file suffix. It is a distinct aspell token from `Markdown`. Tooling that is not markdown is still not a leftover unstack phrase in prose.

### M_3 `McBride`

McBride is named with Atkey as an author of Quantitative Type Theory in `0002_Systems_Lean.md`. That paper is not a Form 1 pin here.

### M_4 `McLelland`

McLelland is named in acknowledgments with Keagan McLelland. That credit is informative. Credit uses a backlink to the canonical page.

### M_5 `md`

md is the file extension of numbered specifications and of this map. The numbered file pattern is `NNNN_descriptive_name.md` at the repository root.

### M_6 `meta`

meta is the Nix derivation attribute that records description and license on packages and apps. Flake apps require `meta.description`.

### M_7 `midtones`

midtones are soft shades between the eight palette colors. `0001_DOGE.md` places soft midtones outside the scope of the palette. High contrast is mandatory.

### M_8 `mmap`

mmap is memory mapping as an access path required of conforming beastdb. This repository does not claim that mapping is implemented.

### M_9 `Morty`

Morty is named with Rick in the informative cultural marker for SSSSS. Television canon is not a conformance item.

### M_10 `multiplicities`

multiplicities are the Quantitative Type Theory use counts in Systems Lean. The permitted set is 0, 1, and omega. No other multiplicity is permitted.

### M_11 `multiplicity`

multiplicity is one of those use counts. The ASCII word omega is unrestricted multiplicity in prose. The companion Lean constructor is `unrestricted`, not a Greek letter.

## N

### N_1 `Nix`

Nix is the build and check interface for this repository. Pure Nix evaluation owns trailing whitespace and tab indent across the tree. `nix flake check` is the canonical gate.

### N_2 `NixOS`

NixOS is the Linux distribution whose unstable channel this flake follows as `nixpkgs`. It is a distinct token from `nixos`.

### N_3 `nixos`

nixos in lowercase appears in flake input URLs such as `github:NixOS/nixpkgs/nixos-unstable`. It is a distinct token from `NixOS`.

### N_4 `nixpkgs`

nixpkgs is the Nix package set. This flake pins `nixos-unstable` and takes `lean4` and `aspellWithDicts` from it.

### N_5 `noncommercial`

noncommercial appears when recording licenses of pinned third party texts. Surmount work in this repository is Unlicense. Upstream trees keep their original licenses.

### N_6 `nonconforming`

nonconforming means a clause is not met. Leftover unstack is nonconforming under CATE. Residual silence is nonconforming when remaining work was named.

### N_7 `normative`

normative text states requirements with RFC 2119 keywords. Informative sections should be labeled so readers can tell they are not requirements.

### N_8 `NUL`

NUL is the null byte. It is not an allowed ASCII byte in numbered specifications.

## O

### O_1 `OLED`

OLED is an organic light emitting display. DOGE targets OLED and similar emissive hardware.

## P

### P_1 `PDFs`

PDFs are the Form 2 publisher artifacts for ECMA-48 and ITU-T T.416 under `ref/`. The whitespace checker skips PDF files.

### P_2 `POSIX`

POSIX names portable path and process behavior assumed by Lean IO and Nix builds. Numbered specifications still require ASCII files with LF line endings.

### P_3 `pre`

pre is the HTML preformatted element and the prefix of `libbeastdb`. It is also the start of `precommit` and `Preflight` as separate tokens.

### P_4 `precommit`

precommit is the personal-list spelling of the git-hooks.nix pre-commit hook name. The tool name `pre-commit` may keep its hyphen as a tool name.

### P_5 `Preflight`

Preflight is the check before adding a Form 1 submodule, because `git submodule add` has no `--dry-run` flag. The documented command is `git ls-remote` on the publisher URL.

### P_6 `premultiplied`

premultiplied alpha is specified in DOGE: convert to straight RGB before discarding alpha. Fully transparent pixels are treated as black.

## Q

### Q_1 `QTT`

QTT is Quantitative Type Theory. Systems Lean takes multiplicities 0, 1, and omega from that theory as used in Idris 2.

### Q_2 `quantization`

quantization is mapping arbitrary colors onto the eight DOGE colors. `0001_DOGE.md` specifies two methods.

### Q_3 `quantize`

quantize is the verb for that mapping. Alpha is discarded before quantization.

## R

### R_1 `README`

README is `README.md` at the repository root. It orients humans and agents. It is not itself a full specification. When specs, validation, Nix, or process that it describes change, it is updated in the same effort.

### R_2 `rebalance`

rebalance is a structural operation in beastdb that fencing by generation must cover so a reader cannot observe torn structure from a prior generation.

### R_3 `reformats`

reformats are community copies of standards. They are not the publisher's canonical git and MUST NOT be invented as Form 1 pins.

### R_4 `RelationType`

RelationType is the name of the correspondence a SSSSS Rosetta relation asserts. A RelationType MUST be present on every Rosetta relation.

### R_5 `repo`

repo is a git repository. This specifications repository is distinct from a Systems Lean product tree and from any beastdb product tree.

### R_6 `repos`

repos is the plural. Form 1 pins clone publisher repos as submodules under `ref/` in the tree that cites them.

### R_7 `representable`

representable describes colors or values a palette or type can name. DOGE representable colors are exactly the eight table rows.

### R_8 `RFC`

RFC names RFC 2119, the requirement keyword document. Numbered specifications MUST cite RFC 2119. The Form 2 pin is `ref/rfc2119`.

### R_9 `RGB`

RGB is red, green, and blue. In DOGE it is the 3 bit palette model. In `0006_RSI.md` RGB as product is out of scope. Those uses SHALL NOT be mashed into one fact.

### R_10 `RGBCMYKW`

RGBCMYKW is the ordered set of the eight DOGE colors: Red, Green, Blue, Cyan, Magenta, Yellow, Black, White.

### R_11 `Rick`

Rick is named with Morty in the informative SSSSS cultural marker. Television canon is not a conformance item.

### R_12 `RocksDB`

RocksDB is informative prior art in `0003_beastdb.md`. It is not a Clause 12 pin and is not under this repository's `ref/`.

### R_13 `Rosetta`

Rosetta is the mapping between LanguageID and WordID values across languages, persisted in beastdb for SSSSS. It is not a second primary identity in place of sequential identifiers.

### R_14 `RSI`

RSI is Recursive Self Improvement, numbered specification `0006_RSI.md`. It does not replace CATE. It does not claim that every agent already conforms.

### R_15 `runtimeless`

runtimeless C is the primary emission target of Slake. It contains no managed Lean runtime.

## S

### S_1 `scanability`

scanability is why uppercase RFC 2119 keywords are recommended in normative clauses. It is not a private requirement language.

### S_2 `scc`

scc is the source counting tool used when the operator asked for size. Reports include the COCOMO block and do not pass `--no-cocomo`.

### S_3 `SemVer`

SemVer is Semantic Versioning 2.0.0. First publication of a specification is 1.0.0. The Form 1 pin is `ref/semver`. The Lean tool `spec_check` has its own SemVer, independent of numbered specifications.

### S_4 `SGR`

SGR is Select Graphic Rendition in ECMA-48. DOGE maps palette colors to SGR foreground and background parameters.

### S_5 `SIMD`

SIMD is vector hardware parallelism required of conforming beastdb. This repository does not claim that path is implemented.

### S_6 `Slake`

Slake is the freestanding compiler product specified in `0002_Systems_Lean.md`. It is written in Systems Lean. It is not the language name Systems Lean, and it is not the Lake package id `SystemsLean`.

### S_7 `SPDX`

SPDX is the license identifier used in this repository as `Unlicense`. See `UNLICENSE.md`.

### S_8 `spec`

A spec is a numbered specification in this repository. The spec spec is `0000_spec.md`.

### S_9 `specs`

specs is the plural. This repository holds those documents at the root. It is not a nested `specs/` folder of another tree.

### S_10 `SQLite`

SQLite is informative prior art in `0003_beastdb.md`. It is not a Clause 12 pin and is not under this repository's `ref/`.

### S_11 `sRGB`

sRGB is the color space of the DOGE table. Each of the eight colors has fixed 24 bit sRGB values.

### S_12 `SSSP`

SSSP is the Surmount Systems System Prompt, named in `0006_RSI.md` as possible later input. SSSP is not specified and has no assigned number.

### S_13 `SSSSS`

SSSSS is the Surmount Systems Smart Symbolic Supercompiler, numbered specification `0004_SSSSS.md`. The five consecutive S letters are an informative cultural marker. This specification does not claim a conforming implementation exists.

### S_14 `stderr`

stderr is where `spec_check` prints `file:line: message` diagnostics. A nonzero exit means a check failed.

### S_15 `Steinberg`

Steinberg is the second name in Floyd-Steinberg error diffusion. The hyphenated official designation may stay.

### S_16 `stochastic`

stochastic describes Gaussian dithering in the DOGE design notes. That method is not selected.

### S_17 `subagent`

A subagent is a tightly scoped agent used for an independent encode stream. CATE requires independent work streams with disjoint writes to run as parallel subagents.

### S_18 `subagents`

subagents is the plural. Serializing two jobs that do not share a write set is nonconforming under CATE.

### S_19 `subdirectory`

A subdirectory is a nested folder. Numbered specifications MUST NOT live in a subdirectory. They live at the repository root.

### S_20 `submodule`

A submodule is a Form 1 git pin of publisher canonical git under `ref/`. SemVer is the example in this repository.

### S_21 `submodules`

submodules is the plural. Form 2 pins are not submodules. They are ordinary files with a SOURCE record.

### S_22 `subpixel`

subpixel rendering is a display technique. DOGE still permits only the eight palette colors, not extra shades from subpixel tricks.

### S_23 `Supercompiler`

Supercompiler is the last word of Surmount Systems Smart Symbolic Supercompiler. SSSSS is specification 0004, not 0003.

### S_24 `Surmount`

Surmount is the organization that maintains these specifications. Surmount miscellaneous specifications are the documents in this repository.

### S_25 `SWMR`

SWMR is single writer, multiple reader. It is the required default concurrency for conforming beastdb. More than one writer on disjoint leaves is optional.

### S_26 `synonymy`

synonymy is an example RelationType on a SSSSS Rosetta relation, alongside translation and hypernymy.

## T

### T_1 `th`

th is the ordinal suffix in citations such as 5th Edition of ECMA-48. Stock en_US spelling does not always accept that suffix as a standalone token.

### T_2 `TOC`

TOC is a table of contents heading. This file's table of contents links only letters that have entries.

### T_3 `toc`

toc in lowercase is the same phrase as a common noun. It is a distinct aspell token from `TOC`.

### T_4 `tokenize`

tokenize means splitting text into tokens. SSSSS encodes programs as sequential language runs of WordID values, not as hashed strings as primary identity.

### T_5 `tokenized`

tokenized is the past form. A language run is a LanguageID plus a tokenized WordID list.

### T_6 `tokenizer`

A tokenizer produces those tokens. Primary identity remains sequential LanguageID and WordID, not a hash of tokenizer output.

### T_7 `tokenizes`

tokenizes is the present form. The hashing ban in SSSSS is a requirement on identity, not a ban on having a tokenizer.

### T_8 `TOML`

TOML is the format of `lean/lakefile.toml`. Lean and YAML may indent with spaces. Numbered specifications still use tabs.

### T_9 `trie`

A trie is the ordered tree beastdb uses. A conforming implementation uses tries that do not use locks. This document does not claim those tries are implemented.

### T_10 `tries`

tries is the plural. Progress of a reader or writer MUST NOT depend on another thread being scheduled to release a mutual exclusion lock on that trie.

### T_11 `TT`

TT is type theory, as in the Idris 2 core TT based on quantitative type theory. It is not a second name for Systems Lean.

### T_12 `TUI`

TUI is a text user interface. DOGE mapping to ECMA-48 SGR is for terminals as well as graphical interfaces.

### T_13 `Turing`

Turing complete is the class of programming languages SSSSS translates among. Natural language translation is separate and is best effort unless Lean proven or high confidence.

### T_14 `txt`

txt is the extension of `aspell_words.txt` and of the RFC 2119 Form 2 pin `rfc2119.txt`.

### T_15 `typecheck`

typecheck is a single word in this list for the act of typechecking. A bootstrapped Slake that fully typechecks is a required Systems Lean validation step.

### T_16 `typechecking`

typechecking is the gerund. Saying `fully type checking` as two leftover words is nonconforming under CATE. The rephrased form is a bootstrapped Slake that fully typechecks.

### T_17 `typechecks`

typechecks is the verb form used in that rephrased requirement.

## U

### U_1 `Unlicense`

Unlicense is the license of this repository and of novel Systems Lean and Slake source. CompCert and other upstream trees keep their original licenses.

### U_2 `unstack`

unstack appears in leftover unstack, specified by CATE in `0005_CATE.md`. Deleting a hyphen and leaving the same two words is nonconforming. RSI does not replace that repair.

### U_3 `URL`

A URL is a publisher or citation address. Hyperlinks to publisher pages still matter. Local `ref/` copies freeze what was reviewed.

### U_4 `URLs`

URLs is the plural. Spec_check strips markdown links and http URLs before some form scans.

### U_5 `US`

US names American English (`en_US`) and the US Federal Plain Language Guidelines. Those guidelines are informative prior art for CATE, not a Clause 12 pin.

### U_6 `UTF`

UTF names encodings such as UTF-8. Numbered specifications are pure ASCII, not UTF multibyte letters or punctuation.

## V

### V_1 `validator`

A validator here is Lean `spec_check` or a flake check. Spelling checkability in 0000 means documents stay checkable by that validator.

### V_2 `validators`

validators is the plural. Meaning-model test binaries are extra validators of selected clauses. They are not a second markdown form checker.

### V_3 `Vibefication`

Vibefication appears in Formal Vibefication, cited by Systems Lean and other specifications as the split between numbered markdown people read and Lean models of selected clauses. It is not a second specification number.

## W

### W_1 `Whitespace`

Whitespace with a capital W names the Nix check across the project and `nix/whitespace.nix`. It is a distinct token from `whitespace`.

### W_2 `whitespace`

whitespace in lowercase is the characters themselves: trailing space or tab, and leading indent. Numbered specifications use tabs for leading indent. Lean and YAML may use spaces because those languages require it.

### W_3 `WordID`

WordID is a dense identifier for a word in beastdb and SSSSS. It is not a Unicode code point used as the primary key. Sequential WordID is primary identity, not hashing.

### W_4 `WordIDs`

WordIDs is the plural. A language run is a LanguageID plus a list of WordIDs.

### W_5 `wordlist`

A wordlist here is `aspell_words.txt`. This vocabulary map matches that list token for token, excluding the `personal_ws-1.1 en N` header.

## Y

### Y_1 `YAML`

YAML is used in generated pre-commit config. The whitespace checker allows space indent in YAML. Authors do not hand edit `.pre-commit-config.yaml`.

### Y_2 `YouTube`

YouTube is the host of a talk named in acknowledgments. That link is informative credit, not a Clause 12 pin.

## Z

### Z_1 `zerocopy`

zerocopy is a required access property of conforming beastdb. This repository does not claim that path is implemented.
