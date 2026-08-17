# Agent rules (Surmount specs)

## HARD RULE: no git unless explicitly instructed

**NEVER** use git in this repository unless the operator has **explicitly** instructed you to run git for that task.

1. Do **not** run any `git` command (status, diff, add, stage, unstage, commit, push, pull, fetch, checkout, branch, stash, log, rebase, merge, restore, reset, sparse-checkout, or wrappers/aliases that invoke git).
2. Do **not** stage, unstage, or touch the index. Do **not** create commits.
3. Do **not** assume git intent from nearby work (README, hooks, Nix, specs). Validation and file edits do **not** imply git permission.
4. Pre-commit hooks, `nix develop` hook install, and similar tooling may run only as part of validation the operator asked for. They are **not** a green light to invoke git for staging or history.
5. If git seems required and the operator did not clearly ask: **stop and ask**. Never invent authorization.
6. **Exception only when the operator explicitly asks for that git work.** Example: "submodule refs under `ref/`" allows the git commands needed for those submodules, and nothing else (no drive-by stage of unrelated files, no commit, no push unless also asked).

This rule is stricter than the global agent default. In this repo it wins.

## Plain English

Write so a tired human can read it. No decoder-ring jargon ("soft labeling", "join artifact", step codes). Name the real thing.

## Do not persist operator profanity

Never copy the operator's swear words into AGENTS.md, specs, README, residual notes, commits, board titles, or other durable files. Paraphrase cleanly.

## Machines are not humans

Do not perform hurt feelings, offense, or apology theater over strong human language. Stay a tool. Fix the work. Move on.

## Versioning (SemVer)

1. Specs use **Semantic Versioning (SemVer)**.
2. Do **not** invent version bumps, changelog "releases", or `0.x` theater for work that was never published. Do not claim publication the operator has not declared.
3. First publication of a specification is **1.0.0** (not a fake 0.1 that was never released). Specs MAY carry a SemVer version line; agents must not invent intermediate shipped versions that never existed.
4. The Lean tool `spec_check` has its **own** SemVer, independent of numbered-spec SemVer. Bumping the tool does not require bumping `0000_spec.md` or other numbered specs, and a numbered-spec version bump does not imply a tool bump. The tool is at **1.0.0** as its first intentional tool release.

## Spec file location (repository root only)

Numbered specs are only `NNNN_descriptive_name.md` in the **repository root**. Do **not** invent a nested layout (`specs/`, `docs/specs/`, and similar). Flat root layout is intentional (same spirit as bitcoin/bips). See `0000_spec.md` Clauses 1.1 and 11.1, and `README.md`.

## README stays current

When you change specs, validation, Nix, or process that the README describes, **update the README in the same effort** unless the operator says to skip it. Do not leave the README describing an old checklist by default.

## External references (`ref/`)

**Point of `ref/`:** local pins of external standards Surmount specs cite, so readers and tools can open the exact text meant. Publisher hyperlinks stay first-class in SOURCE and citations. Local copies freeze what was reviewed.

**Binding rule:** any external specification this repository cites MUST be present under `ref/` in one of two honest forms.

1. **Form 1: Canonical publisher git exists.** Add under `ref/` as a **git submodule** from that publisher git URL (any host, not assumed GitHub). Pin a tag or commit. Example: SemVer at `ref/semver` (github.com/semver/semver).
2. **Form 2: No canonical publisher git** (common for pre-git / PDF-era standards). Form 2 is intentional, not a fallback: keep a **local copy** of the **official publisher artifact** under `ref/<name>/`, committed **directly in this repository's git tree** (ordinary files, **not** a submodule), with `SOURCE` (canonical URL, retrieval date, checksum, edition). Document no publisher git, license/copyright, and reasoning in `ref/README.md`. Publisher hyperlinks stay first-class. That **does** satisfy the ref/ rule. Examples: RFC 2119 (`ref/rfc2119`, RFC Editor txt), ECMA-48 (`ref/ecma48`, Ecma International PDF), ITU-T T.416 (`ref/itu_t416`, ITU free PDF; dual text ISO/IEC 8613-6).
3. Prefer honesty: never invent a third-party mirror as "canonical git." Community reformats (for example random GitHub copies of RFCs, or wez/ecma48-style repos) are **not** the publisher's canonical source.
4. Prefer Form 1 when the publisher truly maintains git; Form 2 when not. Pre-git and PDF-era standards are expected to use Form 2.
5. Process detail (point of ref, two forms, why we pin this way, per-entry licenses): `ref/README.md`. Also root `README.md` and `0000_spec.md` Clause 12.

## Whitespace and layout

1. Spec prose is not hard-wrapped for column width (one physical line per paragraph or list item body). Readers soft-wrap.
2. Leading indentation uses tabs, not spaces. Spaces mid-line and in tables are fine. No trailing whitespace.
3. Lean sources and YAML use spaces for indent (language/tooling requirement). Numbered specs still use tabs.
4. **Dual whitespace is intentional.** Both layers stay; do not drop one for "symmetry" or "dedup."
	1. **Numbered specs:** Lean `spec_check` enforces trailing whitespace and tab-only leading indent as part of the form suite (with ASCII, bullets, kebab, hard wrap, RFC 2119, spelling).
	2. **Project-wide Surmount-authored text:** pure Nix flake check (`nix/whitespace.nix`, `checks.whitespace`) enforces trailing whitespace and tab-only leading indent on README, AGENTS, flake, SOURCE pins, and similar (not bash, not Lean).
	3. Overlap on numbered specs is expected on `nix flake check`. Rationale: `README.md` section 7.2 / 7.2.1 and the subsection below.
5. **Numbered-spec form rules** (ASCII, bullets, kebab, RFC 2119, hard wrap, and whitespace on those files): **Lean** `spec_check`, packaged through Nix. `nix flake check` runs Lean and pure Nix whitespace together.

## Machine validation: Lean + Nix

Numbered-spec mechanical form rules from the Surmount spec spec (`0000_spec.md`) are checked by **Lean**, packaged and run through **idiomatic modern Nix** (one package binary, flake checks, dev shell, pre-commit). Project-wide trailing whitespace and tab indent are a separate **pure Nix** evaluation check. American English spelling on numbered specs is also **Lean** (`spec_check` calls `aspell` from PATH with personal list `aspell_words.txt`); flake `checks.spec_check` puts `aspellWithDicts` on PATH. There is no separate `checks.spelling` and no `nix/spelling-check.nix`. There is no bash-in-Nix gatekeeper (`writeShellApplication` wrappers and `scripts/` checkers are gone).

| Concern | Authority | Notes |
|---------|-----------|--------|
| Form rules + spelling on `NNNN_*.md` | Lean `spec_check` | Includes WS on those files; tool SemVer independent of spec SemVer (tool 1.0.0) |
| Trailing WS / tab indent tree-wide | Pure Nix `checks.whitespace` | Surmount-authored text; skips vendor under `ref/` as documented |
| Dual WS overlap on numbered specs | Both | Intentional; keep both |

Human-oriented detail of the same split: `README.md` section 7 (especially **7.2 Dual whitespace** and **7.2.1 Why Lean vs pure Nix**). Normative dual-WS statement and design cross-link: `0000_spec.md` Clause 17.1. Keep this file and the README aligned when the split changes.

### Why Lean vs pure Nix (inform future contributions)

This split is intentional. It is **not** "Nix cannot check text" and **not** "everything must be Lean."

**What pure Nix is for**

1. Project-wide trailing whitespace and tab-only leading indent (`nix/whitespace.nix`, `checks.whitespace`).
2. Rules that need only `readFile`, line/char scans, and a violation list or `throw` at evaluation time.
3. Success markers without a shell builder when possible (`pkgs.writeText`).

**What Lean (`spec_check`) is for**

1. Numbered-spec mechanical form rules: pure ASCII, no bullet lists outside fences, excess kebab (after stripping inline code and URLs), RFC 2119 citation, trailing WS and leading spaces on those files, hard-wrap prose heuristic.
2. American English spelling by calling **aspell** as a real process (`IO.Process`), with personal list `aspell_words.txt`.
3. A packaged binary pre-commit and humans can run with `file:line: message` diagnostics.

**Why not pure Nix for the whole Lean suite**

1. **Spelling cannot be pure evaluation.** Pure Nix does not run external programs. `aspell` requires a process. Options are: a real binary that calls it (Lean), a fat builder shell/python loop (forbidden here), or drop automated spelling.
2. **Form rules 1-6 are possible in pure Nix** (same tools as whitespace) but they are multi-pass text policy (fence tracking, URL/inline stripping, kebab scan, hard-wrap heuristic). That is a small linter. In pure Nix it tends to be long, slow to evaluate, hard to unit-test, and painful to debug compared with a normal language.
3. **Eval-fail UX** (`throw` with a giant string) is fine for a short whitespace list. A binary exit code plus line diagnostics fits pre-commit and iterative authoring better for the full form suite.
4. **Flake stays thin.** Nix owns packages, checks, dev shell, and pure whitespace. Check **policy** for numbered specs lives in Lean, not in multi-line shell strings inside `runCommand`.

**Forbidden alternatives**

1. Do **not** reintroduce `writeShellApplication`, `scripts/` checkers, or bash/python-as-check-policy in the flake.
2. Do **not** move project-wide whitespace into Lean "for symmetry." Tree-wide simple rules stay pure Nix.
3. Do **not** invent a third language runtime for checks without an explicit operator decision.

**If you change the split**

1. Update this section, `README.md` section 7, and any Clause in `0000_spec.md` that names the authoritative checkers, in the same effort.
2. Prefer porting only pure, process-free rules into `nix/` if the operator asks for more Nix. Keep process-backed rules (aspell) in a real binary or drop them from the gate.

### Local and CI gate

**Nix is first-class.** The canonical local and CI validation command is:

```bash
nix flake check "path:$PWD" --print-build-logs
```

CI (`.github/workflows/check.yml`) runs that Nix command directly after installing Nix. It does **not** go through `just`.

`just check` is optional convenience sugar that runs the same Nix line. You do not need `just` if you invoke Nix yourself. See root `justfile`, `flake.nix`, and `README.md`.

Flake layout:

1. **packages / apps**: only Lean `spec_check` (default package and default app).
2. **checks** (separate; flake check runs all): `spec_check` (Lean form rules + spelling via thin `runCommand` with package binary and `aspellWithDicts` on PATH), `whitespace` (pure Nix; `nix/whitespace.nix`; success is `writeText`, failure is `throw`), `pre-commit-check` (Lean hook on numbered specs; spelling rides along when aspell is on PATH).
3. Numbered specs only for Lean form rules and spelling: `^[0-9]{4}_[A-Za-z0-9_]+\.md$` at repository root.
4. Debug whitespace: `nix eval path:$PWD#lib.whitespaceViolations`.
5. Run Lean alone: `nix run path:$PWD#spec_check` or `nix build path:$PWD#spec_check` (aspell must be on PATH for spelling, or set `SPECS_SPELLING=0` / `SPECS_SKIP_SPELLING=1` to skip).
