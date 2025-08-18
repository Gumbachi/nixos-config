{ config, lib, ... }:
let
  cfg = config.services.deluge-vpn;
in
{

  options.services.deluge-vpn.enable = lib.mkEnableOption "Enable deluge-vpn container";

  config = lib.mkIf cfg.enable {

    # Reverse Proxy
    services.caddy.virtualHosts."sail.gumbachi.com" = {
      extraConfig = ''reverse_proxy localhost:8112'';
      serverAliases = [ "deluge.gumbachi.com" ];
    };

    # Secrets
    age.secrets.deluge-vpn.file = ../../../secrets/deluge-vpn.age;

    virtualisation.oci-containers.containers.deluge-vpn = {
      image = "docker.io/binhex/arch-delugevpn:latest";
      privileged = true;
      capabilities.NET_ADMIN = true;
      environmentFiles = [ config.age.secrets.deluge-vpn.path ]; # Secrets
      environment = {
        TZ = "America/New_York";
        VPN_ENABLED = "yes";
        VPN_PROV = "pia";
        VPN_CLIENT = "wireguard";
        ENABLE_STARTUP_SCRIPTS = "no"; 
        ENABLE_PRIVOXY = "no";
        STRICT_PORT_FORWARD = "yes";
        USERSPACE_WIREGUARD = "no";
        ENABLE_SOCKS = "no";
        LAN_NETWORK = "192.168.68.0/22";
        NAME_SERVERS = "1.1.1.1,1.0.0.1";
        DELUGE_DAEMON_LOG_LEVEL = "info"; 
        DELUGE_WEB_LOG_LEVEL = "info"; 
        DELUGE_ENABLE_WEBUI_PASSWORD = "yes";
        VPN_INPUT_PORTS = "1234"; 
        VPN_OUTPUT_PORTS = "5678"; 
        DEBUG = "false";
        PUID = "0";
        PGID = "0"; # Media Group
        UMASK = "000";
      };
      ports = [
        "8112:8112" 
        # "8118:8118" # Privoxy
        # "9118:9118" # Socks
        "58847:58846" 
        "58947:58946" 
        "58947:58946/udp" 
      ];
      volumes = [  
        # This line must match on both sides or the arrs freak out
        "/mnt/main/torrents/vpn:/mnt/main/torrents/vpn"

        # These dont have to match
        "/mnt/main/config/deluge-vpn/data:/data"
        "/mnt/main/config/deluge-vpn/config:/config"
      ];
    };    

  };


}
