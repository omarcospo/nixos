{
  config,
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}: let
  hostsFile = pkgs.fetchFromGitHub {
    owner = "StevenBlack";
    repo = "hosts";
    rev = "36d7958e582132b6edee229be1a42c89869400de";
    sha256 = "nNfRcWqETuuAwKqjAxP8+b7L+CHWEkjLZHHIY3cOcrk=";
  };
  youtubeHosts = builtins.fetchurl {
    url = "https://gist.githubusercontent.com/omarcospo/216a26f5f8c97549f8b32d50238f77fc/raw/aa0a0782426582dfe312da7f3486c3dae680d9da/BlockYouTubeHostsFile";
    sha256 = "0p1fcqpzrgibas1p7xb20q5d4hmqcwdf9vizkg7ldvwb9lyz6mkw";
  };
in {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "0";
      efi.canTouchEfiVariables = true;
    };
    # Set kernel parameters for silent boot
    plymouth.enable = true;
    plymouth.theme = "bgrt";
    kernelParams = ["quiet" "loglevel=0" "splash"];
    consoleLogLevel = 0;
  };

  # Reduce disk usage
  boot.loader.systemd-boot.configurationLimit = 5;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  nix.settings.auto-optimise-store = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [intel-media-driver intel-vaapi-driver];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  # Network
  networking.extraHosts =
    ''
    ''
    # ${builtins.readFile "${hostsFile}/alternates/porn-only/hosts"}
    # ${builtins.readFile youtubeHosts}
    ;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    # KDE Connect
    allowedTCPPortRanges.to = 1714;
    allowedTCPPortRanges.from = 1764;
    allowedUDPPortRanges.to = 1714;
    allowedUDPPortRanges.from = 1764;
  };

  time.timeZone = "America/Sao_Paulo";

  console.keyMap = "br-abnt2";
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

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_MIN_FREQ_ON_AC = 1500000;
      CPU_SCALING_MAX_FREQ_ON_AC = 2400000;
      CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";
    };
  };

  services.fstrim.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {General = {Experimental = true;};};
  };

  services.displayManager.gdm.enable = true;

  programs.kdeconnect.enable = true;

  services.gvfs.enable = true; # Mount android
  programs.adb.enable = true; # Android ADB

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  services.xserver.xkb = {layout = "br";};

  users.users.talib = {
    isNormalUser = true;
    description = "talib";
    extraGroups = ["networkmanager" "wheel" "adbusers"];
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05";

  # ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # BUILDING DEPENDENCIES
    gnumake
    ninja
    gcc
    binutils
    uv
    # CLI TOOLS
    lf
    fzf
    ripgrep
    sd
    fd
    bat
    eza
    dua
    zoxide
    wl-clipboard
    stow
    grimblast
    slurp
    hyprpicker
    grim
    zathura
    imv
    p7zip
    # NETWORK
    qbittorrent
    syncthing
    # PRODUCTIVITY
    onlyoffice-desktopeditors
    kdePackages.kdenlive
    ocenaudio
    stable.calibre
    lunacy
    # CLI
    pavucontrol
    win-virtio
    foliate
    ((pkgs.stable.ffmpeg.override {withOpengl = true;}) .overrideAttrs (_: {doCheck = false;}))
    pdftk
    openconnect
    networkmanager-openconnect
    # WALLET
    monero-gui
    # PRODUCTIVITY
    ungoogled-chromium
    blanket
    # SYSTEM
    bleachbit
    bottles
    gearlever
  ];

  services = {
    syncthing = {
      enable = true;
      group = "wheel";
      user = "talib";
      dataDir = "/home/talib/Documents";
      configDir = "/home/talib/.config/syncthing";
    };
  };

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
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
  };

  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.sessionPackages = [pkgs.niri];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["talib"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.extraGroups.vboxusers.members = ["talib"];

  environment = {
    shellInit = ''
      export PATH="${pkgs.gcc}/bin:$PATH"
    '';
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LD_LIBRARY_PATH = lib.makeLibraryPath [pkgs.stdenv.cc.cc pkgs.zlib];
      QT_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      NIXOS_OZONE_WL = "1";
    };
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      nerd-fonts.iosevka
      nerd-fonts.noto
      noto-fonts-cjk-sans
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      open-dyslexic
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Iosevka Nerd Font"];
      };
    };
  };
}
