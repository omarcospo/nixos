{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    gnome-console
    gnome-photos
    gnome-tour
    gnome-text-editor
    cheese
    gnome-music
    epiphany
    geary
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-maps
    gnome-weather
    gnome-contacts
    simple-scan
    gnome-shell-extensions
    gnome-system-monitor
  ];

  services.xserver.xkb = {
    layout = "br";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.talib = {
    isNormalUser = true;
    description = "talib";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05";

  # ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # System
  environment.systemPackages = with pkgs; [
    python313
    lf
    fzf
    ripgrep
    fd
    bat
    eza
    zoxide
    wl-clipboard
    stow
    win-virtio
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["talib"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.extraGroups.vboxusers.members = ["talib"];

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = lib.makeLibraryPath [pkgs.stdenv.cc.cc pkgs.zlib];
    };
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.noto
      barlow
      lora
      b612
      poppins
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      ibm-plex
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Iosevka Nerd Font"];
      };
    };
  };
}
