{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  hostsFile = pkgs.fetchFromGitHub {
    owner = "StevenBlack";
    repo = "hosts";
    rev = "36d7958e582132b6edee229be1a42c89869400de";
    sha256 = "nNfRcWqETuuAwKqjAxP8+b7L+CHWEkjLZHHIY3cOcrk=";
  };
in {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
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
      "quiet"
      "loglevel=0"
      "splash"
    ];
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
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  # Network
  networking.extraHosts = ''
    ${builtins.readFile "${hostsFile}/alternates/fakenews-gambling-porn-social/hosts"}
    0.0.0.0 youtube.com
    0.0.0.0 www.youtube.com
    0.0.0.0 m.youtube.com
    0.0.0.0 youtubei.googleapis.com
    0.0.0.0 youtube-nocookie.com
    0.0.0.0 ytimg.com
    0.0.0.0 ytstatic.l.google.com
  '';
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
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
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
    };
  };

  services.fstrim.enable = true;

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
  };
}
