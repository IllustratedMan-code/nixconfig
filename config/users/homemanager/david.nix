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
    ./python
    ./discord
    ./sioyek
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.packages = with pkgs; [
    tmux
    anki-bin
    pdftk
    chromium
    pkgs.unstable.blender
  ];
}
