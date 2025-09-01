{ config, lib, ... }:
let
  cfg = config.services.immich;
  port = config.variables.immich.port;
in 
{

  users.users.immich.extraGroups = lib.mkIf cfg.enable [ "video" "render" "media" ];

  # Reverse proxy setup
  services.caddy.virtualHosts."photos.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.immich = {
    group = "media";
    port = port;
    openFirewall = true;
    mediaLocation = "/mnt/main/media/photos-and-videos/immich"; 
    accelerationDevices = null;
  };

}
