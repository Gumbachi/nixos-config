{ config, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  userConfig = "/home/jared/nixos-config/GOOMBAX1/.config";
in
{

  home.username = "jared";
  home.homeDirectory = "/home/jared";

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
