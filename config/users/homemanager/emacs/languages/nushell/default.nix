{ ... }:
{
  emacsLib.useFiles = [ "languages/nushell/+nushell.el" ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      nushell-mode
    ])
  );
}
