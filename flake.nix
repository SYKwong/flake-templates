{
  description = "Reusable Nix flake project templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      treefmtEval = forAllSystems (
        system:
        treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} {
          projectRootFile = "flake.nix";

          programs = {
            deadnix.enable = true;
            nixfmt.enable = true;
            prettier = {
              enable = true;
              includes = [ "*.md" ];
            };
            statix.enable = true;
          };

          settings.global.excludes = [
            "**/gemset.nix"
          ];
        }
      );
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      templates = {
        c-clang = {
          path = ./c/clang;
          description = "C (Clang) playground with Ceedling (Unity + CMock), clang, lldb/gdb, and just";
        };
        c-gcc = {
          path = ./c/gcc;
          description = "C (GCC) playground with Ceedling (Unity + CMock), gcc, gdb, and just";
        };
      };
    };
}
