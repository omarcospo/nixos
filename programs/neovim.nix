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
      biome
      #TYPST
      typstyle
      typst-lsp
      #NIX
      alejandra
      # GO
      gopls
      gofumpt
      goimports-reviser
      # LUA
      stylua
      lua-language-server
      # TYPESCRIPT
      nodePackages.typescript-language-server
      # PYTHON
      ruff
      # SHELL
      shellcheck
      #MARKDOWN
      mdformat
    ];
  };
}
