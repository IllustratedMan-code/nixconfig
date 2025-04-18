{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/python/+python.el"];
  home.packages = with pkgs; [pyright];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      lsp-pyright
    ])
  );
}
