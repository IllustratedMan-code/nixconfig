{ inputs
, config
, pkgs
, ...
}:
{
  emacsLib.useFiles = [ "keymap/userkeymap.el" ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      general
      evil-owl
      evil
      evil-collection
    ])
  );
}
