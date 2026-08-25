# Agent rules (Surmount specs)

## HARD RULE: no git unless explicitly instructed

**NEVER** use git in this repository unless the operator has **explicitly** instructed you to run git for that task.

1. Do **not** run any `git` command (status, diff, add, stage, unstage, commit, push, pull, fetch, checkout, branch, stash, log, rebase, merge, restore, reset, sparse-checkout, or wrappers/aliases that invoke git).
2. Do **not** stage, unstage, or touch the index. Do **not** create commits.
3. Do **not** assume git intent from nearby work (README, hooks, Nix, specs). Validation and file edits do **not** imply git permission.
4. Pre-commit hooks, `nix develop` hook install, and similar tooling may run only as part of validation the operator asked for. They are **not** a green light to invoke git for staging or history.
5. If git seems required and the operator did not clearly ask: **stop and ask**. Never invent authorization.
6. **Exception only when the operator explicitly asks for that git work.** Example: "submodule refs under `ref/`" allows the git commands needed for those submodules, and nothing else (no drive by stage of unrelated files, no commit, no push unless also asked).

This rule is stricter than the global agent default. In this repo it wins.

## Plain English

Write so a tired human can read it. No decoder ring jargon ("soft labeling", "join artifact", step codes). Name the real thing.

When asking the operator a decision, write a complete American English question. Say which file or clause, quote the current wording, say why the choice matters, and name the options. Do not send a half label such as "Keep or replace coined labels?" as if that were the question.

## Reduce hyphenation in prose

Prefer ordinary English over hyphenated compounds. People who are not writing legal captions rarely hyphenate. Do not write lawyerly modifiers such as `high-assurance` or `lock-free`. Do not "fix" them by deleting the hyphen and leaving the same two words (`high assurance`, `lock free`, `non markdown`, `must like`, `LF only`). Rephrase so a person would actually say it (`high assurance` can stay when it is already natural; `tooling that is not markdown`; `rules that sound like MUST`; `line endings that are LF only (no CR)`). Keep a hyphen only when the token is a filename, a URL, a code identifier, or an official designation that is spelled with a hyphen (for example `ITU-T`). This applies to numbered specifications, README, this file, `RESIDUAL.md`, and project skills.

## Do not persist operator profanity

Never copy the operator's swear words into AGENTS.md, specs, README, residual notes, commits, board titles, or other durable files. Paraphrase cleanly.

## Machines are not humans

Do not perform hurt feelings, offense, or apology theater over strong human language. Stay a tool. Fix the work. Move on.

## Versioning (SemVer)

1. Specs use **Semantic Versioning (SemVer)**.
2. Do **not** invent version bumps, changelog "releases", or `0.x` theater for work that was never published. Do not claim publication the operator has not declared.
3. First publication of a specification is **1.0.0** (not a fake 0.1 that was never released). Specs MAY carry a SemVer version line; agents must not invent intermediate shipped versions that never existed.
4. The Lean tool `spec_check` has its **own** SemVer, independent of SemVer for numbered specifications. Bumping the tool does not require bumping `0000_spec.md` or other numbered specifications, and a version bump on a numbered specification does not imply a tool bump. The tool is at **1.0.0** as its first intentional tool release.

## Spec file location (repository root only)

Numbered specs are only `NNNN_descriptive_name.md` in the **repository root**. Do **not** invent a nested layout (`specs/`, `docs/specs/`, and similar). Flat root layout is intentional (same spirit as bitcoin/bips). See `0000_spec.md` Clauses 1.1 and 11.1, and `README.md`.

Stack numbers in this repository:

1. 0000 = spec spec (`0000_spec.md`)
2. 0001 = DOGE (`0001_DOGE.md`)
3. 0002 = Systems Lean (`0002_Systems_Lean.md`)
4. 0003 = beastdb (`0003_beastdb.md`). The product name is always the lowercase form `beastdb`. Never mixed case forms.
5. 0004 = Smart Symbolic Supercompiler (`0004_SSSSS.md`)
6. 0005 = fargo, planned file `0005_fargo.md` (**do not create the file**)
7. Carbonado Network Protocol: deferred, discussed as a possible later 0006; **do not create a file**; **do not treat 0006 as assigned** until a numbered specification exists.

## Residual for numbered specifications (must be complete on disk)

Residual for numbered specifications MUST be written in full on disk: a residual clause in the numbered specification and/or `RESIDUAL.md` at the repository root. A parenthetical planned file name in Scope is not enough by itself. List unpublished specifications, unassigned numbers, unpinned prior art, unimplemented product claims, and out of scope items the document names. Use complete sentences. Do not invent shipped versions for unpublished specs. Do not create numbered specification files the operator forbade (today: `0005_fargo.md` and any Carbonado numbered file).

## Project skills live under `.agents/skills/`

Project skills for this repository MUST live under `.agents/skills/`. That is the project skill home. It is not `~/.grok` (host Grok config). It is not `.grok/skills/` at the repository root. Do not create a project `.grok/` for skills.

## Project skill `/surmount-specify`

This repository's Grok Build skill for encoding numbered specifications is `.agents/skills/surmount-specify/SKILL.md`. Use `/surmount-specify` when pasting a spec draft or adding a numbered specification. It is this repository only. Form authority remains `0000_spec.md`. Stack number authority remains this file plus `lean/SpecRegistry.lean`.

## README stays current

When you change specs, validation, Nix, or process that the README describes, **update the README in the same effort** unless the operator says to skip it. Do not leave the README describing an old checklist by default.

## External references (`ref/`)

**Point of `ref/`:** local pins of external standards Surmount specs cite, so readers and tools can open the exact text meant. Publisher hyperlinks still matter as publisher links in SOURCE and citations. Local copies freeze what was reviewed.

**Binding rule:** any external specification this repository cites MUST be present under `ref/` in one of two honest forms.

1. **Form 1: Canonical git that the publisher maintains.** Add under `ref/` as a **git submodule** from that publisher git URL (any host, not assumed GitHub). Pin a tag or commit. Example: SemVer at `ref/semver` (github.com/semver/semver).
2. **Form 2: No canonical git that the publisher maintains** (common for standards from before git and from the PDF era). Form 2 is intentional, not a fallback: keep a **local copy** of the **official publisher artifact** under `ref/<name>/`, committed **directly in this repository's git tree** (ordinary files, **not** a submodule), with `SOURCE` (canonical URL, retrieval date, checksum, edition). Form 2 is used when the publisher does not maintain canonical git. In `ref/README.md` you must say that there is no publisher git, record license and copyright, and record why Form 2 was used. Publisher hyperlinks still matter as publisher links. That **does** satisfy the ref/ rule. Examples: RFC 2119 (`ref/rfc2119`, RFC Editor txt), ECMA-48 (`ref/ecma48`, Ecma International PDF), ITU-T T.416 (`ref/itu_t416`, ITU free PDF; dual text ISO/IEC 8613-6).
3. Prefer honesty: never invent a third party mirror as "canonical git." Community reformats (for example random GitHub copies of RFCs, or wez/ecma48-style repos) are **not** the publisher's canonical source.
4. Prefer Form 1 when the publisher truly maintains git; Form 2 when not. Standards from before git and from the PDF era are expected to use Form 2.
5. Process detail (point of ref, two forms, why we pin this way, per-entry licenses): `ref/README.md`. Also root `README.md` and `0000_spec.md` Clause 12.

## Whitespace and layout

1. Spec prose is not wrapped to a column (one physical line per paragraph or list item body). Readers soft wrap.
2. Leading indentation uses tabs, not spaces. Spaces in the middle of a line and in tables are fine. No trailing whitespace.
3. Lean sources and YAML use spaces for indent (language/tooling requirement). Numbered specs still use tabs.
4. **Dual whitespace is intentional.** Both layers stay; do not drop one for "symmetry" or "dedup."
	1. **Numbered specifications:** Lean `spec_check` enforces trailing whitespace and leading indent that uses tabs only as part of the form suite (with ASCII, bullets, kebab, wrapping to a column, RFC 2119, spelling).
	2. **Surmount authored text across the project:** pure Nix flake check (`nix/whitespace.nix`, `checks.whitespace`) enforces trailing whitespace and leading indent that uses tabs only on README, AGENTS, flake, SOURCE pins, and similar (not bash, not Lean).
	3. Overlap on numbered specifications is expected on `nix flake check`. Rationale: `README.md` section 7.2 / 7.2.1 and the subsection below.
5. **Form rules for numbered specifications** (ASCII, bullets, kebab, RFC 2119, wrapping to a column, and whitespace on those files): **Lean** `spec_check`, packaged through Nix. `nix flake check` runs Lean and pure Nix whitespace together.

## Machine validation: Lean + Nix

Mechanical form rules for numbered specifications from the Surmount spec spec (`0000_spec.md`) are checked by **Lean**, packaged and run through **idiomatic modern Nix** (one package binary, flake checks, dev shell, pre-commit). Trailing whitespace and tab indent across the project are a separate **pure Nix** evaluation check. American English spelling on numbered specifications is also **Lean** (`spec_check` calls `aspell` from PATH with personal list `aspell_words.txt`); flake `checks.spec_check` puts `aspellWithDicts` on PATH. There is no separate `checks.spelling` and no `nix/spelling-check.nix`. Do not implement flake checks as bash or Python stuffed inside Nix. `writeShellApplication` wrappers and `scripts/` checkers are gone. Form rules for numbered specifications live in the Lean `spec_check` binary. Trailing whitespace and tab indent across the tree live in pure Nix evaluation.

| Concern | Authority | Notes |
|---------|-----------|--------|
| Form rules + spelling on `NNNN_*.md` | Lean `spec_check` | Includes WS on those files; tool SemVer independent of spec SemVer (tool 1.0.0). Also runs the registry scan for numbered specifications (wrong numbers, file name mismatches, wrong `beastdb` capitalization). |
| Systems Lean meaning (spec 0002) | Lean `SystemsLean` library + `systems_lean_tests` | Companion model of selected clauses; not a second markdown linter |
| beastdb meaning (spec 0003) | Lean `BeastDb` library + `beastdb_tests` | Companion model of selected clauses plus registry fixtures; not a second markdown linter |
| SSSSS meaning (spec 0004) | Lean `Sssss` library + `sssss_tests` | Companion model of selected clauses plus registry fixtures; not a second markdown linter |
| Trailing WS / tab indent across the tree | Pure Nix `checks.whitespace` | Surmount authored text; skips vendor under `ref/` as documented |
| Dual WS overlap on numbered specifications | Both | Intentional; keep both |

Human oriented detail of the same split: `README.md` section 7 (especially **7.2 Dual whitespace** and **7.2.1 Why Lean vs pure Nix**). Normative dual WS statement and design cross-link: `0000_spec.md` Clause 17.1. Keep this file and the README aligned when the split changes.

### Why Lean vs pure Nix (inform future contributions)

This split is intentional. It is **not** "Nix cannot check text" and **not** "everything must be Lean."

**What pure Nix is for**

1. Trailing whitespace and leading indent that uses tabs only, across the project (`nix/whitespace.nix`, `checks.whitespace`).
2. Rules that need only `readFile`, line/char scans, and a violation list or `throw` at evaluation time.
3. Success markers without a shell builder when possible (`pkgs.writeText`).

**What Lean (`spec_check`) is for**

1. Mechanical form rules for numbered specifications: pure ASCII, no bullet lists outside fences, excess kebab (after stripping inline code and URLs), RFC 2119 citation, trailing WS and leading spaces on those files, heuristic for wrapping to a column.
2. American English spelling by calling **aspell** as a real process (`IO.Process`), with personal list `aspell_words.txt`.
3. A packaged binary pre-commit and humans can run with `file:line: message` diagnostics.

**Why not pure Nix for the whole Lean suite**

1. **Spelling cannot be pure evaluation.** Pure Nix does not run external programs. `aspell` requires a process. Options are: a real binary that calls it (Lean), a fat builder shell/python loop (forbidden here), or drop automated spelling.
2. **Form rules 1-6 are possible in pure Nix** (same tools as whitespace) but they are text policy that takes more than one pass (fence tracking, URL/inline stripping, kebab scan, heuristic for wrapping to a column). That is a small linter. In pure Nix it tends to be long, slow to evaluate, hard to unit test, and painful to debug compared with a normal language.
3. **Eval fail UX** (`throw` with a giant string) is fine for a short whitespace list. A binary exit code plus line diagnostics fits pre-commit and iterative authoring better for the full form suite.
4. **Flake stays thin.** Nix owns packages, checks, dev shell, and pure whitespace. Check **policy** for numbered specifications lives in Lean, not in shell strings that span multiple lines inside `runCommand`.

**Forbidden alternatives**

1. Do **not** reintroduce `writeShellApplication`, `scripts/` checkers, or flake checks implemented as bash or Python.
2. Do **not** move whitespace across the project into Lean "for symmetry." Simple rules across the tree stay pure Nix.
3. Do **not** invent a third language runtime for checks without an explicit operator decision.

**If you change the split**

1. Update this section, `README.md` section 7, and any Clause in `0000_spec.md` that names the authoritative checkers, in the same effort.
2. Prefer porting only pure rules that need no extra process into `nix/` if the operator asks for more Nix. Keep rules that need a process (aspell) in a real binary or drop them from the gate.

### Local and CI gate

**Nix is the primary interface.** The canonical local and CI validation command is:

```bash
nix flake check "path:$PWD" --print-build-logs
```

CI (`.github/workflows/check.yml`) runs that Nix command directly after installing Nix. It does **not** go through `just`.

`just check` is optional convenience sugar that runs the same Nix line. You do not need `just` if you invoke Nix yourself. See root `justfile`, `flake.nix`, and `README.md`.

Flake layout:

1. **packages / apps**: Lean `spec_check` is the default package and the default app (form rules, spelling, and the registry scan for numbered specifications). Hermetic test binaries `spec_check_tests`, `systems_lean_tests`, `beastdb_tests`, and `sssss_tests` are additional packages, not additional apps.
2. **checks** (separate; flake check runs all): `spec_check` (Lean form rules + spelling + registry scan for numbered specifications via thin `runCommand` with package binary and `aspellWithDicts` on PATH), `spec_check_tests` (form helper unit tests), `systems_lean_tests` (companion meaning proofs for `0002_Systems_Lean.md`; not form rules), `beastdb_tests` (companion meaning proofs for `0003_beastdb.md` and registry fixtures; not form rules), `sssss_tests` (companion meaning proofs for `0004_SSSSS.md` and registry fixtures; not form rules), `whitespace` (pure Nix; `nix/whitespace.nix`; success is `writeText`, failure is `throw`), `pre-commit-check` (Lean hook on numbered specifications; spelling rides along when aspell is on PATH).
3. Numbered specifications only for Lean form rules and spelling: `^[0-9]{4}_[A-Za-z0-9_]+\.md$` at repository root.
4. Debug whitespace: `nix eval path:$PWD#lib.whitespaceViolations`.
5. Run Lean alone: `nix run path:$PWD#spec_check` or `nix build path:$PWD#spec_check` (aspell must be on PATH for spelling, or set `SPECS_SPELLING=0` / `SPECS_SKIP_SPELLING=1` to skip). Meaning model tests: `nix build path:$PWD#systems_lean_tests`, `nix build path:$PWD#beastdb_tests`, and `nix build path:$PWD#sssss_tests` then run the installed binaries, or `nix flake check` which includes `checks.systems_lean_tests`, `checks.beastdb_tests`, and `checks.sssss_tests`.
