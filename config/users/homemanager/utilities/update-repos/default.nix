{pkgs,config, ...}:
let
  bin = pkgs.writeShellApplication {
    name="urs";
    text = ''
         ${builtins.readFile ./update.sh}

         update ${config.variables.nixconfig}
         update ${config.variables.roam}
         update ${config.variables.planner}
    '';
  };
in
{

  home.packages = [
    bin
  ];
}
