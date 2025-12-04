{ pkgs, ... }: # a basic R setup for interactive use
let
  packages = with pkgs.rPackages; [
    tidyverse
    languageserver
    RSQLite
    DBI
    rsconnect
    devtools
    usethis
    shiny
    maps
    mapproj

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
