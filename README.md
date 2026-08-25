# Surmount miscellaneous specifications

This repository holds small, precise specifications maintained by Surmount. Each numbered document is a standalone technical spec. The zero document is the spec spec: form rules for how the rest are written.

## Table of contents

1. [What this repository is](#1-what-this-repository-is)
2. [Current specifications](#2-current-specifications)
3. [Document rules](#3-document-rules)
4. [Versioning and publication](#4-versioning-and-publication)
5. [RFC 2119 requirement keywords](#5-rfc-2119-requirement-keywords)
6. [External references (`ref/`)](#6-external-references-ref)
7. [Validation (Lean and Nix)](#7-validation-lean-and-nix)
	1. [Why Lean vs pure Nix](#721-why-lean-vs-pure-nix)
	2. [Systems Lean meaning proofs](#75-systems-lean-meaning-proofs-not-form-rules)
	3. [beastdb meaning proofs and the number registry](#76-beastdb-meaning-proofs-and-the-number-registry)
	4. [SSSSS meaning proofs](#77-sssss-meaning-proofs-not-form-rules)
8. [Development shell and pre-commit](#8-development-shell-and-pre-commit)
9. [Residual](#9-residual)
10. [Project skill `/surmount-specify`](#10-project-skill-surmount-specify)
11. [License](#11-license)

## 1. What this repository is

Surmount miscellaneous specifications are short normative documents for interfaces, formats, and design constraints that do not belong in a larger product tree. Specs are pure ASCII markdown, written in American English, versioned with real Semantic Versioning when published, and checked by automated tools packaged through Nix.

Numbered specifications live only in the repository root as files named `NNNN_descriptive_name.md` (for example `0000_spec.md`, `0001_DOGE.md`, `0002_Systems_Lean.md`, `0003_beastdb.md`, `0004_SSSSS.md`). They are not nested under a `specs/` subdirectory or similar. That flat root layout is the same spirit as the bitcoin/bips repository: numbered proposals at the root.

The binding rules for form live in [0000_spec.md](0000_spec.md). This README orients humans and agents; it is not itself a full specification.

## 2. Current specifications

1. [0000_spec.md](0000_spec.md) - Surmount spec spec (spec 0), version 1.0.0. Defines how specs in this repository are written, named, versioned, cited, and checked.
2. [0001_DOGE.md](0001_DOGE.md) - Digital Octal Graphical Emissive (DOGE) color specification, version 1.0.0. Defines a pure 3 bit RGB palette of eight colors with fixed sRGB values, ECMA-48 SGR mapping, and two quantization methods. Uses RFC 2119 requirement keywords; cites RFC 2119, ECMA-48, and ITU-T T.416 / ISO/IEC 8613-6 under `ref/`.
3. [0002_Systems_Lean.md](0002_Systems_Lean.md) - Systems Lean, version 1.0.0. Defines Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities 0, 1, and omega; names Slake as the freestanding compiler product; requires a freestanding product wire without managed Lean runtime or garbage collection; requires CompCert verified compilation of that emit and bootstrapping a Slake compiler that fully typechecks as core validation steps. Cites RFC 2119, SemVer, and `0000_spec.md` from this repository's `ref/`. Lean 4, Idris 2, CompCert, and Rust Form 1 pins live in the Systems Lean product tree, not this repository's `ref/`. Companion Lean meaning proofs live under `lean/SystemsLean.lean` and are not the numbered specification. The Smart Symbolic Supercompiler is specified in `0004_SSSSS.md`. beastdb is specified in `0003_beastdb.md`.
4. [0003_beastdb.md](0003_beastdb.md) - beastdb, version 1.0.0. Defines the durable ordered store with lowercase product name beastdb and freestanding library libbeastdb; requires Systems Lean, a bootstrapped Slake that fully typechecks, and CompCert verified compilation as in 0002; requires proven ACID, tries that do not use locks, SWMR, optional access by more than one writer on disjoint leaves, fencing by generation, mmap, SIMD, zerocopy, LanguageID, WordID, Rosetta, mandatory schema with two modes, and interoperability through fargo rather than a traditional foreign function interface. This specification does not claim a conforming implementation exists. Companion Lean meaning proofs live under `lean/BeastDb.lean`. Residual for this specification is Clause 6 of that file; residual for the numbered specification program is [RESIDUAL.md](RESIDUAL.md).
5. [0004_SSSSS.md](0004_SSSSS.md) - Surmount Systems Smart Symbolic Supercompiler, version 1.0.0. Defines encoding as sequential language runs with LanguageID prefix only on change; requires 64 bit sequential LanguageID and per language sequential WordID as primary identity and forbids hashing as primary identity; requires Rosetta relations with provenance tags; requires a deterministic pipeline given the same vocabulary and relation set; permits neural proposals only after reduction to sequential integers; permits natural language translation as best effort provisional work; requires durable state in beastdb and a Systems Lean core with CompCert and a Slake bootstrap that fully typechecks for components that are safety critical, that run in environments with tight resources, and that are freestanding. This specification does not claim a conforming implementation exists. Companion Lean meaning proofs live under `lean/Sssss.lean`. Residual for this specification is Clause 6 of that file.

## 3. Document rules

All new specification prose SHALL follow [0000_spec.md](0000_spec.md). Summary for everyday use:

1. American English spelling and wording throughout (en_US).
2. Pure ASCII characters only (no Unicode punctuation or letters that are not ASCII). Use ASCII `-`, straight quotes, and `...` (three periods). Files use line endings that are LF only (no CR).
3. Prefer ordinary English over hyphenated compounds. Do not write lawyerly modifiers such as `high-assurance` or `lock-free`. Do not "fix" them by deleting the hyphen and leaving the same two words. Rephrase so a person would actually say it. `high assurance` may stay when it already reads as English. Keep a hyphen only for filenames, URLs, code identifiers, and official designations (for example `ITU-T`). The automated checker fails on lowercase identifiers with two or more hyphens (three or more segments), for example `foo-bar-baz`. A single hyphen is still allowed by that mechanical checker; authors still should rephrase rather than leave a hyphen. The tool name `pre-commit` may stay as the tool name.
4. Enumerate sections and lists clearly. Use numbered or lettered lists. Do not use markdown bullet markers (`-`, `*`, `+`) outside fenced code.
5. Do not wrap prose to a column. Prefer one physical line per paragraph and per list item body. Soft wrap is the reader's editor setting. Deliberate breaks stay for headings, blank lines, list items, tables, and fenced code.
6. Leading indentation uses tab characters only (not spaces). Spaces in the middle of a line and inside table cells are fine. Nested lists indent with tabs. No trailing spaces or tabs at end of line.
7. Maintain high precision. Label open questions and behavior the implementation defines. Do not leave silent gaps implementers need filled.
8. Name files `NNNN_descriptive_name.md` with a four digit prefix and underscores in the descriptive part (not filenames that use hyphens in the basename). Place them only in the repository root (not under a nested `specs/` folder). `0000` is reserved for the spec spec (`0000_spec.md`).
9. Background, history, and design reasoning text is informative. Requirements use RFC 2119 keywords (MUST, SHALL, SHOULD, MAY, and related words) in the RFC 2119 sense. Informative sections should be titled or opened so readers can tell they are not requirements (for example "Algorithm selection reasoning"). Do not invent private requirement jargon; use ordinary English plus RFC 2119. An RFC 2119 keyword still makes a sentence normative even inside an otherwise informative section; prefer keeping requirements in normative sections.
10. Every normative spec includes a Required Conformance clause (how to conform to that spec). Meeting the form rules in 0000 is a separate checklist in that document ("Conformance to this document").
11. Include Copyright or License text, or state that the repository Unlicense applies.

Standard legal text in [UNLICENSE.md](UNLICENSE.md) is excluded from style, spelling, list, and kebab checks.

## 4. Versioning and publication

1. Specs use real Semantic Versioning (SemVer) 2.0.0: MAJOR.MINOR.PATCH. Cite SemVer; local copy path when present: `ref/semver`.
2. The repository operator controls when a specification is published.
3. Do not invent pretend shipped releases or a 0.x release train for work that was never published.
4. First publication of a specification SHALL be version 1.0.0.
5. Specs MAY carry a SemVer version line (see the pattern in 0000). Do not invent fake version history or claim publication the operator has not declared.
6. After publication, incompatible changes raise MAJOR; backward compatible additions raise MINOR; compatible fixes raise PATCH, as SemVer describes.
7. The Lean tool `spec_check` has its own SemVer, independent of SemVer for numbered specifications. A bump to the tool does not imply a bump to `0000_spec.md` or any other numbered specification, and the reverse is also true. The tool is at **1.0.0** as its first intentional tool release.

## 5. RFC 2119 requirement keywords

Specs SHALL use RFC 2119 keywords in the RFC 2119 sense:

MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, OPTIONAL.

Cite RFC 2119 (local path when present under `ref/`, for example `ref/rfc2119`). Uppercase keywords in normative clauses are recommended for scanability. Do not invent a private rule that bans MUST or redefines these words. Background and design reasoning prose is informative; label such sections clearly. See [0000_spec.md](0000_spec.md) Clause 4.2.

## 6. External references (`ref/`)

`ref/` holds the external standards this repository cites so readers and tools can open the **exact** text meant without hunting the web. Hyperlinks to publisher pages still matter; canonical URLs stay in SOURCE and in citations. Local copies freeze what was reviewed and checksummed or pinned in git. Full process, reasoning, and per-entry license notes: [ref/README.md](ref/README.md). Normative summary: [0000_spec.md](0000_spec.md) Clause 12.

1. Binding rule: any external specification this repository cites MUST be present under `ref/` in one of two honest forms:
	1. **Form 1: Canonical git that the publisher maintains.** Git submodule from the publisher's canonical git repository (any host, not assumed GitHub), pinned to a tag or commit.
	2. **Form 2: No canonical git that the publisher maintains.** Keep a local copy of the specific official publisher artifact (PDF, plain text, or similar) under `ref/<name>/`, committed **directly in this repository's git tree** (ordinary files, **not** a submodule), with a `SOURCE` file (canonical URL, retrieval date, checksum, edition or version). Form 2 is used when the publisher does not maintain canonical git. In `ref/README.md` you must say that there is no publisher git, record license and copyright, and record why Form 2 was used. Hyperlinks to the publisher still matter as publisher links. That form **does** satisfy the rule and is the intentional process for standards from before git and from the PDF era (RFC 2119, ECMA-48, ITU-T T.416, similar), not a fallback failure.
2. Prefer honesty: never invent a third party mirror or community reformat as "canonical git." Prefer Form 1 when the publisher truly maintains git for that standard; Form 2 when that is what the publisher ships.
3. Adding a new external citation in a spec requires adding or updating the matching `ref/` entry under that process.
4. Present entries (all valid under the rule above):
	1. SemVer (`ref/semver`) - Form 1 git submodule of https://github.com/semver/semver , pinned to tag `v2.0.0` (commit `7c834b3f3a4940d77ab593bc32583004d6a426a9`). Upstream doc license: CC BY 3.0. See `ref/semver.SOURCE` and `ref/README.md`.
	2. RFC 2119 (`ref/rfc2119`) - Form 2 official RFC Editor plain text, committed directly in this tree (not a submodule), with SOURCE. Canonical publication is https://www.rfc-editor.org/rfc/rfc2119.txt ; there is no canonical git that the publisher maintains for this historic RFC. IETF Trust / RFC copyright; freely available from the RFC Editor; Surmount does not own the text. See `ref/rfc2119/SOURCE` and `ref/README.md`.
	3. ECMA-48 (`ref/ecma48`) - Form 2 official Ecma International PDF, committed directly in this tree (not a submodule), with SOURCE. Ecma text copyright policy allows unchanged republication with notice. Community reformats are not the Ecma publisher source. See `ref/ecma48/SOURCE` and `ref/README.md`.
	4. ITU-T T.416 / ISO/IEC 8613-6 (`ref/itu_t416`) - Form 2 official ITU free PDF (Recommendation T.416, 03/93; identical text also published as ISO/IEC 8613-6), committed directly in this tree (not a submodule), with SOURCE. No canonical git that the publisher maintains. Surmount does not own the text. See `ref/itu_t416/SOURCE` and `ref/README.md`.
5. Paths may be documented before the directories are populated. Empty paths are not an excuse to drop the public citation.
6. `git submodule add` has no `--dry-run`. Preflight a new Form 1 submodule with `git ls-remote <url>` and an optional temporary clone outside the tree.
7. After this repository has its first commit with submodule gitlinks, clones populate Form 1 submodules with:

```bash
git submodule update --init --recursive
```

	Or clone with `git clone --recurse-submodules <url>`. Those commands apply only to real Form 1 submodules (for example `ref/semver`). Form 2 pins such as `ref/rfc2119`, `ref/ecma48`, and `ref/itu_t416` are ordinary files in this repository's git tree and need no submodule init.

## 7. Validation (Lean and Nix)

### 7.1 Local and CI gate (Nix is primary)

**Nix is the primary interface** for validation. There is no `scripts/` bash gatekeeper. The canonical command for local work and GitHub Actions is:

```bash
nix flake check "path:$PWD" --print-build-logs
```

CI installs Nix and runs that command directly (workflow: `.github/workflows/check.yml`). Checkout initializes Form 1 git submodules; Form 2 pins need no submodule init. It does **not** install or invoke `just`.

`just` is optional local sugar only. `just check` runs the same Nix flake check line; you do not need `just` if you call Nix yourself. Prefer `path:` when local flake files may be untracked so pure git tree eval is not required.

On a single architecture host, `nix flake check` may warn that it omitted checks for incompatible systems. That omit warning is normal and not a failure.

What the flake checks cover (separate checks; `nix flake check` runs all of them):

1. **`checks.spec_check`** - Lean form rules and American English spelling on numbered specifications at the repository root, plus the registry scan for numbered specifications (published file names including `0004_SSSSS.md`, planned `0005_fargo.md` must not exist, `NNNN_name.md` tokens must match the registry, product name beastdb must stay lowercase). Thin `runCommand` puts the `packages.spec_check` binary and `pkgs.aspellWithDicts` on PATH, sets `REPO_ROOT`, and runs `spec_check`. No discovery or aspell loops in shell; spelling is inside Lean. The registry lives in `lean/SpecRegistry.lean`.
2. **`checks.whitespace`** - pure Nix evaluation of text owned by the project for trailing whitespace and leading indent that uses tabs only (skips vendor blobs under `ref/semver`, PDFs, and RFC plain text; Lean and YAML may indent with spaces). Violations that are not empty fail evaluation with `throw`; success is a `writeText` marker with no shell. No bash script.
3. **`checks.pre-commit-check`** - sandboxed pre-commit suite (Lean hook on numbered specifications only; spelling rides along when aspell is on PATH from the dev shell). Whitespace across the project is the pure Nix flake check, not a bash pre-commit hook.
4. **`checks.spec_check_tests`** - hermetic Lean unit tests for `spec_check` form rule helpers (string fixtures).
5. **`checks.systems_lean_tests`** - companion meaning proofs for `0002_Systems_Lean.md` (multiplicities, finite use counts for erased / linear / affine / unrestricted, composed Clause 5 conformance, language set, hygiene including product tree `ref/` names, and stack targeting claims). Clause 5 conformance on the wire holds when the product is a well formed freestanding product with no managed Lean runtime and no garbage collection, or when every leftover that still blocks that is named and tracked. CompCert verified compilation and a bootstrapped Slake that fully typechecks are separate Clause 5 items; a named leftover does not excuse either. This is not a second markdown form checker. The Smart Symbolic Supercompiler is specification 0004 in that model, not 0003. beastdb is specification 0003.
6. **`checks.beastdb_tests`** - companion meaning proofs for `0003_beastdb.md` (lowercase product name, libbeastdb, Systems Lean and Slake bootstrap typecheck, proven ACID and tries that do not use locks as required, mandatory schema with two modes, fargo rather than a traditional foreign function interface, scope of a store that is local first, stack numbers) plus registry string fixtures. This is not a second markdown form checker.
7. **`checks.sssss_tests`** - companion meaning proofs for `0004_SSSSS.md` (sequential WordID rather than hashing as primary identity, LanguageID prefix only on change, Rosetta provenance tags, pipeline determinism, neural proposals reduced to sequential integers, natural language translation marked provisional unless proven or high confidence, durable state in beastdb, Systems Lean file `0002_Systems_Lean.md`) plus registry string fixtures. This is not a second markdown form checker.

Numbered specifications matched for Lean and spelling:

1. Glob at repository root: `[0-9][0-9][0-9][0-9]_*.md`
2. Basename regex: `^[0-9]{4}_[A-Za-z0-9_]+\.md$`
3. Examples: `0000_spec.md`, `0001_DOGE.md`, `0002_Systems_Lean.md`, `0003_beastdb.md`, `0004_SSSSS.md`
4. Not in the default scan: `README.md`, `AGENTS.md`, `UNLICENSE.md`, and anything under subdirectories

Optional convenience: `just` with no arguments lists recipes (`just --list` / `just -l`). See the root `justfile`.

### 7.2 Authoritative checkers (Lean form rules and spelling; pure Nix whitespace)

**Lean** (`lean/` binary `spec_check`, packaged as the only flake software package) is authoritative for mechanical form rules and American English spelling on **numbered specifications**. Tool SemVer for `spec_check` is independent of SemVer for numbered specifications; the tool is at 1.0.0 as its first intentional tool release (see section 4).

**Dual whitespace (both stay on purpose)**

| Surface | Who enforces it | Why it stays |
|---------|-----------------|--------------|
| Trailing whitespace and leading indent that uses tabs only on numbered specifications | Lean `spec_check` (form suite; pre-commit and `checks.spec_check`) | Same binary as ASCII, bullets, kebab, wrapping to a column, spelling; line diagnostics for authors |
| Same class of rules on Surmount authored text across the tree | Pure Nix `checks.whitespace` (`nix/whitespace.nix`) | Evaluation gate without a process; no second language; covers README, AGENTS, flake, SOURCE pins, not only specs |
| Overlap on numbered specifications | Both run on `nix flake check` | Intentional. Do not drop Lean whitespace "because Nix covers the tree," and do not move whitespace across the tree into Lean "for symmetry." Rationale: section 7.2.1 |

Lean coverage on numbered specifications:

1. Pure ASCII (tab, LF, printable 0x20-0x7E; no CR or high bytes).
2. No markdown bullet list markers (`-`, `*`, `+`) outside fenced code.
3. No excess hyphenated tokens in prose (lowercase token with two or more hyphens, for example `foo-bar-baz`), ignoring fenced code, inline code, and URLs.
4. In scope specs (`NNNN_*.md` with the naming scheme above) must cite RFC 2119 (or RFC2119). README is not required to carry that citation. License files are style excluded for bullets/kebab/RFC (ASCII and whitespace still checked).
5. No trailing whitespace (space or tab before end of line).
6. No leading indent with spaces (use tabs for nested markdown indent).
7. No prose wrapped to a column on numbered specifications (heuristic outside fences and tables; see `0000_spec.md` Clause 6.4).
8. American English spelling via `aspell list --lang=en_US --mode=markdown` with personal dictionary `aspell_words.txt` (pure hex and pure digit tokens skipped). Requires `aspell` with en_US on PATH; flake `checks.spec_check` and `nix develop` supply `pkgs.aspellWithDicts`. Skip with `SPECS_SPELLING=0` or `SPECS_SKIP_SPELLING=1`. There is no separate `checks.spelling` and no `nix/spelling-check.nix`.

**Whitespace across the project** is a separate **pure Nix** check (`nix/whitespace.nix`, flake output `checks.whitespace`). It is not bash and not Lean.

1. Same trailing whitespace and leading space rules on Surmount authored text (`*.md`, `*.nix`, SOURCE pins we write, and similar).
2. Skips vendor material: `ref/semver/**`, `*.pdf`, `ref/**/rfc2119.txt`.
3. Lean (`.lean`) and YAML (`.yml` / `.yaml`) are exempt from the leading space ban because those languages reject tab indent. They still must not have trailing whitespace.
4. On `nix flake check`, a violation list that is not empty fails Nix evaluation (`throw` with all messages). Success uses `pkgs.writeText` (no shell builder). Debug with `nix eval "path:$PWD#lib.whitespaceViolations"`.

Use `pkgs.aspellWithDicts` (English dictionaries bundled with the aspell wrapper). Bare `nix shell nixpkgs#aspell` or pairing `aspell` with `aspellDicts.en` as separate packages is not enough: aspell will report that no word lists can be found for `en_US`.

With no paths, `spec_check` discovers only numbered specifications at the root (same naming scheme).

#### Author tips for wrapping to a column

The Lean heuristic for wrapping to a column (normative algorithm in `0000_spec.md` Clause 6.4) fails when two consecutive body lines that are not empty look like a wrap in the middle of a sentence: the first line does not end with `.`, `!`, `?`, or `:`, and the next line starts with a lowercase letter. Fenced code and table rows are exempt.

What usually trips it:

1. A paragraph broken for column width so the continuation starts with a lowercase word on the next physical line.
2. A list item body split the same way across two physical lines.

How to fix:

1. Join each paragraph (and each list item body) into one physical line. Let the editor soft wrap.
2. Keep deliberate structure breaks: blank lines between paragraphs, one list item per line, headings, fences, tables.
3. A short full sentence that ends with `.` on its own line is fine even when the next line starts a new sentence with a capital letter.

Example that fails the heuristic (do not write this in numbered specifications):

```text
This sentence was broken for column width in the middle
of a thought and the next line starts lowercase.
```

Example that passes (one physical line per paragraph; shown wrapped only in this README for display if your viewer wraps):

```text
This sentence stays on one physical line so soft wrap is the reader's choice.
```

### 7.2.1 Why Lean vs pure Nix

This section records the design reasoning so future contributors do not "simplify" the wrong layer.

**Short answer:** pure Nix is right for simple rules across the tree that need no extra process. Lean is right for the form suite on numbered specifications and for anything that must run an external program (aspell). The flake is the interface; bash and Python are not check implementations.

| Concern | Pure Nix? | Where it lives |
|---------|-----------|----------------|
| Trailing whitespace / tab leading indent (whole tree) | Yes | `nix/whitespace.nix`, `checks.whitespace` |
| ASCII, bullets, kebab, RFC 2119 cite, wrapping to a column on `NNNN_*.md` | Possible, not chosen | Lean `spec_check` (maintainability) |
| Spelling with aspell | No as pure eval | Lean calls `aspell` on PATH |
| Fat shell/python loops in `runCommand` or `scripts/` | Forbidden | Never |

**Why pure Nix for whitespace across the project**

1. The rule set is small (trailing space/tab; leading space ban with known exemptions).
2. Implementation needs only fileset discovery, `readFile`, and line scans.
3. Evaluation *is* the check: empty list plus `writeText` success, or `throw` with diagnostics. No builder shell, no second language.

**Why Lean for form rules on numbered specifications and spelling**

1. **Spelling cannot be pure Nix evaluation.** Pure eval does not spawn processes. Automated en_US spelling needs `aspell`. Acceptable shapes: a real binary that calls it (current Lean path), or drop spelling from the gate. Unacceptable: multi line bash/python policy inside a derivation builder.
2. **Form rules beyond whitespace are a small linter** (fence tracking, strip inline code and URLs, excess kebab, heuristic for wrapping to a column, RFC citation). Those *can* be written in pure Nix the same way whitespace is, but they become long, slow to evaluate, and hard to test and debug in the evaluator. A packaged program with line diagnostics fits pre-commit and local authoring.
3. **One binary owns the suite for numbered specifications** (discovery of root `NNNN_*.md`, form rules, optional spelling skip via env). Nix packages it and runs a thin check; check policy does not live in shell strings.
4. **Flake stays idiomatic:** default package and app are the Lean `spec_check` binary; hermetic test binaries (`spec_check_tests`, `systems_lean_tests`, `beastdb_tests`, `sssss_tests`) are extra packages. Checks are pure whitespace plus thin invoke of those binaries plus pre-commit. No `writeShellApplication` gatekeeper packages.

**What not to do without an explicit decision**

1. Do not implement flake checks as bash or Python stuffed inside Nix (`writeShellApplication`, `scripts/` checkers, shell strings that span multiple lines as check policy). Form rules for numbered specifications live in the Lean `spec_check` binary. Trailing whitespace and tab indent across the tree live in pure Nix evaluation.
2. Do not move whitespace across the tree into Lean only for symmetry with form rules.
3. Do not assume "everything should be pure Nix" or "everything should be Lean." Match the rule to the mechanism: pure data rules to pure Nix; form policy that needs a process or that takes more than one pass to the Lean binary (or another real language package if the operator chooses to replace Lean later).

Agent facing copy of this split: `AGENTS.md` (Machine validation / Why Lean vs pure Nix). Keep both in sync when the authority model changes.

### 7.3 Run Lean directly

With `lean` / `lake` from nixpkgs (or `nix develop`):

```bash
cd lean && lake build
./.lake/build/bin/spec_check
./.lake/build/bin/spec_check 0000_spec.md 0001_DOGE.md 0002_Systems_Lean.md 0003_beastdb.md 0004_SSSSS.md
lake build systems_lean_tests
./.lake/build/bin/systems_lean_tests
lake build beastdb_tests
./.lake/build/bin/beastdb_tests
lake build sssss_tests
./.lake/build/bin/sssss_tests
```

Or via the flake (default package and default app are both the Lean binary):

```bash
nix build "path:$PWD#spec_check" -L
nix run "path:$PWD#spec_check"
nix run "path:$PWD#spec_check" -- 0000_spec.md
```

Exit status is nonzero when any check fails. Diagnostics go to stderr as `file:line: message`.

### 7.4 Run via Nix

```bash
# Canonical gate (local and CI): all flake checks
nix flake check "path:$PWD" --print-build-logs
# Optional sugar (same command):
just check
# Lean binary only:
nix run "path:$PWD#spec_check"
nix build "path:$PWD#spec_check" -L
# Individual checks (system name varies):
nix build "path:$PWD#checks.$(nix eval --impure --raw --expr builtins.currentSystem).spec_check" -L
nix build "path:$PWD#checks.$(nix eval --impure --raw --expr builtins.currentSystem).whitespace" -L
```

Flake layout:

1. **packages**: `spec_check` (Lean form checker binary, including the registry scan for numbered specifications; also `default`), plus hermetic test binaries `spec_check_tests`, `systems_lean_tests`, `beastdb_tests`, and `sssss_tests`.
2. **apps**: only `spec_check` (also `default` -> same binary path).
3. **checks**: `spec_check` (form rules + spelling + registry scan), `spec_check_tests`, `systems_lean_tests` (0002 meaning proofs, not form rules), `beastdb_tests` (0003 meaning proofs and registry fixtures, not form rules), `sssss_tests` (0004 meaning proofs and registry fixtures, not form rules), `whitespace`, `pre-commit-check` (each independent; no bash orchestrated aggregate package).
4. No `writeShellApplication` packages and no `scripts/` validation tools.

### 7.5 Systems Lean meaning proofs (not form rules)

Numbered specification `0002_Systems_Lean.md` is the contract that humans read. Companion Lean modules under `lean/SystemsLean.lean` encode selected checkable claims from that spec: the multiplicity set `{0, 1, omega}`, erasure of multiplicity 0 at compile time, a finite use count model for linear (exactly once), affine (at most once), erased (zero runtime uses), and unrestricted (any Nat of uses), a freestanding product wire with no managed Lean runtime and no garbage collection, residual honesty composed with that wire (Clause 5 item 2: well formed freestanding product, or every remaining blocker named and tracked), CompCert verified compilation and a bootstrapped Slake that fully typechecks as required Clause 5 conjuncts (a named residual does not excuse either), the novel language set (Idris 2, Lean 4 including Systems Lean, and pure Nix), Unlicense vs upstream `ref/` hygiene with product tree directory names `Idris2`, `lean4`, `CompCert`, and `rust`, stack targeting as a claim that fails when a Clause 4.4 component cannot target Slake, one Clause 5 conformance predicate over those facts, and the fact that this specification is number 0002 (the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md`, not 0003; beastdb is specified in `0003_beastdb.md`). Optional LLVM IR emission is modeled and is not required for conformance.

Those modules are meaning proofs. They do not replace the markdown spec. They do not duplicate `spec_check` form rules (ASCII, tabs, RFC 2119 citation, spelling, wrapping to a column, kebab, bullets). Form checking remains `checks.spec_check`. Meaning model tests are `checks.systems_lean_tests` (Lake executable `systems_lean_tests`).

This is the same split described in Clause 1.2 of `0002_Systems_Lean.md`: numbered markdown is the contract that humans read; Lean theorems are a separate model of selected clauses, not the spec.

### 7.6 beastdb meaning proofs and the number registry

Numbered specification `0003_beastdb.md` is the contract that humans read for beastdb. Companion Lean modules under `lean/BeastDb.lean` encode selected checkable claims from that spec: the lowercase product name beastdb, the library name libbeastdb, Systems Lean plus a bootstrapped Slake that fully typechecks and CompCert as required, proven ACID and tries that do not use locks as required, SWMR required with more than one writer on disjoint leaves optional, mandatory schema with predefined and inferred modes, interoperability through fargo and not a traditional foreign function interface, the scope of a store that is local first with network features out of scope, Carbonado unassigned, and this specification as number 0003 (not 0002, not 0004). Those modules are meaning proofs. They do not replace the markdown spec. Meaning model tests are `checks.beastdb_tests` (Lake executable `beastdb_tests`).

The registry for numbered specifications is `lean/SpecRegistry.lean`. It encodes published rows (0000 spec spec, 0001 DOGE, 0002 Systems Lean, 0003 beastdb, 0004 SSSSS) and planned rows (0005 fargo). Theorems pin unique numbers, beastdb = 3, Systems Lean = 2, SSSSS = 4, fargo planned = 5, and Carbonado unassigned. `spec_check` runs an IO scan of root `NNNN_*.md` files so a wrong number, a file name mismatch, a planned file that exists, or a wrong capitalization of beastdb fails `checks.spec_check` and therefore `nix flake check`. Registry string fixtures also run in `checks.beastdb_tests` and `checks.sssss_tests`.

### 7.7 SSSSS meaning proofs (not form rules)

Numbered specification `0004_SSSSS.md` is the contract that humans read for SSSSS. Companion Lean modules under `lean/Sssss.lean` encode selected checkable claims from that spec: this specification as number 0004 with file name `0004_SSSSS.md`, Systems Lean as 0002, beastdb as 0003, fargo planned as 0005, sequential WordID rather than hashing as primary identity, LanguageID prefix only on language change, a language run as LanguageID plus a WordID list, Rosetta provenance tags, pipeline determinism given the same vocabulary and relation set, durable state in beastdb, neural proposals reduced to sequential integers before acceptance, natural language translation marked provisional unless proven or high confidence, CompCert and a Slake bootstrap that fully typechecks for components that are safety critical with residual honesty not substituting, and the fact that a stale Systems Lean file name `0003_systems_lean.md` fails. Those modules are meaning proofs. They do not replace the markdown spec. Meaning model tests are `checks.sssss_tests` (Lake executable `sssss_tests`). This specification does not claim a conforming implementation exists. Lean Machine has no numbered specification.

## 8. Development shell and pre-commit

This project uses a Nix flake so that a pre-commit hook can run the Lean validator when you commit on a machine with the development shell installed.

1. Enter the shell (installs the repository pre-commit hook via the flake shell hook):

```bash
nix develop "path:$PWD"
# or: just dev
```

2. Optionally run hooks on every file without committing:

```bash
nix develop "path:$PWD" -c pre-commit run --all-files
```

3. Tools on the shell `PATH` include `just`, `lean` / `lake` (nixpkgs lean4), `spec_check`, `aspell` via `aspellWithDicts` (`en_US`) for local ad hoc use, and `git`. Spelling and whitespace across the project are flake checks, not shell package aliases. Use `nix flake check` for the full gate, or `nix eval "path:$PWD#lib.whitespaceViolations"` to debug whitespace.

The pre-commit Lean hook matches only numbered specifications (`^[0-9]{4}_[A-Za-z0-9_]+\.md$`), so README, AGENTS, and UNLICENSE are not subject to full RFC 2119 / style rules unless you pass them to `spec_check` explicitly. Whitespace across the project is enforced by pure Nix `checks.whitespace` on `nix flake check`, not by a bash pre-commit hook.

`.pre-commit-config.yaml` is generated by git-hooks.nix when you enter `nix develop` (it is typically a store symlink, not a hand maintained source file). Do **not** hand edit that file; change hook definitions in `flake.nix` and reenter the development shell so the generated config refreshes. Prefer the flake and this README over hard coding third party hook product names as process law.

## 9. Residual

Remaining work for the numbered specification program is written in full in [RESIDUAL.md](RESIDUAL.md). Clause 6 of [0003_beastdb.md](0003_beastdb.md) is the residual record for that specification. Clause 6 of [0004_SSSSS.md](0004_SSSSS.md) is the residual record for SSSSS. A parenthetical planned file name in Scope is not enough by itself.

Do not create `0005_fargo.md` or a numbered specification for Carbonado unless the operator asks. Do not treat 0006 as assigned. Do not claim a conforming beastdb or SSSSS implementation exists. Lean Machine has no numbered specification.

## 10. Project skill `/surmount-specify`

Grok Build encodes numbered specifications in this repository with the project skill at `.agents/skills/surmount-specify/SKILL.md`. Run `/surmount-specify` when pasting a spec draft or adding a numbered specification. The skill is this repository only. Project skills live under `.agents/skills/`, not `~/.grok` and not `.grok/skills/`. It does not replace `0000_spec.md`. It tells the agent to keep spec markdown separate from Lean proofs, update `lean/SpecRegistry.lean`, write residual in full, and run `nix flake check "path:$PWD" --print-build-logs`.

## 11. License

This work is released into the public domain under the Unlicense. See [UNLICENSE.md](UNLICENSE.md). SPDX license identifier: `Unlicense`.
