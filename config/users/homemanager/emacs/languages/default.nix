{ inputs
, config
, pkgs
, ...
}:
{
  imports = [ ./nix ];
  emacsLib.useFiles = [ "languages/languages.el" ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      lsp-mode
      lsp-ivy
    ])
  );
}
