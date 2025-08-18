{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkMerge mkEnableOption;
  module = "gaming";
  cfg = config.${module};
in {

  options.${module} = {
    # Minecraft
    minecraft.enable = mkEnableOption "Install Prism Launcher for Minecraft.";

    # VR
    vr.enable = mkEnableOption "Enable VR with ALVR.";

    # Steam
    steam = {
      enable = mkEnableOption "Install Steam.";
      forceDesktopScaling = mkEnableOption "Set an environment variable to force desktop scaling to 1.5x";
    };

    steam-tui.enable = mkEnableOption "Install steam-tui.";

    # Heroic Launcher
    heroic.enable = mkEnableOption "Install Heroic Launcher.";

    # Lutris Launcher
    lutris.enable = mkEnableOption "Install Lutris Launcher.";

    # Mangohud
    mangohud.enable = mkEnableOption "Install Mangohud.";

    # Gamescope
    gamescope.enable = mkEnableOption "Install gamescope.";

    # Gamemode
    gamemode.enable = mkEnableOption "Install gamemode.";

    # ProtonUP
    protonup.enable = mkEnableOption "Install proton version manager.";

    # Proton Plus manager 
    protonplus.enable = mkEnableOption "Install proton plus prefix manager.";
  };

  config = mkMerge [

    # Steam
    (mkIf cfg.steam.enable {
      programs.steam.enable = true;
      programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];      
      environment.sessionVariables = mkIf cfg.steam.forceDesktopScaling {
        STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
      };
    })

    # Steam-TUI
    (mkIf cfg.steam-tui.enable { 
      environment.systemPackages = [ pkgs.steam-tui ];
    })

    # Heroic
    (mkIf cfg.heroic.enable {
      environment.systemPackages = [ pkgs.heroic ];
    })

    # Lutris
    (mkIf cfg.lutris.enable { 
      home-manager.sharedModules = [{
        programs.lutris.enable = true;
      }];
    })

    # Mangohud
    (mkIf cfg.mangohud.enable { 
      environment.systemPackages = [pkgs.mangohud];
      home-manager.sharedModules = [{
        programs.mangohud.enable = true;
      }];
    })

    # Gamescope
    (mkIf cfg.gamescope.enable {
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
      # programs.steam.enableGamescopeSession = true;
    })

    # Gamemode
    (mkIf cfg.gamemode.enable { 
      programs.gamemode.enable = true;
    })

    # ProtonUP
    (mkIf cfg.protonup.enable {
      environment.systemPackages = [pkgs.protonup-qt];
    })

    # ProtonPlus
    (mkIf cfg.protonplus.enable {
      environment.systemPackages = [ pkgs.protonplus ];
    })

    # Minecraft
    (mkIf cfg.minecraft.enable {
      environment.systemPackages = [pkgs.prismlauncher];
    })

    # VR
    (mkIf cfg.vr.enable {
      programs.alvr = {
        enable = true;
        openFirewall = true;
      };
    })
  ];
}
