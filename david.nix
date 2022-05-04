{ inputs, config, pkgs, home-manager, nixpkgs, neovim, doom-emacs, emacs-overlay, dotfiles, ... }:
{
  # I have to manage the overlays in configuration.nix, it doesn't seem to work here.
  programs.neovim = {
    enable = true;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGcc;
  programs.zathura.enable = true;
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
  # xdg.configFile."zathura/zathurarc" = {
  #     source = ./dotfiles/zathura/zathurarc;
  # };
  xdg.configFile."dunst" = {
    source = ./dotfiles/dunst;
    recursive = true;
  };
  home.file.".doom.d" = {
    source = ./dotfiles/.doom.d;
    recursive = true;
    onChange = "~/.emacs.d/bin/doom sync";
  };
  home.file."texmf/tex/latex/custom/mla.cls" = {
    source = ./dotfiles/mla.cls;
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/x-shellscript" = [ "emacs.desktop" "emacsclient.desktop" ];
      "text/x-csrc" = [ "emacsclient.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
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
    discord
    pavucontrol
    autorandr
    texlive.combined.scheme-full
    zathura
    conda
    zotero
    vlc
    dropbox
    sox
    ocrmypdf
    shared-mime-info
    inkscape
    xournalpp
    libreoffice
    godot
    blender
    onlyoffice-bin
    lilypond
    libxpdf
    soundfont-fluid
    sumneko-lua-language-server
    haskellPackages.pandoc
    plantuml
    rnix-lsp
    imagemagick
    python39
    python39Packages.pygments
    mysql
  ];
}
