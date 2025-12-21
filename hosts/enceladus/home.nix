{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  userConfig = "/home/jared/nixos-config/GOOMBAX1/.config";
in
{

  home.username = "jared";
  home.homeDirectory = "/home/jared";


  # # https://discourse.nixos.org/t/how-to-install-xdg-desktop-portal-termfilechooser/62819/3
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
  #   config.common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
  # };
  # home.sessionVariables.TERMCMD = "kitty --class=file_chooser";
  # xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
  #   force = true;
  #   text = ''
  #     [filechooser]
  #     cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
  #   '';
  # };


  ################
  ### SYMLINKS ###
  ################

  home.file = {
    # YouTube Music -- No home manager module yet
    ".config/YouTube Music/config.json".source = config.lib.file.mkOutOfStoreSymlink "${userConfig}/YouTube Music/config.json";

    # Home dir symlinks
    "documents".source = mkOutOfStoreSymlink "/mnt/ext/documents";
    "games/main".source = config.lib.file.mkOutOfStoreSymlink "/home/jared/.local/share/Steam/steamapps";
    "games/ext".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ext/steam-library/steamapps";
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
