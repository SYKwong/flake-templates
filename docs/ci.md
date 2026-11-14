---
title: CI & Automation
description: GitHub Actions workflows for PR validation, automated dependency updates, major version checks, and docs site sync.
---

All automation workflows live in `.github/workflows/` and run on `ubuntu-latest` with Nix and Magic Nix Cache.

## Workflows Overview

| Workflow | File | Trigger | Auto-Merge | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **CI** | `ci.yml` | PRs to `main`, `workflow_dispatch` | — | Validates flake outputs and runs template smoke tests |
| **Update dependency** | `update-dependency.yml` | Weekly (Mon 09:00 UTC), `workflow_dispatch` | Yes (squash) | Updates `flake.lock` files and patch Ruby gems |
| **Update dependency major minor version** | `update-dependency-major-minor-version.yml` | Weekly (Mon 10:00 UTC), `workflow_dispatch` | No | Checks for major/minor Ceedling and major compiler bumps |
| **Notify Docs Site** | `notify-docs.yml` | Push to `main` (`docs/**`) | — | Triggers `SYKwong/nix-docs` rebuild via `repository_dispatch` |

## 1. PR Checks (`ci.yml`)

1. Runs `nix flake show --all-systems` on the root flake.
2. Evaluates `nix flake show --all-systems` on every template (`*/flake.nix` and `*/*/flake.nix`).
3. Executes `just run` in `c/clang/` and `c/gcc/` inside their respective `nix develop` shells.

## 2. Patch & Lockfile Updates (`update-dependency.yml`)

1. Runs `nix flake update` on every template flake (`*/flake.nix`, `*/*/flake.nix`).
2. Runs `just update-gems` on every template containing a `Gemfile` (`*/Gemfile`, `*/*/Gemfile`). Because `Gemfile` pins `~> <major>.<minor>.<patch>` (e.g. `~> 1.2.2`), Bundler only applies **patch** updates (`>= 1.2.2, < 1.3.0`) and preserves `aarch64-linux`, `arm64-darwin`, `ruby`, and `x86_64-linux` under `PLATFORMS`.
3. Verifies `nix flake show --all-systems` and runs `just run` + `just clean` on `c/clang` and `c/gcc`.
4. Opens a PR on `chore/update-dependencies` and enables `--auto --squash --delete-branch`.

## 3. Major & Minor Version Checks (`update-dependency-major-minor-version.yml`)

Runs 1 hour after `update-dependency.yml` (Mondays 10:00 UTC) so `flake.lock` is already fresh:

1. **Ceedling (`MAJOR.MINOR`)**: Queries `https://rubygems.org/api/v1/versions/ceedling/latest.json`. If `latest` has a newer `MAJOR.MINOR` than `c/clang/Gemfile` or `c/gcc/Gemfile`, updates the `~> <latest>` constraint and runs `just update-gems`.
2. **Compilers (`Clang` / `GCC` major)**: Evaluates `c/clang`'s `nixpkgs` for the newest `llvmPackages_<N>` and `gcc<N>Stdenv`. If newer than the pinned versions in `c/clang/flake.nix` or `c/gcc/flake.nix`, updates the Nix expressions and docs (`README.md`, `c/README.md`, `docs/c-clang.md`, `docs/c-gcc.md`).
3. Verifies `nix flake show --all-systems` and runs `just run` + `just clean` on `c/clang` and `c/gcc`.
4. Opens a PR on `chore/update-dependency-major-minor-version` **without auto-merge**.

### Manual Review Checklist (Before Merging Major/Minor PRs)

- **Hydra / `cache.nixos.org` availability**: Confirm the new `llvmPackages_<N>` (`stdenv` + `lldb`) or `gcc<N>Stdenv` has binary cache hits and does not build a compiler from source in `nix develop`.
- **macOS (`aarch64-darwin`) verification**: CI runs on `ubuntu-latest`, so `nix flake show --all-systems` checks evaluation on macOS, not runtime compilation. Smoke-test `just run` on `aarch64-darwin` when possible.
- **Ceedling / warning compatibility**: Review upstream Ceedling changelogs and confirm Unity/CMock/CException compile cleanly under `-Wall -Wextra` on the new compiler.

## 4. Docs Site Sync (`notify-docs.yml`)

When commits touching `docs/**` land on `main`, dispatches a `docs-updated` event to `SYKwong/nix-docs` using `secrets.AUTO_PAT` so the published Starlight site rebuilds automatically.
