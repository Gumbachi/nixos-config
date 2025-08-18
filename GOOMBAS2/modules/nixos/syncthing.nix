{ config, lib, ... }:
let
  cfg = config.services.syncthing;
  storage = "/mnt/main";
  port = 8384;
in
{
  # Automatically open port if syncthing is enabled
  networking.firewall.allowedTCPPorts = lib.mkIf cfg.enable [ port ];

  services.caddy.virtualHosts."sync.gumbachi.com" = lib.mkIf cfg.enable {
    # Cant use localhost since multiple syncthing hosts on same network 
    extraConfig = ''reverse_proxy 192.168.69.2:${toString port}'';
    serverAliases = [ "syncthing.gumbachi.com" ];
  };

  services.syncthing = {
    user = "jared"; # makes the most sense to run as me
    group = "users";
    openDefaultPorts = true;
    dataDir = "${storage}";
    configDir = "${storage}/config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:${toString port}";
    settings = {

      # Notes - Knowledge Base
      folders."${storage}/sync/notes" = {
        label = "Notes";
        id = "notes";
        devices = [ "GOOMBAM1" "GOOMBAX1" "Go7" ];
      };

      # General Shared Files
      folders."${storage}/sync/shared" = {
        label = "Shared Files";
        id = "shared";
        devices = [ "GOOMBAM1" "GOOMBAX1" "Go7" ];
      };

      # Torrents
      folders."${storage}/sync/torrents" = {
        label = "Torrents";
        id = "torrents";
        devices = [ "GOOMBAX1" ];
      };

      # Books
      folders."${storage}/media/books" = {
        label = "Books";
        id = "books";
        devices = [ "Go7" ];
      };

      # Emulator Saves
      folders."${storage}/sync/emulation/saves" = {
        label = "Emulation Saves";
        id = "emulation-saves";
        devices = [ "GOOMBAX1" "GOOMBAM1" ];
      };

      # Phone
      devices.GOOMBAM1 = {
        id = "VTVTPAN-QXGZNSD-FLSI4UR-LIJY6O2-SJOLELJ-6EBOEHV-6MYCVWE-OQEG7Q7";
        autoAcceptFolders = false;
      };
      
      # Main Desktop
      devices.GOOMBAX1 = {
        id = "A3EODPJ-UEDWGN5-ULBOGU3-YK2Q6IK-RLURJQV-5KGCCQ4-3IZPKPS-NAAPLQV";
        autoAcceptFolders = false;
      };
      
      # E-Reader
      devices.Go7 = {
        id = "GKNIIKZ-6P7TNMQ-X4FDQPI-75UH4O4-J664KC2-MVU3SVQ-BFYQL5V-4WC4WAF";
        autoAcceptFolders = false;
      };

    };

  };

}
