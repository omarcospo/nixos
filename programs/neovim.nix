{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      #
      nodejs
      gcc
      bun
      #TYPST
      typst
      typstyle
      tinymist
      #NIX
      alejandra
      # LUA
      lua
      stylua
      lua-language-server
      # PYTHON
      uv
      python314
      ruff
      # Markdown
      marksman
    ];
  };
}
