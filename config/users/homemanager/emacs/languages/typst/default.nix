{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/typst/+typst.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      typst-ts-mode
    ])
  );
  home.packages = with pkgs; [
    tinymist
    typstyle
  ];
}
