{ config, pkgs, inputs, ...}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  users.users.david = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
  home-manager.users.david.imports = [./homemanager/david.nix];
  home-manager.users.david.home.stateVersion = config.system.stateVersion;
 
}
