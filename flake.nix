{
  description = "NixOS configuration";

  inputs = rec {

    nix.url = github:nixos/nix;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    dotfiles = {
      url = "github:IllustratedMan-code/dotfiles";
      flake = false;
    };
    eww.url = "github:elkowar/eww";
    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };
    image-factory.url = "github:IllustratedMan-code/Image-Factory";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      colorscheme = "gruvbox-dark-medium";
      system = "x86_64-linux";
      stable-pkgs = import inputs.stable-nixpkgs { inherit system; config.allowUnfree = true; overlays = [ ]; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: { stable = stable-pkgs; })
          inputs.hyprland.overlays.default
          inputs.emacs-overlay.overlays.default
        ];
      };
      mkSystemConfig = hostname: extra_modules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          inputs.base16.nixosModule
          { scheme = "${inputs.base16-schemes}/${colorscheme}.yaml"; }
          ./configuration.nix
          {
            networking.hostName = hostname;
            nixpkgs.overlays = [

              (final: prev: { stable = stable-pkgs; })
              inputs.hyprland.overlays.default
              inputs.emacs-overlay.overlays.default
            ];

          }
          ./users/users.nix
          inputs.hyprland.nixosModules.default
          { programs.hyprland = { enable = true; }; }
        ] ++ extra_modules;
      };
    in
    {
      nixosConfigurations = {
        work = mkSystemConfig "work" [ ./work ];
        personal = mkSystemConfig "personal" [ ./personal ];
      };
      packages."${system}" = with pkgs;
        let
          install = install_script: stdenv.mkDerivation {
            name = "install";
            src = self;
            installPhase = ''
              mkdir $out/bin
              echo "nixos-install --flake $src" >> $out/bin/install
              cat ${install_script} >> $out/bin/install
              chmod +x $out/bin/install
            '';
          };
        in
        {
          work_laptop = install ./install/install.sh;
          personal_laptop = install ./install/install.sh;
        };
    };
}
