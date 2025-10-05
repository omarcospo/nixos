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
    ./programs/qute.nix
    ./session/gnome.nix
    ./session/niri.nix
  ];

  programs.home-manager.enable = true;
}
