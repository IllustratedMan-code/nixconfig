{
  description = "Illustratedman-code's NixOS configuration";

  inputs = {

    #nix.url = github:nixos/nix;
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    stylix.url = "github:danth/stylix/release-24.11";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      colorscheme = "everforest";
      system = "x86_64-linux";
      unstable-pkgs = import inputs.unstable-nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ ];
      };
      pkgoverlays = [
        inputs.emacs-overlay.overlays.default
        (final: prev: { unstable = unstable-pkgs; })
      ];
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations."davidnix" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit colorscheme;
        };
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = pkgoverlays;
            }
          )
          inputs.stylix.nixosModules.stylix
          ./config
        ];
      };
    };
}
