{ config
, pkgs
, inputs
, ...
}:
{
  imports = [
    ./wine.nix
    ./configuration.nix
    ./system-packages.nix
    ./users
    ./cache.nix
    ./theme
    ./vaapi.nix
    ./laptop.nix
    ./theme/theme_specializations.nix
    ./lix.nix
  ];
}
