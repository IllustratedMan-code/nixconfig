{ config, pkgs, home-manager, nixpkgs,neovim, ... }:
{
    nixpkgs.overlays = [
       # (import (builtins.fetchTarball { url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
       #   sha256 = "0hwidvyi95g67hssfp0yja9p8k7aankbv53xydq974yjm6dr1rq1";
       # }))
        neovim.overlay
    ];
    programs.neovim = {
    enable = true;
    };
    xdg.configFile."nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
    };
    xdg.configFile."autorandr/postswitch" = {
        source = ./dotfiles/autorandr-postswitch.sh;
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
    xdg.configFile."dunst" = {
        source = ./dotfiles/dunst;
        recursive = true;
    };
    home.file.".doom.d" = {
        source = ./dotfiles/.doom.d;
        recursive = true;
    };

    xdg.mimeApps = {
        enable = true;
        associations.added = {
          "application/pdf" = ["org.pwmt.zathura.desktop"];
          "application/x-shellscript" = ["emacs.desktop" "emacsclient.desktop"];
          "text/x-csrc" = ["emacsclient.desktop"];
          "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
          "application/zip" = ["org.gnome.FileRoller.desktop"];
        };
        defaultApplications = {
          "application/pdf" = ["org.pwmt.zathura.desktop"];
        };
      };
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    services.lorri.enable = true;

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
        zathura conda zotero vlc dropbox
        sox ocrmypdf shared-mime-info inkscape
        xournalpp libreoffice
        ];
}
