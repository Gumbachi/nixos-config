{ config, lib, ... }: let
  cfg = config.services.slskd;
  port = config.variables.slskd.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."soulseek.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };


  # Add jellyfin user to special groups if enabled
  users.users = lib.mkIf cfg.enable {
    slskd.extraGroups = [ "media" ];
  };

  services.slskd = {
    group = "media";
    openFirewall = true;
  };

}
