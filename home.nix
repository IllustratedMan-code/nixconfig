{ config, lib, pkgs, specialArgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.neovim.overlay inputs.emacs-overlay.overlay ];
  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    shell = pkgs.zsh;
    description = "David Lewis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.david =
    { config, pkgs, ... }:
    let
      inherit inputs;
    in
    {
      imports = [ ./build-tools.nix ];

      programs.neovim = {
        enable = true;
      };
      programs.emacs = {
        enable = true;
        package = pkgs.emacsNativeComp;
        extraPackages = (epkgs: [ epkgs.vterm ]);
      };
      services.emacs.enable = true;
      services.emacs.package = pkgs.emacsNativeComp;
      programs.zathura.enable = true;
      xdg.configFile."nvim" = {
        source = "${inputs.dotfiles}/nvim";
        recursive = true;
      };
      xdg.configFile."autorandr/postswitch" = {
        source = "${inputs.dotfiles}/autorandr-postswitch.sh";
      };
      xdg.configFile."polybar" = {
        source = "${inputs.dotfiles}/polybar";
        recursive = true;
      };
      xdg.configFile."kitty" = {
        source = "${inputs.dotfiles}/kitty";
        recursive = true;
      };
      xdg.configFile."rofi" = {
        source = "${inputs.dotfiles}/rofi";
        recursive = true;
      };
      xdg.configFile."i3" = {
        source = "${inputs.dotfiles}/i3";
        recursive = true;
      };
      # xdg.configFile."zathura/zathurarc" = {
      #     source = ./dotfiles/zathura/zathurarc;
      # };
      xdg.configFile."dunst" = {
        source = "${inputs.dotfiles}/dunst";
        recursive = true;
      };
      home.file.".doom.d" = {
        source = "${inputs.dotfiles}/.doom.d";
        recursive = true;
        onChange = "~/.emacs.d/bin/doom sync";
      };
      home.file."texmf/tex/latex/custom/mla.cls" = {
        source = "${inputs.dotfiles}/mla.cls";
      };
      home.file.".zshrc" = {
        source = "${inputs.dotfiles}/.zshrc";
      };
      home.file.".bashrc" = {
        source = "${inputs.dotfiles}/.bashrc";
      };
      xdg.configFile."shell" = {
        source = "${inputs.dotfiles}/shell";
        recursive = true;
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
      ];
    };
}
