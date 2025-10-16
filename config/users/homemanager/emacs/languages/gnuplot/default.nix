{pkgs,...}:
{
  emacsLib.useFiles = ["languages/gnuplot/+gnuplot.el"];
  home.packages = with pkgs; [gnuplot];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      gnuplot
    ])
  );

}
