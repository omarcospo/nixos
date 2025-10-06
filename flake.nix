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
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    neovim-nightly-overlay,
    niri-flake,
    dankMaterialShell,
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
          nixpkgs.config.allowUnfree = true;
        }
        niri-flake.nixosModules.niri
      ];
    };

    homeConfigurations.talib = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
        {nixpkgs.config.allowUnfree = true;}
        niri-flake.homeModules.niri
        dankMaterialShell.homeModules.dankMaterialShell.default
        dankMaterialShell.homeModules.dankMaterialShell.niri
      ];
    };
  };
}
