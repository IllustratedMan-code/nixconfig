{ config, lib, pkgs, specialArgs, inputs, ... }:
let
  stable = final: prev: { stable = import inputs.stable-nixpkgs { config.allowUnfree = true; system = "${prev.system}"; }; };
  waybar_overlay = self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      postPatch = ''
        sed -i -e 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
      '';
    });
  };
in
{
  # workaround for ardour
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    #{ domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    #{ domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    #{ domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  nixpkgs.overlays = [ inputs.emacs-overlay.overlay stable waybar_overlay ];
  users.extraGroups.vboxusers.members = [ "david" ];
  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    shell = pkgs.zsh;
    description = "David Lewis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "wireshark" ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = specialArgs // { scheme = config.scheme; };
  home-manager.users.david.imports = [ ./david.nix ];
}
