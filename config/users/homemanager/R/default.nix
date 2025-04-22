{pkgs, ...}: # a basic R setup for interactive use
let
in
{
  home.packages = with pkgs;[
    (rWrapper.override {
      packages = with rPackages;
        [
          tidyverse
          languageserver
        ];
    }
    )
  ];

}
