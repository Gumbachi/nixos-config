{ config, lib, ... }: let
  cfg = config.services.jackett;
  port = config.variables.jackett.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."jackett.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  # Main Config
  services.jackett = {
    group = "media";
    port = ports.jackett;
    openFirewall = true;
    dataDir = "/mnt/main/config/jackett";
  };

}
