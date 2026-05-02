{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reiru = {
    isNormalUser = true;
    description = "reiru";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  programs.zsh.enable = true;
  services.xserver.enable = false;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.getty.autologinUser = "reiru";
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.opentabletdriver.enable = true;
  hardware.uinput,enable = true;
  boot.kernelModules = [ "uinput" ];
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  programs.thunar.enable = true;
  programs.amnezia-vpn.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     chromium
     firefox

     kitty
     git
     vim
     neovim
     fastfetch
     btop
     htop
     tree
     unzip
     p7zip
     jq
     ripgrep
     fd
     fzf
     bat
     eza
     yazi
     tmux

     wget
     curl
     tree-sitter

     gcc
     clang
     clang-tools
     gdb
     cmake
     gnumake
     ninja
     go
     gopls
     golangci-lint
     valgrind
     pnpm
     nixd

     obsidian
     krita

     mpv
     vlc
     cava
     mpd
     ncmpcpp

     file
     telegram-desktop
     pkg-config
     python3
     nodejs
     rustup
     mangohud
     goverlay
     gamescope
     vulkan-tools
     mesa-demos
     waybar
     mako
     rofi
     wl-clipboard
     grim
     slurp
     swww
     hyprpaper
     hypridle
     hyprsunset
     brightnessctl
     playerctl
     pamixer
     networkmanagerapplet
     pavucontrol

     nftables
     tailscale
     sing-box

     ipset
     iptables

     # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  systemd.services.zapret = {
    description = "zapret DPI bypass";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "firewall.service"
      "nftables.service"
    ];
    wants = [ "network-online.target" ];

    path = with pkgs; [
      bash
      coreutils
      gnugrep
      gnused
      gawk
      findutils
      iproute2
      iptables
      ipset
      nftables
      curl
      procps
    ];

    serviceConfig = {
      Type = "forking";
      Restart = "no";
      TimeoutSec = "30sec";
      IgnoreSIGPIPE = false;
      KillMode = "none";
      GuessMainPID = false;
      RemainAfterExit = false;

      ExecStart = "/opt/zapret/init.d/sysv/zapret start";
      ExecStop = "/opt/zapret/init.d/sysv/zapret stop";
    };
  };

  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    fira-code
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  services.openssh.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  programs.nix-ld.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
