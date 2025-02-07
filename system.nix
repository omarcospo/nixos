{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  hosts = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-only/hosts";
    sha256 = "zvPPF90hdh0d1D+6wb4WA9hfIupnGjFcvFs3PmEvIgY=";
  };
in {
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
      "loglevel=0" # Limits kernel log output (0 = emergency, 7 = debug)
      "splash" # Enables splash screen (if using Plymouth)
    ];
    consoleLogLevel = 0; # 0 = no console output, 7 = debug
  };

  # Reduce disk usage
  boot.loader.systemd-boot.configurationLimit = 5;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  nix.settings.auto-optimise-store = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = builtins.readFile hosts;
  networking.firewall = {
    enable = false;
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

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  console.keyMap = "br-abnt2";

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
      CPU_SCALING_MIN_FREQ_ON_AC = 2500000;
      CPU_SCALING_MAX_FREQ_ON_AC = 3600000;
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };
}
