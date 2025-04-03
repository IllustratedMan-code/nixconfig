{
  inputs,
  config,
  pkgs,
  ...
}:
let
in
{
  imports = [
    ./emacs
    ./helix
    ./zsh
    ./kitty
    ./hyprland
    ./utilities/cluster-connect
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.packages = with pkgs; [
    tmux
  ];
}
