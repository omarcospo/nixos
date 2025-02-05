{
  inputs,
  config,
  pkgs,
  ...
}: let
  chromium = pkgs.ungoogled-chromium.override {
    commandLineArgs = "--force-device-scale-factor=1.10";
  };
in {
  home.username = "talib";
  home.homeDirectory = "/home/talib";
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./programs/alacritty.nix
    ./programs/vscodium.nix
    ./programs/neovim.nix
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/mpv.nix
    ./programs/yt-dlp.nix
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
      enable-hot-corners = true;
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
      enabled-extensions = with pkgs.gnomeExtensions; [
        speedinator.extensionUuid
        appindicator.extensionUuid
        clipboard-indicator.extensionUuid
        quick-settings-audio-panel.extensionUuid
        alphabetical-app-grid.extensionUuid
        paperwm.extensionUuid
        gsconnect.extensionUuid
        steal-my-focus-window.extensionUuid
        color-picker.extensionUuid
      ];
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["ctrl:nocaps" "ctrl:rctrl" "altwin:swap_lalt_lwin"];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-right = ["<Super>e"];
      switch-to-workspace-left = ["<Super>q"];
      move-to-workspace-right = ["<Super><Ctrl>e"];
      move-to-workspace-left = ["<Super><Ctrl>q"];
      close = ["<Super>c"];
      toggle-fullscreen = ["<Super>f"];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      volume-down = ["<Ctrl>F2"];
      volume-up = ["<Ctrl>F3"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Alacritty";
      command = "alacritty";
      binding = "<Super>w";
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.speedinator
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.gsconnect
    gnomeExtensions.steal-my-focus-window
    gnomeExtensions.color-picker
    gnomeExtensions.paperwm
    gnome-extension-manager
    dconf-editor
    # LANGUAGES
    lua
    typst
    python312Packages.jedi-language-server
    # APPS
    unstable.neovide
    unstable.lunacy
    unstable.chromium
    unstable.anytype
    mission-center
    qbittorrent
    onlyoffice-desktopeditors
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # fix python packages not being recognized
  home = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  programs.home-manager.enable = true;
}
