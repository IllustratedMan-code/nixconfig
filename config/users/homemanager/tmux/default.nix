{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/config/users/homemanager/tmux/.tmux.conf";
}
