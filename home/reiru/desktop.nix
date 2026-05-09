{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
    waybar
    mako

    awww
    hyprpaper
    hyprlock
    hypridle

    grim
    slurp
    wl-clipboard
    swappy

    hyprpicker
    brightnessctl
    playerctl
    pavucontrol
  ];

  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
  };

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };
}
