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

  qt = {
    enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.krohnkite
    kdePackages.kdeconnect-kde
    kde-rounded-corners
  ];
  programs.plasma = {
    enable = true;
    shortcuts = {
      kwin = {
        "Overview" = "Meta";
        "Switch to Previous Desktop" = "Meta+Q";
        "Switch to Next Desktop" = "Meta+E";
      };
    };
  };
}
