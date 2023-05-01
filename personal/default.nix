{ config, pkgs, inputs, ... }:
{
  imports = [ ./hardware-configuration.nix ./nvidia-2.nix ];
  boot.loader.grub.useOSProber = true;
  systemd.network.wait-online.anyInterface = true;
}
