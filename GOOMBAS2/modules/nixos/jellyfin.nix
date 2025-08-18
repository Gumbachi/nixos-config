{ config, lib, ... }:
let
  cfg = config.services.jellyfin;
in
{

  # Reverse Proxy
  services.caddy.virtualHosts."watch.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:8096'';
    serverAliases = [ "jellyfin.gumbachi.com" ];
  };

  services.jellyfin = {
    group = "media";
    configDir = "/mnt/main/config/jellyfin";
  };
 
}
