# This file should only contain a basic list of system packages
{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    ripgrep
    firefox
  ];
}
