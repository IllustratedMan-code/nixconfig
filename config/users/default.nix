{ config
, pkgs
, inputs
, specialArgs
, ...
}:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./david.nix
  ];
  home-manager.extraSpecialArgs = specialArgs // {
    scheme = config.scheme;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.sharedModules = [ ./homemanager/shared.nix ];
}
