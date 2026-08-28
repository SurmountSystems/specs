# External public standards (`ref/`)

## Point of `ref/`

1. `ref/` holds the external standards Surmount specs cite, so readers and tools can open the **exact** text we mean without hunting the web.
2. Hyperlinks to publisher pages still matter (and often predate git and even some of the specs). Canonical URLs stay in each Form 2 entry's `SOURCE.md` file, in each Form 1 sibling `.SOURCE` file, and in citations from Surmount specs.
3. Local copies under `ref/` freeze what we reviewed and checksummed (or git-pinned) for this repository.

Process detail here is binding for authors and agents. Normative summary also appears in `0000_spec.md` Clause 12 and briefly in the repository root `README.md`.

## Two forms (binding)

Any external specification this repository cites MUST be present under `ref/` in one of these two honest forms.

### Form 1: Canonical publisher git exists

When a cited standard has a **canonical git repository maintained by the publisher** (any host: GitHub, GitLab, self-hosted, or other; not assumed to be GitHub):

1. Add it under `ref/` as a **git submodule** from that publisher git URL.
2. Pin a tag or commit.
3. Document the pin in this README and in `ref/<short_name>.SOURCE` (sibling file outside the submodule so the upstream tree is not dirtied).
4. Example: Semantic Versioning at https://github.com/semver/semver under `ref/semver`.

### Form 2: No canonical publisher git

Common for pre-git and PDF-era standards (RFC 2119, ECMA-48, ITU-T T.416, similar crypto or PDF publications). When the publisher does **not** maintain a canonical git repository for that standard (or official git is not the authoritative publication form), Form 2 is the **intended** process, not a fallback or failure:

1. **Document that fact** in this README for each such entry (no publisher git; what we use instead).
2. **Keep a local copy** of the **specific official publisher artifact** under `ref/<short_name>/`, committed **directly in this repository's git tree** as ordinary files (**not** a submodule). Fetch from the most canonical official source the publisher provides (info page and download URL recorded in SOURCE.md).
3. Record canonical hyperlink(s), retrieval date, checksum, and edition or version in `ref/<short_name>/SOURCE.md`. Publisher hyperlinks stay first-class; the local copy freezes the reviewed bytes.
4. Note **license / copyright / republication** status for that entry in this README (keep detail in SOURCE.md). Be honest: free official download is not the same as claiming Surmount ownership or inventing an SPDX id.
5. State **reasoning** here: why direct tree copy instead of submodule (no publisher git; need a durable local pin of the exact official artifact; hyperlinks remain for the living publisher location; we do not invent fake git remotes).

That form **does** satisfy the ref/ rule. Examples: RFC 2119 (RFC Editor txt), ECMA-48 (Ecma International PDF), and ITU-T T.416 (ITU free PDF; identical text also published as ISO/IEC 8613-6).

### Honesty rules (both forms)

1. Never invent a third-party mirror or community reformat as "canonical git." Random GitHub copies of RFCs, and community repos that reformat ECMA-48 or similar, are **not** the publisher's canonical source.
2. Prefer Form 1 when the publisher truly maintains git for that standard. Prefer Form 2 when that is what the publisher actually ships.
3. Name directories `ref/<short_name>/` using a short, stable, lowercase name (examples: `semver`, `rfc2119`, `ecma48`).
4. Do not edit upstream files inside submodules or inside pinned official artifacts. Surmount specs cite a version, tag, commit, or SOURCE.md checksum. Update the pin when the cited version must change.

Standards older than widespread git often have only an official PDF or plain text from the publisher. Similar cases elsewhere include older SECG PDF publications and FIPS hash standards. Those examples illustrate the **pattern** of Form 2; they are not items this repository must add now.

## Why we pin this way

1. **Submodule when publisher git is real.** Form 1 tracks the publisher's own history and tags. The parent tree records an exact gitlink commit.
2. **Direct commit of official PDF/txt when not.** Form 2 puts the official artifact in this repository's ordinary tree so clones always have the exact bytes we reviewed, with no fake remote and no submodule init step.
3. **Hyperlinks stay first-class.** SOURCE.md (Form 2), sibling `.SOURCE` (Form 1), and citations keep the publisher's living URL. Local pins freeze review; they do not replace the publisher page as the public home of the standard.
4. **No third-party mirror git as fake canonical.** We do not point a submodule at a random reformat and call it upstream.
5. **Pre-git and PDF-era standards are expected to use Form 2.** RFC 2119, ECMA-48, ITU-T T.416, and similar standards follow Form 2 by default unless the publisher later maintains real canonical git for that standard. Keeping the official artifact under `ref/` with SOURCE.md and hyperlinks is intentional.

## Present entries

### `ref/semver/` (Form 1: publisher git submodule)

1. **Standard:** Semantic Versioning 2.0.0.
2. **Form:** Git submodule of https://github.com/semver/semver .
3. **Pin:** tag `v2.0.0`, commit `7c834b3f3a4940d77ab593bc32583004d6a426a9`.
4. **Pin notes:** `ref/semver.SOURCE` (outside the submodule).
5. **License / copyright:** The upstream `semver.md` document states Creative Commons Attribution 3.0 (CC BY 3.0), http://creativecommons.org/licenses/by/3.0/ . Surmount does not own that text; the submodule is a pin of the publisher tree. See `ref/semver.SOURCE` and the License section of `ref/semver/semver.md`.
6. **Reasoning:** The SemVer project maintains canonical git. Form 1 applies.

### `ref/btc-verified/` (Form 1: git submodule)

1. **Standard:** Bitcoin canonical CompactSize as specified and proved in Lean (namespace `BtcVerified.CompactSize`, theorems `decode_encode`, `decode_canonical`, `encode_length_le`), plus the rest of that Lean tree.
2. **Form:** Git submodule of https://github.com/cryptoquick/btc-verified.git .
3. **Pin:** commit `6c279c18914f5a22fb33e772f466b9362d6a4fcb` (no release tag at this pin). That commit was `master` HEAD when the submodule was added.
4. **Pin notes:** `ref/btc-verified.SOURCE` (outside the submodule).
5. **License / copyright:** The upstream `LICENSE` file states Apache License, Version 2.0, http://www.apache.org/licenses/LICENSE-2.0 . Surmount does not own that tree; the submodule is a pin of the named git. Numbered specification 0009 in this repository is Unlicense and does not relicense this pin. See `ref/btc-verified.SOURCE` and `ref/btc-verified/LICENSE`.
6. **Reasoning:** The operator named this git URL as the Form 1 pin for CompactSize prior proof. Form 1 applies. Surmount specs cite the recorded commit.

### `ref/rfc2119/` (Form 2: direct tree copy, no publisher git)

1. **Standard:** RFC 2119, Key words for use in RFCs to Indicate Requirement Levels.
2. **Form:** Official RFC Editor plain text, committed **directly in this repository's git tree** as ordinary files under `ref/rfc2119/` (**not** a submodule).
3. **Artifact:** `ref/rfc2119/rfc2119.txt` with `ref/rfc2119/SOURCE.md`.
4. **Canonical URL:** https://www.rfc-editor.org/rfc/rfc2119.txt
5. **No publisher git:** There is no publisher-maintained canonical git repository for this historic RFC that we treat as authoritative. Third-party GitHub copies are not canonical. Form 2 applies.
6. **License / copyright:** IETF Trust / RFC copyright. RFCs are freely available from the RFC Editor. The vendored official txt is a local pin for this repository; Surmount does not own the RFC text. Do not invent an SPDX id here; cite SOURCE.md for URL, date, and checksum. Detail: `ref/rfc2119/SOURCE.md`.
7. **Reasoning:** No publisher git; need a durable local pin of the exact official bytes; hyperlink remains the living publisher location; we do not invent a fake git remote.

### `ref/ecma48/` (Form 2: direct tree copy, no publisher git)

1. **Standard:** ECMA-48, 5th edition, June 1991 (reprinted June 1998).
2. **Form:** Official Ecma International PDF, committed **directly in this repository's git tree** as ordinary files under `ref/ecma48/` (**not** a submodule).
3. **Artifact:** `ref/ecma48/ECMA-48_5th_edition_june_1991.pdf` with `ref/ecma48/SOURCE.md`.
4. **Canonical page / PDF:** https://ecma-international.org/publications-and-standards/standards/ecma-48/ and https://ecma-international.org/wp-content/uploads/ECMA-48_5th_edition_june_1991.pdf
5. **No publisher git:** Ecma publishes this standard as PDF from its site. Community reformats are not the Ecma publisher source. Form 2 applies.
6. **License / copyright:** Ecma text copyright policy allows unchanged republication with notice retained. This pin is the unmodified official PDF. Policy URL (also in SOURCE.md): https://ecma-international.org/policies/by-ipr/ecma-text-copyright-policy/ Surmount does not own the Ecma text. Detail: `ref/ecma48/SOURCE.md`.
7. **Reasoning:** No publisher git for this PDF-era standard; need a durable local pin; hyperlinks remain for the living publisher location; we do not invent a fake git remote.

### `ref/itu_t416/` (Form 2: direct tree copy, no publisher git)

1. **Standard:** ITU-T Recommendation T.416 (03/93), Open Document Architecture (ODA) and Interchange Format: Character Content Architectures. Identical text also published as ISO/IEC International Standard 8613-6.
2. **Form:** Official ITU free PDF, committed **directly in this repository's git tree** as ordinary files under `ref/itu_t416/` (**not** a submodule).
3. **Artifact:** `ref/itu_t416/T-REC-T.416-199303-I.pdf` with `ref/itu_t416/SOURCE.md`.
4. **Canonical page / PDF:** https://www.itu.int/rec/T-REC-T.416-199303-I/en and official download https://www.itu.int/rec/dologin_pub.asp?lang=e&id=T-REC-T.416-199303-I!!PDF-E&type=items
5. **No publisher git:** ITU publishes this Recommendation as PDF. There is no publisher-maintained canonical git repository. Form 2 applies.
6. **License / copyright:** ITU provides free download of most Recommendations as PDF. This pin is the free official ITU dual text (also designated ISO/IEC 8613-6). Surmount does not own the text; do not invent a free-for-all SPDX. ISO may sell separate editions; we pin the free ITU artifact that DOGE cites. Detail: `ref/itu_t416/SOURCE.md`.
7. **Reasoning:** No publisher git; DOGE cites this standard for extended color models; need a durable local pin of the exact official bytes; hyperlinks remain for the living ITU location; we do not invent a fake git remote. Form 2 is intentional for this PDF-era dual ITU/ISO text.

## How to add a Form 1 git submodule

Use this path only when the publisher maintains a canonical git repository for the standard.

From the Surmount specs repository root (requires git permission for submodule work only when the operator has granted it):

1. Choose a short directory name under `ref/`.
2. Confirm the URL is the standard publisher's canonical git repository, not a random mirror or community reformat.
3. Preflight before adding. `git submodule add` has no `--dry-run` flag. Check that the remote exists and which refs it offers:

```
git ls-remote https://example.publisher/path/to/repo.git
```

	Optionally clone into a temporary directory outside this repository to inspect tags and history, then remove that temp clone. Only then run `git submodule add` in this tree.
4. Add the submodule from the canonical upstream URL:

```
git submodule add https://example.publisher/path/to/repo.git ref/<short_name>
```

5. Optionally pin a release tag or known-good commit:

```
cd ref/<short_name>
git checkout <tag-or-commit>
cd ../..
git add ref/<short_name>
```

6. Write pin notes outside the submodule so the upstream tree stays clean. Use `ref/<short_name>.SOURCE` (sibling file) with the upstream URL, the pin (tag and full commit hash), license note if known, and why that pin was chosen. Update the Present entries section of this README.
7. Do not edit files inside the submodule.

`.gitmodules` records the path and URL. The parent tree records the exact commit as a gitlink.

## How to update a Form 1 git submodule

1. Fetch and check out the new pin inside the submodule:

```
cd ref/<short_name>
git fetch origin
git checkout <new-tag-or-commit>
cd ../..
git add ref/<short_name>
```

2. Update `ref/<short_name>.SOURCE` with the new tag/commit and the reason for the change. Update this README if the Present entries blurb changes.
3. Leave a normal commit of the parent tree to the human operator; agents do not create commits in this repository unless explicitly instructed.

After the first commit of this repository that records submodule gitlinks, clones populate submodules as follows.

Clone with submodules already populated:

```
git clone --recurse-submodules <url>
```

Or after a normal clone:

```
git submodule update --init --recursive
```

These commands apply only to real Form 1 submodules such as `ref/semver` and `ref/btc-verified`. Form 2 pins such as `ref/rfc2119`, `ref/ecma48`, and `ref/itu_t416` are ordinary files in the Surmount git tree and need no submodule init.

## How to add a Form 2 official publisher artifact pin

Use this path when there is no canonical publisher git (or when official git is not the authoritative publication form).

1. Choose a short directory name under `ref/<short_name>/`.
2. Fetch the file from the **publisher's official URL** only.
3. Place the unchanged official file in that directory as ordinary files to be committed **directly in this repository's git tree** (not a submodule).
4. Write `ref/<short_name>/SOURCE.md` (pure ASCII) with at least:

	1. Standard name and edition or version
	2. Canonical page and file URL
	3. Retrieval date (YYYY-MM-DD)
	4. Vendored filename
	5. SHA-256 of the vendored file
	6. Form note: Form 2 official publisher artifact pin, committed directly in the Surmount git tree, not a submodule; and why that form is correct
	7. Copyright or redistribution status, honestly stated

5. Document the entry in this README: no publisher git, license/copyright note, and reasoning (Form 2).
6. Do not edit the official file in place. Refresh only by re-fetching from the same canonical URL and updating SOURCE.md.
7. Do not substitute a third-party reformat for the official artifact.

## Citing from Surmount specs

1. Prefer citing the standard name, version or edition, and a stable locator (tag, commit, RFC number, or SOURCE.md checksum for artifact pins).
2. Keep publisher hyperlinks in citations where useful; local `ref/` paths are for exact local review and validation.
3. Paths under `ref/` are not a claim that Surmount owns the upstream text.
4. Never rewrite upstream wording in place to "fix" a citation.

## Proof of Keags essays (not Clause 12)

Essays and research by Keagan McLelland (Proof of Keags) are cited as research with backlinks to https://proofofkeags.com . They are not `0000_spec.md` Clause 12 pins. Local copies under `ref/philosophy/proofofkeags/` are for readers. Honesty notes are `ref/philosophy/proofofkeags/SOURCE.md`. They are not Form 2 pins of an external specification. They are not an Unlicense grant. Back linking is the documented handling.

## Scope limits for agents

1. Only use git for submodule setup when the operator has explicitly allowed it for `ref/` work.
2. Do not stage unrelated files or create commits as part of adding a ref unless the operator asked for that separately.
3. Do not invent third-party mirrors as canonical sources.
4. Form 2 official publisher artifact pins with a complete SOURCE.md file **do** satisfy the ref/ process rule when that is the correct form for the standard.
5. Do not delete pinned files or add new standards unless the operator asks.
