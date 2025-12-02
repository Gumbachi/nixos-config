{ config, lib, ... }:
let
  cfg = config.services.deluge;
  port = config.variables.deluge.port;
in
{

  # Secrets
  services.deluge.authFile = config.age.secrets.deluge-auth.path; # File should be plaintext as user:pass:level
  age.secrets.deluge-auth = lib.mkIf cfg.enable {
    file = ../../secrets/deluge.age;
    owner = "deluge";
    group = "media";
    mode = "770";
  };

  # Reverse Proxy
  services.caddy.virtualHosts."open-deluge.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  # Add immich user to special groups if immich is enabled
  users.users = lib.mkIf cfg.enable {
    deluge.extraGroups = lib.mkIf cfg.enable [ "media" ];
  };

  services.deluge = {
    dataDir = "/mnt/main/config/deluge";
    openFirewall = true;
    web = {
      enable = cfg.enable;
      openFirewall = true;
      port = port;
    };

    declarative = true; # Force config

    # Find config here https://git.deluge-torrent.org/deluge/tree/deluge/core/preferencesmanager.py#n41
    config = {
      download_location = "/mnt/main/torrents/open";
      dont_count_slow_torrents = false;
      allow_remote = true;
      max_active_seeding = 45;
      max_active_downloading = 5;
      max_active_limit = 50;
    };
  };

}
