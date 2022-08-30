{inputs, config, pkgs, scheme, ... }:
    with scheme.withHashtag;
let
    theme =  ''
        $base00: ${base00};
        $base01: ${base01};
        $base02: ${base02};
        $base03: ${base03};
        $base04: ${base04};
        $base05: ${base05};
        $base06: ${base06};
        $base07: ${base07};
        $base0D: ${base08};
        $base0E: ${base09};
        $base0C: ${base0A};
        $base0A: ${base0B};
        $base09: ${base0C};
        $base0B: ${base0D};
        $base08: ${base0E};
        $base0F: ${base0F};
    '';
in
{
  xdg.configFile."eww/base16.scss".text = theme;
  # wait until config is more mature
  #xdg.configFile."eww/eww.scss".source = "${inputs.dotfiles}/eww/eww.scss";
  #xdg.configFile."eww/eww.yuck".source = "${inputs.dotfiles}/eww/eww.yuck";
  #xdg.configFile."eww/scripts" = {
  #  source = "${inputs.dotfiles}/eww/scripts";
  #  recursive = true;
  #};
  #xdg.configFile."eww/widgets" = {
  #  source = "${inputs.dotfiles}/eww/widgets";
  #  recursive = true;
  #};
  #xdg.configFile."eww/windows" = {
  #  source = "${inputs.dotfiles}/eww/windows";
  #  recursive = true;
  #};

}
