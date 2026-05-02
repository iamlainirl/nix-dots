{ ... }:

{
    programs.kitty = {
        enable = true;

        settings = {
            font_size = 12;
            confirm_os_window_close = 0;
            enable_audio_bell = false;
            window_padding_wigth = 8;
            background_opacity = "0.9";
          };
          keybindings = {
              "ctrl+shift+t" = "new_tab";
              "ctrl+shift+q" = "close_tab";
          };
      };
  }
