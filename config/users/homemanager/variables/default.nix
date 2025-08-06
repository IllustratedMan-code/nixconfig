{ lib, config, ... }:
{
  options.variables = {
    nixconfig = lib.mkOption {
      default = "~/nixconfig";
    };
    roam = lib.mkOption {
      default = "~/Wiki/roam-wiki";
    };
    wiki = lib.mkOption {
      default = "~/Wiki/wiki";
    };
    planner = lib.mkOption {
      default = "~/Wiki/planner";
    };
  };
  config = {
    systemd.user.sessionVariables = lib.mapAttrs (name: value: value) config.variables;
  };
}
