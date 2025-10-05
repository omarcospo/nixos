{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
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
    evince
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.gvfs.enable = true; # Mount android
  programs.adb.enable = true; # Android ADB

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  services.xserver.xkb = {
    layout = "br";
  };

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
    win-virtio
    # CLI
    gcc
    binutils
    gnumake
    ninja
    uv
    python313
    foliate
    ((pkgs.stable.ffmpeg.override {
        withOpengl = true;
      })
      .overrideAttrs (_: {doCheck = false;}))
    lf
    fzf
    ripgrep
    fd
    bat
    eza
    dua
    zoxide
    wl-clipboard
    stow
    lua
    typst
    pdftk
    openconnect
    networkmanager-openconnect
    pavucontrol
    # globalprotect-openconnect
    # NETWORK
    protonvpn-gui
    qbittorrent
    blueman
    # WALLET
    monero-gui
    # PRODUCTIVITY
    calibre
    logseq
    onlyoffice-desktopeditors
    wpsoffice
    ocenaudio
    anytype
    lunacy
    papers
    blanket
    kdePackages.kdenlive
    # SYSTEM
    bleachbit
    bottles
    gearlever
    mission-center
    p7zip
    fuzzel
    swaylock
    mako
    swayidle
  ];

  services = {
    syncthing = {
      enable = true;
      group = "wheel";
      user = "talib";
      dataDir = "/home/talib/Documents";
      configDir = "/home/talib/.config/syncthing";
      settings = {
        devices = {
          "phone" = {id = "EGBYA4F-ARUU3RK-S7UIV2F-KZNTWMJ-E7NSTDO-LPSWDGY-WCI2CIX-SSLIWQO ";};
        };
      };
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
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};
  programs.waybar.enable = true; # top bar

  # Add Niri to desktop manager sessions
  services.displayManager.sessionPackages = [
    pkgs.niri
  ];

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
      nerd-fonts.iosevka
      nerd-fonts.noto
      noto-fonts
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
