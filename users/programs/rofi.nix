{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    * {
      al: #00000000;
      bg: ${base01};
      se: ${base0C};
      fg: ${base06};
      ac: ${base0C};
    }
  '';
in
{
  xdg.configFile."rofi/config.rasi".source = "${inputs.dotfiles}/rofi/config.rasi";
  xdg.configFile."rofi/theme.rasi".source = "${inputs.dotfiles}/rofi/theme.rasi";
  xdg.configFile."rofi/colors.rasi".text = theme;
}
