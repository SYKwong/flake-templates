{
  description = "Reusable Nix flake project templates";

  outputs =
    { ... }:
    {
      templates = {
        c-clang = {
          path = ./c-clang;
          description = "C (Clang) playground with Ceedling (Unity + CMock), clang, lldb/gdb, and just";
        };
        c-gcc = {
          path = ./c-gcc;
          description = "C (GCC) playground with Ceedling (Unity + CMock), gcc, gdb, and just";
        };
      };
    };
}
