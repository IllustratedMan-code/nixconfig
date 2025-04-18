{...}:
{
  emacsLib.useFiles = ["languages/org/+org.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      org-modern
    ])
  );
}
  
