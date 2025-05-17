{ config, ... }: {

  programs.niri.settings = {

    input = {
      touchpad = {
        accel-profile = "flat";
        dwt = true; # disable while typing
      };
    };

    outputs."eDP-1" = {
      mode = { width = 1920; height = 1080; refresh = 60.0; };
      position = { x = 0; y = 0; };
    };

    binds = with config.lib.niri.actions; {
      "Mod+C".action = close-window;
      "Mod+R".action = spawn "fuzzel";
      "Mod+Q".action = spawn "kitty";
      "Mod+B".action = spawn "floorp";
      "Mod+1".action = focus-workspace 1;
    };

  };

}
