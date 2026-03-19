{
  inputs,
  config,
  pkgs,
  ...
}:

with config.lib.stylix.colors.withHashtag;
let
  configPath = "${config.home.homeDirectory}/nixconfig/config/users/homemanager/emacs";
in
{
  imports = [
    ./keymap
    ./emacslib.nix
    ./languages
    ./modeline
    ./remote
    ./snippets
    ./ui
  ];
  systemd.user.sessionVariables = {
    emacsconfig = configPath;
  };
  programs.emacs = {
    enable = true;
    package = with pkgs; emacs-gtk;
    extraPackages = (
      epkgs:
      (with epkgs; [
        flycheck
        hl-todo
        titlecase
        direnv
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
        treemacs
        treemacs-evil
        f
      ])
    );
  };
  home.packages = with pkgs; [ sshfs ];
  home.file.".emacs.d/init.el".source =
    config.emacsLib.makeSymlink "init.el";
  home.file.".emacs.d/early-init.el".text = ''
    ${builtins.readFile ./early-init.el}
    (add-to-list 'default-frame-alist '(foreground-color . "${base05}"))
    (add-to-list 'default-frame-alist '(background-color . "${base00}"))
    (setq-default emacs-config "${configPath}")
    '';
  
  emacsLib.useFiles = [ "languages/languages.el" ];
}
