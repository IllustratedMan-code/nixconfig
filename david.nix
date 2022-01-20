{ config, pkgs, home-manager, nixpkgs, ... }:
{
    imports = [
        (import "${home-manager}/nixos")
      ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.david = {

        nixpkgs.overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
          sha256 = "0hwidvyi95g67hssfp0yja9p8k7aankbv53xydq974yjm6dr1rq1";

        }))
        ];
        programs.neovim = {
        enable = true;
        };
       # xdg.configFile."nvim" = {
       # source = "${home-manager}/dotfiles/nvim";
       # recursive = true;
       # };
        xdg.configFile."polybar" = {
        source = "${home-manager}/dotfiles/polybar";
        recursive = true;
        };
        xdg.configFile."kitty" = {
        source = "${home-manager}/dotfiles/kitty";
        recursive = true;
        };
        xdg.configFile."rofi" = {
        source = "${home-manager}/dotfiles/rofi";
        recursive = true;
        };
        xdg.configFile."i3" = {
        source = "${home-manager}/dotfiles/i3";
        recursive = true;
        };
        xdg.configFile."zathura" = {
        source = "${home-manager}/dotfiles/zathura";
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
        };
    }
