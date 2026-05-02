{ config, pkgs, ... }:

{
    imports = [
      ./packages.nix 
      ./git.nix 
      ./terminal.nix 
      ./desktop.nix 
    ];

    home.username = "reiru";
    home.homeDirectory = "/home/reiru";

    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    home.sessionVariables = {
        EDITOR = "nvim";
        MOZ_ENABLE_WAYLAND = "1";
        XCURSOR_SIZE = "24";
        HYPRCCURSOR_SIZE = "24";
      };
  }
