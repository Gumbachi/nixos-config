{ config, lib, ... }:
let
  cfg = config.services.immich;
  port = config.variables.immich.port;
in
{

  # users.users.immich.isSystemUser = true;
  # users.users.immich.group = "media";

  # Reverse proxy setup
  services.caddy.virtualHosts."photos.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  # Add immich user to special groups if immich is enabled
  users.users = lib.mkIf cfg.enable {
    immich.extraGroups = lib.mkIf cfg.enable [ "video" "render" "media" ];
  };

  services.immich = {
    host = "0.0.0.0";
    port = port;
    openFirewall = true;
    mediaLocation = "/mnt/main/media/photos-and-videos/immich";
    accelerationDevices = null;
  };

}
