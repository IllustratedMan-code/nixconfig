{ inputs, config, pkgs, scheme, ... }:
with scheme;
let
  hex = {
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
    "A" = 10;
    "B" = 11;
    "C" = 12;
    "D" = 13;
    "E" = 14;
    "F" = 15;
  };
  toint = pkgs.lib.strings.stringAsChars (x: hex.x);
  split = str: [ (builtins.substring 0 2 str) (builtins.substring 2 2 str) (builtins.substring 4 2 str) ];
  tohex = str: map builints.lib.strings.toInt (split str);

in
{ }
