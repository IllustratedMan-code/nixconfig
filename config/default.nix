{ config, pkgs, inputs,... }:
{
imports = [./configuration.nix ./hardware-configuration.nix ./system-packages.nix ./users ./cache.nix];
}
