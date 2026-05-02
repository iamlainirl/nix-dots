{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ll = "eza -lah --group-directories-first";
            la = "eza -la --group-directories-first";
            ports = "ss -tulpn";
            myip = "curl ifconfig.me";
            rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
            flake update = "nix flake update ~/nix-config";

        };
        initExtra = '';
          bindkey -e 
        '';
      };
      programs.starship = {
          enable = true;
          enableZshIntegration = true;
      };
  }
