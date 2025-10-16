{
  inputs,
  config,
  pkgs,
  ...
}: let
  importDir = dir: let
    files = builtins.readDir dir;
    nixFiles =
      builtins.filter (name: builtins.match ".*\\.nix" name != null)
      (builtins.attrNames files);
  in
    map (file: dir + "/${file}") nixFiles;
in {
  home.username = "talib";
  home.homeDirectory = "/home/talib";
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  imports =
    (importDir ./programs)
    ++ [
      ./session/niri.nix
    ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/x-pdf" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
    };
  };

  programs.home-manager.enable = true;
}
