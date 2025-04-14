{
  inputs,
  config,
  pkgs,
  ...
}:
let
in
{
  imports = [
  ];
  home.packages = with pkgs; [ ];
  stylix.iconTheme = {
    enable = true;
    light = "Papirus";
    dark = "Papirus";
    package = pkgs.papirus-icon-theme;
  };
}
