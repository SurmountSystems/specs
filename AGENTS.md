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

## Proof of Keags research (back linking)

When citing, quoting, or building on research by Keagan McLelland (Proof of Keags), ALWAYS include a markdown link to the canonical URL on https://proofofkeags.com . Do not cite those ideas without a backlink. This is not an Unlicense grant. This is not permission to vendor those essays as Form 2 copies under `ref/`.

## Plain English

Write so a tired human can read it. No decoder ring jargon ("soft labeling", "join artifact", step codes). Name the real thing.

When asking the operator a decision, write a complete American English question. Say which file or clause, quote the current wording, say why the choice matters, and name the options. Do not send a half label such as "Keep or replace coined labels?" as if that were the question.

## Concise American Technical English (CATE)

CATE is numbered specification `0005_CATE.md` (first publication 1.0.0, stack number corrected to 0005 in 1.1.0). It is not numbered specification 0006. Number 0006 is Recursive Self Improvement (`0006_RSI.md`). `0000_spec.md` (SemVer 1.3.0) keeps a short pointer only and does not restate CATE. fargo has no assigned number. Read `0005_CATE.md` before encoding or revising a numbered specification. Lean `spec_check` leftover unstack and residual heading checks ride along with form rules. Companion meaning proofs live under `lean/Cate.lean`.

## Always self improve the encode process

When friction appears in the same encode effort (hyphen leftovers, incomplete questions, README wording that does not match the registry), improve the encode process in that same effort. Prove the improvement with a Lean check or a skill step, not a chat reminder.

Independent work streams SHALL run as parallel subagents. Do not serialize two jobs that do not share a write set. When two specs must land in one effort, spawn one subagent per spec on disjoint files, then one pass on shared files (registry, README, this file, residual, flake).

Reports that describe a change: when the operator asked for size, run `scc --exclude-dir ref,.git,result,lean/.lake,.direnv --exclude-ext pdf .` before and after, including the COCOMO block. COCOMO is fun and is not a real cost or schedule. Do not pass `--no-cocomo`. When the operator asked for git status, run `git status --short`. Do not `git add` or `git commit`. Git remains forbidden in this repository unless the operator explicitly asked for that git work.

## Always use better tools

If a Lean theorem can state the claim, do not fall back to a shovel test or a Python checker. Improve `spec_check`, `line_encodings_check`, `word_stats`, or a companion meaning model rather than a disposable script. The Lean 4 agent skill pack is the git submodule at `skills/lean4-skills`. The Grok Build wrapper is `/lean4` at `.agents/skills/lean4/SKILL.md`.

## Reduce hyphenation in prose

Prefer ordinary English over hyphenated compounds. People who are not writing legal captions rarely hyphenate. Do not write lawyerly modifiers such as `high-assurance`, `best-effort`, `self-improving`, `lock-free`, or `safety-critical`. Do not "fix" them by deleting the hyphen and leaving the same two words (`lock free`, `non markdown`, `must like`, `LF only`). Rephrase so a person would actually say it (`high assurance` may stay when it already reads as English; `tooling that is not markdown`; `tries that do not use locks` rather than `lock free tries`; `bootstrapped Slake that fully typechecks` rather than `fully type checking Slake`; `line endings that use LF and never CR`). Keep a hyphen only when the token is a filename, a URL, a code identifier, or an official designation that is spelled with a hyphen (for example `ITU-T`). This applies to numbered specifications, README, this file, `RESIDUAL.md`, and project skills. The leftover unstack floor list lives in `0005_CATE.md`.

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
6. 0005 = Concise American Technical English (`0005_CATE.md`)
7. 0006 = Recursive Self Improvement (`0006_RSI.md`)
8. 0007 = Continuous Integration and stack consistency (`0007_CI.md`)
9. 0008 = Formal Vibefication (`0008_Formal_Vibefication.md`). Spelling is Vibefication, matching the Proof of Keags title.
10. 0009 is withdrawn. The file `0009_VOCABULARY.md` MUST NOT exist, the same class as `0005_fargo.md`. Number 0009 is not fargo and is not Carbonado. The word catalog lives in CATE (`0005_CATE.md`). Root `VOCABULARY.md` is a short pointer to that file.
11. 0010 = Surmount Systems (`0010_Surmount_Systems.md`)
12. fargo has no assigned number. Do not create `0005_fargo.md`. Do not invent a new number for fargo. Do not create `0006_fargo.md`.
13. Carbonado Network Protocol: deferred; **do not create a file**; Carbonado has no assigned number. Number 0005 is CATE. Number 0006 is RSI. Number 0007 is CI. Number 0008 is Formal Vibefication. Number 0009 is withdrawn. Number 0010 is Surmount Systems. Do not steal 0005, 0006, 0007, 0008, or 0010 for fargo or Carbonado.

## Residual for numbered specifications (must be complete on disk)

Residual for numbered specifications MUST be written in full on disk: a residual clause in the numbered specification and/or `RESIDUAL.md` at the repository root. A parenthetical planned file name in Scope is not enough by itself. List unpublished specifications, unassigned numbers, unpinned prior art, unimplemented product claims, and out of scope items the document names. Use complete sentences. Do not invent shipped versions for unpublished specs. Do not create numbered specification files the operator forbade (today: `0005_fargo.md` is withdrawn and must not exist; `0009_VOCABULARY.md` is withdrawn and must not exist; any Carbonado numbered file).

## Project skills live under `.agents/skills/`

Project skills for this repository MUST live under `.agents/skills/`. That is the project skill home. It is not `~/.grok` (host Grok config). It is not `.grok/skills/` at the repository root. Do not create a project `.grok/` for skills.

## Project skill `/surmount-specify`

This repository's Grok Build skill for encoding numbered specifications is `.agents/skills/surmount-specify/SKILL.md`. Use `/surmount-specify` when pasting a spec draft or adding a numbered specification. It is this repository only. Form authority remains `0000_spec.md`. Stack number authority remains this file plus `lean/SpecRegistry.lean`.

## Project skill `/rsi`

This repository's Grok Build skill for building durable engineering tools per `0006_RSI.md` is `.agents/skills/rsi/SKILL.md`. Use `/rsi` when adding a Lean checker, a Nix check, a project skill, or a helper used next to a compiler that a later session can run. It is this repository only. CATE remains `0005_CATE.md`. It does not replace `0006_RSI.md`.

## Project skill `/lean4`

This repository's Grok Build skill for proving companion Lean meaning models is `.agents/skills/lean4/SKILL.md`. Use `/lean4` when writing or repairing `lean/*.lean`. The pack lives at `skills/lean4-skills` (MIT license; not under `ref/`; not a Clause 12 pin; not mathlib). The wrapper is a real file, not a symlink. Do not set the nested plugin tree as the only skill discovery root. Populate the submodule with `git submodule update --init skills/lean4-skills`. Use the pack as Plan, then Work (prove or autoprove), then Checkpoint, then Review, then golf. The composition proof is `lean/Surmount.lean`. Numbered markdown is the contract humans read. Spec encodings are Lean. Proofs are separate Lean modules. Every published numbered markdown file has a sibling `Spec_NNNN.lean` at the repository root; proofs of those line encodings live in `lean/Proofs_NNNN.lean`. Product tree unification is not a license to mix spec encodings with proofs in this repository, and is not a license to mix theorems into numbered markdown here. The gate is `nix flake check "path:$PWD" --print-build-logs`. No mathlib.

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
	1. **Numbered specifications:** Lean `spec_check` enforces trailing whitespace and leading indent that uses tabs only as part of the form suite (with ASCII, bullets, hyphenation, wrapping to a column, RFC 2119, spelling).
	2. **Surmount authored text across the project:** pure Nix flake check (`nix/whitespace.nix`, `checks.whitespace`) enforces trailing whitespace and leading indent that uses tabs only on README, AGENTS, flake, SOURCE pins, and similar (not bash, not Lean).
	3. Overlap on numbered specifications is expected on `nix flake check`. Rationale: `README.md` section 7.2 / 7.2.1 and the subsection below.
5. **Form rules for numbered specifications** (ASCII, bullets, hyphenation, RFC 2119, wrapping to a column, and whitespace on those files): **Lean** `spec_check`, packaged through Nix. `nix flake check` runs Lean and pure Nix whitespace together.

## Machine validation: Lean + Nix

Mechanical form rules for numbered specifications from the Surmount spec spec (`0000_spec.md`) are checked by **Lean**, packaged and run through **idiomatic modern Nix** (one package binary, flake checks, dev shell, pre-commit). Trailing whitespace and tab indent across the project are a separate **pure Nix** evaluation check. American English spelling on numbered specifications is also **Lean** (`spec_check` calls `aspell` from PATH with personal list `aspell_words.txt`); flake `checks.spec_check` puts `aspellWithDicts` on PATH. There is no separate `checks.spelling` and no `nix/spelling-check.nix`. Do not implement flake checks as bash or Python stuffed inside Nix. `writeShellApplication` wrappers and `scripts/` checkers are gone. Form rules for numbered specifications live in the Lean `spec_check` binary. Trailing whitespace and tab indent across the tree live in pure Nix evaluation.

| Concern | Authority | Notes |
|---------|-----------|--------|
| Form rules + spelling on `NNNN_*.md` | Lean `spec_check` | Includes WS on those files; tool SemVer independent of spec SemVer (tool 1.0.0). Also runs the registry scan for numbered specifications (wrong numbers, file name mismatches, wrong `beastdb` capitalization), CATE leftover unstack phrases, a Residual heading when a numbered specification other than 0000 contains a planned `NNNN_*.md` token, and a numbered specification that names Keagan or proofofkeags must also contain proofofkeags.com. |
| CATE meaning (spec 0005) | Lean `Cate` library + `cate_tests` | Companion model of selected CATE clauses and catalog ownership; not a second markdown linter; CATE is specification 0005; not specification 0006; number 0009 is withdrawn |
| RSI meaning (spec 0006) | Lean `Rsi` library (`Rsi.lean`, `Vocabulary.lean`) + `rsi_tests` | Companion model of selected RSI clauses and vocabulary tags for the same English word used in more than one tree; not a second markdown linter; RSI is specification 0006; CATE is not |
| CI meaning (spec 0007) | Lean `Ci` library + `ci_tests` | Companion model of selected CI clauses; not a second markdown linter; CI is specification 0007; not specification 0005 and not specification 0006 |
| Vocabulary catalog (owned by spec 0005) | Lean `VocabularySpec` encodings + `VocabularyProofs` + `VocabAspell` runtime + `vocab_aspell_tests` | Inverse maps between `aspell_words.txt` tokens and `0005_CATE.md` `L_n` ids; `vocabularySpecNumber = 5` equals `cateSpecNumber`; root `VOCABULARY.md` is a pointer; not ISO 24495; number 0009 is withdrawn |
| Unique English word tracking | Lean `WordStats` + `word_stats` + `word_stats_tests` | Unique lowercased ASCII letter tokens in Surmount authored markdown (root numbered specifications, README, AGENTS, residual, vocabulary pointer) versus proven tokens from the CATE `L_n` catalog plus RFC 2119 requirement keywords already named as vocabulary; root `WORD_STATS.md` must match; flake check fails when that report is stale; tracking, not a proof that every English sentence is CATE; leftover unstack remains a separate floor; Lean comments are not in the scan |
| Systems Lean meaning (spec 0002) | Lean `SystemsLean` library + `systems_lean_tests` | Companion model of selected clauses; not a second markdown linter |
| beastdb meaning (spec 0003) | Lean `BeastDb` library + `beastdb_tests` | Companion model of selected clauses plus registry fixtures; not a second markdown linter |
| SSSSS meaning (spec 0004) | Lean `Sssss` library + `sssss_tests` | Companion model of selected clauses plus registry fixtures; not a second markdown linter |
| Formal Vibefication (spec 0008) | Lean `FormalVibeficationSpec` encodings + `FormalVibeficationProofs` + `formal_vibefication_tests` | Spec encodings state what must be true; proofs live in a separate module; a mashed module does not conform; not a second markdown linter |
| Sibling line encodings | Lean `MdLine` + `LineEncodings` + `line_encodings_check` + `line_encodings_tests` | Every published `NNNN_*.md` has sibling `Spec_NNNN.lean` at the repository root; proofs in `lean/Proofs_NNNN.lean`; isomorphism of physical lines; encodings are explicit `MdLine` or `String` literals, one per physical markdown line; `include_str` is not a line encoding; a mash of encoding and proofs does not conform; compiled `encodedLines` and comments in `FormalVibeficationSpec` and `VocabularySpec` use the CATE leftover unstack floor (`Cate.leftoverUnstackPhrases`, same scan as `spec_check`); not a numbered specification and not a second markdown linter |
| Surmount composition | Lean `Surmount` library + `surmount_tests` | Companion model of `0010_Surmount_Systems.md`; one proof that stack identities compose (`surmountSpecNumber = 10`, `formalVibeficationSpecNumber = 8`, `vocabularySpecNumber = 5` equals `cateSpecNumber`); does not require published 0009; human markdown, Lean spec encodings, and Lean proofs stay distinct in this repository; every published numbered markdown has a sibling line encoding; Lean spec encodings are CATE on the leftover unstack floor; product trees may unify; not a proof that emit matches ELF or that products are ready for use |
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

1. Mechanical form rules for numbered specifications: pure ASCII, no bullet lists outside fences, excess hyphenated tokens (after stripping inline code and URLs), leftover unstack phrases, Residual heading when a numbered specification other than 0000 contains a planned file token, RFC 2119 citation, trailing WS and leading spaces on those files, heuristic for wrapping to a column, and a numbered specification that names Keagan or proofofkeags must also contain proofofkeags.com.
2. American English spelling by calling **aspell** as a real process (`IO.Process`), with personal list `aspell_words.txt`.
3. A packaged binary pre-commit and humans can run with `file:line: message` diagnostics.

**Why not pure Nix for the whole Lean suite**

1. **Spelling cannot be pure evaluation.** Pure Nix does not run external programs. `aspell` requires a process. Options are: a real binary that calls it (Lean), a fat builder shell/python loop (forbidden here), or drop automated spelling.
2. **Form rules 1-6 are possible in pure Nix** (same tools as whitespace) but they are text policy that takes more than one pass (fence tracking, URL/inline stripping, hyphenation scan, heuristic for wrapping to a column). That is a small linter. In pure Nix it tends to be long, slow to evaluate, hard to unit test, and painful to debug compared with a normal language.
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

1. **packages / apps**: Lean `spec_check` is the default package and the default app (form rules, spelling, and the registry scan for numbered specifications). Hermetic test binaries `spec_check_tests`, `systems_lean_tests`, `beastdb_tests`, `sssss_tests`, `cate_tests`, `rsi_tests`, `ci_tests`, `vocab_aspell_tests`, `formal_vibefication_tests`, `surmount_tests`, `line_encodings_tests`, and `word_stats_tests` are additional packages, not additional apps. The line encoding checker `line_encodings_check` and the word tracking checker `word_stats` are additional packages, not additional apps.
2. **checks** (separate; flake check runs all): `spec_check` (Lean form rules + spelling + registry scan for numbered specifications via thin `runCommand` with package binary and `aspellWithDicts` on PATH), `spec_check_tests` (form helper unit tests, including leftover unstack), `systems_lean_tests` (companion meaning proofs for `0002_Systems_Lean.md`; not form rules), `beastdb_tests` (companion meaning proofs for `0003_beastdb.md` and registry fixtures, including residual heading; not form rules), `sssss_tests` (companion meaning proofs for `0004_SSSSS.md` and registry fixtures; not form rules), `cate_tests` (companion meaning proofs for `0005_CATE.md`; not form rules), `rsi_tests` (companion meaning proofs for `0006_RSI.md`; not form rules), `ci_tests` (companion meaning proofs for `0007_CI.md`; not form rules), `vocab_aspell_tests` (aspell list and 0005_CATE.md catalog inverse maps), `formal_vibefication_tests` (spec encodings versus proofs for `0008_Formal_Vibefication.md`; not form rules), `surmount_tests` (composition proof over the meaning models; not form rules), `line_encodings_tests` (hermetic fixtures for sibling line encodings; not form rules), `line_encodings_check` (isomorphism of numbered markdown lines and sibling `Spec_NNNN.lean`; `include_str` is not a line encoding; leftover unstack floor on compiled encodings and named spec encoding comments; not form rules), `word_stats_tests` (hermetic fixtures for unique ASCII letter token tracking; not form rules), `word_stats` (root `WORD_STATS.md` matches unique English word counts in Surmount authored markdown versus the CATE `L_n` catalog plus RFC 2119 requirement keywords; tracking, not a proof that every English sentence is CATE), `whitespace` (pure Nix; `nix/whitespace.nix`; success is `writeText`, failure is `throw`), `pre-commit-check` (Lean hook on numbered specifications; spelling rides along when aspell is on PATH).
3. Numbered specifications only for Lean form rules and spelling: `^[0-9]{4}_[A-Za-z0-9_]+\.md$` at repository root.
4. Debug whitespace: `nix eval path:$PWD#lib.whitespaceViolations`.
5. Run Lean alone: `nix run path:$PWD#spec_check` or `nix build path:$PWD#spec_check` (aspell must be on PATH for spelling, or set `SPECS_SPELLING=0` / `SPECS_SKIP_SPELLING=1` to skip). Meaning model tests: `nix build path:$PWD#systems_lean_tests`, `nix build path:$PWD#beastdb_tests`, `nix build path:$PWD#sssss_tests`, `nix build path:$PWD#cate_tests`, `nix build path:$PWD#rsi_tests`, `nix build path:$PWD#ci_tests`, `nix build path:$PWD#formal_vibefication_tests`, and `nix build path:$PWD#surmount_tests` then run the installed binaries. Vocabulary isomorphism: `nix build path:$PWD#vocab_aspell_tests` with `REPO_ROOT` set. Sibling line encodings: `nix build path:$PWD#line_encodings_tests` and `nix build path:$PWD#line_encodings_check` then run `line_encodings_check` with `REPO_ROOT` set. Unique English word tracking: `nix build path:$PWD#word_stats_tests` and `nix build path:$PWD#word_stats` then run `word_stats` with `REPO_ROOT` set (`word_stats --write` refreshes root `WORD_STATS.md`). `nix flake check` includes `checks.systems_lean_tests`, `checks.beastdb_tests`, `checks.sssss_tests`, `checks.cate_tests`, `checks.rsi_tests`, `checks.ci_tests`, `checks.vocab_aspell_tests`, `checks.formal_vibefication_tests`, `checks.surmount_tests`, `checks.line_encodings_tests`, `checks.line_encodings_check`, `checks.word_stats_tests`, and `checks.word_stats`.
