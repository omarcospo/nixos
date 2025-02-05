{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
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
  ];
}
