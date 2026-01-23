{ pkgs, ... }:
{
  emacsLib.useFiles = [
    "languages/xppaut/+xppaut.el"
    "languages/xppaut/xpp.el"
  ];
}
