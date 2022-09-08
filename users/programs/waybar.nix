
{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    window#waybar {
      background-color: transparent;
      border: 0px transparent;
    }
  '';
in
{
  programs.waybar = {
    enable = true;
    settings = [{
      position = "top";
      layer = "top";
      height = 15;
      margin-top = -25;
      margin-right = 120;
      margin-left = 600;
      modules-right = ["tray"];
      exclusive = false;
    }];
    style = theme;
  };
}
