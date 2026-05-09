{ pkgs, ... }:

{
    home.packages = with pkgs; [
      btop
      ripgrep
      fd
      bat
      eza
      fzf
      jq
      yq
      tree
      unzip
      neovim

      pciutils
      usbutils
      lshw
      dmidecode
      ethtool

      iw
      wirelesstools
      traceroute
      netcat-gnu
      openssl
      wireguard-tools
      rsync

      nil
      nh 
      nix-output-monitor
      nixfmt-rfc-style

      gcc
      gnumake
      cmake
      go
      python3
      nodejs

      lazydocker
      docker-compose

      yazi
      fastfetch

      firefox
      chromium
      krita
      obsidian

      grim
      slurp
      wl-clipboard
      cliphist
      swappy
      wlogout
      pavucontrol
      playerctl


    ];
  }
