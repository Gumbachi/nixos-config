{ ... }:
let
  mkDisabledDesktopEntry = name: {
    "${name}" = {
      name = name;
      exec = "";
      noDisplay = true;
    };
  };

  disabled = map mkDisabledDesktopEntry [
    "Proton EasyAntiCheat Runtime"
    "btop++"
    "NixOS Manual"
    "Qt5 Settings"
    "Qt6 Settings"
    "Yazi"
    "fish"
    "kitty"
    "uuctl" 
    "Neovim"
  ];
in
{

  xdg.desktopEntries = {

    # yazi = {
    #   name = "Yazi";
    #   genericName = "File Explorer";
    #   exec = "yazi";
    #   terminal = true;
    #   mimeType = ["inode/directory"];
    #   icon = "system-file-manager";
    # };

    vlc = {
      name = "VLC";
      genericName = "Media Player";
      exec = "env -u DISPLAY vlc";
      icon = "vlc";
    };

    immich = {
      name = "Immich";
      genericName = "Photo Manager";
      exec = "xdg-open https://photos.gumbachi.com";
      icon = "multimedia-photo-viewer";
    };

    jellyfin = {
      name = "Jellyfin";
      genericName = "Jellyfin";
      exec = "xdg-open https://watch.gumbachi.com";
      icon = "jellyfin";
    };

  };

} 
