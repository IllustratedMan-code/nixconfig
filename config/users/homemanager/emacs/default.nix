{ inputs, config, pkgs, scheme, ...}:
{
  programs.emacs = {
    enable = true;
    package = with pkgs;  emacs-pgtk;
    extraPackages = (epkgs: (with epkgs; [ vterm
                           treesit-grammars.with-all-grammars
                           use-package
                           evil
                           evil-collection
        		   bind-key]
    ));
  };
  home.file.".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink /home/david/nixconfig/config/users/homemanager/emacs/init.el;
}
