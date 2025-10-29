{ config, lib, ... }:
let
  cfg = config.services.syncthing;
  port = config.variables.syncthing.port;
  storage = "/mnt/main";
in
{
  # Automatically open port if syncthing is enabled
  networking.firewall.allowedTCPPorts = lib.mkIf cfg.enable [ port ];

  services.caddy.virtualHosts."sync.gumbachi.com" = lib.mkIf cfg.enable {
    # Cant use localhost since multiple syncthing hosts on same network
    extraConfig = ''reverse_proxy 192.168.69.2:${toString port}'';
  };

  # Basic settings
  services.syncthing = {
    user = "jared"; # makes the most sense to run as me
    group = "users";
    openDefaultPorts = true;
    dataDir = "${storage}/sync";
    configDir = "${storage}/config/syncthing";
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:${toString port}";
    settings.options = {
      urAccepted = -1;
      localAnnounceEnabled = true;
    };
  };

  # Devices
  services.syncthing.settings.devices = {
    "GOOMBAX1".id = "VFR4AWB-OIPVPEQ-74A3CZQ-DWKDSUA-H6IOQNJ-ZPP2NYZ-3MDAHKW-SGC5EAF";
    "Pixel 8".id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
    "Go 7".id = "GKNIIKZ-6P7TNMQ-X4FDQPI-75UH4O4-J664KC2-MVU3SVQ-BFYQL5V-4WC4WAF";
  };

  # Folders
  services.syncthing.settings.folders = {

    "${storage}/sync/notes" = {
      label = "Notes";
      id = "notes";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

    "${storage}/sync/misc" = {
      label = "Misc. Shared Files";
      id = "misc";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

    "${storage}/sync/emulation/saves" = {
      label = "Emulation Saves";
      id = "emulation-saves";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

    "${storage}/sync/pictures/avatars" = {
      label = "Avatars";
      id = "pictures-avatars";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

    "${storage}/sync/pictures/emotes" = {
      label = "Emotes";
      id = "pictures-emotes";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

    "${storage}/sync/pictures/wallpapers" = {
      label = "Wallpapers";
      id = "pictures-wallpapers";
      devices = [ "GOOMBAX1" "Pixel 8" ];
    };

  };
}
