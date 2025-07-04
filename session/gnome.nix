{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  home.packages = with pkgs; [
    gnomeExtensions.speedinator
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.gsconnect
    gnomeExtensions.steal-my-focus-window
    gnomeExtensions.color-picker
    gnomeExtensions.caffeine
    gnomeExtensions.forge
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.tiling-assistant
    gnome-extension-manager
    dconf-editor
  ];

  home.file.".config/Kvantum/KvLibadwaita".source = "${pkgs.fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "main";
    sha256 = "xBl6zmpqTAH5MIT5iNAdW6kdOcB5MY0Dtrb95hdYpwA=";
  }}/src/KvLibadwaita";

  home.file.".local/share/background-image.jpg" = {
    source = pkgs.fetchurl {
      url = "https://images.unsplash.com/photo-1542816417-0983c9c9ad53?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&dl=ashkan-forouzani-7blIFp0kFP4-unsplash.jpg";
      sha256 = "00dzmi3zchbq0hwmpv7pb0bmvscpqb69d8q6s8b65fics5pkpjbp";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "KvLibadwaitaDark";
  };

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
      picture-uri = "file://${config.home.homeDirectory}/.local/share/background-image.jpg";
      picture-uri-dark = "file://${config.home.homeDirectory}/.local/share/background-image.jpg";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${config.home.homeDirectory}/.local/share/background-image.jpg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      enabled-extensions = with pkgs.gnomeExtensions; [
        speedinator.extensionUuid
        blur-my-shell.extensionUuid
        appindicator.extensionUuid
        clipboard-indicator.extensionUuid
        quick-settings-audio-panel.extensionUuid
        alphabetical-app-grid.extensionUuid
        forge.extensionUuid
        gsconnect.extensionUuid
        steal-my-focus-window.extensionUuid
        color-picker.extensionUuid
        vitals.extensionUuid
        rounded-window-corners-reborn.extensionUuid
        caffeine.extensionUuid
        tiling-assistant.extensionUuid
        forge.extensionUuid
        bluetooth-battery-meter.extensionUuid
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
      toggle-maximized = ["<Super>f"];
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
}
