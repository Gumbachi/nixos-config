{ config, lib, ... }: let
  cfg = config.services.scrutiny;
  port = config.variables.scrutiny.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."disks.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.scrutiny = {
    openFirewall = true;
    web.listen.port = port;
  };

}
