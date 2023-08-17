{ config, pkgs, ... }:
with pkgs; let
  R-with-my-packages = rWrapper.override { packages = with rPackages; [ ggplot2 dplyr xts tidyverse styler ]; };
  python-with-my-packages = pkgs.python3.withPackages (p: with p; [
    pandas
    matplotlib
    numpy
    pygments
    python-lsp-server
    ipython
    jupyter
    ipykernel
    scikit-learn
    plotly
    nltk
    networkx
    graphviz
  ]);
in
{
  home.packages = with pkgs; [
    R-with-my-packages
    python-with-my-packages
    rustup
    clang
    bear
    clang-tools
    graphviz
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
  home.sessionVariables = {
    QT_PLUGIN_PATH = with pkgs.qt5; "${qtbase}/${qtbase.qtPluginPrefix}";
  };
}
