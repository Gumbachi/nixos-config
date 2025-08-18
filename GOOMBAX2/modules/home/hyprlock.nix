{ config, osConfig, lib, ... }:
let
  textColor = if config.stylix.enable then config.lib.stylix.colors.base05 else "cdd6f4";
  accentColor = if config.stylix.enable then config.lib.stylix.colors.base0D else "89b4fa";
  font = "Inter";
  monitor = "eDP-1";
in
{

  programs.hyprlock = {
    settings = {
      # GENERAL
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      # BACKGROUND
      background = {
        blur_passes = 2;
      };

      label = [ 
        # TIME
        {
          monitor = "${monitor}";
          text = ''cmd[update:30000] echo "$(date +"%R")"'';
          color = "rgb(${textColor})";
          font_size = 70;
          font_family = "${font}";
          position = "50, -30";
          halign = "left";
          valign = "top";
        }

        # DATE 
        {
          monitor = "${monitor}";
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          color = "rgb(${textColor})";
          font_size = 20;
          font_family = "${font}";
          position = "50, -180";
          halign = "left";
          valign = "top";
        } 

        # GREETING
        {
          monitor = "${monitor}";
          text = "${osConfig.networking.hostName}";
          text_align = "center";
          color = "rgb(${textColor})";
          font_size = 30;
          font_family = "${font}";
          position = "0, 70"; # -80x for left align
          halign = "center";
          valign = "center";
        }
      ];

      # USER AVATAR
      image = {
        monitor = "${monitor}";
        path = builtins.toString ../../../images/avatars/5mort.jpg;
        size = 200;
        border_color = "rgb(${accentColor})";
        border_size = 4;
        position = "-500, 0";
        halign = "center";
        valign = "center";
      };


      # INPUT FIELD
      input-field = {
        monitor = "${monitor}";
        size = "250, 50";
        outline_thickness = 4;
        dots_size = 0.25;
        dots_spacing = 0.25;
        dots_center = true;
        outer_color = lib.mkForce "rgb(${accentColor})";
        # inner_color = $surface0;
        fade_on_empty = false;
        placeholder_text = "$DESC";
        hide_input = false;
        # check_color = $accent;
        # fail_color = $red
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        font_family = "${font}";
        # font_color = $text
        position = "0, -70";
        halign = "center";
        valign = "center";   
      };

    };
  };
}
