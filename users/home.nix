{ inputs, config, pkgs, ... }:
{
  imports = [ ./build-tools.nix inputs.hyprland.homeManagerModules.default ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # this isn't working right now
  nixpkgs.config.allowUnfree = true;
  # temporary solution

  #needed for firefox
  home.stateVersion = "22.05";
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      extraPolicies = { ImportEnterpriseRoots = true; };
    };
  };
  home.packages = with pkgs; [
    pick-colour-picker
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
    libreoffice
    godot
    onlyoffice-bin
    libxpdf
    soundfont-fluid
    sumneko-lua-language-server
    haskellPackages.pandoc
    plantuml
    rnix-lsp
    imagemagick
    mysql
    sshfs-fuse
    dunst
    polybar
    rofi
    flameshot
    zip
    go
    stalonetray
  ];
}
