---
title: Flake Templates
description: Reusable Nix flake project templates for playgrounds and projects.
---

`flake-templates` provides self-contained, system-agnostic Nix flake project templates. Each template lives in its own directory with an independent `flake.nix`, `flake.lock`, `.envrc`, and task runner so projects stay isolated from global system packages.

## Quick Start

Create a new project from a template:

```bash
# Local clone
nix flake new -t ~/Templates/flake-templates#c ~/Projects/playground/my-c-test

# Remote (GitHub)
nix flake new -t github:SYKwong/flake-templates#c ~/Projects/playground/my-c-test
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
| `c` | C playground with Ceedling 1.2.2 (Unity + CMock), `gcc`, `gdb`, `just`, and `clangd` | [C Playground](./c/) |

## Repository Automation

- **PR Checks (`.github/workflows/ci.yml`)**: Validates `nix flake show --all-systems` across the root flake and every `*/flake.nix`, and runs `just run` in `c/`.
- **Weekly `flake.lock` Updates (`.github/workflows/update-flake-locks.yml`)**: Runs `nix flake update` on every `*/flake.lock`, verifies all checks pass, opens a PR, and auto-merges via squash merge.
