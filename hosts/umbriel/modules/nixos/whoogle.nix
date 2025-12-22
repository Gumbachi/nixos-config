{ config, lib, ... }: let
  port = config.variables.whoogle.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."search.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.whoogle-search.port = port;

}
