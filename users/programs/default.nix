{inputs, config, pkgs, ... }:
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
              ./polybar.nix
              ./rofi.nix
              ./nvim.nix
              ./dunst.nix
              ./i3.nix
              ./wallpapers
              ./gtk
            ];
}
