{ config, lib, ... }:
let
  cfg = config.services.jellyseerr;
  port = 5055;
in
{

  # Reverse Proxy Config
  services.caddy.virtualHosts."request.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
    serverAliases = [ 
      "requests.gumbachi.com"
      "jellyseerr.gumbachi.com"
      "jellyseer.gumbachi.com"
    ];
  };

  services.jellyseerr = {
    port = port;
  };

}
