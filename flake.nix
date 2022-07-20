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
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mkSystemConfig = hostname: extra_modules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          { networking.hostName = hostname; }
          ./users/users.nix
        ] ++ extra_modules;
      };
    in
    {
      nixosConfigurations = {
        work = mkSystemConfig "work" [ ./work/hardware.nix ];
        personal = mkSystemConfig "personal" [ ./personal/hardware.nix ];
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
