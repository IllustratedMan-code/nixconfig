{pkgs,config, ...}:
let
  bin = pkgs.writeShellApplication {
    name="flake-repl";
    runtimeInputs = [pkgs.nushell];
    text = ''
         ${builtins.readFile ./nix-flake-repl.nu}
    '';
  };
in
{

  home.packages = [
    bin
  ];
}
