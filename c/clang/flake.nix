{
  description = "C (Clang) playground with Ceedling (Unity + CMock), clang, lldb/gdb, and just";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system: f (import nixpkgs { inherit system; })
        );
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          rubyEnv = pkgs.bundlerEnv {
            name = "ceedling-ruby-env";
            ruby = pkgs.ruby;
            gemdir = ./.;
          };
          mkClangShell = pkgs.mkShell.override { stdenv = pkgs.llvmPackages_23.stdenv; };
        in
        {
          default = mkClangShell {
            packages = [
              rubyEnv
              rubyEnv.wrappedRuby
              pkgs.gdb
              pkgs.just
              pkgs.llvmPackages_23.lldb
            ];
          };
        }
      );
    };
}
