{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    niri-flake.url = "github:sodiboo/niri-flake";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    neovim-nightly-overlay,
    niri-flake,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "qtwebengine-5.15.19"
      ];
    };
    overlays = [
      inputs.niri-flake.overlays.niri
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
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfree = true; # This line was added
        }
        niri-flake.nixosModules.niri
      ];
    };

    homeConfigurations.talib = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
        {
          nixpkgs.config.allowUnfree = true; # This line was added for Home Manager
        }
        niri-flake.homeModules.niri
      ];
    };
  };
}
