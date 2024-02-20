{ inputs, config, pkgs, scheme, ... }:
with scheme; with pkgs.lib;
let
  pow =
    let
      pow' = base: exponent: value:
        # FIXME: It will silently overflow on values > 2**62 :(
        # The value will become negative or zero in this case
        if exponent == 0
        then 1
        else if exponent <= 1
        then value
        else (pow' base (exponent - 1) (value * base));
    in
    base: exponent: pow' base exponent base;

  rgb = value:
    let
      hexMap = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
      };
      convert = str:
        let
          chars = stringToCharacters str;
          len = length chars;
          mapper = imap0 (k: v: (hexMap."${v}" * (pow 16 (len - k - 1))));
        in
        toString ((foldl' (x: y: x + y) 0 (mapper chars)) / 255.0);
      split = str: {
        r = convert (builtins.substring 0 2 str);
        g = convert (builtins.substring 2 2 str);
        b = convert (builtins.substring 4 2 str);
      };
      color = split value;
    in
    {
      r = color.r;
      g = color.g;
      b = color.b;
      value = value;
    };
  bg = rgb base00;
  fg = rgb base05;
  statusbg = rgb base01;
  statusfg = rgb base04;
  hi = statusbg;
  theme = ''
    background_color ${bg.r} ${bg.g} ${bg.b}
    custom_background_color ${bg.r} ${bg.g} ${bg.b}
    custom_text_color ${fg.r} ${fg.g} ${fg.b}
    status_bar_color ${statusbg.r} ${statusbg.g} ${statusbg.b}
    status_bar_text_color ${statusfg.r} ${statusfg.g} ${statusfg.b}
    text_highlight_color ${hi.r} ${hi.g} ${hi.b}
    search_highlight_color ${hi.r} ${hi.g} ${hi.b}
    should_launch_new_window 1
    startup_commands toggle_custom_color;
  '';
in
{
  xdg.configFile."sioyek/prefs_user.config".text = theme;
}
