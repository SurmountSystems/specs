{
	description = "Surmount miscellaneous specifications with Lean form rule validator";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		git-hooks = {
			url = "github:cachix/git-hooks.nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		{
			self,
			nixpkgs,
			git-hooks,
		}:
		let
			systems = [
				"x86_64-linux"
				"aarch64-linux"
				"x86_64-darwin"
				"aarch64-darwin"
			];
			forAllSystems = nixpkgs.lib.genAttrs systems;

			# Pure Nix project-wide whitespace gate (trailing WS; tab leading indent).
			# Empty list = ok. Non-empty = "path:line: message" diagnostics.
			whitespaceViolations = import ./nix/whitespace.nix {
				lib = nixpkgs.lib;
			} ./.;
		in
		{
			# Debug: nix eval path:$PWD#lib.whitespaceViolations
			lib = {
				inherit whitespaceViolations;
			};

			# Only real software: Lean spec_check binary.
			packages = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};

					# Lake lives in lean/. Sibling Spec_NNNN.lean encodings and the
					# numbered markdown those encodings match sit at the repository root.
					# include_str is not a line encoding.
					# Drop host .lake caches so lake cannot replay host-linked objects
					# (those pin /lib64/ld-linux and break the Nix sandbox).
					leanSrc = pkgs.lib.cleanSourceWith {
						name = "spec-check-lean-src";
						src = ./.;
						filter =
							path: type:
							let
								base = baseNameOf path;
								pathStr = toString path;
								rootStr = toString ./.;
								rel =
									if pathStr == rootStr then
										""
									else if pkgs.lib.hasPrefix (rootStr + "/") pathStr then
										pkgs.lib.removePrefix (rootStr + "/") pathStr
									else
										base;
								isLeanTree =
									rel == "lean"
									|| pkgs.lib.hasPrefix "lean/" rel;
								isLakeJunk =
									base == ".lake"
									|| rel == "lean/.lake"
									|| pkgs.lib.hasPrefix "lean/.lake/" rel
									|| base == "lake-manifest.json"
									|| pkgs.lib.hasSuffix ".olean" base
									|| pkgs.lib.hasSuffix ".ilean" base;
								isRootSpecLean = builtins.match "Spec_[0-9][0-9][0-9][0-9]\\.lean" rel != null;
								isRootNumberedMd = builtins.match "[0-9][0-9][0-9][0-9]_[A-Za-z0-9_]+\\.md" rel != null;
							in
							if type == "directory" then
								(rel == "" || isLeanTree)
								&& !isLakeJunk
							else
								(isLeanTree && !isLakeJunk) || isRootSpecLean || isRootNumberedMd;
					};

					# Shared Lean build env (sandbox-clean leanSrc; no host .lake).
					leanBuildInputs = [
						pkgs.gmp
						pkgs.libuv
					];
					mkLeanBin =
						{
							pname,
							lakeTarget,
							binName,
							description,
						}:
						pkgs.stdenv.mkDerivation {
							inherit pname;
							version = "1.0.0";
							src = leanSrc;
							nativeBuildInputs = [
								pkgs.lean4
							];
							buildInputs = leanBuildInputs;
							dontStrip = true;
							buildPhase = ''
								runHook preBuild
								export HOME="$TMPDIR"
								export LEAN_CC="$CC"
								# Store copy is read only; Lake must write .lake under lean/.
								chmod -R u+w .
								cd lean
								rm -rf .lake
								lake build ${lakeTarget}
								install -m755 .lake/build/bin/${binName} "$NIX_BUILD_TOP/${binName}"
								runHook postBuild
							'';
							installPhase = ''
								runHook preInstall
								mkdir -p $out/bin
								install -m755 "$NIX_BUILD_TOP/${binName}" $out/bin/${binName}
								runHook postInstall
							'';
							meta = with pkgs.lib; {
								inherit description;
								license = licenses.unlicense;
								mainProgram = binName;
							};
						};

					spec_check = mkLeanBin {
						pname = "spec_check";
						lakeTarget = "spec_check";
						binName = "spec_check";
						description = "Lean checker for Surmount spec spec mechanical form rules and spelling";
					};

					# Hermetic string-fixture unit tests (not the default package).
					spec_check_tests = mkLeanBin {
						pname = "spec_check_tests";
						lakeTarget = "spec_check_tests";
						binName = "spec_check_tests";
						description = "Lean unit tests for SpecCheck form-rule helpers";
					};

					# Companion meaning-model tests for 0002_Systems_Lean.md (not form rules).
					systems_lean_tests = mkLeanBin {
						pname = "systems_lean_tests";
						lakeTarget = "systems_lean_tests";
						binName = "systems_lean_tests";
						description = "Lean tests for the Systems Lean meaning model (spec 0002)";
					};

					# Companion meaning-model tests for 0003_beastdb.md (not form rules).
					beastdb_tests = mkLeanBin {
						pname = "beastdb_tests";
						lakeTarget = "beastdb_tests";
						binName = "beastdb_tests";
						description = "Lean tests for the beastdb meaning model (spec 0003) and the numbered-spec registry";
					};

					# Companion meaning-model tests for 0004_SSSSS.md (not form rules).
					sssss_tests = mkLeanBin {
						pname = "sssss_tests";
						lakeTarget = "sssss_tests";
						binName = "sssss_tests";
						description = "Lean tests for the SSSSS meaning model (spec 0004) and the numbered-spec registry";
					};

					# Companion meaning-model tests for 0005_CATE.md (not form rules).
					cate_tests = mkLeanBin {
						pname = "cate_tests";
						lakeTarget = "cate_tests";
						binName = "cate_tests";
						description = "Lean tests for the CATE meaning model (spec 0005)";
					};

					# Companion meaning-model tests for 0006_RSI.md (not form rules).
					rsi_tests = mkLeanBin {
						pname = "rsi_tests";
						lakeTarget = "rsi_tests";
						binName = "rsi_tests";
						description = "Lean tests for the RSI meaning model (spec 0006)";
					};

					# Companion meaning-model tests for 0007_CI.md (not form rules).
					ci_tests = mkLeanBin {
						pname = "ci_tests";
						lakeTarget = "ci_tests";
						binName = "ci_tests";
						description = "Lean tests for the CI meaning model (spec 0007)";
					};

					# Isomorphism between aspell_words.txt and 0005_CATE.md catalog headings.
					vocab_aspell_tests = mkLeanBin {
						pname = "vocab_aspell_tests";
						lakeTarget = "vocab_aspell_tests";
						binName = "vocab_aspell_tests";
						description = "Lean tests that 0005_CATE.md catalog headings are an isomorphism of aspell_words.txt";
					};

					# Composition proof over the numbered-spec meaning models (not form rules).
					surmount_tests = mkLeanBin {
						pname = "surmount_tests";
						lakeTarget = "surmount_tests";
						binName = "surmount_tests";
						description = "Lean tests for the Surmount composition proof (spec 0010, stack identities, spec encoding versus proof split)";
					};

					# Spec encodings versus proofs for Formal Vibefication (spec 0008).
					formal_vibefication_tests = mkLeanBin {
						pname = "formal_vibefication_tests";
						lakeTarget = "formal_vibefication_tests";
						binName = "formal_vibefication_tests";
						description = "Lean tests for Formal Vibefication spec encodings and separate proofs (spec 0008)";
					};

					# Hermetic tests for isomorphism of markdown lines and Lean encodings.
					line_encodings_tests = mkLeanBin {
						pname = "line_encodings_tests";
						lakeTarget = "line_encodings_tests";
						binName = "line_encodings_tests";
						description = "Lean unit tests for sibling Spec_NNNN.lean line encodings and leftover unstack floor";
					};

					# Runtime iso: each NNNN_*.md versus compiled Spec_NNNN.lean lines.
					line_encodings_check = mkLeanBin {
						pname = "line_encodings_check";
						lakeTarget = "line_encodings_check";
						binName = "line_encodings_check";
						description = "Lean checker that numbered specification markdown lines match sibling Spec_NNNN.lean encodings and that those encodings use the CATE leftover unstack floor";
					};

					# Hermetic tests for unique English word tracking versus the CATE catalog.
					word_stats_tests = mkLeanBin {
						pname = "word_stats_tests";
						lakeTarget = "word_stats_tests";
						binName = "word_stats_tests";
						description = "Lean unit tests for unique ASCII letter token tracking versus the CATE catalog and RFC 2119 requirement keywords";
					};

					# Runtime scan: Surmount authored markdown versus CATE catalog; WORD_STATS.md must match.
					word_stats = mkLeanBin {
						pname = "word_stats";
						lakeTarget = "word_stats";
						binName = "word_stats";
						description = "Lean checker that WORD_STATS.md matches unique English word counts in Surmount authored markdown versus the CATE L_n catalog";
					};
				in
				{
					inherit spec_check spec_check_tests systems_lean_tests beastdb_tests sssss_tests cate_tests rsi_tests ci_tests vocab_aspell_tests surmount_tests formal_vibefication_tests line_encodings_tests line_encodings_check word_stats_tests word_stats;
					default = spec_check;
				}
			);

			# Only the Lean binary (default -> same).
			# nix flake check requires apps.*.meta (at least meta.description).
			apps = forAllSystems (
				system:
				let
					spec = self.packages.${system}.spec_check;
					app = {
						type = "app";
						program = "${spec}/bin/spec_check";
						meta = {
							description = "Run Lean spec_check on numbered Surmount specs (form rules and spelling)";
						};
					};
				in
				{
					spec_check = app;
					default = app;
				}
			);

			# Separate checks; flake check runs all. No bash policy packages.
			# Why Lean vs pure Nix: README.md 7.2.1, AGENTS.md "Why Lean vs pure Nix".
			checks = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
					spec = self.packages.${system}.spec_check;
					aspellEnv = pkgs.aspellWithDicts (dicts: [ dicts.en ]);
					# Hook binary: same Lean tool with aspell on PATH (makeWrapper; no shell app).
					specCheckHook = pkgs.symlinkJoin {
						name = "spec_check-hook";
						paths = [ spec ];
						nativeBuildInputs = [ pkgs.makeWrapper ];
						postBuild = ''
							wrapProgram $out/bin/spec_check \
								--prefix PATH : ${aspellEnv}/bin
						'';
					};
					# Numbered specs only (not README / AGENTS / UNLICENSE).
					numberedSpecFiles = "^[0-9]{4}_[A-Za-z0-9_]+\\.md$";
					pre-commit-check = git-hooks.lib.${system}.run {
						src = ./.;
						hooks = {
							spec_check = {
								enable = true;
								name = "spec check (Lean)";
								description = "Enforce 0000_spec.md mechanical rules and spelling via Lean spec_check on numbered specs";
								entry = "${specCheckHook}/bin/spec_check";
								language = "system";
								files = numberedSpecFiles;
								pass_filenames = true;
							};
						};
					};

					# Pure Nix: fail evaluation when violations exist; else store text marker.
					whitespace =
						if whitespaceViolations == [ ] then
							pkgs.writeText "whitespace-ok" "ok"
						else
							throw (
								"whitespace violations:\n"
								+ nixpkgs.lib.concatStringsSep "\n" whitespaceViolations
							);

					# Lean form rules + spelling: thin invoke glue only (aspell on PATH).
					spec_check =
						pkgs.runCommand "spec_check"
							{
								nativeBuildInputs = [
									spec
									aspellEnv
								];
							}
							''
								export REPO_ROOT=${./.}
								cd "$REPO_ROOT"
								spec_check
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Hermetic Lean unit tests (string fixtures; no bash/python policy).
					spec_check_tests =
						pkgs.runCommand "spec_check_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.spec_check_tests
								];
							}
							''
								spec_check_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Systems Lean meaning proofs (0002); not a second markdown linter.
					systems_lean_tests =
						pkgs.runCommand "systems_lean_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.systems_lean_tests
								];
							}
							''
								systems_lean_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# beastdb meaning proofs (0003) and registry fixtures; not a second markdown linter.
					beastdb_tests =
						pkgs.runCommand "beastdb_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.beastdb_tests
								];
							}
							''
								beastdb_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# SSSSS meaning proofs (0004) and registry fixtures; not a second markdown linter.
					sssss_tests =
						pkgs.runCommand "sssss_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.sssss_tests
								];
							}
							''
								sssss_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# CATE meaning proofs (0005); not a second markdown linter.
					cate_tests =
						pkgs.runCommand "cate_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.cate_tests
								];
							}
							''
								cate_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# RSI meaning proofs (0006); not a second markdown linter.
					rsi_tests =
						pkgs.runCommand "rsi_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.rsi_tests
								];
							}
							''
								rsi_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# CI meaning proofs (0007); not a second markdown linter.
					ci_tests =
						pkgs.runCommand "ci_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.ci_tests
								];
							}
							''
								ci_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# aspell list and 0005_CATE.md catalog headings are inverse maps (same tokens, L_n ids).
					vocab_aspell_tests =
						pkgs.runCommand "vocab_aspell_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.vocab_aspell_tests
								];
							}
							''
								export REPO_ROOT=${./.}
								cd "$REPO_ROOT"
								vocab_aspell_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Surmount composition proof; not a second markdown linter.
					surmount_tests =
						pkgs.runCommand "surmount_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.surmount_tests
								];
							}
							''
								surmount_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Formal Vibefication spec encodings versus proofs; not a second markdown linter.
					formal_vibefication_tests =
						pkgs.runCommand "formal_vibefication_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.formal_vibefication_tests
								];
							}
							''
								formal_vibefication_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Hermetic line encoding fixtures; not a second markdown linter.
					line_encodings_tests =
						pkgs.runCommand "line_encodings_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.line_encodings_tests
								];
							}
							''
								line_encodings_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Sibling Spec_NNNN.lean lines match numbered markdown; leftover unstack floor on encodings.
					line_encodings_check =
						pkgs.runCommand "line_encodings_check"
							{
								nativeBuildInputs = [
									self.packages.${system}.line_encodings_check
								];
							}
							''
								export REPO_ROOT=${./.}
								cd "$REPO_ROOT"
								line_encodings_check
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# Hermetic unique English word tracking fixtures; not a second markdown linter.
					word_stats_tests =
						pkgs.runCommand "word_stats_tests"
							{
								nativeBuildInputs = [
									self.packages.${system}.word_stats_tests
								];
							}
							''
								word_stats_tests
								mkdir -p "$out"
								echo ok > "$out/result"
							'';

					# WORD_STATS.md matches the current Surmount authored markdown scan.
					word_stats =
						pkgs.runCommand "word_stats"
							{
								nativeBuildInputs = [
									self.packages.${system}.word_stats
								];
							}
							''
								export REPO_ROOT=${./.}
								cd "$REPO_ROOT"
								word_stats
								mkdir -p "$out"
								echo ok > "$out/result"
							'';
				in
				{
					inherit
						pre-commit-check
						whitespace
						spec_check
						spec_check_tests
						systems_lean_tests
						beastdb_tests
						sssss_tests
						cate_tests
						rsi_tests
						ci_tests
						vocab_aspell_tests
						surmount_tests
						formal_vibefication_tests
						line_encodings_tests
						line_encodings_check
						word_stats_tests
						word_stats
						;
				}
			);

			devShells = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
					preCommit = self.checks.${system}.pre-commit-check;
					# aspellWithDicts so local hooks and ad-hoc spec_check can spell-check.
					# Bare nixpkgs#aspell cannot find en_US word lists without the wrapper.
					aspellEnv = pkgs.aspellWithDicts (dicts: [ dicts.en ]);
				in
				{
					default = pkgs.mkShell {
						inherit (preCommit) shellHook;
						packages = preCommit.enabledPackages ++ [
							pkgs.git
							pkgs.just
							pkgs.lean4
							aspellEnv
							self.packages.${system}.spec_check
						];
					};
				}
			);
		};
}
