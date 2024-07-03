{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.username = "marcos";
  home.homeDirectory = "/home/marcos";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./programs/vscodium.nix
    ./programs/neovim.nix
    ./programs/zsh.nix
    ./programs/git.nix
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
    };
  };

  home.packages = with pkgs; [
    brave
    # GNOME
    gnome.gnome-tweaks
    # GNOME Extensions
    gnomeExtensions.forge
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.alphabetical-app-grid
    # LANGUAGES
    nodejs_22
    go
    wails
    lua
    typst
    # make global to be availlable in neovim and vscodium
    python312Packages.jedi-language-server
  ];

  home = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH";
    };
  };
  programs.home-manager.enable = true;
}
