{ config, lib, ... }:
let
  cfg = config.services.uptime-kuma;
  dashboard-cfg = config.services.homepage-dashboard;
  host = "127.0.0.1";
  port = "3180";
  url = "uptime.gumbachi.com";
in
{

  services.uptime-kuma = {
    settings = {
      HOST = host;
      PORT = port;
    };
  };

  # Reverse Proxy
  services.caddy.virtualHosts.${url} = lib.mkIf cfg.enable { 
    extraConfig = ''reverse_proxy ${host}:${port}'';
  };

  # # Homepage Dashboard Service
  # services.homepage-dashboard.services = lib.mkIf dashboard-cfg.enable [{
  #   "Other" = [
  #     {
  #       "Uptime" = {
  #         icon = "uptime-kuma.png";
  #         description = "Uptime Stats";
  #         href = "https://${url}";
  #         siteMonitor = "https://${url}";
  #       };
  #     }
  #   ] ++ (lib.lists.findFirst (x: x ? "Other") { "Other" = []; } dashboard-cfg.services)."Other";
  # }];

}
