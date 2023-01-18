{ config, lib, pkgs, specialArgs, inputs, ... }:
let
  stable = final: prev: { stable = import inputs.stable-nixpkgs { system = "${prev.system}"; }; };
  waybar_overlay = self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  nixpkgs.overlays = [ inputs.emacs-overlay.overlay stable waybar_overlay ];
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
