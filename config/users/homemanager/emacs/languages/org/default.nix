{ pkgs, ... }:
{
  emacsLib.useFiles = [ "languages/org/+org.el" ];
  home.packages = with pkgs; [
    texlive.combined.scheme-medium
    alsa-utils # required to play sounds with org-pomodoro (aplay)
  ];
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
      org-pomodoro
      sound-wav # required to play sounds with org-pomodoro
    ])
  );
}
