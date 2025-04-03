{ inputs
, config
, pkgs
, ...
}:

with config.lib.stylix.colors.withHashtag;
let
  theme = ''
    * {
      al: #00000000;
      bg: ${base00};
      se: ${base0C};
      fg: ${base06};
      ac: ${base0C};
    }
  '';
in
{
  home.packages = with pkgs; [ rofi-wayland ];
  xdg.configFile."rofi/theme.rasi".source = ./theme.rasi;
  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  xdg.configFile."rofi/colors.rasi".text = theme;
  hyprland.configs = ["rofi/rofi-hyprland.conf"];
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  # };
}
