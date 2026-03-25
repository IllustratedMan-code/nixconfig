# This file should only contain a basic list of system packages
{ config, pkgs, inputs, system, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    firefox
    wl-clipboard
    zip
    gnumake
    inputs.project-jump.packages.${system}.default
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

}
