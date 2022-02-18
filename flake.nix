{
    description = "NixOS configuration";

    inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    neovim.url = "github:neovim/neovim?dir=contrib";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    base16.url = "github:SenchoPens/base16.nix";
    base16.inputs.nixpkgs.follows = "nixpkgs";
    base16-nord-scheme = {
        url = github:ada-lovecraft/base16-nord-scheme;
        flake = false;
    };
    base16-zathura = {
        url = github:haozeke/base16-zathura;
        flake = false;
    };
};


    outputs = inputs@{self, base16, home-manager, nixos-hardware, nixpkgs, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
          base16.nixosModule
          home-manager.nixosModules.home-manager
          ./nvidia.nix
          {scheme = "${inputs.base16-nord-scheme}/nord.yaml";}
          ./theming.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./david.nix;
          }
        ];
      };
    };
  };
}
