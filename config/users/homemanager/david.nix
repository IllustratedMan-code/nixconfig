{ inputs
, config
, pkgs
, ...
}:
let
in
{
  imports = [
    ./starship
    ./nushell
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
    ./quarto
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
    sqlitebrowser
  ];
}
