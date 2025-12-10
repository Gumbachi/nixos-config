{ osConfig, lib, configPath, ... }: let
  # Get the default exe from the defaults determined by default-apps.nix
  # Example: getDefault browser -> librewolf
  getDefault = type: lib.getExe (builtins.elemAt osConfig.default-apps.${type} 0);
in {

  wayland.windowManager.hyprland = {
    settings = let
      mainMod = "SUPER";
      terminal = "${getDefault "terminal"}";
      terminalWithZellij = "${terminal} zellij";
      fileManager = "${terminal} ${getDefault "files"}";
      launcher = "fuzzel";
      confedit = "${terminal} $EDITOR ${configPath}";
      screenshot = "hyprshot -m region --clipboard-only";
      screenshotSave = "hyprshot -m region -o $HOME/screenshots/";
      browser = "${getDefault "browser"}";
      systemMonitor = "${terminal} btop";
      gameLauncher = "steam";
      steamGameRegex = "class:^(steam_app_.*)$";
      launchOverlay = "qs -p ~/code/overway";
      toggleOverlay = "qs -p ~/code/overway ipc call overway toggle";
      toggleShortcuts = "qs -p ~/code/overway ipc call shortcuts toggle";
      toggleLauncher = "qs -p ~/code/overway ipc call launcher toggle";
    in {

      monitor = [
        "DP-1, 3840x2160@240, 2880x400, 1.5, bitdepth, 10"
        "DP-2, 2560x1440@120, 1440x0, 1, transform, 1"
        "DP-3, 2560x1440@120, 0x0, 1, transform, 1"
      ];

      exec-once = [
        "hyprlock"
        "${launchOverlay}"
        "${toggleOverlay}"
        "steam -silent"
        "[workspace 1 silent] ${terminal} cava"
        "[workspace 2 silent] sleep 1 && youtube-music" # The sleep is to let network stuff init before launch
        "[workspace 1 silent] ${systemMonitor}"
        "[workspace 2 silent] vesktop"
        "[workspace special:magic silent] ${browser}" # preload the browser so its quicker to launch
      ];

      general = {
        gaps_in = 0; # 5
        gaps_out = 0; # 10
        border_size = 0; # 4
        resize_on_border = false; # Click and drag on borders to resize
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0; # 4
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
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

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        force_default_wallpaper = 0; # disable anime wallpaper
        disable_hyprland_logo = true;
        vrr = 1;
        focus_on_activate = true;
        enable_swallow = false;
        swallow_regex = "kitty";
      };

      cursor = {
        # default_monitor = "DP-1";
        # no_warps = true;
      };

      render = {
        direct_scanout = 2;
      };

      input = {
        accel_profile = "flat";
      };

      bind = [
        "${mainMod}, T, exec, ${terminalWithZellij}"
        "${mainMod} SHIFT, T, exec, ${terminal}"
        "${mainMod}, C, killactive,"
        "${mainMod} SHIFT, C, exec, hyprpicker | wl-copy"
        "${mainMod} SHIFT, M, exec, pkill Hyprland,"
        "${mainMod}, E, exec, ${fileManager}"
        "${mainMod}, V, togglefloating,"
        "${mainMod}, R, exec, ${toggleLauncher}"
        "${mainMod} SHIFT, R, exec, ${launcher}"
        "${mainMod}, P, pseudo, # dwindle"
        "${mainMod}, Y, togglesplit, # dwindle"
        "${mainMod}, N, exec, ${confedit}"
        "${mainMod} SHIFT, F, fullscreen, 1"
        "${mainMod}, F, fullscreen, 0"
        "${mainMod}, B, exec, ${browser}"
        ", PRINT, exec, ${screenshot}"
        "SHIFT, PRINT, exec, ${screenshotSave}"
        "${mainMod}, M, exec, ${systemMonitor}"
        "${mainMod}, O, exec, ${toggleOverlay}"
        "${mainMod}, slash, exec, ${toggleShortcuts}"
        "${mainMod}, G, exec, ${gameLauncher}"

        "${mainMod}, H, movefocus, l"
        "${mainMod}, J, movefocus, d"
        "${mainMod}, K, movefocus, u"
        "${mainMod}, L, movefocus, r"
        "${mainMod} SHIFT, H, movewindow, l"
        "${mainMod} SHIFT, J, movewindow, d"
        "${mainMod} SHIFT, K, movewindow, u"
        "${mainMod} SHIFT, L, movewindow, r"

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
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      workspace = [
        "1, monitor:DP-3, default:true, persistent:true"
        "2, monitor:DP-2, default:true, persistent:true"
        "3, monitor:DP-1, default:true, persistent:true"
        "4, monitor:DP-1, decorate:false, border:false"
      ];

      windowrule = [

        # Floating windows dont look stupid
        "bordersize 2, rounding 4, floating:1"

        # Discord file upload
        "float, size 1200 800, title:(Open Files)"

        # firefox file upload
        "center, size 1200 800, title:(File Upload)"

        "workspace 2, class:(com.github.th_ch.youtube_music)"
        "workspace 2, class:(vesktop)"

        "workspace 10, fullscreen, class:.virt-manager-wrapped, title:^Windows10.*$"

        "float, title:(Authentication Required)"

        # Jetbrains Fixes
        "suppressevent fullscreen, class:^(jetbrains-studio)$"

        "workspace 4, fullscreen, idleinhibit always, ${steamGameRegex}"
        # "fullscreen, ${steamGameRegex}"
        # "idleinhibit always, ${steamGameRegex}"

        # Steam Game Overrides
        "fullscreenstate 0 0, float, center, class:steam_app_1361210, title:^(Launcher)$"
        # "float, class:steam_app_1361210, title:^(Launcher)$"
        # "center, class:steam_app_1361210, title:^(Launcher)$"

        # Steam UI
        "monitor DP-1, class:^(steam)$"

        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:vesktop"
        "suppressevent fullscreen, class:com.github.th_ch.youtube_music"
      ];

    };
  };

}
