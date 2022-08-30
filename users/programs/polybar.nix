{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    [colors]
    nord0=${base00}
    nord1=${base01}
    nord2=${base02}
    nord3=${base03}
    nord4=${base04}
    nord5=${base05}
    nord6=${base06}
    nord7=${base07}
    nord8=${base0C}
    nord9=${base0D}
    nord10=${base0F}
    nord11=${base08}
    nord12=${base09}
    nord13=${base0A}
    nord14=${base0B}
    nord15=${base0E}
    base00=${base00}
    base01=${base01}
    base02=${base02}
    base03=${base03}
    base04=${base04}
    base05=${base05}
    base06=${base06}
    base07=${base07}
    base08=${base08}
    base09=${base09}
    base0A=${base0A}
    base0B=${base0B}
    base0C=${base0C}
    base0D=${base0D}
    base0E=${base0E}
    base0F=${base0F}
  '';
in
{
  xdg.configFile."polybar/config.ini".source = "${inputs.dotfiles}/polybar/config.ini";
  xdg.configFile."polybar/rofi-bluetooth".source = "${inputs.dotfiles}/polybar/rofi-bluetooth";
  xdg.configFile."polybar/pomodoro.sh".source = "${inputs.dotfiles}/polybar/pomodoro.sh";
  xdg.configFile."polybar/ding.mp3".source = "${inputs.dotfiles}/polybar/ding.mp3";
  xdg.configFile."polybar/vpn-openvpn-status.sh".source = "${inputs.dotfiles}/polybar/vpn-openvpn-status.sh";
  xdg.configFile."polybar/colors.ini".text = theme;
}
