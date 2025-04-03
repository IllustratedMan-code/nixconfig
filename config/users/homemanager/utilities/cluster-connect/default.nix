{ config
, pkgs
, inputs
, ...
}:
with config.lib.stylix.colors.withHashtag;
let
  cluster =
    with pkgs;
    pkgs.writeShellApplication {

      runtimeInputs = [
        gum
        openssh
      ];

      name = "bmicluster";
      text = ''
        export GUM_CHOOSE_CURSOR_FOREGROUND=${base0D}
        export FOREGROUND=${base05}
        export BACKGROUND=${base01}
        ${builtins.readFile ./cluster.sh}
      '';
    };
in
{
  home.packages = [ cluster ];
}
