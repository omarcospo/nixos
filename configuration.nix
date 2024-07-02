{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-text-editor
    ])
    ++ (with pkgs.gnome; [
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
    ]);

  services.xserver.xkb = {
    layout = "br";
    variant = "nodeadkeys";
  };

  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marcos = {
    isNormalUser = true;
    description = "Marcos Felipe";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "24.05"; # Did you read the comment?

  # Fix python problem with packages requiring libstdc++.so.6
  # environment = {
  #   sessionVariables = {
  #     LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH";
  #   };
  # };

  # ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # System
  environment.systemPackages = let
    pythonEnv = pkgs.python3.withPackages (ps:
      with ps; [
        numpy
        pandas
        matplotlib
        seaborn
        plotly
      ]);
  in
    with pkgs; [
      pythonEnv
      lf
      fzf
      ripgrep
      fd
      bat
      eza
      zoxide
      wl-clipboard
      alacritty
      stow
    ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Iosevka"];})
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
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
