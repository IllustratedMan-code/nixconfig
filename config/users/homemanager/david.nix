{ inputs
, config
, pkgs
, ...
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
    ./tmux
    ./utilities/cluster-connect
    ./typst
    ./R
    ./discord
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.packages = with pkgs; [
    tmux
    anki-bin
    pdftk
    chromium
  ];
}
