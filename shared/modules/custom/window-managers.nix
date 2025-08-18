{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkMerge mkEnableOption mkDefault;
  module = "window-managers";
  cfg = config.${module};
in {

  options.${module} = {
    hyprland.enable = mkEnableOption "Install Hyprland WM and set greetd to launch into Hyprland.";
    niri.enable = mkEnableOption "Install Niri WM and set greetd to launch into Niri";
  };

  config = mkMerge [
 
    # Hyprland
    (mkIf cfg.hyprland.enable { 

      # NixOS
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
      };

      # Greetd: Autostart Hyprland on boot
      services.greetd = let
        session = {
          command = "uwsm start hyprland-uwsm.desktop > /dev/null";
          user = "jared";
        };
      in {
        enable = true;
        settings = {
          initial_session = session;
          default_session = session;
        };
      };

      # Home Manager
      home-manager.sharedModules = [{
        programs.kitty.enable = true;
        wayland.windowManager.hyprland.enable = true;
      }];

    })

    # Niri
    (mkIf cfg.niri.enable { 

      programs.niri.enable = true;
      programs.niri.package = pkgs.niri;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
      };

      # Greetd: Autostart Niri on boot
      services.greetd = let
        session = {
          command = "niri-session";
          user = "jared";
        };
      in {
        enable = true;
        settings = {
          initial_session = session;
          default_session = session;
        };
      };

      # Home Manager
      home-manager.sharedModules = [{
        programs.alacritty.enable = mkDefault true;
        programs.fuzzel.enable = mkDefault true;
      }];

    })


  ];
}
