{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.username = "marcos";
  home.homeDirectory = "/home/marcos";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  # programs.alacritty
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = false;
    shellAliases = {
      uh = "home-manager switch --flake ~/.nixos";
      us = "sudo nixos-rebuild switch --flake ~/.nixos";
      ee = "eza";
      qq = "clear";
      eq = "exit";
      config = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      npmi = "cd ~/.local && npm install";
    };
    initExtraFirst = ''
      setopt PROMPT_SUBST
      PROMPT='%F{yellow}[%n]%f %~ '
    '';
    initExtra = ''
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ~/.config/zsh/extra
    '';
  };

  programs.git = {
    enable = true;
    userName = "omarcospo";
    userEmail = "marcos.felipe@usp.br";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  # ...
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false; # enables user extensions
      enabled-extensions = [
        pkgs.gnomeExtensions.forge.extensionUuid
      ];
    };
  };

  home.packages = with pkgs; [
    brave
    # GNOME
    gnome.gnome-tweaks
    # GNOME Extensions
    gnomeExtensions.forge
    # GENERAL LANGUAGE
    nodejs_22
    biome
    #GO
    go
    gopls
    gofumpt
    goimports-reviser
    wails
    #LUA
    lua
    stylua
    lua-language-server
    #TYPST
    typst
    typstyle
    typst-lsp
    #NIX
    alejandra
    # TYPESCRIPT
    nodePackages.typescript-language-server
    # PYTHON
    python312
    ruff
    python312Packages.jedi-language-server
    # SHELL
    shellcheck
    #MARKDOWN
    mdformat
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}
