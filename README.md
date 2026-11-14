# flake-templates

[![Documentation](https://img.shields.io/badge/docs-nix.kyle--kwong.com-blue?style=flat-square)](https://nix.kyle-kwong.com/templates/)

Self-contained, system-agnostic Nix flake project templates for playgrounds and projects.

📚 **Documentation:** [**nix.kyle-kwong.com/templates**](https://nix.kyle-kwong.com/templates/)

---

## Available Templates

| Template | Description | Guide |
| :--- | :--- | :--- |
| **`c`** | C playground with Ceedling `1.2.2` (Unity + CMock), `gcc`, `gdb`, `just`, and `clangd` | [`docs/c.md`](https://nix.kyle-kwong.com/templates/c/) |

---

## Quick Start

Create a new project from a template:

```bash
# Local clone
nix flake new -t ~/Templates/flake-templates#c ~/Projects/playground/my-c-test

# Remote (GitHub)
nix flake new -t github:SYKwong/flake-templates#c ~/Projects/playground/my-c-test

cd ~/Projects/playground/my-c-test
direnv allow
```
