{ inputs, config, pkgs, ... }:
let
in
{
  imports = [
    ./gnuplot.nix
    ./kitty.nix
    ./emacs.nix
    ./hyprland.nix
    ./eww.nix
    ./zathura.nix
    ./rofi.nix
    ./nvim
    ./dunst.nix
    ./wallpapers
    ./gtk
    ./waybar.nix
    ./zsh.nix
    ./shellPrograms
    ./ardour.nix
    ./latex
    ./sioyek.nix
  ];
}
