{ config, lib, ... }: let
  cfg = config.services.homepage-dashboard;
  port = config.variables.homepage.port;
  vars = config.variables;
in {
  # Reverse proxy
  services.caddy.virtualHosts."homepage.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
    # if you add a server alias make sure to add to allowed hosts
    # e.g. allowedHosts = "homepage.gumbachi.com,dashboard.gumbachi.com, ..."
    serverAliases = [ "home.gumbachi.com" ];
  };

  services.homepage-dashboard = {
    listenPort = port;
    openFirewall = true;
    allowedHosts = "homepage.gumbachi.com,home.gumbachi.com,192.168.69.2:${toString port}";
  };

  # Settings - https://gethomepage.dev/configs/settings/
  services.homepage-dashboard.settings = {
    title = "Home";
    description = "GOOMBAS2";
    # theme = "dark";
    target = "_self"; # Open in place of homepage
    fullWidth = true;
    statusStyle = "dot";
    cardBlur = "md";
    favicon = "https://files.gumbachi.com/icons/home.png";
    background.image = "https://files.gumbachi.com/wallpapers/bisbiswas10.jpg";
    hideVersion = true;
  };

  # Layout - https://gethomepage.dev/configs/settings/#layout
  services.homepage-dashboard.settings.layout = [
    {
      Bookmarks = {
        columns = 4;
        style = "row";
      };
    }
    {
      Services = {
        columns = 4;
        style = "row";
      };
    }
  ];

  # Widgets - https://gethomepage.dev/configs/info-widgets/
  services.homepage-dashboard.widgets = [
    {
      resources.cpu = true;
      resources.memory = true;
      resources.disk = "/mnt/main";
      resources.network = true;
    }
    {
      search.provider = "duckduckgo";
      search.focus = false;
      search.showSearchSuggestions = false;
      search.target = "_self";
    }
  ];

  # Bookmarks - https://gethomepage.dev/configs/bookmarks/
  services.homepage-dashboard.bookmarks = [{
    Bookmarks = [
      {
        "NixOS Search" = [{
          href = "https://search.nixos.org/options?channel=unstable";
          icon = "nixos.png";
          description = "";
        }];
      }
      {
        "Home Manager" = [{
          href = "https://home-manager-options.extranix.com/?query=&release=master";
          icon = "nixos.png";
          description = "";
        }];
      }
      {
        "Codeberg" = [{
          href = "https://codeberg.org/";
          icon = "codeberg.png";
          description = "";
        }];
      }
      {
        "GitHub" = [{
          href = "https://github.com/";
          icon = "github-light.png";
          description = "";
        }];
      }
      {
        "YouTube" = [{
          href = "https://youtube.com";
          icon = "youtube.png";
          description = "";
        }];
      }
      {
        "Reddit" = [{
          href = "https://reddit.com";
          icon = "reddit.png";
          description = "";
        }];
      }
      {
        "SteamDB" = [{
          href = "https://steamdb.info";
          icon = "steam.png";
          description = "";
        }];
      }
      {
        "ProtonDB" = [{
          href = "https://protondb.com";
          icon = "steam.png";
          description = "";
        }];
      }
      {
        "PurelyMail" = [{
          href = "https://purelymail.com";
          icon = "purelymail.png";
          description = "";
        }];
      }
      {
        "Porkbun" = [{
          href = "https://porkbun.com";
          icon = "porkbun.png";
          description = "";
        }];
      }
      {
        "TorrentLeech" = [{
          href = "https://torrentleech.org/";
          icon = "nzbget";
          description = "";
        }];
      }
      {
        "Anonamouse" = [{
          href = "https://www.myanonamouse.net/";
          icon = "nzbget";
          description = "";
        }];
      }
    ];
  }];


  # Services - https://gethomepage.dev/configs/services/
  services.homepage-dashboard.services = [{
    Services = [
      {
        "Sonarr" = {
          icon = "sonarr.png";
          description = "Shows";
          href = "https://sonarr.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.sonarr.port}";
        };
      }
      {
        "Qbit VPN" = {
          icon = "qbittorrent.png";
          description = "Bittorrent";
          href = "https://qbit-vpn.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.qbit-vpn.port}";
        };
      }
      {
        "Deluge" = {
          icon = "deluge.png";
          description = "Bittorrent";
          href = "https://open-deluge.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.deluge.port}";
        };
      }
      {
        "File Server" = {
          icon = "files.png";
          description = "File Browser";
          href = "https://files.gumbachi.com";
          siteMonitor = "https://files.gumbachi.com";
        };
      }
      {
        "Jellyfin" = {
          icon = "jellyfin.png";
          description = "Better than Plex";
          href = "https://watch.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.jellyfin.port}";
        };
      }
      {
        "Radarr" = {
          icon = "radarr.png";
          description = "Movies";
          href = "https://radarr.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.radarr.port}";
        };
      }
      # {
      #   "Bazarr" = {
      #     icon = "bazarr.png";
      #     description = "Subtitles";
      #     href = "https://bazarr.gumbachi.com";
      #     siteMonitor = "http://localhost:6767";
      #   };
      # }
      {
        "Prowlarr" = {
          icon = "prowlarr.png";
          description = "Indexer Management";
          href = "https://prowlarr.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.prowlarr.port}";
        };
      }
      {
        "Syncthing - GOOMBAS2" = {
          icon = "syncthing.png";
          description = "File Sync";
          href = "https://sync.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.syncthing.port}";
        };
      }
      {
        "Adguard" = {
          icon = "adguard-home.png";
          description = "DNS ad-blocking";
          href = "https://adguard.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.adguardhome.port}";
        };
      }
      {
        "Immich" = {
          icon = "immich.png";
          description = "Cloud Photos";
          href = "https://photos.gumbachi.com";
          siteMonitor = "http://localhost:${toString vars.immich.port}";
        };
      }
    ];
  }];
}
