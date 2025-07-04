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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.excludePackages = [pkgs.xterm];

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
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

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
    python313Full
    ((pkgs.ffmpeg.override {
        withUnfree = true;
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
    libreoffice-fresh
    lua
    typst
    openconnect
    networkmanager-openconnect
    globalprotect-openconnect
    # GUI
    librewolf-bin
    protonvpn-gui
    bleachbit
    onlyoffice-desktopeditors
    luminance
    tenacity
    anytype
    bottles
    lunacy
    gearlever
    mission-center
    qbittorrent
    kdePackages.kdenlive
    google-chrome
    ocenaudio
    p7zip
    droidcam
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
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
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
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
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
      open-dyslexic
    ];
    fontconfig = {
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
