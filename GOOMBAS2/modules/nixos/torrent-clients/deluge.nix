{ config, lib, ... }:
let
  cfg = config.services.deluge;
  port = 8111;
in
{

  # Secrets
  age.secrets.deluge-auth = {
    file = ../../../secrets/deluge.age;
    owner = "deluge";
    group = "media";
    mode = "440";
  };

  # Reverse Proxy
  services.caddy.virtualHosts."open-deluge.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
  };

  services.deluge = {
    openFirewall = true;
    group = "media";
    web = {
      enable = cfg.enable;
      openFirewall = true;
      port = port;
    };

    declarative = true; # Force config
    authFile = config.age.secrets.deluge-auth.path; # File should be plaintext as user:pass:level

    # Find config here https://git.deluge-torrent.org/deluge/tree/deluge/core/preferencesmanager.py#n41
    config = {
      download_location = "/mnt/main/torrents/open";
      dont_count_slow_torrents = false;
      allow_remote = true;
      daemon_port = 58847;
      listen_ports = [ 6882 6890 ];
      # These below options rename the torrent file to be unreadable
      # copy_torrent_file = true;
      # torrentfiles_location = "/mnt/main/Sync/Torrents";
    };
  };

}
