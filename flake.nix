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
		in
		{
			packages = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
					aspellEnv = pkgs.aspellWithDicts (dicts: [ dicts.en ]);

					# Authoritative Lean 4 checker (stdlib only, lake build).
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

					spec_check = pkgs.stdenv.mkDerivation {
						pname = "spec_check";
						version = "0.1.0";
						src = leanSrc;
						nativeBuildInputs = [
							pkgs.lean4
						];
						buildInputs = [
							pkgs.gmp
							pkgs.libuv
						];
						dontStrip = true;
						buildPhase = ''
							runHook preBuild
							export HOME="$TMPDIR"
							export LEAN_CC="$CC"
							# Belt and suspenders if a cache ever slips into src.
							rm -rf .lake
							lake build
							runHook postBuild
						'';
						installPhase = ''
							runHook preInstall
							mkdir -p $out/bin
							install -m755 .lake/build/bin/spec_check $out/bin/spec_check
							runHook postInstall
						'';
						meta = with pkgs.lib; {
							description = "Lean checker for Surmount spec spec mechanical form rules";
							license = licenses.unlicense;
							mainProgram = "spec_check";
						};
					};

					# Drop-in name used by older docs and scripts.
					check_spec_rules = pkgs.writeShellApplication {
						name = "check_spec_rules";
						runtimeInputs = [ spec_check ];
						text = ''
							exec spec_check "$@"
						'';
					};

					# Legacy bash + aspell checker (spelling and historical parity).
					check_spec_rules_legacy = pkgs.writeShellApplication {
						name = "check_spec_rules_legacy";
						runtimeInputs = [
							pkgs.bash
							pkgs.coreutils
							pkgs.findutils
							pkgs.gnugrep
							pkgs.gnused
							pkgs.gawk
							aspellEnv
						];
						text = ''
							if [[ -n "''${REPO_ROOT:-}" ]]; then
								root="$REPO_ROOT"
							elif [[ -f "''${PWD}/aspell_words.txt" ]]; then
								root="$PWD"
							else
								root="${./.}"
							fi
							export REPO_ROOT="$root"
							export ASPELL_WORDS="''${ASPELL_WORDS:-$root/aspell_words.txt}"
							exec bash "${./scripts/check_spec_rules}" "$@"
						'';
					};

					run_checks = pkgs.writeShellApplication {
						name = "run_checks";
						runtimeInputs = [ spec_check ];
						text = ''
							exec spec_check "$@"
						'';
					};

					# Primary local/CI gate: Lean + aspell on root NNNN_*.md only.
					check_numbered_specs = pkgs.writeShellApplication {
						name = "check_numbered_specs";
						runtimeInputs = [
							pkgs.bash
							pkgs.coreutils
							pkgs.gnugrep
							spec_check
							check_spec_rules_legacy
						];
						text = ''
							export CHECK_NUMBERED_SPECS_ROOT="''${CHECK_NUMBERED_SPECS_ROOT:-${./.}}"
							if [[ -z "''${REPO_ROOT:-}" ]]; then
								if [[ -f "''${PWD}/flake.nix" && -f "''${PWD}/aspell_words.txt" ]]; then
									export REPO_ROOT="$PWD"
								else
									export REPO_ROOT="$CHECK_NUMBERED_SPECS_ROOT"
								fi
							fi
							exec bash "${./scripts/check_numbered_specs}" "$@"
						'';
					};

					# Project-owned text: trailing whitespace and tab-only leading indent.
					check_whitespace = pkgs.writeShellApplication {
						name = "check_whitespace";
						runtimeInputs = [
							pkgs.bash
							pkgs.coreutils
							pkgs.findutils
						];
						text = ''
							if [[ -n "''${REPO_ROOT:-}" ]]; then
								root="$REPO_ROOT"
							elif [[ -f "''${PWD}/flake.nix" ]]; then
								root="$PWD"
							else
								root="${./.}"
							fi
							export REPO_ROOT="$root"
							exec bash "${./scripts/check_whitespace}" "$@"
						'';
					};
				in
				{
					inherit
						spec_check
						check_spec_rules
						check_spec_rules_legacy
						run_checks
						check_numbered_specs
						check_whitespace
						;
					default = spec_check;
				}
			);

			apps = forAllSystems (
				system:
				let
					spec = self.packages.${system}.spec_check;
					legacy = self.packages.${system}.check_spec_rules_legacy;
					numbered = self.packages.${system}.check_numbered_specs;
				in
				{
					check = {
						type = "app";
						program = "${numbered}/bin/check_numbered_specs";
					};
					check_numbered_specs = {
						type = "app";
						program = "${numbered}/bin/check_numbered_specs";
					};
					check_spec_rules = {
						type = "app";
						program = "${self.packages.${system}.check_spec_rules}/bin/check_spec_rules";
					};
					check_spec_rules_legacy = {
						type = "app";
						program = "${legacy}/bin/check_spec_rules_legacy";
					};
					spec_check = {
						type = "app";
						program = "${spec}/bin/spec_check";
					};
					check_whitespace = {
						type = "app";
						program = "${self.packages.${system}.check_whitespace}/bin/check_whitespace";
					};
					default = {
						type = "app";
						program = "${numbered}/bin/check_numbered_specs";
					};
				}
			);

			checks = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
					spec = self.packages.${system}.spec_check;
					numbered = self.packages.${system}.check_numbered_specs;
					ws = self.packages.${system}.check_whitespace;
					# Numbered specs only (not README / AGENTS / UNLICENSE).
					numberedSpecFiles = "^[0-9]{4}_[A-Za-z0-9_]+\\.md$";
					pre-commit-check = git-hooks.lib.${system}.run {
						src = ./.;
						hooks = {
							spec_check = {
								enable = true;
								name = "spec check (Lean)";
								description = "Enforce 0000_spec.md mechanical rules via Lean spec_check on numbered specs";
								entry = "${spec}/bin/spec_check";
								language = "system";
								files = numberedSpecFiles;
								pass_filenames = true;
							};
							check_whitespace = {
								enable = true;
								name = "whitespace (tabs, trailing)";
								description = "Trailing whitespace and tab-only leading indent on project-owned text";
								entry = "${ws}/bin/check_whitespace";
								language = "system";
								pass_filenames = true;
							};
						};
					};
				in
				{
					inherit pre-commit-check;
					# Primary gate: Lean + aspell on root NNNN_*.md (nix flake check / CI).
					numbered_specs = pkgs.runCommand "numbered_specs" {
						nativeBuildInputs = [ numbered ];
					} ''
						export REPO_ROOT="${./.}"
						cd "$REPO_ROOT"
						check_numbered_specs
						mkdir -p "$out"
						echo ok > "$out/result"
					'';
					# Lean-only default discovery (also numbered-root only after Lean change).
					spec_check = pkgs.runCommand "spec_check" {
						nativeBuildInputs = [ spec ];
					} ''
						export REPO_ROOT="${./.}"
						cd "$REPO_ROOT"
						spec_check
						mkdir -p "$out"
						echo ok > "$out/result"
					'';
					# Project-owned text whitespace (trailing WS; tab indent except Lean/YAML).
					whitespace = pkgs.runCommand "whitespace" {
						nativeBuildInputs = [ ws ];
					} ''
						export REPO_ROOT="${./.}"
						cd "$REPO_ROOT"
						check_whitespace
						mkdir -p "$out"
						echo ok > "$out/result"
					'';
					# Alias for older flake check names.
					check_spec_rules = self.checks.${system}.spec_check;
				}
			);

			devShells = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
					preCommit = self.checks.${system}.pre-commit-check;
					# Same aspellWithDicts env as check_spec_rules_legacy. Bare
					# nixpkgs#aspell (even with aspellDicts.en on PATH) cannot find en_US.
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
							self.packages.${system}.check_spec_rules
							self.packages.${system}.check_spec_rules_legacy
							self.packages.${system}.check_numbered_specs
							self.packages.${system}.check_whitespace
							self.packages.${system}.run_checks
						];
					};
				}
			);
		};
}
