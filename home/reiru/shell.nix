{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            cat = "bat";
            ll = "eza -lah --group-directories-first";
            la = "eza -la --group-directories-first";
            ports = "ss -tulpn";
            myip = "curl ifconfig.me";
            rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
            flake-update = "nix flake update ~/nix-config";
            lt = "eza --tree --level=2 --icons";
            hyprconf = "nvim ~/nix-config/home/reiru/hypr/hyprland.conf";
            waybarconf = "nvim ~/nix-config/home/reiru/waybar/config.jsonc";
            waybarstyle = "nvim ~/nix-config/home/reiru/waybar/style.css";
            pkgs = "nvim ~/nix-config/home/reiru/packages.nix";

        };
        initExtra = '';
          bindkey -e 
        '';
      };
      programs.starship = {
          enable = true;
          enableZshIntegration = true;

      };

      programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

  }
