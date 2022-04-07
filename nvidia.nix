{ pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  environment.systemPackages = [ nvidia-offload ];
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
    sync.allowExternalGpu = true;
  };
  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
  specialisation = {
    egpu.configuration = {
      hardware.nvidia.modesetting.enable = pkgs.lib.mkForce false;
      hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
      hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
      services.xserver.config = pkgs.lib.mkOverride 0
        ''
        Section "ServerLayout"
            Identifier     "layout"
            Screen      0  "nvidia" 0 0
            Inactive       "intel"
        EndSection

        Section "Monitor"
            Identifier     "Monitor0"
        EndSection

        Section "Device"
            Identifier     "intel"
            Driver         "modesetting"
            Option         "AccelMethod" "none"
            BusID          "PCI:0:2:0"
        EndSection

        Section "Device"
            Identifier     "nvidia"
            Driver         "nvidia"
            VendorName     "NVIDIA Corporation"
            BusID          "PCI:47:0:0"
            Option         "AllowEmptyInitialConfiguration"
            Option         "AllowExternalGpus" "true"
            Option         "PrimaryGPU" "true"
        EndSection

        Section "Screen"
            Identifier     "nvidia"
            Device         "nvidia"
            Monitor        "Monitor0"
        EndSection

        '';

    };
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
      hardware.nvidia.prime.sync.enable = lib.mkForce true;
    };

  };
}
