{ config, lib, ... }: let
  cfg = config.services.searx;
  port = config.variables.searx.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."search.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  # Secrets
  age.secrets.searx.file = ../../secrets/searx.age;

  services.searx = {
    environmentFile = config.age.secrets.searx.path;
    settings = {
      server.port = port;
      server.bind_address = "0.0.0.0";
      server.secret_key = "$SEARX_SECRET_KEY";
    };
  };

}
