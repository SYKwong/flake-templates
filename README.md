# Flake Templates

## Usage

Create a new project from a template:

```bash
nix flake new -t ~/Templates/flake-templates#c ~/Projects/playground/my-c-test
cd ~/Projects/playground/my-c-test
direnv allow
```

## Available Templates

- `c`: C playground with Ceedling (`ceedling test:all`), `gcc`, `gdb`, `just`, and `compile_commands.json` generation for `clangd`.
