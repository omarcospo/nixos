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
