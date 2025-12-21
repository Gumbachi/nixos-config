{ user, ... }: let
  syncDir = "/home/${user}/sync";
in {

  # Syncthing
  networking.firewall.allowedTCPPorts = [ 8384 ];

  services.syncthing = {
    dataDir = syncDir;
    configDir = "/home/${user}/.config/syncthing";
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
    "Umbriel".id = "TGECLOP-VIUGTKQ-AQ2P4H6-DOS2LPH-BKQBQQY-LIK7LZQ-5XVWPEH-Z2NL4QZ";
    "Phobos".id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
  };


  services.syncthing.settings.folders = {
    "${syncDir}/notes" = {
      label = "Notes";
      id = "notes";
      devices = [ "Umbriel" "Phobos" ];
    };

    "${syncDir}/misc" = {
      label = "Misc. Shared Files";
      id = "misc";
      devices = [ "Umbriel" "Phobos" ];
    };

    "${syncDir}/emulation/saves" = {
      label = "Emulation Saves";
      id = "emulation-saves";
      devices = [ "Umbriel" "Phobos" ];
    };

    "${syncDir}/pictures/avatars" = {
      label = "Avatars";
      id = "pictures-avatars";
      devices = [ "Umbriel" "Phobos" ];
    };

    "${syncDir}/pictures/emotes" = {
      label = "Emotes";
      id = "pictures-emotes";
      devices = [ "Umbriel" "Phobos" ];
    };

    "${syncDir}/pictures/wallpapers" = {
      label = "Wallpapers";
      id = "pictures-wallpapers";
      devices = [ "Umbriel" "Phobos" ];
    };
  };

}
