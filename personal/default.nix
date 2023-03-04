{ config, pkgs, inputs, ... }:
{
  imports = [ ./nvidia.nix ./hardware-configuration.nix ];
  boot.loader.grub.useOSProber = true;
  programs.hyprland.nvidiaPatches = true;
  systemd.network.wait-online.anyInterface = true;
}
