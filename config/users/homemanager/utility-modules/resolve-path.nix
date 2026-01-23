{ lib, config, ... }:
let
  homeconfig = "${config.home.homeDirectory}/nixconfig/config/users/homemanager";
  splitString = path: builtins.head (builtins.match "/nix/store/.*?(/.*)" (toString path));
  resolvePath = rel_to_home: path: (homeconfig + "/${rel_to_home}/" + (splitString (toString path)));
in
{
  options.pathUtils = {
    resolvePath = lib.mkOption {
      default = path: resolvePath;
      readOnly = true;
    };
    symlink = lib.mkOption {
      default = rel_to_home: path: config.lib.file.mkOutOfStoreSymlink (resolvePath rel_to_home path);
      readOnly = true;
    };
  };

}
