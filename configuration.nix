{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  # Enable the KDE Desktop Environment.
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.autoNumlock = true;
    defaultSession = "plasma";
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];
  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # environment.gnome.excludePackages = with pkgs; [
  #   gnome-connections
  #   gnome-console
  #   gnome-photos
  #   gnome-tour
  #   gnome-text-editor
  #   cheese
  #   gnome-music
  #   epiphany
  #   geary
  #   gnome-characters
  #   totem
  #   tali
  #   iagno
  #   hitori
  #   atomix
  #   yelp
  #   gnome-maps
  #   gnome-weather
  #   gnome-contacts
  #   simple-scan
  #   gnome-shell-extensions
  #   gnome-system-monitor
  # ];

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
  system.stateVersion = "24.11";

  # ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # System
  environment.systemPackages = with pkgs; [
    python312
    lf
    fzf
    ripgrep
    fd
    bat
    eza
    zoxide
    wl-clipboard
    stow
    gcc14
    win-virtio
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["talib"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.extraGroups.vboxusers.members = ["talib"];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Iosevka" "Noto"];})
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
