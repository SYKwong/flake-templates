# C (GCC) Playground

C (GCC) playground template using Ceedling (Unity + CMock), `gcc` (GCC 16), `gdb`, and `just`.

## Quick Start

Enter the development shell (automatic if using `direnv`):

```bash
nix develop
```

Run all tests (or a single test file), which also generates `build/artifacts/compile_commands.json` for `clangd`:

```bash
just test
just test test_example.c
just test example
```

Build and run the standalone binary (`build` runs `test` first and requires it to pass):

```bash
just build
just run
```

Clean build artifacts:

```bash
just clean
```

## Layout

- `include/` — Header files
- `src/` — Source files
- `test/` — Ceedling/Unity unit tests (`test_*.c`)
- `justfile` — Task runner recipes (`test`, `build`, `run`, `clean`, `update-gems`)
- `project.yml` — Ceedling configuration (GCC default)

## Quirks

- **macOS debugging**: `gdb` is included, though attaching to local macOS processes requires code-signing entitlements.
- **Supported systems**: Targets `x86_64-linux`, `aarch64-linux`, and `aarch64-darwin` (`x86_64-darwin` was dropped in `nixpkgs` 26.11).
- **`clangd` index**: `build/artifacts/compile_commands.json` is generated on demand when running `just test` (referenced by `.clangd`).
