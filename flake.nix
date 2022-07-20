{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dotfiles = {
      url = "github:IllustratedMan-code/dotfiles";
      flake = false;
    };
  };


  outputs = inputs@{ self, nixpkgs, ... }:
    let
      mkSystemConfig = extra_modules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ./home.nix ] ++ extra_modules;
      };
    in
    {
      nixosConfigurations = {
        work_laptop = mkSystemConfig [ ./work-hardware.nix ];
        personal_laptop = mkSystemConfig [ ./personal-hardware.nix ];
      };

    };
}
