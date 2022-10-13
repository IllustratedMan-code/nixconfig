{ config, pkgs, inputs, ... }:
{
  imports = [ ];
  boot.loader.grub.useOSProber = true;
}
