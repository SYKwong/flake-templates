{
  description = "C playground with Ceedling (Unity + CMock)";

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
        in
        {
          default = pkgs.mkShell {
            packages = [
              rubyEnv
              rubyEnv.wrappedRuby
              pkgs.gcc
              pkgs.gdb
              pkgs.just
            ];
          };
        }
      );
    };
}
