{ config, pkgs, home-manager, nixpkgs, ... }:
{

        nixpkgs.overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
          sha256 = "0hwidvyi95g67hssfp0yja9p8k7aankbv53xydq974yjm6dr1rq1";

        }))
        ];
        programs.neovim = {
        enable = true;
        };
        xdg.configFile."nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
        };
        xdg.configFile."polybar" = {
        source = ./dotfiles/polybar;
        recursive = true;
        };
        xdg.configFile."kitty" = {
        source = ./dotfiles/kitty;
        recursive = true;
        };
        xdg.configFile."rofi" = {
        source = ./dotfiles/rofi;
        recursive = true;
        };
        xdg.configFile."i3" = {
        source = ./dotfiles/i3;
        recursive = true;
        };
        xdg.configFile."zathura" = {
        source = ./dotfiles/zathura;
        recursive = true;
        };


        gtk = {
          enable = true;
          theme = {
            name = "Nordic";
            package = pkgs.nordic;
          };
        };
        home.packages = with pkgs; [
            discord pavucontrol autorandr 
            texlive.combined.scheme-full
            zathura 
            ];
    }
