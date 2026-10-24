# Surmount specs - optional local convenience wrappers.
#
# 1. Nix is the first-class interface for validation (packages, checks, shell).
# 2. just is optional sugar only; you do not need it if you run Nix directly.
# 3. `just check` simply runs the documented nix flake check line (same as CI).
#
# Default (no recipe): list available recipes.

# List recipes (same family as `just -l` / `just --list`).
default:
	just --list

# Same underlying gate as CI: all flake checks for this system.
# Equivalent to: nix flake check "path:$PWD" --print-build-logs
# Uses path: so untracked flake files still evaluate (pure git tree is not required).
# path: copies this working tree. flake.nix repoSrc drops Lake caches, .git, and result links before they are derivation inputs. check, check-local, and check-remote share that filter.
# Uses this machine's Nix config, which may send builds to a remote builder.
check:
	nix flake check "path:{{justfile_directory()}}" --print-build-logs

# Same flake check, local builders only (no remote builder).
check-local:
	nix flake check "path:{{justfile_directory()}}" --print-build-logs --builders ''

# Same flake check, remote builders only (this machine's Nix builders list).
# Fails if no remote builder is configured or the remote builder cannot start.
# --max-jobs 0 keeps derivations off this laptop.
check-remote:
	nix flake check "path:{{justfile_directory()}}" --print-build-logs --max-jobs 0

# Enter the development shell (lean4, just, git, spec_check, aspellWithDicts).
dev:
	nix develop "path:{{justfile_directory()}}"
