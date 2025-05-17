{ pkgs, config, lib, ...}: {

  home-manager.user.jared.imports = [ ../home/hyprland.nix ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Hyprland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  ### Hyprland: Necessary Programs ###
  environment.systemPackages = with pkgs; [

    clipse # Clipboard Manager
    wl-clipboard # Clipboard backend
    rofi-wayland # Launcher
    hyprpicker # Color Picker
    waypaper # Wallpaper GUI
    imv # Image Viewer
    kdePackages.gwenview # Simple Image Editor
    pavucontrol # Sound Settings
    grimblast # Screenshots

    nwg-look # GTK Style GUI

  ];

  # Greetd: Autostart Hyprland on boot
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop > /dev/null";
      user = "jared";
    };
  in {
    enable = true;
    settings = {
      initial_session = session;
      default_session = session;
    };
  };

}
