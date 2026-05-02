{ pkgs, ... }:

{
    home.packages = with pkgs; [
      btop
      htop 
      ripgrep
      fd
      bat 
      eza 
      fzf 
      jq 
      yq 
      tree 
      unzip 
      wget 
      curl 

      dig 
      nmap
      mtr 
      tcpdump 
      iperf3 
      whois 

      git 
      gcc 
      gnumake 
      cmake 
      go 
      python3 
      nodejs 

      lazydocker 

      yazi 

      firefox
      chromium
      thunar
      krita
      obsidian
    ];
  }
