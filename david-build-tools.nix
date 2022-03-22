{ inputs,config, pkgs, home-manager, nixpkgs,neovim, doom-emacs, emacs, ... }:
with pkgs;
let
  R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts ]; };
in {
    home.packages = with pkgs; [R-with-my-packages];
    }
