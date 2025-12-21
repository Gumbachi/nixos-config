{ config, ... }:
let
  userConfig = "/home/jared/nixos-config/GOOMBAX2/.config";
in
{

  home.username = "jared";
  home.homeDirectory = "/home/jared";

  programs.git = {
    enable = true;
    userName = "Gumbachi";
    userEmail = "github@gumbachi.com";
  };

  programs.nh = {
    enable = true;
    flake = "/home/jared/nixos-config";
  };

  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;
  programs.qutebrowser.enable = false;
  services.hyprpolkitagent.enable = true;

  home.file = {
    # YouTube Music -- no home manager module available
    ".config/YouTube Music/config.json".source = config.lib.file.mkOutOfStoreSymlink "${userConfig}/YouTube Music/config.json";
  };

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

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

}
