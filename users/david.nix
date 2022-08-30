{inputs, config, pkgs, ... }:
let 
in
{
  imports = [ ./home.nix
              ./programs
            ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.configFile."autorandr/postswitch" = {
    source = "${inputs.dotfiles}/autorandr-postswitch.sh";
  };
  xdg.configFile."flameshot/flameshot.ini" = {
    source = "${inputs.dotfiles}/flameshot.ini";
  };
  home.file."texmf/tex/latex/custom/mla.cls" = {
    source = "${inputs.dotfiles}/mla.cls";
  };
  home.file.".zshrc" = {
    source = "${inputs.dotfiles}/.zshrc";
  };
  xdg.configFile."shell" = {
    source = "${inputs.dotfiles}/shell";
    recursive = true;
  };
  home.file.".mozilla/certificates/CCHMCIssuingCA.crt" = {
    source = ../work/CCHMCIssuingCA.crt;
  };
  home.file.".mozilla/certificates/CCHMCRootCA.crt" = {
    source = ../work/CCHMCRootCA.crt;
  };



  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/x-shellscript" = [ "emacs.desktop" "emacsclient.desktop" ];
      "text/x-csrc" = [ "emacsclient.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
      "inode/directory" = [ "kitty-open.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };

  #gtk = {
  #  enable = true;
  #  theme = {
  #    name = "Nordic";
  #    package = pkgs.nordic;
  #  };
  #};
  home.packages = with pkgs; [
    inputs.eww.packages.x86_64-linux.eww-wayland
    hyprpaper
    nyxt
    grim
    slurp
    gum
    sass
    stable.zathura
  ];

}
