{ ... }: {
 
  # Syncthing
  networking.firewall.allowedTCPPorts = [ 8384 ];

  services.syncthing = {
    dataDir = "/home/jared/sync";
    configDir = "/home/jared/.config/syncthing";
    user = "jared";
    group = "users";
    openDefaultPorts = true;      
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    settings = {
      devices.GOOMBAS2.id = "2VD6JZS-NF7AWWM-XZYU6Z2-TAZLQ3J-LEUUDBO-SSLYVXW-LA5JTEH-AO766A4";
      devices.GOOMBAM1.id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
      devices.Go7.id = "GKNIIKZ-6P7TNMQ-X4FDQPI-75UH4O4-J664KC2-MVU3SVQ-BFYQL5V-4WC4WAF";

      folders."/home/jared/sync/notes" = {
        id = "notes";
        label = "Notes";
        devices = [ "GOOMBAS2" "GOOMBAM1" "Go7" ];
      };

      folders."/home/jared/sync/shared" = {
        id = "shared";
        label = "Shared Files";
        devices = [ "GOOMBAS2" "GOOMBAM1" "Go7" ];
      };

      folders."/home/jared/sync/torrents" = {
        id = "torrents";
        label = "Torrents";
        devices = [ "GOOMBAS2" ];
      };

      folders."/home/jared/sync/emulation/saves" = {
        id = "emulation-saves";
        label = "Emulation Saves";
        devices = [ "GOOMBAS2" "GOOMBAM1" ];
      };

      folders."/home/jared/sync/emulation/library" = {
        id = "emulation-library";
        label = "Emulation Library";
        devices = [ "GOOMBAS2" ];
      };
    };
  };

}
