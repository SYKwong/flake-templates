---
title: Flake Templates
description: Reusable Nix flake project templates for playgrounds and projects.
---

`flake-templates` provides self-contained, system-agnostic Nix flake project templates. Each template lives in its own directory with an independent `flake.nix`, `flake.lock`, `.envrc`, and task runner so projects stay isolated from global system packages.

## Quick Start

Create a new project from a template:

```bash
# Local clone
nix flake new -t ~/Templates/flake-templates#c-clang ~/Projects/playground/my-c-test

# Remote (GitHub)
nix flake new -t github:SYKwong/flake-templates#c-clang ~/Projects/playground/my-c-test
```

Enter the project directory and activate the environment:

```bash
cd ~/Projects/playground/my-c-test
direnv allow
```

> Directories under `~/Projects/playground` and `~/Templates` are whitelisted in `direnv` when using the `nix-config` Home Manager setup.

## Available Templates

| Template | Description | Guide |
| :--- | :--- | :--- |
| `c-clang` | C (Clang) playground with Ceedling 1.2.2 (Unity + CMock), `clang` 23, `lldb`/`gdb`, `just`, and `clangd` | [C (Clang)](./c-clang/) |
| `c-gcc` | C (GCC) playground with Ceedling 1.2.2 (Unity + CMock), `gcc` 16, `gdb`, `just`, and `clangd` | [C (GCC)](./c-gcc/) |

## Repository Automation

- **PR Checks (`.github/workflows/ci.yml`)**: Validates `nix flake show --all-systems` across the root flake and every template `flake.nix`, and runs `just run` in `c/clang/` and `c/gcc/`.
- **Weekly `flake.lock` & Patch Gem Updates (`.github/workflows/update-dependency.yml`)**: Runs `nix flake update` and `just update-gems` (constrained to `~> 1.2.2` patch versions in `Gemfile`), verifies all checks pass, opens a PR, and auto-merges via squash merge.
- **Weekly Major/Minor Dependency Checks (`.github/workflows/update-dependency-major-minor-version.yml`)**: Checks for major/minor Ceedling updates and major Clang (`llvmPackages_<N>`) / GCC (`gcc<N>Stdenv`) updates, verifies tests pass, and opens a PR without auto-merge for manual review.
