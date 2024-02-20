{ config, pkgs, inputs, ... }:
with config.scheme.withHashtag;
let
  cluster = with pkgs; stdenv.mkDerivation rec {
    name = "osccluster";
    src = ./.;
    buildInputs = [ gum openssh ];
    installPhase = ''
      mkdir -p $out/bin
      echo "#!${stdenv.shell}" >> $out/bin/${name}
      echo "export GUM_CHOOSE_CURSOR_FOREGROUND=${base0D}" >> $out/bin/${name}
      cat cluster.sh >> $out/bin/${name}
      chmod +x $out/bin/${name}
    '';
  };
in
{
  environment.systemPackages = [ cluster ];
}
