{ config, lib, ... }:
let
  cfg = config.services.jellyseerr;
  port = config.variables.jellyseerr.port;
in
{

  # Reverse Proxy Config
  services.caddy.virtualHosts."requests.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.jellyseerr = {
    port = port;
  };

}
