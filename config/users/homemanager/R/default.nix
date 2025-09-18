{ pkgs, ... }: # a basic R setup for interactive use
let
  packages = with pkgs.rPackages; [
    tidyverse
    languageserver
    RSQLite
    DBI
  ];
in
{
  home.packages = with pkgs; [
    (rstudioWrapper.override { inherit packages; })
    (rWrapper.override {
      inherit packages;
    })
  ];

}
