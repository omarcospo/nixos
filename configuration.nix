{
  config,
  pkgs,
  ...
}: let
  hosts = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts";
    sha256 = "NCGRGJzEaHPLr+hpDfeYp1AhTwNvTSzYrKJTQlZ/Fwg=";
  };
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "0";
      efi.canTouchEfiVariables = true;
    };
    # Set kernel parameters for silent boot
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    kernelParams = [
      "quiet" # Suppresses most boot messages
      "loglevel=3" # Limits kernel log output (0 = emergency, 7 = debug)
      "splash" # Enables splash screen (if using Plymouth)
    ];
    consoleLogLevel = 0; # 0 = no console output, 7 = debug
  };

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = builtins.readFile hosts;

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

  # Reduce disk usage
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1d";
  };
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver

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

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 75;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wifi wwan";
    };
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

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

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
