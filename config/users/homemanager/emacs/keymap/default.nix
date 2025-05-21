{ inputs
, config
, pkgs
, ...
}:
let
  
in
{
  
  emacsLib.useFiles = [ "keymap/+keymap.el" ];
  home.packages = with pkgs;[fzf silver-searcher ripgrep];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      general
      evil-owl
      evil
      evil-collection
      ace-window
      avy
      darkroom
    ])
  );
}
