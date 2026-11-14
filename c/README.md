# C Playgrounds (`c/clang` & `c/gcc`)

C playground templates using Ceedling (Unity + CMock), pinned compilers (`clang` 23 or `gcc` 16), debuggers (`lldb`/`gdb`), and `just`.

- **`c-clang`** (`c/clang/`): Clang 23 (`llvmPackages_23.stdenv`), `lldb` 23, `gdb`, `just`, and Ceedling `1.2.2` configured for `clang`.
- **`c-gcc`** (`c/gcc/`): GCC 16 (`gcc16Stdenv`), `gdb`, `just`, and Ceedling `1.2.2` (GCC default).

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

Clean build artifacts and update Ceedling patch gems:

```bash
just clean
just update-gems
```

## Layout

- `include/` — Header files
- `src/` — Source files
- `test/` — Ceedling/Unity unit tests (`test_*.c`)
- `justfile` — Task runner recipes (`test`, `build`, `run`, `clean`, `update-gems`)
- `project.yml` — Ceedling configuration

## Quirks

- **macOS debugging**: Use `lldb` (`c/clang`) for local debugging on macOS (`gdb` is included in both, but attaching to local macOS processes requires code-signing entitlements).
- **Supported systems**: Targets `x86_64-linux`, `aarch64-linux`, and `aarch64-darwin` (`x86_64-darwin` was dropped in `nixpkgs` 26.11).
- **`clangd` index**: `build/artifacts/compile_commands.json` is generated on demand when running `just test` (referenced by `.clangd`).
