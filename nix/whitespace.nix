# Pure Nix checker: project-owned trailing whitespace and tab-only leading indent.
#
# Call as: import ./nix/whitespace.nix { inherit lib; } root
# root may be a Nix path, an absolute path string, or a set whose outPath
# is a Nix path or an absolute path string. cleanSourceWith returns a set.
# Its outPath may be a path, or an absolute path string. /. + that string
# makes a Nix path. A store path string drops its context first.
# Do not pass toString of that set. fileFilter rejects a string.
# Returns: list of "path:line: message" strings (empty = ok).
#
# Not Lean. Not bash. Evaluation is the check (see flake checks.whitespace).
# Why pure Nix here vs Lean for numbered-spec form/spelling: README.md 7.2.1
# and AGENTS.md "Why Lean vs pure Nix".

{ lib }:
root:

let
	inherit (builtins)
		readFile
		split
		stringLength
		substring
		filter
		isString
		isPath
		pathExists
		typeOf
		;
	inherit (lib) fileset;

	# fileFilter requires a Nix path. cleanSourceWith returns a set.
	# outPath may be a path, or an absolute path string.
	# /. + s is path concatenation. It turns that string into a Nix path.
	# Nix refuses /. + on a string that refers to a store path, so that case
	# drops the string context first (builtins.unsafeDiscardStringContext).
	# Do not use toString on the set. Do not use builtins.toPath.
	# A relative string is not coerced.
	badRootMsg = "whitespace.nix: root must be a Nix path, an absolute path string, or a set whose outPath is a Nix path or an absolute path string. Pass cleanSourceWith outPath. Do not pass toString of that set into fileFilter.";

	absStringToPath =
		s:
		if isString s && lib.hasPrefix "/" s then
			if builtins.hasContext s then
				/. + builtins.unsafeDiscardStringContext s
			else
				/. + s
		else
			throw badRootMsg;

	rootPath =
		if isPath root then
			root
		else if isString root then
			absStringToPath root
		else if typeOf root == "set" && root ? outPath && isPath root.outPath then
			root.outPath
		else if typeOf root == "set" && root ? outPath then
			absStringToPath root.outPath
		else
			throw badRootMsg;

	# toString of the Nix path is the diagnostic prefix. Do not toString a set.
	rootStr = toString rootPath;
	rootPrefix =
		if lib.hasSuffix "/" rootStr then
			rootStr
		else
			rootStr + "/";

	# Path relative to root for diagnostics and rule selection.
	relOf =
		path:
		let
			p = toString path;
		in
		if p == rootStr then
			"."
		else if lib.hasPrefix rootPrefix p then
			lib.removePrefix rootPrefix p
		else
			p;

	# Vendor / generated / non-owned paths we never read or gate.
	isSkipped =
		rel:
		rel == "flake.lock"
		|| rel == ".pre-commit-config.yaml"
		|| rel == "ref/semver"
		|| lib.hasPrefix "ref/semver/" rel
		|| rel == "ref/btc-verified"
		|| lib.hasPrefix "ref/btc-verified/" rel
		|| rel == "skills/lean4-skills"
		|| lib.hasPrefix "skills/lean4-skills/" rel
		|| lib.hasSuffix ".pdf" rel
		|| rel == "ref/rfc2119/rfc2119.txt"
		|| lib.hasSuffix "/rfc2119.txt" rel
		|| rel == ".git"
		|| lib.hasPrefix ".git/" rel
		|| rel == ".direnv"
		|| lib.hasPrefix ".direnv/" rel
		|| rel == "lean/.lake"
		|| lib.hasPrefix "lean/.lake/" rel
		|| rel == "result"
		|| lib.hasPrefix "result/" rel
		|| lib.hasPrefix "result-" rel
		# Agent join scratch / hidden temp names at root (skip, never include).
		|| lib.hasPrefix ".agent_join" rel
		# Session board dump at repository root. It is not numbered specification prose.
		|| rel == "TECH.md";

	# Surmount-authored text kinds (mirrors prior bash discovery intent).
	isOwnedKind =
		rel:
		let
			base = baseNameOf rel;
		in
		base == "justfile"
		|| base == ".gitignore"
		|| base == ".gitmodules"
		|| base == "SOURCE"
		|| base == "SOURCE.md"
		|| base == "aspell_words.txt"
		|| base == "lean-toolchain"
		|| lib.hasSuffix ".SOURCE" base
		|| lib.hasSuffix ".md" rel
		|| lib.hasSuffix ".lean" rel
		|| lib.hasSuffix ".nix" rel
		|| lib.hasSuffix ".toml" rel
		|| lib.hasSuffix ".yml" rel
		|| lib.hasSuffix ".yaml" rel
		|| lib.hasSuffix ".txt" rel
		|| lib.hasPrefix ".github/" rel;

	# Lean and YAML require space indent; still check trailing WS.
	skipsLeadingSpaceRule =
		rel: lib.hasSuffix ".lean" rel || lib.hasSuffix ".yml" rel || lib.hasSuffix ".yaml" rel;

	# Only a path reaches fileFilter. PDFs never match this predicate.
	ownedFileset =
		fileset.fileFilter (
			file:
			let
				n = file.name;
			in
			file.hasExt "md"
			|| file.hasExt "lean"
			|| file.hasExt "nix"
			|| file.hasExt "toml"
			|| file.hasExt "yml"
			|| file.hasExt "yaml"
			|| file.hasExt "txt"
			|| n == "justfile"
			|| n == ".gitignore"
			|| n == ".gitmodules"
			|| n == "SOURCE"
			|| n == "SOURCE.md"
			|| n == "aspell_words.txt"
			|| n == "lean-toolchain"
			|| lib.hasSuffix ".SOURCE" n
		) rootPath;

	candidateFileset = ownedFileset;

	# Drop vendor trees and known blobs before toList (never readFile PDFs).
	excludeTrees =
		let
			maybe =
				p:
				if pathExists (rootPath + p) then
					[ (rootPath + p) ]
				else
					[ ];
		in
		fileset.unions (
			maybe "/ref/semver"
			++ maybe "/ref/btc-verified"
			++ maybe "/skills/lean4-skills"
			++ maybe "/ref/rfc2119/rfc2119.txt"
			++ maybe "/.git"
			++ maybe "/.direnv"
			++ maybe "/lean/.lake"
			++ maybe "/.lake"
			++ maybe "/result"
		);

	selectedFileset = fileset.difference candidateFileset excludeTrees;

	# rootPath is a path, so fileFilter already accepted it. A string never reaches here.
	allPaths = fileset.toList selectedFileset;

	pathsToCheck = filter (
		path:
		let
			rel = relOf path;
		in
		!(isSkipped rel) && isOwnedKind rel
	) allPaths;

	linesOf =
		content:
		# builtins.split "\n" yields strings interleaved with match lists.
		filter isString (split "\n" content);

	hasTrailingWs =
		line:
		let
			n = stringLength line;
		in
		n > 0
		&& (
			let
				c = substring (n - 1) 1 line;
			in
			c == " " || c == "\t"
		);

	hasLeadingSpace = line: stringLength line > 0 && substring 0 1 line == " ";

	checkLine =
		rel: lineNo: line:
		let
			trail =
				if hasTrailingWs line then
					[
						"${rel}:${toString lineNo}: trailing whitespace (space or tab before end of line)"
					]
				else
					[ ];
			lead =
				if !(skipsLeadingSpaceRule rel) && hasLeadingSpace line then
					[
						"${rel}:${toString lineNo}: leading space indentation (use tab for leading indent)"
					]
				else
					[ ];
		in
		trail ++ lead;

	checkFile =
		path:
		let
			rel = relOf path;
			base = baseNameOf rel;
			leftoverBareSource =
				if base == "SOURCE" then
					[
						"${rel}: leftover Form 2 pin notes named SOURCE (use SOURCE.md)"
					]
				else
					[ ];
			content = readFile path;
			lines = linesOf content;
		in
		leftoverBareSource
		++ lib.concatLists (lib.imap1 (lineNo: line: checkLine rel lineNo line) lines);

in
lib.concatMap checkFile pathsToCheck
