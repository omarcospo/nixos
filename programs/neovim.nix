{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      #
      bun
      #TYPST
      typstyle
      tinymist
      #NIX
      alejandra
      # LUA
      stylua
      lua-language-server
      # PYTHON
      ruff
    ];
  };
  programs.neovide = {
    enable = true;
    settings = {
      frame = "none";
      maximized = false;
      no-multigrid = false;
      srgb = false;
      tabs = false;
      theme = "auto";
      title-hidden = true;
      vsync = false;
      wsl = false;
      font = {
        normal = [];
        size = 15.0;
      };
    };
  };
}
