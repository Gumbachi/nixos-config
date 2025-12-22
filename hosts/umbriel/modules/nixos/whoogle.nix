{ config, lib, ... }: let
  cfg = config.services.whoogle-search;
  port = config.variables.whoogle.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."search.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.whoogle-search = {
    port = port;
    extraEnv = {
      WHOOGLE_USER_AGENT = "Mozilla/5.0 (X11; Linux) KHTML/4.9.1 (like Gecko) Konqueror/4.9";
      WHOOGLE_USER_AGENT_MOBILE = "Mozilla/5.0 (X11; Linux) KHTML/4.9.1 (like Gecko) Konqueror/4.9";
    };
  };


}
