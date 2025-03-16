{
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # ms-python.python
        ms-toolsai.jupyter
        esbenp.prettier-vscode
        asvetliakov.vscode-neovim
        piousdeer.adwaita-theme
      ];
      userSettings = {
        # Font
        "editor.fontFamily" = "'IosevkaTerm Nerd Font'";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 17;
        "notebook.output.fontFamily" = "'IosevkaTerm Nerd Font'";
        # Window
        "window.title" = "''\${rootName}";
        "window.titleBarStyle" = "custom";
        "workbench.sideBar.location" = "right";
        "editor.minimap.enabled" = false;
        "breadcrumbs.enabled" = false;
        "notebook.lineNumbers" = "on";
        # Security
        "security.workspace.trust.banner" = "never";
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        # Theming
        "workbench.colorTheme" = "Adwaita Dark";
        "workbench.productIconTheme" = "adwaita";
        # Language
        "python.defaultInterpreterPath" = "~/.local/python/bin/python";
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
      };
    };
  };
}
