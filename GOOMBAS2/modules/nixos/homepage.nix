{ config, lib, ... }:
let
  cfg = config.services.homepage-dashboard;
  port = config.variables.homepage.port;
  vars = config.variables;
in
{
  # Reverse proxy
  services.caddy.virtualHosts."homepage.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
    # if you add a server alias make sure to add to allowed hosts
    # e.g. allowedHosts = "homepage.gumbachi.com,dashboard.gumbachi.com, ..."
  };

  # Main Configuration
  services.homepage-dashboard = {
    listenPort = port;
    openFirewall = true;
    allowedHosts = "homepage.gumbachi.com,192.168.69.2:${toString port}";

    # Settings - https://gethomepage.dev/configs/settings/
    settings = {
      title = "Home";
      description = "GOOMBAS2 Dashboard";
      theme = "dark";
      useEqualHeights = true;
      hideVersion = true;
      target = "_self"; # Open in place of homepage
      # fullWidth = true;
      statusStyle = "dot";
      cardBlur = "xl";
      favicon = "https://files.gumbachi.com/icons/home.png";
      background.image = "https://files.gumbachi.com/wallpapers/aurora.png";
      layout = {
        Sites = {
          style = "row";
          columns = 4;
        };
        Bookmarks = {
          style = "row";
          columns = 4;
        };
      };
        
    };

    # Widgets - https://gethomepage.dev/configs/info-widgets/
    widgets = [
      {
        search = {
          provider = "duckduckgo";
          focus = false;
          showSearchSuggestions = false;
          target = "_self";
        };
      }
      {
        resources = {
          cpu = true;
          memory = true;
          # disk = "/mnt/main";
          network = true;
        };
      }
    ];

    # Services - https://gethomepage.dev/configs/services/
    services = [
      # Uptime Checks
      {
        "Sites" = [
          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              description = "Better than Plex";
              href = "https://watch.gumbachi.com";
              siteMonitor = "http://localhost:8096";
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
            "File Server" = {
              icon = "files.png";
              description = "File Browser";
              href = "https://files.gumbachi.com";
              siteMonitor = "https://files.gumbachi.com";
            };
          }

          { 
            "Radarr" = {
              icon = "radarr.png";
              description = "Movies";
              href = "https://radarr.gumbachi.com";
              siteMonitor = "http://localhost:7878";
            };
          }

          {
            "Sonarr" = {
              icon = "sonarr.png";
              description = "Shows";
              href = "https://sonarr.gumbachi.com";
              siteMonitor = "http://localhost:8989";
            };
          }

          {
            "Bazarr" = {
              icon = "bazarr.png";
              description = "Subtitles";
              href = "https://bazarr.gumbachi.com";
              siteMonitor = "http://localhost:6767";
            };
          }

          {
            "Prowlarr" = {
              icon = "prowlarr.png";
              description = "Indexer Management";
              href = "https://prowlarr.gumbachi.com";
              siteMonitor = "http://localhost:9696";
            };
          }

          {
            "Syncthing" = {
              icon = "syncthing.png";
              description = "File Sync";
              href = "https://sync.gumbachi.com";
              siteMonitor = "http://localhost:8384";
            };
          }
          {
            "Deluge" = {
              icon = "deluge.png";
              description = "Bittorrent";
              href = "https://open-deluge.gumbachi.com";
              siteMonitor = "http://localhost:8112";
            };
          }

          {
            "Adguard" = {
              icon = "adguard-home.png";
              description = "DNS ad-blocking";
              href = "https://adguard.gumbachi.com";
              siteMonitor = "http://localhost:3080";
            };
          }

          {
            "Immich" = {
              icon = "immich.png";
              description = "Cloud Photos";
              href = "https://photos.gumbachi.com";
              siteMonitor = "http://localhost:2283";
            };
          }


        ];
      }
    ];

    # Bookmarks - https://gethomepage.dev/configs/bookmarks/
    bookmarks = [{
      "Bookmarks" = [
        {
          "NixOS Search" = [{
            abbr = "NX";
            href = "https://search.nixos.org/options?channel=unstable";
            icon = "nixos.png";
          }];
        }
        {
          "Home Manager" = [{
            abbr = "HM";
            href = "https://home-manager-options.extranix.com/?query=&release=master";
            description = "extranix.com";
            icon = "nixos.png";
          }];
        }
        {
          "GitHub" = [{
            abbr = "GH";
            href = "https://github.com/";
            icon = "github-light.png";
          }];
        }
        {
          "Codeberg" = [{
            abbr = "CB";
            href = "https://codeberg.org";
            icon = "codeberg.png";
          }];
        }
        {
          "YouTube" = [{
            abbr = "YT";
            href = "https://youtube.com";
            icon = "youtube.png";
          }];
        }
        {
          "Reddit" = [{
            abbr = "RD";
            href = "https://reddit.com";
            icon = "reddit.png";
          }];
        }
        {
          "SteamDB" = [{
            abbr = "SD";
            href = "https://steamdb.info";
            icon = "steam.png";
          }];
        }
        {
          "ProtonDB" = [{
            abbr = "PD";
            href = "https://protondb.com";
            icon = "steam.png";
          }];
        }
        {
          "PurelyMail" = [{
            abbr = "PM";
            href = "https://purelymail.com";
            icon = "purelymail.png";
          }];
        }
        {
          "Porkbun" = [{
            abbr = "PB";
            href = "https://porkbun.com";
            icon = "porkbun.png";
          }];
        }

        {
          "Achievements" = [{
            abbr = "RA";
            href = "https://retroachievements.org/";
            description = "retroachievements";
            icon = "si-retroarch";
          }];
        }
        {
          "TorrentLeech" = [{
            abbr = "TL";
            href = "https://torrentleech.org/";
            description = "torrents";
          }];
        }
        {
          "MAM" = [{
            abbr = "MA";
            href = "https://www.myanonamouse.net/";
            description = "books";
          }];
        }

      ];}
    ];
  };
}
