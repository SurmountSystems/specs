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
check:
	nix flake check "path:{{justfile_directory()}}" --print-build-logs

# Enter the development shell (Lean, just, aspellWithDicts, git, checkers).
dev:
	nix develop "path:{{justfile_directory()}}"
