---
title: Flake Templates
description: Reusable Nix flake project templates for playgrounds and projects.
---

`flake-templates` provides self-contained, system-agnostic Nix flake project templates. Each template lives in its own directory with an independent `flake.nix`, `flake.lock`, `.envrc`, and task runner so projects stay isolated from global system packages.

## Quick Start

Create a new project from a template:

```bash
nix flake new -t github:SYKwong/flake-templates#c-clang my-c-test
```

Enter the project directory and activate the environment:

```bash
cd my-c-test
direnv allow
```

## Available Templates

| Template | Description | Guide |
| :--- | :--- | :--- |
| `c-clang` | C (Clang) playground with Ceedling 1.2.2 (Unity + CMock), `clang` 23, `lldb`/`gdb`, `just`, and `clangd` | [C (Clang)](./c/clang/) |
| `c-gcc` | C (GCC) playground with Ceedling 1.2.2 (Unity + CMock), `gcc` 16, `gdb`, `just`, and `clangd` | [C (GCC)](./c/gcc/) |

## Repository Automation

See [CI & Automation](./ci/) for details on PR checks (`ci.yml`), weekly patch/lockfile auto-updates (`update-dependency.yml`), manual-review major/minor version checks (`update-dependency-major-minor-version.yml`), and docs site sync (`notify-docs.yml`).
