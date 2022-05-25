{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    neovim.url = "github:nix-community/neovim-nightly-overlay";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    base16.url = "github:SenchoPens/base16.nix";
    base16.inputs.nixpkgs.follows = "nixpkgs";
    base16-nord-scheme = {
      url = github:ada-lovecraft/base16-nord-scheme;
      flake = false;
    };
    base16-gruvbox-scheme = {
      url = github:dawikur/base16-gruvbox-scheme;
      flake = false;
    };
    base16-zathura = {
      url = github:haozeke/base16-zathura;
      flake = false;
    };
    doom-emacs = {
      url = github:hlissner/doom-emacs;
      flake = false;
    };
    dotfiles = {
      url = "github:IllustratedMan-code/dotfiles";
      flake = false;
    };
  };


  outputs = inputs@{ self, nixpkgs, ... }: {
   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [ ./configuration.nix ./home.nix ];
   };
  };
  }
