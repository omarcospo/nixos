{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dynamic_title = true;
        decorations = "full";
        opacity = 1.00;
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
          background = "#1c1e1f";
          foreground = "#ffffff";
        };
        normal = {
          black = "#262626";
          red = "#ee5396";
          green = "#BE95FF";
          yellow = "#42be65";
          blue = "#78a9ff";
          magenta = "#ff7eb6";
          cyan = "#3ddbd9";
          white = "#dde1e6";
        };
        bright = {
          black = "#393939";
          red = "#ee5396";
          green = "#BE95FF";
          yellow = "#42be65";
          blue = "#78a9ff";
          magenta = "#ff7eb6";
          cyan = "#3ddbd9";
          white = "#dde1e6";
        };
      };
    };
  };
}
