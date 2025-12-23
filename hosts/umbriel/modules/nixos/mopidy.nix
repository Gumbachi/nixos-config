{ pkgs, config, lib, ... }: {

  services.mopidy = {
    dataDir = "/mnt/main/config/mopidy";
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-mpris
      mopidy-ytmusic
      mopidy-jellyfin
    ];
  };

  services.mopidy.settings.mpd = {
    enabled = true;
    hostname = "::";
  };

}
