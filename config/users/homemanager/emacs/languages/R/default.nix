{...}:
{
  emacsLib.useFiles = ["languages/R/+R.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      ess
    ])
  );

}
