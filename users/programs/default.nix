{inputs, config, pkgs, ... }:
let
in
{
  imports = [
              ./gnuplot.nix
              ./kitty.nix
              ./gtk.nix
            ];
}
