{ config, lib, ... }:
let
  cfg = config.services.qbit-vpn;
  port = 8115;
in
{

  options.services.qbit-vpn.enable = lib.mkEnableOption "Enable qbit-vpn container";

  config = lib.mkIf cfg.enable {

    # Reverse Proxy
    services.caddy.virtualHosts."qbit-vpn.gumbachi.com" = {
      extraConfig = ''reverse_proxy localhost:8668'';
    };

    # Secrets
    age.secrets.qbit-vpn.file = ../../../secrets/qbit-vpn.age;

    virtualisation.oci-containers.containers.qbit-vpn = {
      image = "docker.io/binhex/arch-qbittorrentvpn:latest";
      privileged = true;
      capabilities.NET_ADMIN = true;
      environmentFiles = [ config.age.secrets.qbit-vpn.path ]; # Secrets
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
        WEBUI_PORT = "8668";
        DEBUG = "false";
        PUID = "1000";
        PGID = "986"; # Media Group
        UMASK = "000";
      };
      ports = [
        "8668:8668" 
        # "8118:8118" # Privoxy
        # "9118:9118" # Socks
        "58946:58946" 
        "58946:58946/udp" 
      ];
      volumes = [  
        # This line must match on both sides or the arrs freak out
        "/mnt/main/torrents/qbit-vpn:/mnt/main/torrents/qbit-vpn"

        # These dont have to match
        "/mnt/main/config/qbit-vpn/data:/data"
        "/mnt/main/config/qbit-vpn/config:/config"
      ];
    };    

  };


}
