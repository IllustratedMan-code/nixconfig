{ pkgs ? import <nixpkgs> {} }:
let
    R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [
        ggplot2 dplyr xts BiocManager DESeq2
        ];
    };
in
pkgs.mkShell {
  buildInputs = [
    R-with-my-packages
    # other dependencies
  ];
}
