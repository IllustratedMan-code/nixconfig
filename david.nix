{ config, pkgs, home-manager, nixpkgs, ... }:
let 
    polybarConfig = builtins.readFile ./dotfiles/polybar/config;
in
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
        source = /home/david/dotfiles/nvim;
        recursive = true;
        };
        home.file.".config/polybar/config".text = "${polybarConfig}";
        xdg.configFile."kitty" = {
        source = /home/david/dotfiles/kitty;
        recursive = true;
        };
        xdg.configFile."rofi" = {
        source = /home/david/dotfiles/rofi;
        recursive = true;
        };
        xdg.configFile."i3" = {
        source = /home/david/dotfiles/i3;
        recursive = true;
        };
        xdg.configFile."zathura" = {
        source = /home/david/dotfiles/zathura;
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
