{ ... }:

{
  programs.git = {
      enable = true;
      

      settings = {
          user = {
              name = "iamlainirl";
              email = "scdndhppthghts@gmail.com";
          };

          init = {
              defaultBranch = "main";
          };

          pull = {
              rebase = false;
          };

          core = {
              editor = "nvim";
          };
      };

  };
}
