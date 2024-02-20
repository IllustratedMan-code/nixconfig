{ config, pkgs, inputs, ... }:
{
  imports = [ ./hardware-configuration.nix ./nvidia-2.nix ./cluster ];
  boot.loader.grub.useOSProber = true;
  systemd.network.wait-online.anyInterface = true;
}
