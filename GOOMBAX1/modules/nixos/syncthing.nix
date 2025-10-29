{ ... }: let
  syncDir = "/home/jared/sync";
in {

  # Syncthing
  networking.firewall.allowedTCPPorts = [ 8384 ];

  services.syncthing = {
    dataDir = syncDir;
    configDir = "/home/jared/.config/syncthing";
    user = "jared";
    group = "users";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    overrideFolders = true;
    settings.options = {
      urAccepted = -1;
      localAnnounceEnabled = true;
    };
  };

  services.syncthing.settings.devices = {
    "GOOMBAS2".id = "TGECLOP-VIUGTKQ-AQ2P4H6-DOS2LPH-BKQBQQY-LIK7LZQ-5XVWPEH-Z2NL4QZ";
    "Pixel 8".id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
  };


  services.syncthing.settings.folders = {

    "${syncDir}/notes" = {
      label = "Notes";
      id = "notes";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

    "${syncDir}/misc" = {
      label = "Misc. Shared Files";
      id = "misc";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

    "${syncDir}/emulation/saves" = {
      label = "Emulation Saves";
      id = "emulation-saves";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

    "${syncDir}/pictures/avatars" = {
      label = "Avatars";
      id = "pictures-avatars";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

    "${syncDir}/pictures/emotes" = {
      label = "Emotes";
      id = "pictures-emotes";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

    "${syncDir}/pictures/wallpapers" = {
      label = "Wallpapers";
      id = "pictures-wallpapers";
      devices = [ "GOOMBAS2" "Pixel 8" ];
    };

  };

}
