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
    ./theme/theme_specializations.nix
  ];
}
