{
  inputs = {
    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    nixpkgs-stable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-24.11";
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
    overlays = [
      neovim-nightly-overlay.overlays.default
      (final: prev: {
        stable = import nixpkgs-stable {
          system = prev.system;
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
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };

    homeConfigurations.talib = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs-unstable {
        inherit system overlays;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [./home.nix];
    };
  };
}
