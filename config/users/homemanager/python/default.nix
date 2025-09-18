{pkgs, ...}:
let
  mypy = (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      seaborn
      numpy
      matplotlib
      pandas
      polars
      ipython
      scipy
  ]));
  pycalc = pkgs.writeShellScriptBin "pycalc" ''
     ipython --quick --no-banner -i ${./pycalc.py};
  '';
in
{
  home.packages = [
    mypy
    pycalc
  ];
}
