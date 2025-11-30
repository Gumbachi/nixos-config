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


  # Add jellyfin user to special groups if enabled
  users.users = lib.mkIf cfg.enable {
    jellyfin.extraGroups = [ "media" "video" "render" ];
  };

  services.jellyfin = {
    dataDir = "/mnt/main/config/jellyfin";
    configDir = "/mnt/main/config/jellyfin/config";
    openFirewall = true;
  };

}
