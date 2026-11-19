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

| Template  | Description                                                                                              | Guide                   |
| :-------- | :------------------------------------------------------------------------------------------------------- | :---------------------- |
| `c-clang` | C (Clang) playground with Ceedling 1.2.2 (Unity + CMock), `clang` 23, `lldb`/`gdb`, `just`, and `clangd` | [C (Clang)](./c/clang/) |
| `c-gcc`   | C (GCC) playground with Ceedling 1.2.2 (Unity + CMock), `gcc` 16, `gdb`, `just`, and `clangd`            | [C (GCC)](./c/gcc/)     |

## Why `nixos-unstable`?

Both the root flake and individual templates intentionally track `nixpkgs/nixos-unstable` rather than a 6-month stable release:

- **Toolchain flexibility**: `nixos-unstable` exposes both cutting-edge compiler releases (`clang` 23 / `llvmPackages_23`, `gcc` 16 / `gcc16Stdenv`) and older versioned toolchains in the same `nixpkgs` tree, making it easy to pin either the newest or an older compiler per project. Weekly major-version checks (`update-dependency-major-minor-version.yml`) also rely on `nixos-unstable` to detect newly packaged compiler releases.
- **Reproducible and CI-gated**: Every template commits its own `flake.lock`, and PR/weekly CI (`ci.yml`, `update-dependency.yml`) verifies `nix flake show --all-systems` and `just run` smoke tests before lockfile updates merge—providing fresh toolchains without sacrificing reproducibility.
- **Store & formatter consistency**: Tracking `nixos-unstable` matches the host `nix-config` flake, keeping `treefmt-nix` formatters consistent and maximizing Nix store sharing.

## Repository Automation

See [CI & Automation](./ci/) for details on PR checks (`ci.yml`), weekly patch/lockfile auto-updates (`update-dependency.yml`), manual-review major/minor version checks (`update-dependency-major-minor-version.yml`), and docs site sync (`notify-docs.yml`).
