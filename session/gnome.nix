{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  gnomeExts = with pkgs.gnomeExtensions; [
    speedinator
    appindicator
    clipboard-indicator
    quick-settings-audio-panel
    alphabetical-app-grid
    gsconnect
    steal-my-focus-window
    color-picker
    caffeine
    forge
    rounded-window-corners-reborn
    bluetooth-battery-meter
    tiling-assistant
    cronomix
    impatience
    soft-brightness-plus
    gnome-bedtime
    no-time-for-caution
    tophat
  ];
in {
  home.packages = with pkgs; [gnome-extension-manager dconf-editor];

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
      enabled-extensions = map (ext: ext.extensionUuid) gnomeExts;
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
