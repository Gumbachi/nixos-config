{ config, lib, ... }:
let
  cfg = config.services.jellyfin;
  port = config.variables.jellyfin.port;
in
{

  # Reverse Proxy
  services.caddy.virtualHosts."watch.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.jellyfin = {
    group = "media";
    configDir = "/mnt/main/config/jellyfin";
    openFirewall = true;
  };
 
}
