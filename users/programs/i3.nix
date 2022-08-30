{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    set $base00 ${base00}
    set $base01 ${base01}
    set $base02 ${base02}
    set $base03 ${base03}
    set $base04 ${base04}
    set $base05 ${base05}
    set $base06 ${base06}
    set $base07 ${base07}
    set $base08 ${base08}
    set $base09 ${base09}
    set $base0A ${base0A}
    set $base0B ${base0B}
    set $base0C ${base0C}
    set $base0D ${base0D}
    set $base0E ${base0E}
    set $base0F ${base0F}
  '';
in
{
  xdg.configFile."i3/atp.png".source = "${inputs.dotfiles}/i3/atp.png";
  xdg.configFile."i3/launch_polybar.sh".source = "${inputs.dotfiles}/i3/launch_polybar.sh";
  xdg.configFile."i3/launch-monitors.sh".source = "${inputs.dotfiles}/i3/launch-monitors.sh";
  xdg.configFile."i3/config".source = "${inputs.dotfiles}/i3/config";
  xdg.configFile."i3/colors.config".text = theme;

}
