{pkgs, ...}:
{
	emacsLib.useFiles = ["languages/nix/+nix.el"];
  home.packages = with pkgs; [nixfmt-rfc-style];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
			nix-mode
    ])
  );
}
