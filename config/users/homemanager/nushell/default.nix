{ config, ... }:
let
  symlink-path =
    path: "${config.home.homeDirectory}/nixconfig/config/users/homemanager/nushell/${path}";
in
{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "hx";
        nrs = "sudo nixos-rebuild switch --flake ~/nixconfig";
        fzfp = "fzf --style full --preview 'fzf-preview {}'";
        bfzf = "bat (fzf)";
      };
    };
  };

}
