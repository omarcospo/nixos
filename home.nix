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
    neovide
    lunacy
    anytype
    firefox
    mission-center
    qbittorrent
    stable.kdePackages.kdenlive
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

  programs.home-manager.enable = true;
}
