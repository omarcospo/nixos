{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      window = {
        dynamic_title = true;
        decorations = "none";
        opacity = 0.99;
        padding = {
          x = 0;
          y = 0;
        };
      };

      mouse = {
        bindings = [
          {
            mouse = "Right";
            mods = "Control";
            action = "Paste";
          }
        ];
      };

      keyboard = {
        bindings = [
          {
            action = "CreateNewWindow";
            key = "N";
            mods = "Control|Shift";
          }
        ];
      };

      font = {
        glyph_offset = {
          x = 0;
          y = 0;
        };
        size = 15.0;
        builtin_box_drawing = true;
        offset = {
          x = 0;
          y = 0;
        };
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
      };

      cursor = {
        style = "Underline";
        unfocused_hollow = false;
      };

      colors = {
        draw_bold_text_with_bright_colors = false;
        transparent_background_colors = true;
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
      };
    };
  };
}
