{
  description = "Illustratedman-code's NixOS configuration";

  inputs = {
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    stylix.url = "github:danth/stylix/release-25.05";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    plover-flake.url = "github:openstenoproject/plover-flake";
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
      specialArgs = {
        inherit system;
        inherit inputs;
        inherit colorscheme;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      nixosConfigurations."iso" = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules =
          [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ];
      };
      nixosConfigurations."davidnix" = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules =  modules ++ [ ./config/hardware-configuration.nix ./config/steammachine/steam.nix];
      };
      nixosConfigurations."davidnixusb" = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules =  modules ++ [ ./config/usb-hardware-config.nix ];
      };

      nixosConfigurations."stixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = ./config/steammachine;
      };
      packages.${system}.iso = self.nixosConfigurations.iso.config.system.build.isoImage;
    };
}
