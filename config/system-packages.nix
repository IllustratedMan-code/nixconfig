# This file should only contain a basic list of system packages
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    firefox
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

}
