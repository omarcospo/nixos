{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  dconf.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.packages = with pkgs; [
    colloid-icon-theme
    kdePackages.krohnkite
    kdePackages.kdeconnect-kde
    kdePackages.bluez-qt
    kde-rounded-corners
  ];
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Breeze-Light";
      };
      iconTheme = "Colloid-Dark";
    };
    kwin = {
      virtualDesktops = {
        number = 5;
      };
    };
    shortcuts = {
      kwin = {
        "Overview" = "Meta";
        "Close Window" = "Meta+C";
        "Krohnkite: Focus Next" = "Meta+D";
        "Krohnkite: Focus Previous" = "Meta+A";
        "Krohnkite: Monocle Layout" = "Meta+F";
        "Krohnkite: Toggle Float" = "Meta+V";
        "Window One Desktop to the Right" = "Meta+Control+E";
        "Window One Desktop to the Left" = "Meta+Control+Q";
        "Switch to Previous Desktop" = "Meta+Q";
        "Switch to Next Desktop" = "Meta+E";
      };
    };
  };
}
