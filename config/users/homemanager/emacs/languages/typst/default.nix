{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/typst/+typst.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      typst-ts-mode
      ox-typst
    ])
  );
  home.packages = with pkgs; [
    tinymist
    typstyle
    pandoc
  ];
}
