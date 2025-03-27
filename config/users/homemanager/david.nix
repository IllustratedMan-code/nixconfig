{inputs, config, pkgs, ...}:
let
in
{
 imports = [./emacs];
 programs.direnv.enable = true;
 programs.direnv.nix-direnv.enable = true;
 home.packages = with pkgs; [];
}
