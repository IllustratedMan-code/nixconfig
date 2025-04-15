{ lib, config, ... }:
let
  cfg = config.emacsLib;
  fullpath = Path: "${config.home.homeDirectory}/nixconfig/config/users/homemanager/emacs/${Path}";
  makeConfig = Path: ({
    ".emacs.d/${Path}".source = config.lib.file.mkOutOfStoreSymlink (fullpath Path);
  });
in
{

  options.emacsLib = {
    useFiles = lib.mkOption {
      default = [ ];
    };

    makeSymlink = lib.mkOption {
      default = Path: config.lib.file.mkOutOfStoreSymlink (fullpath Path);
      readOnly = true;
    };
  };

  config =
    let
      configFiles = (
        builtins.foldl' (x: y: x // y) { } (builtins.map makeConfig config.emacsLib.useFiles)
      );
      usepackage =
        Path:
        ''(use-package ${(lib.removeSuffix ".el" (builtins.baseNameOf Path))} :load-path "${(builtins.dirOf Path)}/")'';

      sourcelines = builtins.foldl' (x: y: "${x}\n${y}") "" (
        builtins.map (x: usepackage x) config.emacsLib.useFiles
      );
    in
    {
      home.file = configFiles;

      xdg.configFile."emacs/niximports.el".text = ''
        ${sourcelines}
        (provide 'niximports)
      '';
    };
}
