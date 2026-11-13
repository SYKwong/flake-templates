# C Playground

C playground template using Ceedling (Unity + CMock), `gcc`, `gdb`, and `just`.

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
- `justfile` — Task runner recipes (`build`, `run`, `test`, `clean`)
- `project.yml` — Ceedling configuration

## Quirks

- **macOS debugging**: `gdb` is provided in the shell (useful for remote/embedded targets), but attaching it to local macOS processes requires code-signing entitlements; use `lldb` for local debugging on macOS.
- **Supported systems**: Targets `x86_64-linux`, `aarch64-linux`, and `aarch64-darwin` (`x86_64-darwin` is dropped in `nixpkgs` 26.11).
- **`clangd` index**: `build/artifacts/compile_commands.json` is generated on demand when running `ceedling test:all` (referenced by `.clangd`).
