{ config
, pkgs
, inputs
, ...
}:
{
  imports = [
    ./configuration.nix
    ./system-packages.nix
    ./users
    ./cache.nix
    ./theme
    ./vaapi.nix
    ./laptop.nix
  ];
}
