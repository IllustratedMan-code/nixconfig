
{ config, pkgs, inputs, ... }:
with config.scheme.withHashtag;
let
  ShellPrograms = with pkgs; stdenv.mkDerivation {
    name = "ShellPrograms";
    src = ./.;
    buildInputs = [ gum grim slurp gawk];
    installPhase = ''
      mkdir -p $out/bin
      echo "#! ${stdenv.shell}" >> $out/bin/nrs
      echo "#! ${stdenv.shell}" >> $out/bin/colorpicker
      cat nrs.sh >> $out/bin/nrs
      cat colorpicker.sh >> $out/bin/colorpicker
      chmod +x $out/bin/nrs
      chmod +x $out/bin/colorpicker
    '';
  };
in
{
  home.packages = [ShellPrograms];
}
