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

					# Drop host .lake caches from src so lake cannot replay host-linked
					# objects (those pin /lib64/ld-linux and break the Nix sandbox).
					leanSrc = pkgs.lib.cleanSourceWith {
						name = "spec-check-lean-src";
						src = ./lean;
						filter =
							path: type:
							let
								base = baseNameOf path;
							in
							base != ".lake"
							&& base != "lake-manifest.json"
							&& !(pkgs.lib.hasSuffix ".olean" base)
							&& !(pkgs.lib.hasSuffix ".ilean" base);
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
								# Belt and suspenders if a cache ever slips into src.
								rm -rf .lake
								lake build ${lakeTarget}
								runHook postBuild
							'';
							installPhase = ''
								runHook preInstall
								mkdir -p $out/bin
								install -m755 .lake/build/bin/${binName} $out/bin/${binName}
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
				in
				{
					inherit spec_check spec_check_tests;
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
				in
				{
					inherit
						pre-commit-check
						whitespace
						spec_check
						spec_check_tests
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
