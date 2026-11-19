default:
    @just --list

# Format repository with treefmt-nix
format:
    nix fmt

# Run formatting checks and validate root and template flakes across all systems
check:
    nix fmt -- --fail-on-change
    nix flake check --no-build --all-systems
    nix flake show --all-systems
    @for f in */flake.nix */*/flake.nix; do \
        [ -f "$f" ] || continue; \
        dir="$(dirname "$f")"; \
        echo "Checking ${dir}..."; \
        nix flake show --all-systems "./${dir}"; \
    done

# Smoke-test all language templates inside their devShells
test:
    nix develop ./c/clang --command just -f c/clang/justfile -d c/clang run
    nix develop ./c/clang --command just -f c/clang/justfile -d c/clang clean
    nix develop ./c/gcc --command just -f c/gcc/justfile -d c/gcc run
    nix develop ./c/gcc --command just -f c/gcc/justfile -d c/gcc clean

# Update root and template flake.lock files
update-flakes:
    nix flake update
    @for f in */flake.nix */*/flake.nix; do \
        [ -f "$f" ] || continue; \
        dir="$(dirname "$f")"; \
        echo "Updating ${dir}/flake.lock..."; \
        nix flake update --flake "./${dir}"; \
    done
