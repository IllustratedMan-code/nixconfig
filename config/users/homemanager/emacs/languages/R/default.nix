{pkgs,...}:
{
  emacsLib.useFiles = ["languages/R/+R.el"];
  home.packages = with pkgs;[ air-formatter ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      ess
    ])
  );

}
