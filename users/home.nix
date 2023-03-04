{ inputs, config, pkgs, ... }:
{
  imports = [ ./build-tools.nix ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # this isn't working right now
  nixpkgs.config.allowUnfree = true;
  # temporary solution

  #needed for firefox
  home.stateVersion = "22.05";
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };
  home.packages = with pkgs; [
    element-desktop-wayland
    krita
    cinnamon.nemo
    google-chrome-beta
    tree-sitter
    kate
    mdbook
    nextflow
    haskellPackages.gtk-sni-tray
    haskellPackages.status-notifier-item
    wofi
    pavucontrol
    autorandr
    texlive.combined.scheme-full
    conda
    zotero
    vlc
    dropbox
    sox
    ocrmypdf
    shared-mime-info
    inkscape
    xournalpp
    stable.libreoffice
    godot_4
    onlyoffice-bin
    libxpdf
    soundfont-fluid
    sumneko-lua-language-server
    haskellPackages.pandoc
    plantuml
    rnix-lsp
    imagemagick
    sshfs-fuse
    dunst
    rofi-wayland
    flameshot
    zip
    go
    gnuplot
    obsidian
    anki
    markdown-anki-decks
  ];
}
