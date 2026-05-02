{ pkgs, ... }:

{
    home.packages = with pkgs; [
      rofi
      waybar
      mako
      swww
      hyprpaper
      hyprlock
      hypridle
      grim
      slurp
      wl-clipboard
      hyprpicker 
      brightnessctl
      playerctl
      pavucontrol
    ];
  }
