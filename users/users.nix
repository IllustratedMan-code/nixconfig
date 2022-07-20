{ config, lib, pkgs, specialArgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.neovim.overlay inputs.emacs-overlay.overlay ];
  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    shell = pkgs.zsh;
    description = "David Lewis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = specialArgs;
  home-manager.users.david = import ./david.nix;
}
