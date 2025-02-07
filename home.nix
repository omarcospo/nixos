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
    python312Packages.jedi-language-server
    # APPS
    unstable.neovide
    unstable.lunacy
    unstable.anytype
    unstable.firefox-beta
    mission-center
    qbittorrent
    kdenlive
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

  home = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
    };
  };
  programs.home-manager.enable = true;
}
