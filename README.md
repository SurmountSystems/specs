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
8. [Development shell and pre-commit](#8-development-shell-and-pre-commit)
9. [License](#9-license)

## 1. What this repository is

Surmount miscellaneous specifications are short normative documents for interfaces, formats, and design constraints that do not belong in a larger product tree. Specs are pure ASCII markdown, written in American English, versioned with real Semantic Versioning when published, and checked by automated tools packaged through Nix.

Numbered specs live only in the repository root as files named `NNNN_descriptive_name.md` (for example `0000_spec.md`, `0001_DOGE.md`). They are not nested under a `specs/` subdirectory or similar. That flat root layout is the same spirit as the bitcoin/bips repository: numbered proposals at the root.

The binding rules for form live in [0000_spec.md](0000_spec.md). This README orients humans and agents; it is not itself a full specification.

## 2. Current specifications

1. [0000_spec.md](0000_spec.md) - Surmount spec spec (spec 0), version 1.0.0. Defines how specs in this repository are written, named, versioned, cited, and checked.
2. [0001_DOGE.md](0001_DOGE.md) - Digital Octal Graphical Emissive (DOGE) color specification, version 1.0.0. Defines a pure 3 bit RGB palette of eight colors with fixed sRGB values, ECMA-48 SGR mapping, and two quantization methods. Uses RFC 2119 requirement keywords; cites RFC 2119, ECMA-48, and ITU-T T.416 / ISO/IEC 8613-6 under `ref/`.

## 3. Document rules

All new specification prose SHALL follow [0000_spec.md](0000_spec.md). Summary for everyday use:

1. American English spelling and wording throughout (en_US).
2. Pure ASCII characters only (no Unicode punctuation or non-ASCII letters). Use ASCII `-`, straight quotes, and `...` (three periods). Files use LF-only line endings (no CR).
3. Avoid excess hyphenation and kebab case in prose. Prefer spaces or compound words. The automated checker fails on lowercase identifiers with two or more hyphens (three or more segments), for example `foo-bar-baz`. Single-hyphen compounds such as `pre-commit` are allowed by the current mechanical checker.
4. Enumerate sections and lists clearly. Use numbered or lettered lists. Do not use markdown bullet markers (`-`, `*`, `+`) outside fenced code.
5. Do not hard-wrap prose for column width. Prefer one physical line per paragraph and per list item body. Soft wrap is the reader's editor setting. Deliberate breaks stay for headings, blank lines, list items, tables, and fenced code.
6. Leading indentation uses tab characters only (not spaces). Spaces mid-line and inside table cells are fine. Nested lists indent with tabs. No trailing spaces or tabs at end of line.
7. Maintain high precision. Label open questions and implementation-defined behavior. Do not leave silent gaps implementers need filled.
8. Name files `NNNN_descriptive_name.md` with a four digit prefix and underscores in the descriptive part (not kebab-case basenames). Place them only in the repository root (not under a nested `specs/` folder). `0000` is reserved for the spec spec (`0000_spec.md`).
9. Background, history, and design-reasoning text is informative. Requirements use RFC 2119 keywords (MUST, SHALL, SHOULD, MAY, and related words) in the RFC 2119 sense. Informative sections should be titled or opened so readers can tell they are not requirements (for example "Algorithm selection reasoning"). Do not invent private requirement jargon; use ordinary English plus RFC 2119. An RFC 2119 keyword still makes a sentence normative even inside an otherwise informative section; prefer keeping requirements in normative sections.
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

## 5. RFC 2119 requirement keywords

Specs SHALL use RFC 2119 keywords in the RFC 2119 sense:

MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, OPTIONAL.

Cite RFC 2119 (local path when present under `ref/`, for example `ref/rfc2119`). Uppercase keywords in normative clauses are recommended for scanability. Do not invent a private rule that bans MUST or redefines these words. Background and design-reasoning prose is informative; label such sections clearly. See [0000_spec.md](0000_spec.md) Clause 4.2.

## 6. External references (`ref/`)

`ref/` holds the external standards this repository cites so readers and tools can open the **exact** text meant without hunting the web. Hyperlinks to publisher pages still matter; canonical URLs stay in SOURCE and in citations. Local copies freeze what was reviewed and checksummed or git-pinned. Full process, reasoning, and per-entry license notes: [ref/README.md](ref/README.md). Normative summary: [0000_spec.md](0000_spec.md) Clause 12.

1. Binding rule: any external specification this repository cites MUST be present under `ref/` in one of two honest forms:
	1. **Form 1: Canonical publisher git exists.** Git submodule from the publisher's canonical git repository (any host, not assumed GitHub), pinned to a tag or commit.
	2. **Form 2: No canonical publisher git.** Keep a local copy of the specific official publisher artifact (PDF, plain text, or similar) under `ref/<name>/`, committed **directly in this repository's git tree** (ordinary files, **not** a submodule), with a `SOURCE` file (canonical URL, retrieval date, checksum, edition or version). Document no-publisher-git, license/copyright, and reasoning in `ref/README.md`. Hyperlinks to the publisher stay first-class. That form **does** satisfy the rule and is the intentional process for pre-git and PDF-era standards (RFC 2119, ECMA-48, ITU-T T.416, similar), not a fallback failure.
2. Prefer honesty: never invent a third-party mirror or community reformat as "canonical git." Prefer Form 1 when the publisher truly maintains git for that standard; Form 2 when that is what the publisher ships.
3. Adding a new external citation in a spec requires adding or updating the matching `ref/` entry under that process.
4. Present entries (all valid under the rule above):
	1. SemVer (`ref/semver`) - Form 1 git submodule of https://github.com/semver/semver , pinned to tag `v2.0.0` (commit `7c834b3f3a4940d77ab593bc32583004d6a426a9`). Upstream doc license: CC BY 3.0. See `ref/semver.SOURCE` and `ref/README.md`.
	2. RFC 2119 (`ref/rfc2119`) - Form 2 official RFC Editor plain text, committed directly in this tree (not a submodule), with SOURCE. Canonical publication is https://www.rfc-editor.org/rfc/rfc2119.txt ; there is no publisher-maintained canonical git for this historic RFC. IETF Trust / RFC copyright; freely available from the RFC Editor; Surmount does not own the text. See `ref/rfc2119/SOURCE` and `ref/README.md`.
	3. ECMA-48 (`ref/ecma48`) - Form 2 official Ecma International PDF, committed directly in this tree (not a submodule), with SOURCE. Ecma text copyright policy allows unchanged republication with notice. Community reformats are not the Ecma publisher source. See `ref/ecma48/SOURCE` and `ref/README.md`.
	4. ITU-T T.416 / ISO/IEC 8613-6 (`ref/itu_t416`) - Form 2 official ITU free PDF (Recommendation T.416, 03/93; identical text also published as ISO/IEC 8613-6), committed directly in this tree (not a submodule), with SOURCE. No publisher-maintained canonical git. Surmount does not own the text. See `ref/itu_t416/SOURCE` and `ref/README.md`.
5. Paths may be documented before the directories are populated. Empty paths are not an excuse to drop the public citation.
6. `git submodule add` has no `--dry-run`. Preflight a new Form 1 submodule with `git ls-remote <url>` and an optional temporary clone outside the tree.
7. After this repository has its first commit with submodule gitlinks, clones populate Form 1 submodules with:

```bash
git submodule update --init --recursive
```

	Or clone with `git clone --recurse-submodules <url>`. Those commands apply only to real Form 1 submodules (for example `ref/semver`). Form 2 pins such as `ref/rfc2119`, `ref/ecma48`, and `ref/itu_t416` are ordinary files in this repository's git tree and need no submodule init.

## 7. Validation (Lean and Nix)

### 7.1 Local and CI gate (Nix first-class)

**Nix is the first-class interface** for validation. The canonical command for local work and GitHub Actions is:

```bash
nix flake check "path:$PWD" --print-build-logs
```

CI installs Nix and runs that command directly (workflow: `.github/workflows/check.yml`). It does **not** install or invoke `just`.

`just` is optional local sugar only. `just check` runs the same Nix flake check line; you do not need `just` if you call Nix yourself. Prefer `path:` when local flake files may be untracked so pure git-tree eval is not required.

What the flake checks cover:

1. **`checks.numbered_specs`** - primary content gate. Discovers repository-root numbered specs only and runs Lean `spec_check` plus legacy aspell spelling.
2. **`checks.spec_check`** - Lean-only default discovery (same numbered set).
3. **`checks.whitespace`** - trailing whitespace and tab-only leading indent on project-owned text (skips vendor blobs under `ref/semver`, PDFs, and RFC plain text; Lean and YAML may use space indent).
4. **`checks.pre-commit-check`** - sandboxed pre-commit suite (Lean hook on numbered specs; whitespace hook on project text).

Numbered specs matched for that gate:

1. Glob at repository root: `[0-9][0-9][0-9][0-9]_*.md`
2. Basename regex: `^[0-9]{4}_[A-Za-z0-9_]+\.md$`
3. Examples: `0000_spec.md`, `0001_DOGE.md`
4. Not in the default scan: `README.md`, `AGENTS.md`, `UNLICENSE.md`, and anything under subdirectories

Package entry point used by the primary check:

```bash
nix run "path:$PWD#check_numbered_specs"
# or, after nix develop:
check_numbered_specs
```

Optional convenience: `just` with no arguments lists recipes (`just --list` / `just -l`). See the root `justfile`.

### 7.2 Authoritative checker (Lean)

The authoritative automated checker for mechanical form rules from the Surmount spec spec is the Lean 4 program under `lean/` (`spec_check`), packaged through this repository's Nix flake (packages, flake checks, development shell, and pre-commit hook).

Lean coverage:

1. Pure ASCII (tab, LF, printable 0x20-0x7E; no CR or high bytes).
2. No markdown bullet list markers (`-`, `*`, `+`) outside fenced code.
3. No excess kebab case in prose (lowercase token with two or more hyphens, for example `foo-bar-baz`), ignoring fenced code, inline code, and URLs.
4. In-scope specs (`NNNN_*.md` with the naming scheme above) must cite RFC 2119 (or RFC2119). README is not required to carry that citation. License files are style-excluded for bullets/kebab/RFC (ASCII and whitespace still checked).
5. No trailing whitespace (space or tab before end of line).
6. No leading space indentation (use tabs for nested markdown indent).
7. No hard-wrapped prose on numbered specs (heuristic outside fences and tables; see `0000_spec.md` Clause 6.4).

Project-wide whitespace (package `check_whitespace` / `nix run path:$PWD#check_whitespace`):

1. Same trailing-whitespace and leading-space rules on Surmount-authored text (`*.md`, `*.nix`, scripts, SOURCE pins we write, and similar).
2. Skips vendor material: `ref/semver/**`, `*.pdf`, `ref/**/rfc2119.txt`.
3. Lean (`.lean`) and YAML (`.yml` / `.yaml`) are exempt from the leading-space ban because those languages reject tab indent. They still must not have trailing whitespace.

With no paths, `spec_check` discovers only root numbered specs (same naming scheme). Spelling (American English via `aspell` and `aspell_words.txt`) remains on the legacy bash helper until ported; `check_numbered_specs` runs both.

### 7.3 Run Lean directly

With `lean` / `lake` from nixpkgs (or `nix develop`):

```bash
cd lean && lake build
./.lake/build/bin/spec_check
./.lake/build/bin/spec_check 0000_spec.md 0001_DOGE.md
```

`scripts/run_checks` prefers `spec_check` on `PATH`, then a local lake build, then the legacy bash script.

Exit status is nonzero when any check fails. Diagnostics go to stderr as `file:line: message`.

### 7.4 Legacy bash helper (spelling)

`scripts/check_spec_rules` still provides bash checks including `aspell` spelling (American English `en_US`, personal list `aspell_words.txt`). Nix exposes it as `check_spec_rules_legacy`. The combined gate `check_numbered_specs` invokes this path for spelling after Lean passes.

Spelling under Nix uses `pkgs.aspellWithDicts` (English dictionaries bundled with the aspell wrapper). Bare `nix shell nixpkgs#aspell` or pairing `aspell` with `aspellDicts.en` as separate packages is not enough: aspell will report that no word lists can be found for `en_US`. The flake packages and `nix develop` shell already wire `aspellWithDicts`. The legacy package wrapper puts `aspell` on `PATH` when you run the binary (`nix run ...#check_spec_rules_legacy`); opening a bare `nix shell ...#check_spec_rules_legacy` does not put `aspell` on `PATH` by itself.

```bash
./scripts/check_spec_rules
# Prefer path: when local flake files may be untracked (pure eval / git tree):
nix run "path:$PWD#check_spec_rules_legacy" -- 0000_spec.md
nix run "path:$PWD#check_numbered_specs"
```

### 7.5 Run via Nix

```bash
# Canonical gate (local and CI):
nix flake check "path:$PWD" --print-build-logs
# Optional sugar (same command):
just check
nix run "path:$PWD#check_numbered_specs"
nix run "path:$PWD#spec_check"
nix build "path:$PWD#spec_check" -L
nix build "path:$PWD#checks.$(nix eval --impure --raw --expr builtins.currentSystem).numbered_specs" -L
```

Package names: `spec_check` (Lean binary), `check_numbered_specs` (Lean + aspell on root numbered specs), `check_whitespace` (project text trailing/leading whitespace), `check_spec_rules` (Lean wrapper), `check_spec_rules_legacy` (bash + aspell).

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

3. Tools on the shell `PATH` include `just`, `lean` / `lake` (nixpkgs lean4), `spec_check`, `check_numbered_specs`, `check_whitespace`, `check_spec_rules` (Lean wrapper), the legacy bash checker, `aspell` via `aspellWithDicts` (`en_US`), and `git`.

The pre-commit Lean hook matches only numbered specs (`^[0-9]{4}_[A-Za-z0-9_]+\.md$`), so README, AGENTS, and UNLICENSE are not subject to full RFC 2119 / style rules unless you pass them to a checker explicitly. The whitespace pre-commit hook runs `check_whitespace` on passed filenames (and flake check `checks.whitespace` scans the tree).

Hook configuration is generated from `flake.nix`. Prefer the flake and this README over hard-coding third party hook product names as process law.

## 9. License

This work is released into the public domain under the Unlicense. See [UNLICENSE.md](UNLICENSE.md). SPDX license identifier: `Unlicense`.
