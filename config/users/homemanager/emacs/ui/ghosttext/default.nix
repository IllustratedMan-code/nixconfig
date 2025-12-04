{pkgs, ...}:
{
  emacsLib.useFiles = ["ui/ghosttext/+ghosttext.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      atomic-chrome
    ])
  );
}
