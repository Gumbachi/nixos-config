{ ... }: {
  
  # Just for insurance to not brick the system
  programs.kitty.enable = true;

  # Hyprland environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Disabled for UWSM compatibility
    settings = let
      mainMod = "SUPER";
      terminal = "uwsm app -- kitty";
      toggleDashboard = "astal -t overway -i overway";
      fileManager = "${terminal} yazi";
      menu = ''rofi -show drun -run-command "uwsm app -- {cmd}" '';
      editConfig = "${terminal} $EDITOR $CONFIG";
      screenshot = "grimblast copy area";
      browser = "uwsm app -- floorp";
      clipboard = "uwsm app -- clipse -listen";
      systemMonitor = "${terminal} btop";
      steamGameRegex = "class:^(steam_app_.*)$";
    in { 

      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        # "DP-1, 1920x1080@240, 1920x0, 1, vrr, 1"
      ];

      exec-once = [
        "uwsm finalize"
        "hyprlock"
        "uwsm app -- overway"
        "${clipboard}"
        # "uwsm app -- steam -silent"
        # "[workspace 2 silent] uwsm app -- vesktop"
        # "[workspace 2 silent] uwsm app -- youtube-music"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4; 
        resize_on_border = false; # Click and drag on borders to resize
        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
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

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      bind = [
        "${mainMod}, Q, exec, ${terminal}"
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
        "${mainMod}, D, exec, ${toggleDashboard}"

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
