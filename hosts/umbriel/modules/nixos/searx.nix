{ config, lib, ... }: let
  cfg = config.services.searx;
  port = config.variables.searx.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."search.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.searx = {
    settings = {
      server.port = port;
      server.bind_address = "0.0.0.0";
    };
  };

}
