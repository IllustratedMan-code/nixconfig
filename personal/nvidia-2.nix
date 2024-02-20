{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.hyprland.nvidiaPatches = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = false;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
