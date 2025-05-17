{ config, ... }:
let
  userConfig = "/home/jared/NixOS-Config/GOOMBAX1/.config";
in
{

  home.username = "jared";
  home.homeDirectory = "/home/jared";

  services.hyprpaper.enable = true;
  services.hyprpolkitagent.enable = true;
  programs.mpv.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/jared/NixOS-Config";
  };

  ################
  ### SYMLINKS ###
  ################

  home.file = {
    # YouTube Music -- No home manager module yet
    ".config/YouTube Music/config.json".source = config.lib.file.mkOutOfStoreSymlink "${userConfig}/YouTube Music/config.json";
  };

  xdg.mimeApps = let
    video = {
      types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
      apps = [ "mpv.desktop" ];
    };
    image = {
      types = [ "apng" "avif" "bmp" "gif" "x-icon" "jpeg" "png" "svg+xml" "tiff" "webp" ];
      apps = [ "imv.desktop" ];
    };
    audio = {
      types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
      apps = [ "mpv.desktop" ];
    };
  in {
    enable = true;
    defaultApplications = 
      builtins.listToAttrs ( map (type: { name = "video/${type}" ; value = video.apps; }) video.types ) //
      builtins.listToAttrs ( map (type: { name = "image/${type}" ; value = image.apps; }) image.types ) //
      builtins.listToAttrs ( map (type: { name = "audio/${type}" ; value = audio.apps; }) audio.types );
  };

  #######################
  ### DESKTOP ENTRIES ###
  #######################

  xdg.desktopEntries = {
    yazi = {
      name = "Yazi";
      genericName = "File Explorer";
      exec = "yazi";
      terminal = true;
      mimeType = ["inode/directory"];
      icon = "system-file-manager";
    };

    vlc = {
      name = "VLC";
      genericName = "Media Player";
      exec = "env -u DISPLAY vlc";
      icon = "vlc";
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
