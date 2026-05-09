{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in
{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family JetBrainsMono Nerd Font
      font_size 11.5

      background ${c.abyss}
      foreground ${c.text}

      selection_background ${c.deep}
      selection_foreground ${c.textLight}

      cursor ${c.blue}
      cursor_text_color ${c.abyss}

      background_opacity 0.92
      dynamic_background_opacity yes
      background_blur 1

      window_padding_width 12
      confirm_os_window_close 0
    '';
  };
}
