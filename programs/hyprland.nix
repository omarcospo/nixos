{pkgs, ...}: {
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprscroller
  ];
}
