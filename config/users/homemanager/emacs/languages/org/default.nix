{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/org/+org.el"];
  home.packages = with pkgs; [texlive.combined.scheme-medium];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      org-modern
      org-present
      evil-org
      org-roam
      org-roam-ui
      org-download
      citeproc
      org-fragtog
      org-appear
    ])
  );
}
  
