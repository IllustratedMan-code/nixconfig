{ config, pkgs, inputs, ... }:
{
  imports =
    [
      #don't need it for now
      #citrix.nix
      ./hardware.nix
      ./cluster
    ];
}
