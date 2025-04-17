{...}:
{
	emacsLib.useFiles = ["languages/nix/nix.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
			nix-mode
    ])
  );
}
