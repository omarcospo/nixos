{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "omarcospo";
    userEmail = "marcos.felipe@usp.br";
    signing.format = "ssh";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
