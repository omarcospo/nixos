{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = false;
    shellAliases = {
      uh = "home-manager switch --flake ~/.nixos --show-trace -L -v";
      us = "sudo nixos-rebuild switch --flake ~/.nixos --show-trace -L -v";
      uu = "sudo nix flake update --flake ~/.nixos && sudo nixos-rebuild switch --flake ~/.nixos --show-trace -L -v && home-manager switch --flake ~/.nixos --show-trace -L -v";
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
      source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
      source ~/.config/zsh/extra
      nix-fetch() {
        nix-hash --type sha256 --base32 --flat <(curl -o - "$@") | wl-copy
      }
    '';
  };
}
