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
      nodejs
      gcc
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
}
