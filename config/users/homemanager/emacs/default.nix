{
  inputs,
  config,
  pkgs,
  ...
}:
let

in
{
  imports = [
    ./keymap
    ./emacslib.nix
    ./languages
  ];
  home.sessionVariables = {
    emacsconfig = "${config.home.homeDirectory}/nixconfig/config/users/homemanager/emacs";
  };
  programs.emacs = {
    enable = true;
    package = with pkgs; emacs-gtk;
    extraPackages = (
      epkgs:
      (with epkgs; [
        vterm
        treesit-grammars.with-all-grammars
        use-package
        evil
        evil-collection
        bind-key
        general
        treesit-auto
        markdown-mode
        ivy
        counsel
        company
        git-gutter
      ])
    );
  };
  home.packages = with pkgs; [ sshfs ];
  home.file.".emacs.d/init.el".source =
    config.emacsLib.makeSymlink "init.el";
  home.file.".emacs.d/early-init.el".source =
    config.emacsLib.makeSymlink "early-init.el";
  
  emacsLib.useFiles = [ "languages/languages.el" ];
}
