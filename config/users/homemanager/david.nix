{ inputs
, config
, pkgs
, ...
}:
let
in
{
  imports = [
    ./neovim
    ./vscode
    ./variables
    ./outlook
    ./slack
    ./emacs
    ./helix
    ./zsh
    ./kitty
    ./hyprland
    ./tmux
    ./utilities/cluster-connect
    ./utilities/update-repos
    ./typst
    ./R
    ./python
    ./discord
    ./sioyek
    ./C++
    ./teams
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.packages = with pkgs; [
    tmux
    anki-bin
    pdftk
    chromium
    pkgs.unstable.blender
    inkscape
    gimp
    zotero
    libreoffice
  ];
}
