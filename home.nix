{
  inputs,
  config,
  pkgs,
  ...
}: {
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
    ./session/gnome.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    # LANGUAGES
    lua
    typst
    # APPS
    lunacy
    anytype
    gearlever
    mission-center
    qbittorrent
    kdePackages.kdenlive
    onlyoffice-desktopeditors
    google-chrome
    (discord.override {
      withVencord = true;
    })
  ];

  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}/Downloads";
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true;
      DisableTelemetry = true;
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.home-manager.enable = true;
}
