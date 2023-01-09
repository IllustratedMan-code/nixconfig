{ config, pkgs, inputs, ... }:
{
  imports = [ ./nvidia.nix ./hardware-configuration.nix ];
  boot.loader.grub.useOSProber = true;
}
