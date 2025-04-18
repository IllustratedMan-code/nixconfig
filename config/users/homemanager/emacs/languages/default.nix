{ inputs
, config
, pkgs
, ...
}:
{
  imports = [ ./nix ./markdown ./python ./org ./typst];
  emacsLib.useFiles = [ "languages/languages.el" ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      lsp-mode
      lsp-ivy
    ])
  );
}
