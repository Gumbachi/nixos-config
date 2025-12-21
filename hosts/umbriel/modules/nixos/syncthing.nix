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
    "enceladus".id = "ISB6RVX-V7ZN4VK-ZB64JN4-LVGN34Y-WZHO4G2-KQOFGKX-XJWURAQ-GN2FLAO";
    "phobos".id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
  };

  # Folders
  services.syncthing.settings.folders = {

    "${storage}/sync/notes" = {
      label = "Notes";
      id = "notes";
      devices = [ "enceladus" "phobos" ];
    };

    "${storage}/sync/misc" = {
      label = "Misc. Shared Files";
      id = "misc";
      devices = [ "enceladus" "phobos" ];
    };

    "${storage}/sync/emulation/saves" = {
      label = "Emulation Saves";
      id = "emulation-saves";
      devices = [ "enceladus" "phobos" ];
    };

    "${storage}/sync/pictures/avatars" = {
      label = "Avatars";
      id = "pictures-avatars";
      devices = [ "enceladus" "phobos" ];
    };

    "${storage}/sync/pictures/emotes" = {
      label = "Emotes";
      id = "pictures-emotes";
      devices = [ "enceladus" "phobos" ];
    };

    "${storage}/sync/pictures/wallpapers" = {
      label = "Wallpapers";
      id = "pictures-wallpapers";
      devices = [ "enceladus" "phobos" ];
    };

  };
}
