{
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      (final: prev: {
        stable = import nixpkgs-stable {
          system = prev.system;
          config.allowUnfree = true;
        };
      })
    ];
  in {
    nixosConfigurations.nixos = nixpkgs-unstable.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [./configuration.nix];
    };
    homeConfigurations.talib = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs-unstable.legacyPackages."x86_64-linux";
      extraSpecialArgs = {inherit inputs;};
      modules = [
        {
          nixpkgs.overlays = overlays;
        }
        ./home.nix
      ];
    };
  };
}
