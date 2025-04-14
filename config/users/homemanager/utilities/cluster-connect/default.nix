{
  config,
  pkgs,
  inputs,
  ...
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
        export GUM_INPUT_PROMPT_FOREGROUND=${base05}
        export GUM_INPUT_PROMPT_BACKGROUND=${base01}
        export GUM_INPUT_CURSOR_FOREGROUND=${base01}
        export GUM_INPUT_CURSOR_BACKGROUND=${base05}
        export GUM_CHOOSE_HEADER_FOREGROUND=${base0A}
        export GUM_CHOOSE_SELECTED_FOREGROUND=${base0A}
        export GUM_CHOOSE_ITEM_FOREGROUND=${base05}

        ${builtins.readFile ./cluster.sh}
      '';
    };
in
{
  home.packages = [ cluster ];
}
