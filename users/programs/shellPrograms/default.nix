{ config, pkgs, inputs, ... }:
with config.scheme.withHashtag;
let
  ShellPrograms = with pkgs; stdenv.mkDerivation {
    name = "ShellPrograms";
    src = ./.;
    buildInputs = [ gum grim slurp gawk ];
    installPhase = ''
      mkdir -p $out/bin
      echo "#! ${stdenv.shell}" >> $out/bin/nrs
      echo "#! ${stdenv.shell}" >> $out/bin/colorpicker
      echo "#! ${stdenv.shell}" >> $out/bin/screenshot
      echo "#! ${stdenv.shell}" >> $out/bin/chat
      cat nrs.sh >> $out/bin/nrs
      cat colorpicker.sh >> $out/bin/colorpicker
      cat screenshot.sh >> $out/bin/screenshot
      cat chat.sh >> $out/bin/chat
      chmod +x $out/bin/nrs
      chmod +x $out/bin/colorpicker
      chmod +x $out/bin/screenshot
      chmod +x $out/bin/chat
    '';
  };
in
{
  home.packages = [ ShellPrograms pkgs.jq ];
}
