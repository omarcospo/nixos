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
      disable-user-extensions = false; # enables user extensions
      disable-extension-version-validation = true;
      enabled-extensions = with pkgs; [
        gnomeExtensions.forge.extensionUuid
        gnomeExtensions.just-perfection.extensionUuid
        gnomeExtensions.appindicator.extensionUuid
        gnomeExtensions.clipboard-indicator.extensionUuid
        gnomeExtensions.quick-settings-audio-panel.extensionUuid
        gnomeExtensions.alphabetical-app-grid.extensionUuid
      ];
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
    gnomeExtensions.app-icons-taskbar
    # GENERAL LANGUAGE
    nodejs_22
    biome
    #GO
    go
    gopls
    gofumpt
    goimports-reviser
    wails
    #LUA
    lua
    stylua
    lua-language-server
    #TYPST
    typst
    typstyle
    typst-lsp
    #NIX
    alejandra
    # TYPESCRIPT
    nodePackages.typescript-language-server
    # PYTHON
    python312
    ruff
    python312Packages.jedi-language-server
    # SHELL
    shellcheck
    #MARKDOWN
    mdformat
  ];

  programs.home-manager.enable = true;
}
