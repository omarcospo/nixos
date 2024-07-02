{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [./configuration.nix];
    };
    homeConfigurations.marcos = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {inherit inputs;};
      modules = [{nixpkgs.overlays = overlays;} ./home.nix];
    };
  };
}
