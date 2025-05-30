{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
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
    home-manager,
    neovim-nightly-overlay,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    overlays = [
      neovim-nightly-overlay.overlays.default
      (final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
  in {
    nixosConfigurations.nixos = nixpkgs-unstable.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        {
          nixpkgs.pkgs = pkgs-unstable;
          nixpkgs.overlays = overlays;
        }
      ];
    };

    homeConfigurations.talib = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;
      extraSpecialArgs = {inherit inputs;};
      modules = [./home.nix];
    };
  };
}
