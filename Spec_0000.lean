/-
  SPEC ENCODING of numbered specification markdown `0000_spec.md`.
  This file sits next to that markdown at the repository root.

  Every physical line of the markdown (including blank lines) is a Lean
  `MdLine` value. Lean module names cannot start with a digit, so this
  file is `Spec_0000.lean` rather than `0000.lean`.

  This module is a spec encoding, not a proof module.
  Proofs live in `lean/Proofs_0000.lean`.
  Numbered markdown is the contract humans read.
  Lean proofs are not the specification.
-/

import MdLine

namespace Spec_0000

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

def specNumber : Nat := 0

def specFileName : String := "0000_spec.md"

def siblingEncodingFileName : String := "Spec_0000.lean"

def proofModuleName : String := "Proofs_0000"

/-- Every physical line of the sibling markdown, including blank lines. -/
def line0001 : MdLine := { number := 1, text := "# Surmount spec spec" }

def line0002 : MdLine := { number := 2, text := "" }

def line0003 : MdLine := { number := 3, text := "> v1.3.0 - 20260825" }

def line0004 : MdLine := { number := 4, text := "> Form rules for numbered Surmount specs (spec 0)" }

def line0005 : MdLine := { number := 5, text := "" }

def line0006 : MdLine := { number := 6, text := "## 1. Scope" }

def line0007 : MdLine := { number := 7, text := "" }

def line0008 : MdLine := { number := 8, text := "This document is the spec spec for Surmount miscellaneous specifications. It defines how specification documents in this repository SHALL be written, named, versioned, cited, and checked for form." }

def line0009 : MdLine := { number := 9, text := "" }

def line0010 : MdLine := { number := 10, text := "### 1.1 Documents in scope" }

def line0011 : MdLine := { number := 11, text := "" }

def line0012 : MdLine := { number := 12, text := "The following documents SHALL conform to this document:" }

def line0013 : MdLine := { number := 13, text := "" }

def line0014 : MdLine := { number := 14, text := "1. Every file matching `NNNN_descriptive_name.md` in the repository root, where `NNNN` is a four digit decimal prefix. Numbered specification files live only at the repository root as a flat set of files. They SHALL NOT be nested under a subdirectory such as `specs/` or `docs/specs/`. That flat root layout is the same spirit as the bitcoin/bips repository: numbered proposals at the root, not under a nested proposals folder." }

def line0015 : MdLine := { number := 15, text := "2. This document (`0000_spec.md`), which SHALL obey its own rules." }

def line0016 : MdLine := { number := 16, text := "" }

def line0017 : MdLine := { number := 17, text := "### 1.2 Documents out of scope" }

def line0018 : MdLine := { number := 18, text := "" }

def line0019 : MdLine := { number := 19, text := "The following are not specification documents under this document:" }

def line0020 : MdLine := { number := 20, text := "" }

def line0021 : MdLine := { number := 21, text := "1. `README.md` and other repository orientation files. They SHOULD use pure ASCII and American English when practical, but need not satisfy every clause here." }

def line0022 : MdLine := { number := 22, text := "2. `UNLICENSE.md`, `LICENSE`, `LICENSE.md`, and equivalent license files. Standard legal text is excluded from style, spelling, list form, and hyphenation rules that would force rewriting canned license prose. License files SHOULD remain pure ASCII when the chosen license text allows it." }

def line0023 : MdLine := { number := 23, text := "3. Scripts, Nix expressions, word lists, hooks, Lean sources, and other tooling that is not markdown. Tooling may enforce this document; it is not itself a specification under these style rules." }

def line0024 : MdLine := { number := 24, text := "" }

def line0025 : MdLine := { number := 25, text := "### 1.3 Status of this document" }

def line0026 : MdLine := { number := 26, text := "" }

def line0027 : MdLine := { number := 27, text := "This document is normative for document form. It does not define product behavior, wire formats, or APIs except as they appear inside other specs." }

def line0028 : MdLine := { number := 28, text := "" }

def line0029 : MdLine := { number := 29, text := "Concise American Technical English is specified in `0005_CATE.md`. This document does not restate CATE. Authors SHALL follow that specification when writing numbered specifications in this repository." }

def line0030 : MdLine := { number := 30, text := "" }

def line0031 : MdLine := { number := 31, text := "## 2. Normative references" }

def line0032 : MdLine := { number := 32, text := "" }

def line0033 : MdLine := { number := 33, text := "The following documents are indispensable for the application of this document. For undated references, the latest edition applies. Local copies under `ref/` are preferred when present (see Clause 12)." }

def line0034 : MdLine := { number := 34, text := "" }

def line0035 : MdLine := { number := 35, text := "1. Semantic Versioning 2.0.0 (SemVer). Local path when present: `ref/semver`." }

def line0036 : MdLine := { number := 36, text := "2. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels. Local path when present: `ref/rfc2119`." }

def line0037 : MdLine := { number := 37, text := "3. ECMA-48 / ISO/IEC 6429 and related terminal control standards, as cited by individual product specs such as DOGE, when those specs require them. Local paths under `ref/` when present." }

def line0038 : MdLine := { number := 38, text := "4. Concise American Technical English (CATE), Surmount specification `0005_CATE.md`. Authors SHALL follow that specification when writing numbered specifications in this repository. This document does not restate CATE." }

def line0039 : MdLine := { number := 39, text := "" }

def line0040 : MdLine := { number := 40, text := "If a `ref/` path is empty or not yet populated, authors SHALL still cite the public standard by title and identity, and SHALL add or update the `ref/` entry under Clause 12 when the external reference process is completed." }

def line0041 : MdLine := { number := 41, text := "" }

def line0042 : MdLine := { number := 42, text := "## 3. Definitions" }

def line0043 : MdLine := { number := 43, text := "" }

def line0044 : MdLine := { number := 44, text := "### 3.1 Normative specification" }

def line0045 : MdLine := { number := 45, text := "" }

def line0046 : MdLine := { number := 46, text := "A numbered `NNNN_descriptive_name.md` document that states mandatory requirements for an implementation, format, or other subject, and is not labeled as informative only." }

def line0047 : MdLine := { number := 47, text := "" }

def line0048 : MdLine := { number := 48, text := "### 3.2 Document that is informative only" }

def line0049 : MdLine := { number := 49, text := "" }

def line0050 : MdLine := { number := 50, text := "A document that provides background, history, or guidance without mandatory implementation requirements. It SHALL say near the top that it is informative only." }

def line0051 : MdLine := { number := 51, text := "" }

def line0052 : MdLine := { number := 52, text := "### 3.3 Publication" }

def line0053 : MdLine := { number := 53, text := "" }

def line0054 : MdLine := { number := 54, text := "The act by which the repository operator declares a specification version shipped. Working text is not publication until the operator says so. First publication of a specification under this document SHALL use version 1.0.0." }

def line0055 : MdLine := { number := 55, text := "" }

def line0056 : MdLine := { number := 56, text := "### 3.4 Repository operator" }

def line0057 : MdLine := { number := 57, text := "" }

def line0058 : MdLine := { number := 58, text := "The person or role that controls publication decisions for this repository." }

def line0059 : MdLine := { number := 59, text := "" }

def line0060 : MdLine := { number := 60, text := "### 3.5 External reference tree" }

def line0061 : MdLine := { number := 61, text := "" }

def line0062 : MdLine := { number := 62, text := "The `ref/` directory, holding public standards this repository cites so readers and tools can open the exact text meant without hunting the web: either git submodules from each standard's canonical git source that the publisher maintains (Form 1), or official publisher artifact pins (PDF, plain text, or similar) committed directly in this repository's git tree with SOURCE metadata (Form 2). Hyperlinks to publisher pages still matter as publisher links. See Clause 12." }

def line0063 : MdLine := { number := 63, text := "" }

def line0064 : MdLine := { number := 64, text := "## 4. Normative language" }

def line0065 : MdLine := { number := 65, text := "" }

def line0066 : MdLine := { number := 66, text := "### 4.1 RFC 2119 requirement keywords" }

def line0067 : MdLine := { number := 67, text := "" }

def line0068 : MdLine := { number := 68, text := "1. Specs SHALL use the requirement keywords defined in RFC 2119 in the RFC 2119 sense: MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL." }

def line0069 : MdLine := { number := 69, text := "2. Specs SHALL cite RFC 2119 (and the local `ref/` copy when present) in Normative references or an equivalent early section when they use those keywords." }

def line0070 : MdLine := { number := 70, text := "3. Keywords are not case sensitive under RFC 2119; this repository RECOMMENDS writing them in uppercase in normative clauses so readers can scan for requirements." }

def line0071 : MdLine := { number := 71, text := "4. Specs SHALL NOT invent a private mapping that weakens or redefines these keywords (for example, telling authors not to use MUST when RFC 2119 MUST is intended)." }

def line0072 : MdLine := { number := 72, text := "" }

def line0073 : MdLine := { number := 73, text := "### 4.2 Normative versus informative text" }

def line0074 : MdLine := { number := 74, text := "" }

def line0075 : MdLine := { number := 75, text := "1. Background, history, design reasoning, examples, notes, acknowledgments, and changelog narrative are informative. They explain context; they are not requirements by themselves." }

def line0076 : MdLine := { number := 76, text := "2. Requirements use the RFC 2119 keywords (MUST, SHALL, SHOULD, MAY, and the rest listed in Clause 4.1) in the RFC 2119 sense. A sentence that states a requirement SHALL use those keywords so readers can tell it is normative." }

def line0077 : MdLine := { number := 77, text := "3. Informative material SHOULD be titled or opened so a reader can tell it is not a requirements section. Examples of clear titles: \"Algorithm selection reasoning\", \"Background (informative)\", or an opening sentence that the subsection is informative." }

def line0078 : MdLine := { number := 78, text := "4. Authors SHALL NOT invent private jargon that redefines requirement levels or invents a parallel vocabulary for rules that sound like MUST. Use ordinary American English plus RFC 2119 keywords for requirements." }

def line0079 : MdLine := { number := 79, text := "5. If a requirement sentence appears inside an otherwise informative section, the RFC 2119 keyword still makes that sentence normative. Prefer keeping requirements in clearly normative sections and leaving informative sections free of mandatory rules." }

def line0080 : MdLine := { number := 80, text := "6. Open questions, behavior the implementation defines, and undefined behavior SHALL be labeled as such and SHALL NOT be mixed unmarked into mandatory requirements." }

def line0081 : MdLine := { number := 81, text := "" }

def line0082 : MdLine := { number := 82, text := "## 5. Document structure" }

def line0083 : MdLine := { number := 83, text := "" }

def line0084 : MdLine := { number := 84, text := "### 5.1 Title and version line" }

def line0085 : MdLine := { number := 85, text := "" }

def line0086 : MdLine := { number := 86, text := "1. The first heading SHALL be a single top level markdown title (`# ...`) naming the specification." }

def line0087 : MdLine := { number := 87, text := "2. Immediately under the title, a blockquote line SHOULD give the version and date." }

def line0088 : MdLine := { number := 88, text := "3. The version line SHOULD use Semantic Versioning with an optional leading `v` and a date:" }

def line0089 : MdLine := { number := 89, text := "" }

def line0090 : MdLine := { number := 90, text := "```text" }

def line0091 : MdLine := { number := 91, text := "> 1.0.0 - YYYYMMDD" }

def line0092 : MdLine := { number := 92, text := "```" }

def line0093 : MdLine := { number := 93, text := "" }

def line0094 : MdLine := { number := 94, text := "or:" }

def line0095 : MdLine := { number := 95, text := "" }

def line0096 : MdLine := { number := 96, text := "```text" }

def line0097 : MdLine := { number := 97, text := "> v1.0.0 - YYYYMMDD" }

def line0098 : MdLine := { number := 98, text := "```" }

def line0099 : MdLine := { number := 99, text := "" }

def line0100 : MdLine := { number := 100, text := "4. A one line subtitle in the same blockquote, or on the line after the version line, MAY state the document role (for example \"Form rules for numbered Surmount specs (spec 0)\")." }

def line0101 : MdLine := { number := 101, text := "" }

def line0102 : MdLine := { number := 102, text := "### 5.2 Version and date format" }

def line0103 : MdLine := { number := 103, text := "" }

def line0104 : MdLine := { number := 104, text := "1. Version strings SHALL follow Semantic Versioning 2.0.0 (MAJOR.MINOR.PATCH). See Clause 13." }

def line0105 : MdLine := { number := 105, text := "2. Dates in version lines and changelog headings SHALL use `YYYYMMDD` (four digit year, two digit month, two digit day, no separators)." }

def line0106 : MdLine := { number := 106, text := "3. In running prose, dates MAY use `YYYYMMDD` or `YYYY-MM-DD`. A single spec SHOULD pick one prose form and keep it consistent." }

def line0107 : MdLine := { number := 107, text := "4. Specs SHALL NOT invent a fake history of shipped 0.x releases for work that was never published. First publication of a specification SHALL be version 1.0.0. Changelog entries SHOULD use real SemVer headings once versions are assigned; they SHALL NOT label intermediate snapshots as shipped version numbers that were never released." }

def line0108 : MdLine := { number := 108, text := "" }

def line0109 : MdLine := { number := 109, text := "### 5.3 Section skeleton" }

def line0110 : MdLine := { number := 110, text := "" }

def line0111 : MdLine := { number := 111, text := "Normative specs SHALL use numbered section headings of the form `## N. Title` and `### N.M Title` (and deeper levels as needed)." }

def line0112 : MdLine := { number := 112, text := "" }

def line0113 : MdLine := { number := 113, text := "Recommended order for a normative specification:" }

def line0114 : MdLine := { number := 114, text := "" }

def line0115 : MdLine := { number := 115, text := "1. Scope" }

def line0116 : MdLine := { number := 116, text := "2. Normative references (if any)" }

def line0117 : MdLine := { number := 117, text := "3. Definitions (if any)" }

def line0118 : MdLine := { number := 118, text := "4. Core clauses (requirements, tables, algorithms)" }

def line0119 : MdLine := { number := 119, text := "5. Required Conformance clause (see Clause 14)" }

def line0120 : MdLine := { number := 120, text := "6. Changelog (required after first publication; recommended earlier)" }

def line0121 : MdLine := { number := 121, text := "7. Copyright or License" }

def line0122 : MdLine := { number := 122, text := "8. Acknowledgments (optional)" }

def line0123 : MdLine := { number := 123, text := "" }

def line0124 : MdLine := { number := 124, text := "Documents that are informative only need not include a Required Conformance clause as a requirements section, but SHALL state near the top that the document is informative only." }

def line0125 : MdLine := { number := 125, text := "" }

def line0126 : MdLine := { number := 126, text := "### 5.4 Lists" }

def line0127 : MdLine := { number := 127, text := "" }

def line0128 : MdLine := { number := 128, text := "1. Outside fenced code blocks, specs SHALL NOT use markdown bullet list markers (`-`, `*`, or `+` at the start of a list item)." }

def line0129 : MdLine := { number := 129, text := "2. Specs SHALL use numbered lists (`1.`, `2.`, ...) or lettered lists (`a.`, `b.`, ... / `A.`, `B.`, ...) for enumerations in prose." }

def line0130 : MdLine := { number := 130, text := "3. Table rows and markdown headings are not list markers and are allowed." }

def line0131 : MdLine := { number := 131, text := "" }

def line0132 : MdLine := { number := 132, text := "## 6. Character set and writing system" }

def line0133 : MdLine := { number := 133, text := "" }

def line0134 : MdLine := { number := 134, text := "### 6.1 Pure ASCII" }

def line0135 : MdLine := { number := 135, text := "" }

def line0136 : MdLine := { number := 136, text := "1. The entire specification file SHALL consist only of ASCII bytes." }

def line0137 : MdLine := { number := 137, text := "2. Allowed bytes are:" }

def line0138 : MdLine := { number := 138, text := "	a. Printable ASCII in the range 0x20 through 0x7E." }

def line0139 : MdLine := { number := 139, text := "	b. Horizontal tab 0x09." }

def line0140 : MdLine := { number := 140, text := "	c. Line feed 0x0A." }

def line0141 : MdLine := { number := 141, text := "3. Carriage return 0x0D SHALL NOT appear. Files SHALL use line endings that use LF and never CR." }

def line0142 : MdLine := { number := 142, text := "4. Other control characters (including NUL) SHALL NOT appear." }

def line0143 : MdLine := { number := 143, text := "5. Unicode punctuation SHALL NOT appear. Forbidden examples include em dashes, en dashes used as punctuation, smart quotation marks, and the Unicode ellipsis character. Use ASCII `-`, straight quotes, and `...` (three periods) instead." }

def line0144 : MdLine := { number := 144, text := "" }

def line0145 : MdLine := { number := 145, text := "### 6.2 American English" }

def line0146 : MdLine := { number := 146, text := "" }

def line0147 : MdLine := { number := 147, text := "1. Prose SHALL use American English spelling and wording (en_US)." }

def line0148 : MdLine := { number := 148, text := "2. On first use of an acronym that the expected audience might not know, specs SHOULD expand the acronym and MAY give the short form in parentheses." }

def line0149 : MdLine := { number := 149, text := "3. Proper nouns and stable external identifiers SHALL keep their upstream spelling and capitalization (for example ECMA-48, Floyd-Steinberg, SemVer)." }

def line0150 : MdLine := { number := 150, text := "" }

def line0151 : MdLine := { number := 151, text := "### 6.3 Spelling checkability" }

def line0152 : MdLine := { number := 152, text := "" }

def line0153 : MdLine := { number := 153, text := "Documents in scope SHALL remain checkable by the repository validator for spelling, character set, list form, hyphenation, and whitespace rules defined here. Domain terms that are correct but absent from a stock en_US dictionary MAY be listed in the repository spelling word list so that validation stays green without weakening the American English rule." }

def line0154 : MdLine := { number := 154, text := "" }

def line0155 : MdLine := { number := 155, text := "### 6.4 Line wrapping (not wrapped to a column)" }

def line0156 : MdLine := { number := 156, text := "" }

def line0157 : MdLine := { number := 157, text := "1. Spec prose SHALL NOT be wrapped to a column. Readers configure soft word wrap in their editor or viewer." }

def line0158 : MdLine := { number := 158, text := "2. Prefer one physical line per paragraph and per list item body." }

def line0159 : MdLine := { number := 159, text := "3. Deliberate line breaks remain for structure: blank lines, headings, list items (one item per line), tables, fenced code blocks, and blockquotes as blocks. The item text of a list entry SHOULD NOT wrap in the middle of a sentence onto a following physical line unless structure requires a nested block." }

def line0160 : MdLine := { number := 160, text := "4. The Lean checker enforces a heuristic for wrapping to a column on numbered specifications outside fenced code and tables: two consecutive body lines that are not empty where the first does not end a sentence or closed structure (does not end with `.`, `!`, `?`, or `:`) and the second continues with a lowercase letter. Full sentences that end with `.` on short lines still pass. Fenced code and table rows are exempt." }

def line0161 : MdLine := { number := 161, text := "5. Informative author tips (not a change to the algorithm in item 4): a common trip is a paragraph split in the middle of a sentence so the next physical line starts with a lowercase letter. Fix by joining that paragraph into one physical line (soft wrap in the editor). A short full sentence that ends with `.` on its own line, then a new sentence starting with a capital, is fine. Nested list structure and blank line paragraph breaks are not wraps to a column. Human oriented examples also appear in `README.md` under Validation." }

def line0162 : MdLine := { number := 162, text := "" }

def line0163 : MdLine := { number := 163, text := "### 6.5 Indentation (tabs)" }

def line0164 : MdLine := { number := 164, text := "" }

def line0165 : MdLine := { number := 165, text := "1. Leading indentation (whitespace from the start of a line before content) SHALL use tab characters (0x09) only, never space (0x20)." }

def line0166 : MdLine := { number := 166, text := "2. Spaces MAY appear in the middle of a line in prose and inside table rows (for example `| foo | bar |` cell padding). Those spaces are content or table formatting, not leading indentation." }

def line0167 : MdLine := { number := 167, text := "3. Nested markdown lists and other nested blocks SHALL indent with tabs (one tab per nesting level is the usual form)." }

def line0168 : MdLine := { number := 168, text := "4. Empty lines may be empty. Trailing whitespace is forbidden separately (Clause 6.6)." }

def line0169 : MdLine := { number := 169, text := "5. Language and format exceptions for source files in this repository that are not specifications: Lean sources MUST use spaces because the Lean 4 parser rejects tab indentation. YAML workflow files use spaces because common YAML tooling rejects tab indentation. Those exceptions apply to tooling files checked by the pure Nix whitespace check across the project; numbered specification markdown remains under the tab rule." }

def line0170 : MdLine := { number := 170, text := "" }

def line0171 : MdLine := { number := 171, text := "### 6.6 Trailing whitespace" }

def line0172 : MdLine := { number := 172, text := "" }

def line0173 : MdLine := { number := 173, text := "1. Lines SHALL NOT contain trailing space or tab characters before the line feed." }

def line0174 : MdLine := { number := 174, text := "2. The Lean checker enforces this on numbered specifications. The pure Nix flake check enforces it on text files owned by the project (see Clause 17 and `README.md`)." }

def line0175 : MdLine := { number := 175, text := "" }

def line0176 : MdLine := { number := 176, text := "## 7. Hyphenation and identifiers in prose" }

def line0177 : MdLine := { number := 177, text := "" }

def line0178 : MdLine := { number := 178, text := "1. Prefer ordinary English over hyphenated compounds. People who are not writing legal captions rarely hyphenate. Do not write modifiers such as `high-assurance`, `best-effort`, `self-improving`, `lock-free`, or `safety-critical`. Do not \"fix\" them by deleting the hyphen and leaving the same two words (`lock free`, `non markdown`, `must like`, `LF only`). Rephrase so a person would actually say it. `high assurance` may stay when it already reads as English. `3 bit`, `8 bit`, `24 bit`, and `high contrast` may stay. Say `tooling that is not markdown` rather than `non markdown tooling`. Say `tries that do not use locks` rather than `lock free tries`. Say `bootstrapped Slake that fully typechecks` rather than `fully type checking Slake`. The Lean `spec_check` leftover unstack list in `0005_CATE.md` is a floor for those leftover pairs; authors still SHALL rephrase other leftover pairs the checker does not name." }

def line0179 : MdLine := { number := 179, text := "2. A lowercase token with two or more hyphens (three or more segments), for example `foo-bar-baz`, SHALL NOT appear in prose outside fenced code blocks and inline code spans. That mechanical ban is a floor. It does not license a single hyphen in prose when a rephrased form works, and it does not license deleting the hyphen and leaving the same two words." }

def line0180 : MdLine := { number := 180, text := "3. Keep a hyphen in prose only when the token is a filename, a URL, a code identifier, or an official designation that is spelled with a hyphen (for example ITU-T, Floyd-Steinberg, ECMA-48, ISO/IEC). The mechanical checker still allows a single hyphen; authors still SHOULD use spaces." }

def line0181 : MdLine := { number := 181, text := "4. Proper names and stable external identifiers MAY keep their canonical hyphens (for example Floyd-Steinberg, ECMA-48, ISO/IEC, ITU-T)." }

def line0182 : MdLine := { number := 182, text := "5. Filenames, URLs, and code identifiers inside inline code or fenced blocks are outside the prose hyphenation ban. The tool name `pre-commit` MAY stay as the tool name." }

def line0183 : MdLine := { number := 183, text := "" }

def line0184 : MdLine := { number := 184, text := "## 8. Precision" }

def line0185 : MdLine := { number := 185, text := "" }

def line0186 : MdLine := { number := 186, text := "1. Terms with special meaning SHALL be defined before use or collected in a Definitions section." }

def line0187 : MdLine := { number := 187, text := "2. Normative facts SHALL prefer exact values, ranges, and enumerations over vague language (\"about\", \"roughly\", \"and so on\") when implementers need a definite answer." }

def line0188 : MdLine := { number := 188, text := "3. Behavior that the implementation defines, undefined behavior, or deliberately open behavior SHALL be called out with those words or in a clearly titled Open questions section." }

def line0189 : MdLine := { number := 189, text := "4. Specs SHALL NOT leave silent gaps on values, units, or states that a conforming implementer needs in order to interoperate." }

def line0190 : MdLine := { number := 190, text := "" }

def line0191 : MdLine := { number := 191, text := "## 9. Units and quantities" }

def line0192 : MdLine := { number := 192, text := "" }

def line0193 : MdLine := { number := 193, text := "1. Bit and byte widths in prose SHOULD be written with a space between the number and the unit word when used as adjectives or measures: `3 bit`, `8 bit`, `24 bit`. Do not treat this as a ban on `3-bit` in external quotations inside code fences." }

def line0194 : MdLine := { number := 194, text := "2. Prefer unambiguous numeric dates as in Clause 5.2." }

def line0195 : MdLine := { number := 195, text := "3. Use clear units for physical or logical quantities. Do not switch unit systems silently inside one spec." }

def line0196 : MdLine := { number := 196, text := "" }

def line0197 : MdLine := { number := 197, text := "## 10. Tables, code, and figures" }

def line0198 : MdLine := { number := 198, text := "" }

def line0199 : MdLine := { number := 199, text := "1. Fixed enumerations of values (palettes, code points, parameter maps) SHOULD be given as markdown tables." }

def line0200 : MdLine := { number := 200, text := "2. Fenced code blocks MAY present algorithms, examples, and ASCII diagrams." }

def line0201 : MdLine := { number := 201, text := "3. Specs SHALL NOT embed binary image assets. External links to figures are discouraged in core normative clauses; if used, the normative content SHALL still be understandable from the text and tables alone." }

def line0202 : MdLine := { number := 202, text := "4. ASCII diagrams inside fenced blocks MAY be used sparingly when they clarify structure." }

def line0203 : MdLine := { number := 203, text := "" }

def line0204 : MdLine := { number := 204, text := "## 11. File naming, numbering, and citation" }

def line0205 : MdLine := { number := 205, text := "" }

def line0206 : MdLine := { number := 206, text := "### 11.1 File names and location" }

def line0207 : MdLine := { number := 207, text := "" }

def line0208 : MdLine := { number := 208, text := "1. Specification files SHALL be named `NNNN_descriptive_name.md`." }

def line0209 : MdLine := { number := 209, text := "2. `NNNN` is a four digit decimal prefix, padded on the left with zeros (for example `0000`, `0001`)." }

def line0210 : MdLine := { number := 210, text := "3. `0000` is reserved for this document (the Surmount spec spec)." }

def line0211 : MdLine := { number := 211, text := "4. `descriptive_name` SHALL use ASCII letters, digits, and underscores only. Filenames that use hyphens in the basename SHALL NOT be used for specs." }

def line0212 : MdLine := { number := 212, text := "5. Numbered specification files SHALL live only in the repository root. Specs SHALL NOT be placed under nested directories (for example `specs/`, `docs/specs/`, or similar). See Clause 1.1." }

def line0213 : MdLine := { number := 213, text := "6. Once a specification number has been published in the repository, that number SHALL NOT be reused for a different document. Do not renumber published specs." }

def line0214 : MdLine := { number := 214, text := "" }

def line0215 : MdLine := { number := 215, text := "### 11.2 Citation of other Surmount specs" }

def line0216 : MdLine := { number := 216, text := "" }

def line0217 : MdLine := { number := 217, text := "1. Other specifications in this repository SHOULD be cited by file name and title, and MAY include a version string (for example `0001_DOGE.md`, Digital Octal Graphical Emissive (DOGE) Color Specification, 1.0.0)." }

def line0218 : MdLine := { number := 218, text := "2. When citing a specification that has not been published yet, do not invent a shipped version number for work the operator has not declared published." }

def line0219 : MdLine := { number := 219, text := "" }

def line0220 : MdLine := { number := 220, text := "### 11.3 Citation of external standards" }

def line0221 : MdLine := { number := 221, text := "" }

def line0222 : MdLine := { number := 222, text := "1. External standards SHOULD be cited with enough identity for a reader to find them: title, issuing body when known, and version or year when relevant." }

def line0223 : MdLine := { number := 223, text := "2. When this repository keeps a local copy under `ref/`, the citation SHOULD also name that path (for example `ref/semver`, `ref/rfc2119`)." }

def line0224 : MdLine := { number := 224, text := "" }

def line0225 : MdLine := { number := 225, text := "## 12. External references (`ref/`)" }

def line0226 : MdLine := { number := 226, text := "" }

def line0227 : MdLine := { number := 227, text := "### 12.1 Purpose" }

def line0228 : MdLine := { number := 228, text := "" }

def line0229 : MdLine := { number := 229, text := "1. `ref/` holds the external standards this repository cites (Semantic Versioning, RFC 2119, ECMA and ISO terminal standards, and similar) so readers and tools can open the **exact** text meant without hunting the web." }

def line0230 : MdLine := { number := 230, text := "2. Hyperlinks to publisher pages still matter (and often predate git and even some of the specs). Canonical URLs SHALL remain in each entry's SOURCE file and SHOULD appear in citations." }

def line0231 : MdLine := { number := 231, text := "3. Local copies under `ref/` freeze what this repository reviewed and checksummed or pinned in git. They do not replace the publisher page as the public home of the standard." }

def line0232 : MdLine := { number := 232, text := "" }

def line0233 : MdLine := { number := 233, text := "### 12.2 Process rule (binding)" }

def line0234 : MdLine := { number := 234, text := "" }

def line0235 : MdLine := { number := 235, text := "1. Any external specification this repository cites MUST be present under `ref/` in one of the two forms in this clause." }

def line0236 : MdLine := { number := 236, text := "2. **Form 1: Canonical git that the publisher maintains.** When a cited standard has a **canonical git repository maintained by the publisher** (any host: GitHub, GitLab, a host you run yourself, or other; NOT assumed to be GitHub), authors SHALL add it under `ref/` as a git submodule from that publisher git URL and pin a tag or commit. Example: Semantic Versioning under `ref/semver`." }

def line0237 : MdLine := { number := 237, text := "3. **Form 2: No canonical git that the publisher maintains.** When the publisher does not maintain a canonical git repository for that standard (common for standards from before git and from the PDF era), or when official git is not the authoritative publication form, Form 2 is the **intended** process (not a fallback failure). Authors SHALL:" }

def line0238 : MdLine := { number := 238, text := "	1. Document that fact in `ref/README.md` for the entry (no publisher git; what is used instead)." }

def line0239 : MdLine := { number := 239, text := "	2. Keep a **local copy** of the specific official publisher artifact needed under `ref/<short_name>/`, committed **directly in this repository's git tree** as ordinary files (**not** a submodule), obtained from the most canonical official source the publisher provides." }

def line0240 : MdLine := { number := 240, text := "	3. Record canonical hyperlink(s), retrieval date, checksum, and edition or version in a pure ASCII `SOURCE` file under that directory. Publisher hyperlinks still matter as publisher links; the local copy freezes the reviewed bytes." }

def line0241 : MdLine := { number := 241, text := "	4. Note license, copyright, or republication status for the entry in `ref/README.md` (detail MAY remain in SOURCE)." }

def line0242 : MdLine := { number := 242, text := "	5. State reasoning in `ref/README.md`: why direct tree copy instead of submodule (no publisher git; durable local pin of the exact official artifact; hyperlinks remain for the living publisher location; no invented fake git remotes). That form **does** satisfy this clause. Examples: RFC 2119 (RFC Editor plain text under `ref/rfc2119`), ECMA-48 (Ecma International PDF under `ref/ecma48`), and ITU-T T.416 (ITU free PDF under `ref/itu_t416`; identical text also published as ISO/IEC 8613-6)." }

def line0243 : MdLine := { number := 243, text := "4. Authors SHALL NOT invent a random third party mirror or community reformat as \"canonical git.\" Prefer honesty about what the publisher actually maintains." }

def line0244 : MdLine := { number := 244, text := "5. Authors SHOULD prefer Form 1 when the publisher truly maintains git for that standard, and SHOULD prefer Form 2 when that is what the publisher ships. Standards from before git and from the PDF era (RFC 2119, ECMA-48, ITU-T T.416, and similar) are expected to use Form 2 unless the publisher later maintains real canonical git for that standard." }

def line0245 : MdLine := { number := 245, text := "6. Directory names under `ref/` SHOULD be short, stable, and lowercase (examples: `semver`, `rfc2119`, `ecma48`, `itu_t416`)." }

def line0246 : MdLine := { number := 246, text := "7. Authors SHALL NOT edit upstream files inside submodules or inside pinned official artifacts. Specs cite a version, tag, commit, or SOURCE checksum. Update the pin when the cited version must change." }

def line0247 : MdLine := { number := 247, text := "8. Process detail for operators and agents, including per-entry license notes and \"Why we pin this way,\" is described in `ref/README.md`. A short summary also appears in the repository root `README.md`." }

def line0248 : MdLine := { number := 248, text := "" }

def line0249 : MdLine := { number := 249, text := "### 12.3 Present initial references" }

def line0250 : MdLine := { number := 250, text := "" }

def line0251 : MdLine := { number := 251, text := "The following are expected early `ref/` entries for this repository when populated. Each form below is valid under Clause 12.2:" }

def line0252 : MdLine := { number := 252, text := "" }

def line0253 : MdLine := { number := 253, text := "1. Semantic Versioning (`ref/semver`) - Form 1 git submodule of the SemVer project's canonical repository that the publisher maintains, when present." }

def line0254 : MdLine := { number := 254, text := "2. RFC 2119 (`ref/rfc2119`) - Form 2 official RFC Editor plain text pin committed directly in this repository's git tree with SOURCE when present. There is no canonical git repository that the publisher maintains for this historic RFC that this process treats as authoritative; third party copies are not canonical." }

def line0255 : MdLine := { number := 255, text := "3. ECMA-48 and related ISO/IEC terminal control references as used by DOGE and similar specs, when available under `ref/` - Form 2 official Ecma International PDF pin committed directly in this repository's git tree with SOURCE for ECMA-48 (`ref/ecma48`) when present. Community reformats are not the Ecma publisher source." }

def line0256 : MdLine := { number := 256, text := "4. ITU-T T.416 / ISO/IEC 8613-6 (`ref/itu_t416`) - Form 2 official ITU free PDF pin (Recommendation T.416, 03/93; identical text also published as ISO/IEC 8613-6) committed directly in this repository's git tree with SOURCE when present. There is no canonical git that the publisher maintains for this Recommendation. DOGE cites this standard for extended color models." }

def line0257 : MdLine := { number := 257, text := "" }

def line0258 : MdLine := { number := 258, text := "Population of `ref/` may be performed by a separate effort. Specs MAY be written citing these paths before the directories exist; the paths remain the documented local locations." }

def line0259 : MdLine := { number := 259, text := "" }

def line0260 : MdLine := { number := 260, text := "### 12.4 Adding or updating a citation" }

def line0261 : MdLine := { number := 261, text := "" }

def line0262 : MdLine := { number := 262, text := "When a specification gains a new normative or strongly recommended external citation, authors SHALL:" }

def line0263 : MdLine := { number := 263, text := "" }

def line0264 : MdLine := { number := 264, text := "1. Add or update the corresponding `ref/` entry under Clause 12.2: either a Form 1 git submodule from the standard's canonical git source that the publisher maintains, or a Form 2 official publisher artifact pin with SOURCE committed directly in this repository's git tree, as fits what the publisher actually provides." }

def line0265 : MdLine := { number := 265, text := "2. Cite both the public identity of the standard (including publisher hyperlink when useful) and the local `ref/` path when the path exists." }

def line0266 : MdLine := { number := 266, text := "3. Avoid treating an empty or not yet populated `ref/` path as a reason to drop the public citation. Document the intended path and complete the pin when the process allows." }

def line0267 : MdLine := { number := 267, text := "4. Authors SHALL NOT delete a valid pin solely to force a different form without operator direction." }

def line0268 : MdLine := { number := 268, text := "5. Existing pins remain. New pins are added when the cited artifact is present under `ref/`." }

def line0269 : MdLine := { number := 269, text := "6. A Form 2 PDF pin SHALL include SOURCE. A permission note for republication of those PDFs SHALL be recorded when the operator writes that note. Until that note exists, residual SHALL name that it is not yet written." }

def line0270 : MdLine := { number := 270, text := "" }

def line0271 : MdLine := { number := 271, text := "## 13. Versioning (Semantic Versioning and publication)" }

def line0272 : MdLine := { number := 272, text := "" }

def line0273 : MdLine := { number := 273, text := "### 13.1 SemVer is real Semantic Versioning" }

def line0274 : MdLine := { number := 274, text := "" }

def line0275 : MdLine := { number := 275, text := "1. Specification version numbers SHALL follow Semantic Versioning 2.0.0: MAJOR.MINOR.PATCH." }

def line0276 : MdLine := { number := 276, text := "2. Specs SHALL cite SemVer (and `ref/semver` when present)." }

def line0277 : MdLine := { number := 277, text := "3. A change that makes previously conforming implementations nonconforming SHALL raise MAJOR and MAY reset MINOR and PATCH to 0 as SemVer describes." }

def line0278 : MdLine := { number := 278, text := "4. A backward compatible addition or clarification SHOULD raise MINOR (and MAY reset PATCH to 0) as SemVer describes." }

def line0279 : MdLine := { number := 279, text := "5. A backward compatible fix that does not add feature surface SHOULD raise PATCH only." }

def line0280 : MdLine := { number := 280, text := "" }

def line0281 : MdLine := { number := 281, text := "### 13.2 First publication and honesty about history" }

def line0282 : MdLine := { number := 282, text := "" }

def line0283 : MdLine := { number := 283, text := "1. The repository operator controls when a specification is published." }

def line0284 : MdLine := { number := 284, text := "2. Specs SHALL NOT invent pretend shipped releases (including a theater of 0.1, 0.2, or other 0.x \"releases\") for work that was never published." }

def line0285 : MdLine := { number := 285, text := "3. First publication of a specification SHALL be version 1.0.0." }

def line0286 : MdLine := { number := 286, text := "4. Specs MAY carry a SemVer version line (Clause 5.1) without special draft status wording. Agents and authors SHALL NOT invent fake version history or claim publication the operator has not declared." }

def line0287 : MdLine := { number := 287, text := "5. Changelog entries SHOULD use SemVer version headings when versions are assigned. They SHALL NOT label snapshots as shipped version numbers that were never released." }

def line0288 : MdLine := { number := 288, text := "" }

def line0289 : MdLine := { number := 289, text := "### 13.3 MAJOR 0" }

def line0290 : MdLine := { number := 290, text := "" }

def line0291 : MdLine := { number := 291, text := "Use of MAJOR version 0 as a public compatibility signal is out of scope for Surmount specs under this document. Do not run a fake 0.x release train. First publication is 1.0.0; versions follow SemVer thereafter." }

def line0292 : MdLine := { number := 292, text := "" }

def line0293 : MdLine := { number := 293, text := "## 14. Required Conformance clause" }

def line0294 : MdLine := { number := 294, text := "" }

def line0295 : MdLine := { number := 295, text := "This clause states what every normative Surmount specification is required to include inside its own document. It is not the checklist for whether a document meets this document (the form rules in 0000); that checklist is Clause 19." }

def line0296 : MdLine := { number := 296, text := "" }

def line0297 : MdLine := { number := 297, text := "1. Every normative specification SHALL include a section that states how an implementation or document conforms to that specification (what has to be true to claim conformance)." }

def line0298 : MdLine := { number := 298, text := "2. That section SHOULD be titled in plain English so readers can find it (for example \"Conformance\" or \"Conformance requirements\")." }

def line0299 : MdLine := { number := 299, text := "3. Documents that are informative only SHALL say they are informative only near the top of the file and need not define implementation conformance." }

def line0300 : MdLine := { number := 300, text := "4. Authors SHOULD NOT use the same heading title for (a) the conformance requirements inside that specification for implementers of that spec and (b) any checklist about conforming to this document (the form rules in 0000), when both appear. Prefer distinct titles such as \"Conformance\" for (a) and leave form rule checklists to this document (Clause 19)." }

def line0301 : MdLine := { number := 301, text := "" }

def line0302 : MdLine := { number := 302, text := "## 15. Change control" }

def line0303 : MdLine := { number := 303, text := "" }

def line0304 : MdLine := { number := 304, text := "1. After first publication, every normative specification SHALL include a Changelog section." }

def line0305 : MdLine := { number := 305, text := "2. Each published revision SHALL add a changelog entry headed with the SemVer version and date form from Clause 5.2 (for example `### 1.1.0 - 20260815`)." }

def line0306 : MdLine := { number := 306, text := "3. Changelog entries SHOULD summarize normative changes in plain language. Informative edits MAY be noted briefly or omitted when trivial." }

def line0307 : MdLine := { number := 307, text := "4. Version numbering follows Clause 13." }

def line0308 : MdLine := { number := 308, text := "5. Specs SHOULD keep a short changelog with SemVer headings once versions are assigned, without fake release numbers for work that was never shipped." }

def line0309 : MdLine := { number := 309, text := "" }

def line0310 : MdLine := { number := 310, text := "## 16. Copyright and license" }

def line0311 : MdLine := { number := 311, text := "" }

def line0312 : MdLine := { number := 312, text := "1. Every specification SHALL include a Copyright or License section, or an explicit statement that the repository license applies to the document." }

def line0313 : MdLine := { number := 313, text := "2. Unless a specification states otherwise, the repository Unlicense (public domain dedication) applies." }

def line0314 : MdLine := { number := 314, text := "3. License sections MAY quote or summarize the Unlicense. They SHALL NOT contradict the repository license without an explicit, visible alternate terms statement." }

def line0315 : MdLine := { number := 315, text := "" }

def line0316 : MdLine := { number := 316, text := "## 17. Machine validation" }

def line0317 : MdLine := { number := 317, text := "" }

def line0318 : MdLine := { number := 318, text := "### 17.1 Authoritative checkers" }

def line0319 : MdLine := { number := 319, text := "" }

def line0320 : MdLine := { number := 320, text := "1. The authoritative automated checker for mechanical form rules on numbered specifications implied by this document is a Lean program, packaged and run through the repository Nix flake as the sole software package (`packages.spec_check`), with a matching flake check, development shell entry, and pre-commit hook." }

def line0321 : MdLine := { number := 321, text := "2. Mechanical form rules checked by Lean on numbered specifications include character set, list markers, excess hyphenated tokens in prose (lowercase token with two or more hyphens), leftover unstack phrases listed in `0005_CATE.md`, a Residual heading when a numbered specification other than this document contains a planned or unpublished `NNNN_*.md` token, trailing whitespace, leading indentation that uses tabs only, detection of prose wrapped to a column, and related form rules, and MAY grow as the Lean checker covers more clauses." }

def line0322 : MdLine := { number := 322, text := "3. Trailing whitespace and leading indentation that uses tabs only, on Surmount authored text files across the project (not only numbered specifications), SHALL be enforced by a pure Nix flake check (Nix language evaluation over the tree; see `nix/whitespace.nix` and `checks.whitespace`). That check is not bash and not Lean. It skips vendor blobs under `ref/` such as the SemVer submodule, PDFs, and RFC plain text, and applies the Lean/YAML indent exceptions in Clause 6.5." }

def line0323 : MdLine := { number := 323, text := "4. Dual whitespace coverage is intentional and both checks SHALL remain: Lean enforces trailing whitespace and leading indentation that uses tabs only on numbered specifications as part of the form suite (item 2); pure Nix enforces the same class of rules across the tree on Surmount authored text (item 3). Neither layer replaces the other. Design rationale for that split (and for keeping spelling and form policy that takes more than one pass in Lean rather than pure Nix) is informative prose in `README.md` section 7.2.1 and in `AGENTS.md` under \"Why Lean vs pure Nix\"; those documents are not additional normative checkers." }

def line0324 : MdLine := { number := 324, text := "5. American English spelling against the repository personal word list SHALL be enforced by the Lean `spec_check` program, which invokes `aspell` from PATH (`list --lang=en_US --mode=markdown`) with `aspell_words.txt`. The flake check `checks.spec_check` supplies `pkgs.aspellWithDicts` on PATH so spelling runs in CI. Spelling is not a separate flake check, not a shell package, and MUST NOT rely on a repository `scripts/` gatekeeper or a bash discovery policy that spans multiple lines." }

def line0325 : MdLine := { number := 325, text := "6. Documents in scope SHALL remain checkable by the relevant authoritative checker when it is available for a given clause." }

def line0326 : MdLine := { number := 326, text := "" }

def line0327 : MdLine := { number := 327, text := "### 17.2 Integration points (no bash authority)" }

def line0328 : MdLine := { number := 328, text := "" }

def line0329 : MdLine := { number := 329, text := "1. Validation entry points are the repository Nix flake: `nix flake check`, `nix build` / `nix run` of `spec_check`, development shell, and pre-commit hook. There is no lasting `scripts/` bash authority for form rules, spelling, or whitespace across the project." }

def line0330 : MdLine := { number := 330, text := "2. The Lean program is authoritative for any form rule on numbered specifications that it implements, including American English spelling when aspell is available (Clause 17.1 item 5). Bash MUST NOT be the authority for trailing whitespace or tab indent across the project; that authority is pure Nix (Clause 17.1 item 3)." }

def line0331 : MdLine := { number := 331, text := "3. This clause does not encode third party hook product brand names as document law. Repository Nix flake checks and a pre-commit hook are the intended integration points described for humans in `README.md`." }

def line0332 : MdLine := { number := 332, text := "" }

def line0333 : MdLine := { number := 333, text := "### 17.3 What validation does not decide" }

def line0334 : MdLine := { number := 334, text := "" }

def line0335 : MdLine := { number := 335, text := "Machine validation does not by itself declare publication, SemVer intent, or correctness of technical algorithms beyond the mechanical form rules it implements." }

def line0336 : MdLine := { number := 336, text := "" }

def line0337 : MdLine := { number := 337, text := "## 18. Self application" }

def line0338 : MdLine := { number := 338, text := "" }

def line0339 : MdLine := { number := 339, text := "This document SHALL conform to its own rules." }

def line0340 : MdLine := { number := 340, text := "" }

def line0341 : MdLine := { number := 341, text := "## 19. Conformance to this document" }

def line0342 : MdLine := { number := 342, text := "" }

def line0343 : MdLine := { number := 343, text := "A markdown document is conformant to this document if and only if all of the following hold when the clause applies to that document:" }

def line0344 : MdLine := { number := 344, text := "" }

def line0345 : MdLine := { number := 345, text := "1. The file is pure ASCII as defined in Clause 6.1." }

def line0346 : MdLine := { number := 346, text := "2. Prose uses American English as in Clause 6.2 and remains validator checkable as in Clauses 6.3 and 17." }

def line0347 : MdLine := { number := 347, text := "3. Line wrapping, tab indentation, and trailing whitespace follow Clauses 6.4, 6.5, and 6.6." }

def line0348 : MdLine := { number := 348, text := "4. Section headings and lists follow Clauses 5.3 and 5.4." }

def line0349 : MdLine := { number := 349, text := "5. RFC 2119 keywords are used as required by Clause 4 when the document is normative and states requirements." }

def line0350 : MdLine := { number := 350, text := "6. Excess hyphenated tokens in prose are absent as required by Clause 7." }

def line0351 : MdLine := { number := 351, text := "7. Precision, open questions, and labels for behavior the implementation defines follow Clauses 4.2 and 8." }

def line0352 : MdLine := { number := 352, text := "8. If the document is a numbered specification file, naming follows Clause 11." }

def line0353 : MdLine := { number := 353, text := "9. External citations follow Clauses 11.3 and 12 when such citations appear." }

def line0354 : MdLine := { number := 354, text := "10. Versioning and publication rules follow Clause 13 and Clause 5.2." }

def line0355 : MdLine := { number := 355, text := "11. If the document is normative (not a document that is informative only), it includes a Required Conformance clause as in Clause 14, and after first publication it includes a Changelog as in Clause 15." }

def line0356 : MdLine := { number := 356, text := "12. Copyright or license material follows Clause 16." }

def line0357 : MdLine := { number := 357, text := "13. No binary images are embedded (Clause 10)." }

def line0358 : MdLine := { number := 358, text := "14. Leftover unstack phrases listed in `0005_CATE.md` are absent from numbered specification prose outside fenced code and inline code." }

def line0359 : MdLine := { number := 359, text := "15. If the document is a numbered specification other than this document and it contains a planned or unpublished `NNNN_*.md` token, it includes a Residual heading as in `0005_CATE.md`." }

def line0360 : MdLine := { number := 360, text := "16. CATE requirements in `0005_CATE.md` that are not fully mechanical still apply to authors (complete thoughts, residual written in full, spec markdown as the contract humans read, no invented conforming product, RFC 2119 not replaced)." }

def line0361 : MdLine := { number := 361, text := "" }

def line0362 : MdLine := { number := 362, text := "Optional recommendations (SHOULD, RECOMMENDED) do not break conformance when unmet, but authors SHOULD follow them unless there is a clear reason not to." }

def line0363 : MdLine := { number := 363, text := "" }

def line0364 : MdLine := { number := 364, text := "## 20. Concise American Technical English (CATE)" }

def line0365 : MdLine := { number := 365, text := "" }

def line0366 : MdLine := { number := 366, text := "Concise American Technical English is specified in `0005_CATE.md`. This document does not restate CATE. Authors SHALL follow that specification when writing numbered specifications in this repository." }

def line0367 : MdLine := { number := 367, text := "" }

def line0368 : MdLine := { number := 368, text := "## 21. Changelog" }

def line0369 : MdLine := { number := 369, text := "" }

def line0370 : MdLine := { number := 370, text := "### 1.3.0 - 20260825" }

def line0371 : MdLine := { number := 371, text := "" }

def line0372 : MdLine := { number := 372, text := "Assigns Concise American Technical English to specification 0005 with file name `0005_CATE.md` and Recursive Self Improvement to specification 0006 with file name `0006_RSI.md`. Existing `ref/` pins remain; new pins are added when the cited artifact is present. A PDF permission note is named in residual until the operator writes that note. Lean 4, CompCert, Idris 2, and Rust stay in the Systems Lean product tree and MUST NOT be copied into this repository's `ref/`." }

def line0373 : MdLine := { number := 373, text := "" }

def line0374 : MdLine := { number := 374, text := "### 1.2.0 - 20260825" }

def line0375 : MdLine := { number := 375, text := "" }

def line0376 : MdLine := { number := 376, text := "Moves Concise American Technical English (CATE) out of this document into numbered specification `0005_CATE.md` (first publication of CATE as a numbered specification, version 1.0.0; the stack number 0005 is recorded in 1.3.0). This document keeps a short pointer only and does not restate CATE. Authors still SHALL apply CATE by following `0005_CATE.md`. fargo has no assigned specification number. The Carbonado Network Protocol still has no assigned number." }

def line0377 : MdLine := { number := 377, text := "" }

def line0378 : MdLine := { number := 378, text := "### 1.1.0 - 20260825" }

def line0379 : MdLine := { number := 379, text := "" }

def line0380 : MdLine := { number := 380, text := "Adds Concise American Technical English (CATE) as an extension of this document (specification 0000). Recursive Self Improvement is specified in `0006_RSI.md`. fargo has no assigned specification number. CATE states complete American English thoughts, concise prose, leftover unstack as nonconforming, residual written in full, spec markdown as the contract humans read, no invented conforming product, and that CATE does not replace RFC 2119. ISO 24495-1:2023 Plain language and the US Federal Plain Language Guidelines are named as informative prior art and are not Clause 12 pins. Lean `spec_check` flags the leftover unstack floor list and requires a Residual heading when numbered specifications other than this document contain a planned or unpublished `NNNN_*.md` token. Companion meaning proofs live under `lean/Cate.lean`." }

def line0381 : MdLine := { number := 381, text := "" }

def line0382 : MdLine := { number := 382, text := "### 1.0.0 - 20260730" }

def line0383 : MdLine := { number := 383, text := "" }

def line0384 : MdLine := { number := 384, text := "Establishes normative clauses for scope, RFC 2119 requirement keywords, Semantic Versioning with no fake 0.x release history, external references under `ref/`, document skeleton, ASCII and American English rules, hyphenation, spelling checkability, tables and code, file naming and flat repository root location only, Required Conformance clause (what each normative spec must include), Conformance to this document (checklist for meeting 0000), change control, license, Lean based machine validation via Nix, and self application. Clarifies normative versus informative text under RFC 2119 (background and design reasoning are informative; requirements use RFC 2119 keywords; informative sections should be labeled as such). Names this document the Surmount spec spec (spec 0); form rules use plain \"spec spec\" language rather than a hyphenated product name." }

def line0385 : MdLine := { number := 385, text := "" }

def line0386 : MdLine := { number := 386, text := "Clause 12 process: external standards this repository cites MUST live under `ref/` either as Form 1 git submodules from a canonical git source that the publisher maintains (example: SemVer), or as Form 2 official publisher artifact pins when there is no canonical git that the publisher maintains. Form 2 is the intentional process for those standards (local copy of the official artifact under `ref/`, SOURCE, publisher hyperlinks that still matter), not a fallback failure. Form 2 pins are ordinary files committed directly in this repository's git tree (not submodules), with SOURCE metadata (canonical URL, retrieval date, checksum, edition), license or copyright notes, and reasoning in `ref/README.md`. Examples: RFC 2119 RFC Editor txt, ECMA-48 Ecma PDF, ITU-T T.416 ITU free PDF (dual text ISO/IEC 8613-6) under `ref/itu_t416`. Hyperlinks to publisher pages still matter as publisher links. Third party mirrors and community reformats are not canonical. Official artifact pins for RFC 2119, ECMA-48, and ITU-T T.416 meet the rule; they are not \"legacy gaps.\"" }

def line0387 : MdLine := { number := 387, text := "" }

def line0388 : MdLine := { number := 388, text := "Whitespace and layout (same 1.0.0 publication line; not a separate shipped release): Clause 6.4 requires prose that is not wrapped to a column (one physical line per paragraph or list item body; soft wrap left to the reader). Clause 6.5 requires leading indentation that uses tabs only in specs (spaces in the middle of a line and in tables remain allowed; Lean and YAML tooling files are documented exceptions for indent with spaces). Clause 6.6 forbids trailing whitespace. Lean `spec_check` enforces trailing whitespace, leading spaces, and a heuristic for wrapping to a column on numbered specifications. Trailing whitespace and tab indent on Surmount authored text across the project are enforced by pure Nix (`checks.whitespace` / `nix/whitespace.nix`), not by bash and not by moving that scan into Lean. Dual whitespace coverage (Lean on numbered specifications plus pure Nix across the tree) is intentional; Clause 17.1 states both and points to `README.md` section 7.2.1 and `AGENTS.md` \"Why Lean vs pure Nix\" for design rationale. American English spelling on numbered specifications is enforced by Lean `spec_check` via aspell and `aspell_words.txt` (flake `checks.spec_check` puts aspellWithDicts on PATH); there is no separate `checks.spelling` and no `scripts/` bash gatekeeper." }

def line0389 : MdLine := { number := 389, text := "" }

def line0390 : MdLine := { number := 390, text := "This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough. Hyphens remain for filenames, URLs, code identifiers, and official designations." }

def line0391 : MdLine := { number := 391, text := "" }

def line0392 : MdLine := { number := 392, text := "Prior short checklists and intermediate text are superseded by this version. They were never separate published releases." }

def line0393 : MdLine := { number := 393, text := "" }

def line0394 : MdLine := { number := 394, text := "## 22. Copyright" }

def line0395 : MdLine := { number := 395, text := "" }

def line0396 : MdLine := { number := 396, text := "This work is released into the public domain under the Unlicense. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository." }

def encodedLines : Array MdLine :=
  #[
    line0001, line0002, line0003, line0004, line0005, line0006, line0007, line0008,
    line0009, line0010, line0011, line0012, line0013, line0014, line0015, line0016,
    line0017, line0018, line0019, line0020, line0021, line0022, line0023, line0024,
    line0025, line0026, line0027, line0028, line0029, line0030, line0031, line0032,
    line0033, line0034, line0035, line0036, line0037, line0038, line0039, line0040,
    line0041, line0042, line0043, line0044, line0045, line0046, line0047, line0048,
    line0049, line0050, line0051, line0052, line0053, line0054, line0055, line0056,
    line0057, line0058, line0059, line0060, line0061, line0062, line0063, line0064,
    line0065, line0066, line0067, line0068, line0069, line0070, line0071, line0072,
    line0073, line0074, line0075, line0076, line0077, line0078, line0079, line0080,
    line0081, line0082, line0083, line0084, line0085, line0086, line0087, line0088,
    line0089, line0090, line0091, line0092, line0093, line0094, line0095, line0096,
    line0097, line0098, line0099, line0100, line0101, line0102, line0103, line0104,
    line0105, line0106, line0107, line0108, line0109, line0110, line0111, line0112,
    line0113, line0114, line0115, line0116, line0117, line0118, line0119, line0120,
    line0121, line0122, line0123, line0124, line0125, line0126, line0127, line0128,
    line0129, line0130, line0131, line0132, line0133, line0134, line0135, line0136,
    line0137, line0138, line0139, line0140, line0141, line0142, line0143, line0144,
    line0145, line0146, line0147, line0148, line0149, line0150, line0151, line0152,
    line0153, line0154, line0155, line0156, line0157, line0158, line0159, line0160,
    line0161, line0162, line0163, line0164, line0165, line0166, line0167, line0168,
    line0169, line0170, line0171, line0172, line0173, line0174, line0175, line0176,
    line0177, line0178, line0179, line0180, line0181, line0182, line0183, line0184,
    line0185, line0186, line0187, line0188, line0189, line0190, line0191, line0192,
    line0193, line0194, line0195, line0196, line0197, line0198, line0199, line0200,
    line0201, line0202, line0203, line0204, line0205, line0206, line0207, line0208,
    line0209, line0210, line0211, line0212, line0213, line0214, line0215, line0216,
    line0217, line0218, line0219, line0220, line0221, line0222, line0223, line0224,
    line0225, line0226, line0227, line0228, line0229, line0230, line0231, line0232,
    line0233, line0234, line0235, line0236, line0237, line0238, line0239, line0240,
    line0241, line0242, line0243, line0244, line0245, line0246, line0247, line0248,
    line0249, line0250, line0251, line0252, line0253, line0254, line0255, line0256,
    line0257, line0258, line0259, line0260, line0261, line0262, line0263, line0264,
    line0265, line0266, line0267, line0268, line0269, line0270, line0271, line0272,
    line0273, line0274, line0275, line0276, line0277, line0278, line0279, line0280,
    line0281, line0282, line0283, line0284, line0285, line0286, line0287, line0288,
    line0289, line0290, line0291, line0292, line0293, line0294, line0295, line0296,
    line0297, line0298, line0299, line0300, line0301, line0302, line0303, line0304,
    line0305, line0306, line0307, line0308, line0309, line0310, line0311, line0312,
    line0313, line0314, line0315, line0316, line0317, line0318, line0319, line0320,
    line0321, line0322, line0323, line0324, line0325, line0326, line0327, line0328,
    line0329, line0330, line0331, line0332, line0333, line0334, line0335, line0336,
    line0337, line0338, line0339, line0340, line0341, line0342, line0343, line0344,
    line0345, line0346, line0347, line0348, line0349, line0350, line0351, line0352,
    line0353, line0354, line0355, line0356, line0357, line0358, line0359, line0360,
    line0361, line0362, line0363, line0364, line0365, line0366, line0367, line0368,
    line0369, line0370, line0371, line0372, line0373, line0374, line0375, line0376,
    line0377, line0378, line0379, line0380, line0381, line0382, line0383, line0384,
    line0385, line0386, line0387, line0388, line0389, line0390, line0391, line0392,
    line0393, line0394, line0395, line0396
  ]

def lineCount : Nat := 396

end Spec_0000
