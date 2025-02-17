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
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
