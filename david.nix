{config, pkgs, callPackage, ... }:
{
    imports = [(import "${home-manager}/nixos")];
    home-manager.users.david = {

        nixpkgs.overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
          sha256 = "0000000000000000000000000000000000000000000000000000";

        }))
        ];
        programs.neovim = {
        enable = true;
        };
        xdg.configFile."nvim" = {
        source = /home/david/dotfiles/nvim;
        recursive = true;
        };
        xdg.configFile."polybar" = {
        source = /home/david/dotfiles/polybar;
        recursive = true;
        };
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
    };
}
