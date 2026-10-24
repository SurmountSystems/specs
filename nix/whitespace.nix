# Pure Nix checker: project-owned trailing whitespace and tab-only leading indent.
#
# Call as: import ./nix/whitespace.nix { inherit lib; } root
# root is a path, or a string store path from toString of cleanSourceWith.
# A string store path is walked with builtins.readDir. lib.fileset.fileFilter
# rejects that string and rejects a set, so fileFilter is not used for it.
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
		readDir
		split
		stringLength
		substring
		filter
		isString
		pathExists
		attrNames
		;
	inherit (lib) fileset;

	rootStr = toString root;
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

	# Directory base names that are build products. A string store root is
	# already filtered, and these names are still not descended into.
	skipDirName =
		name:
		name == ".git"
		|| name == ".direnv"
		|| name == ".lake"
		|| name == "result"
		|| lib.hasPrefix "result-" name;

	# lib.fileset.fileFilter rejects a store path string. Walk that root here.
	readDirFiles =
		dir:
		let
			listing = readDir dir;
		in
		lib.concatMap (
			name:
			let
				typ = listing.${name};
				child = dir + "/" + name;
			in
			if typ == "directory" then
				if skipDirName name || isSkipped (relOf child) then
					[ ]
				else
					readDirFiles child
			else if typ == "regular" then
				[ child ]
			else
				[ ]
		) (attrNames listing);

	# Prefer fileset when root is a path: only text-ish candidates enter the set (PDFs never matched).
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
		) root;

	candidateFileset = ownedFileset;

	# Drop vendor trees and known blobs before toList (never readFile PDFs).
	excludeTrees =
		let
			maybe =
				p:
				if pathExists (root + p) then
					[ (root + p) ]
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

	# A path root still uses fileset. A string root never reaches fileFilter.
	allPaths =
		if isString root then
			readDirFiles root
		else
			fileset.toList selectedFileset;

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
