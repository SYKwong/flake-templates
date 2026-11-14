# flake-templates

[![Documentation](https://img.shields.io/badge/docs-nix.kyle--kwong.com-blue?style=flat-square)](https://nix.kyle-kwong.com/templates/)

Self-contained, system-agnostic Nix flake project templates for playgrounds and projects.

📚 **Documentation:** [**nix.kyle-kwong.com/templates**](https://nix.kyle-kwong.com/templates/)

---

## Available Templates

| Template | Description | Guide |
| :--- | :--- | :--- |
| **`c-clang`** | C (Clang) playground with Ceedling `1.2.2` (Unity + CMock), `clang` 23, `lldb`/`gdb`, `just`, and `clangd` | [`docs/c/clang.md`](https://nix.kyle-kwong.com/templates/c/clang/) |
| **`c-gcc`** | C (GCC) playground with Ceedling `1.2.2` (Unity + CMock), `gcc` 16, `gdb`, `just`, and `clangd` | [`docs/c/gcc.md`](https://nix.kyle-kwong.com/templates/c/gcc/) |

---

## Quick Start

Create a new project from a template:

```bash
nix flake new -t github:SYKwong/flake-templates#c-clang my-c-test
cd my-c-test
direnv allow
```
