{ ... }: {

  programs.kitty = {
    settings = {

      # FONT SETTINGS
      font_family = "BlexMonoNF-Medium";
      bold_font = "BlexMonoNF-Bold";
      font_size = "12.0";

      # CURSOR CUSTOMIZATION
      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
      cursor_shape = "beam";

      # WINDOW CUSTOMIZATION
      confirm_os_window_close = "0";

    };
  };

}
