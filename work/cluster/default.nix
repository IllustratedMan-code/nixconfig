{ config, pkgs, inputs, ... }:
with config.scheme.withHashtag;
let
  cluster = with pkgs; stdenv.mkDerivation {
    name = "cluster";
    src = ./.;
    buildInputs = [ gum openssh ];
    installPhase = ''
      mkdir -p $out/bin
      echo "#! ${stdenv.shell}" >> $out/bin/cluster
      echo "export GUM_CHOOSE_CURSOR_FOREGROUND=${base0D}" >> $out/bin/cluster
      cat cluster.sh >> $out/bin/cluster
      chmod +x $out/bin/cluster
    '';
  };
in
{
  environment.systemPackages = [cluster];
}
