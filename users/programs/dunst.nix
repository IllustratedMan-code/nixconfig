{ inputs, config, pkgs, scheme, ... }:
with scheme;
let
  theme = builtins.replaceStrings
    [
      "2e3440"
      "3b4252"
      "434c5e"
      "4c566a"
      "d8dee9"
      "e5e9f0"
      "eceff4"
      "8fbcbb"
      "bf616a"
      "d08770"
      "ebcb8b"
      "a3be8c"
      "88c0d0"
      "81a1c1"
      "b48ead"
      "5e81ac"
    ]
    [
      base00
      base01
      base02
      base03
      base04
      base05
      base06
      base07
      base08
      base09
      base0A
      base0B
      base0C
      base0D
      base0E
      base0F
    ]
    (builtins.readFile "${inputs.dotfiles}/dunst/dunstrc");

in
{
  xdg.configFile."dunst/dunstrc".text = theme;
}
