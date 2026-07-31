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
4. Enforced by Lean `spec_check` on numbered specs and by `check_whitespace` on project-owned text (`nix flake check` includes both).

## Machine validation: Lean + Nix

Primary automated checking of form rules from the Surmount spec spec (`0000_spec.md`) is intended to be **Lean**, packaged and run through **idiomatic modern Nix** (flake packages, checks, dev shell, pre-commit). Shell helpers may exist as temporary bridges; do not treat a bash-only checker as the long-term authority when Lean work is in scope.

### Local and CI gate

**Nix is first-class.** The canonical local and CI validation command is:

```bash
nix flake check "path:$PWD" --print-build-logs
```

CI (`.github/workflows/check.yml`) runs that Nix command directly after installing Nix. It does **not** go through `just`.

`just check` is optional convenience sugar that runs the same Nix line. You do not need `just` if you invoke Nix yourself. See root `justfile`, `flake.nix`, and `README.md`.

The primary content check is `packages.check_numbered_specs` / `checks.numbered_specs`: Lean `spec_check` plus legacy aspell spelling on repository-root numbered specs only (`^[0-9]{4}_[A-Za-z0-9_]+\.md$`). Spelling uses `pkgs.aspellWithDicts`.
