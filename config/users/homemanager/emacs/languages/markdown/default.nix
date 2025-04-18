{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/markdown/+markdown.el"];
  home.packages = with pkgs; [nodePackages.prettier nodejs];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
			markdown-mode
      apheleia
    ])
  );
}
