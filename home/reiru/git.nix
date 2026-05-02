{ ... }:

{
  programs.git = {
      enable = true;

      userName = "iamlainirl";
      userEmail = "scdndhppthghts@gmail.com";

      extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = false;
          core.editor = "nvim";
      };
    };
}
