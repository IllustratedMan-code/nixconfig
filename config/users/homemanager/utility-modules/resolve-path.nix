{ lib, config, ... }:
let
  nixconfig = "${config.home.homeDirectory}/nixconfig";
  splitString = path: builtins.head (builtins.match "/nix/store/.*?(/.*)" (toString path));
  resolvePath = path: (nixconfig + (toString path));
in
{
  options.pathUtils = {
    resolvePath = lib.mkOption {
      default = path: resolvePath;
      readOnly = true;
    };
    symlink = lib.mkOption {
      default = path: config.lib.file.mkOutOfStoreSymlink (resolvePath path);
      readOnly = true;
    };
  };

}
