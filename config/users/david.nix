{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  virtualisation.docker = {
    enable = true;
  };

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "dialout" "docker"];
  };
  home-manager.users.david.imports = [ ./homemanager/david.nix ./homemanager/plover];
  home-manager.users.david.home.stateVersion = config.system.stateVersion;

  # udev rule for plover
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

}
