{
  description = "Reusable Nix flake project templates";

  outputs =
    { ... }:
    {
      templates = {
        c = {
          path = ./c;
          description = "C playground with Ceedling (Unity + CMock)";
        };
      };
    };
}
