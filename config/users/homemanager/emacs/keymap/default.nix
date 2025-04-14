{ inputs
, config
, pkgs
, ...
}:
{
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      general
			evil-owl
			evil
			evil-collection
    ])
  );
	home.file.".emacs.d/keymap/userkeymap.el".source = config.emacsLib.makeSymlink "keymap/userkeymap.el";
}
