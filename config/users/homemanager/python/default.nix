{pkgs, ...}:
{
  home.packages = with pkgs; [
    (python3.withPackages (python-pkgs: with python-pkgs; [
      seaborn
      numpy
      matplotlib
      pandas
      polars
    ]))
  ];
}
