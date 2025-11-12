{ configPath, ... }: {

  wayland.windowManager.hyprland = {
    settings = let
      mainMod = "SUPER";
      terminal = "kitty";
      # toggleDashboard = "astal -t overway -i overway";
      fileManager = "${terminal} yazi";
      menu = "fuzzel";
      editConfig = "${terminal} $EDITOR ${configPath}";
      screenshot = "hyprshot -m region --clipboard-only";
      browser = "librewolf";
      clipboard = "clipse -listen";
      gameLauncher = "steam";
      systemMonitor = "${terminal} btop";
      steamGameRegex = "class:^(steam_app_.*)$";
      launchOverlay = "qs -p ~/code/overway";
      toggleOverlay = "qs -p ~/code/overway ipc call overway toggle";
    in {

      monitor = [
        "eDP-1, 1920x1080@60, 1920x0, 1"
        "DP-1, 1920x1080@240, 0x0, 1, vrr, 1"
      ];

      exec-once = [
        "hyprlock"
        "${clipboard}"
        "${launchOverlay}"
        "${toggleOverlay}"
        # "steam -silent"
        # "[workspace 2 silent] vesktop"
        # "[workspace 2 silent] youtube-music"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 4;
        resize_on_border = false; # Click and drag on borders to resize
        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0; # disable anime wallpaper
        disable_hyprland_logo = true;
        key_press_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "kitty";
      };

      render = {
        direct_scanout = 2;
      };

      input = {
        kb_options = "caps:swapescape";
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true; # enable 2 finger RMB and 3 finger MMB
        };
      };

      gesture = [
        "3,horizontal, workspace"
        "3, down, close"
        "3, up, fullscreen"
        "2, pinch, float"
      ];

      bind = [
        "${mainMod}, T, exec, ${terminal}"
        "${mainMod}, C, killactive,"
        "${mainMod} SHIFT, M, exec, pkill Hyprland,"
        "${mainMod}, E, exec, ${fileManager}"
        "${mainMod}, V, togglefloating,"
        "${mainMod} SHIFT, V, exec, ${terminal} --class clipse -e 'clipse'"
        "${mainMod}, R, exec, ${menu}"
        "${mainMod}, P, pseudo, # dwindle"
        "${mainMod}, Y, togglesplit, # dwindle"
        "${mainMod}, N, exec, ${editConfig}"
        "${mainMod} SHIFT, F, fullscreen, 1"
        "${mainMod}, F, fullscreen, 0"
        "${mainMod}, B, exec, ${browser}"
        ", PRINT, exec, ${screenshot}"
        "${mainMod}, M, exec, ${systemMonitor}"
        "${mainMod}, D, exec, ${toggleOverlay}"
        "${mainMod}, G, exec, ${gameLauncher}"

        "${mainMod}, H, movefocus, l"
        "${mainMod}, L, movefocus, r"
        "${mainMod}, K, movefocus, u"
        "${mainMod}, J, movefocus, d"
        "${mainMod} SHIFT, H, movewindow, l"
        "${mainMod} SHIFT, L, movewindow, r"
        "${mainMod} SHIFT, K, movewindow, u"
        "${mainMod} SHIFT, J, movewindow, d"

        "${mainMod}, 1, workspace, 1"
        "${mainMod}, 2, workspace, 2"
        "${mainMod}, 3, workspace, 3"
        "${mainMod}, 4, workspace, 4"
        "${mainMod}, 5, workspace, 5"
        "${mainMod}, 6, workspace, 6"
        "${mainMod}, 7, workspace, 7"
        "${mainMod}, 8, workspace, 8"
        "${mainMod}, 9, workspace, 9"
        "${mainMod}, 0, workspace, 10"

        "${mainMod} SHIFT, 1, movetoworkspace, 1"
        "${mainMod} SHIFT, 2, movetoworkspace, 2"
        "${mainMod} SHIFT, 3, movetoworkspace, 3"
        "${mainMod} SHIFT, 4, movetoworkspace, 4"
        "${mainMod} SHIFT, 5, movetoworkspace, 5"
        "${mainMod} SHIFT, 6, movetoworkspace, 6"
        "${mainMod} SHIFT, 7, movetoworkspace, 7"
        "${mainMod} SHIFT, 8, movetoworkspace, 8"
        "${mainMod} SHIFT, 9, movetoworkspace, 9"
        "${mainMod} SHIFT, 0, movetoworkspace, 10"

        "${mainMod}, S, togglespecialworkspace, magic"
        "${mainMod} SHIFT, S, movetoworkspace, special:magic"
      ];

      bindm = [
        "${mainMod}, mouse:272, movewindow"
        "${mainMod}, mouse:273, resizewindow"
      ];

      bindle = [
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", switch:Lid Switch, exec, hyprlock" # Run hyprlock when closing lid
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      workspace = [
        "1, monitor:eDP-1, default:true, persistent:true"
        "2, monitor:DP-1, default:true, persistent:true"
      ];

      windowrule = [
        "float, class:(clipse)"
        # "size 622 652, class:(clipse)"

        "workspace 2, class:(com.github.th_ch.youtube_music)"
        "workspace 2, class:(vesktop)"

        "workspace 3, ${steamGameRegex}"
        "fullscreen, ${steamGameRegex}"
        "idleinhibit always, ${steamGameRegex}"

        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:vesktop"
      ];

    };
  };

}
