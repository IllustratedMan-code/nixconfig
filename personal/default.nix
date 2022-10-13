{ config, pkgs, inputs, ... }:
{
  imports = [ nvidia.nix ];
  boot.loader.grub.useOSProber = true;
}
