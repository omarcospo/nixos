{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # ---- Niri
  home.file.".config/Kvantum/KvLibadwaita".source = "${pkgs.fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "main";
    sha256 = "xBl6zmpqTAH5MIT5iNAdW6kdOcB5MY0Dtrb95hdYpwA=";
  }}/src/KvLibadwaita";

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

  home.file.".local/share/background-image.jpg" = {
    source = pkgs.fetchurl {
      url = "https://images.unsplash.com/photo-1641555979695-ece0d18d0ae4?ixlib=rb-4.1.0&q=85&fm=jpg&crop=entropy&cs=srgb&dl=vidit-goswami-W9fhd6qyryU-unsplash.jpg&w=2400";
      sha256 = "6Jpp2PtAs6sgEPxuc40hwQgNuC12fXnFDClAPecRxoI=";
    };
  };

  programs.niri.settings = {
    spawn-at-startup = [{sh = "wl-paste --watch cliphist store &";}];
    cursor = {theme = "Numix-Cursor";};
    prefer-no-csd = true;
    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          bottom-left = 0.0;
          bottom-right = 0.0;
          top-left = 0.0;
          top-right = 0.0;
        };
      }
    ];
    layout = {
      gaps = 15;
      background-color = "#222222";
      focus-ring.enable = false;
      border.enable = true;
      border.active.color = "#1FC7FF";
      border.width = 2;
      shadow.enable = false;
    };
    input = {
      keyboard = {
        xkb.options = "ctrl:swapcaps,altwin:swap_alt_win";
        xkb.layout = "br";
        repeat-delay = 200;
        repeat-rate = 45;
        numlock = true;
      };
    };
    binds = {
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.reset-window-height = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+Q".action.close-window = {};
      "Mod+C".action.center-column = {};
      "Mod+A".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+D".action.focus-column-right = {};
      "Mod+Ctrl+A".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+D".action.move-column-right = {};
      "Mod+W".action.focus-workspace-up = {};
      "Mod+S".action.focus-workspace-down = {};
      "Mod+Ctrl+W".action.move-column-to-workspace-up = {};
      "Mod+Ctrl+S".action.move-column-to-workspace-down = {};
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+WheelScrollRight".action.focus-column-right = {};
      "Mod+WheelScrollLeft".action.focus-column-left = {};
      # --------------------------------
      "Mod+G".action.toggle-overview = {};
      "Mod+T".action.spawn = "alacritty";
      "Mod+E".action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
      "Mod+N".action.spawn = ["dms" "ipc" "call" "notepad" "toggle"];
      "Mod+V" = {action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];};
      "Mod+L" = {action.spawn = ["dms" "ipc" "call" "lock" "lock"];};
      "Mod+P" = {action.spawn = ["dms" "ipc" "call" "control-center" "toggle"];};
      "Mod+O" = {action.spawn = ["dms" "ipc" "call" "settings" "toggle"];};
      # --------------------------------
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5"];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5"];
      };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "5%+"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "5%-"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
      };
      "Home".action.screenshot = {};
      "Ctrl+Home".action.screenshot-screen = {};
      "Alt+Home".action.screenshot-window = {};
    };
  };

  # ---- Shell
  programs.dankMaterialShell.enable = true;
  programs.dankMaterialShell.enableSystemd = true;
}
