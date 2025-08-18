{ config, lib, ... }:
let
  cfg = config.services.homepage-dashboard;
  port = 8082;
in
{
  # Reverse proxy
  services.caddy.virtualHosts."homepage.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${toString port}'';
    serverAliases = [ "dashboard.gumbachi.com" ];
  };

  # Secrets
  age.secrets.dashboard = {
    file = ../../secrets/dashboard.age;
    owner = "root";
    group = "users";
    mode = "400";
  };

  services.homepage-dashboard = {
    listenPort = port;
    openFirewall = true;
    allowedHosts = "homepage.gumbachi.com,dashboard.gumbachi.com";
    environmentFile = config.age.secrets.dashboard.path;

    # Settings - https://gethomepage.dev/configs/settings/
    settings = {
      title = "Home";
      description = "GOOMBAS2 Dashboard";
      # theme = "dark";
      useEqualHeights = true;
      hideVersion = true;
      target = "_self"; # Open in place of homepage
      fullWidth = true;
      statusStyle = "dot";
      cardBlur = "xl";
      favicon = "https://files.gumbachi.com/icons/home.png";
      background = {
        image = "https://files.gumbachi.com/wallpapers/nix-gray.png";
        blur = "md";
      };
      layout = {
        Sites = {
          style = "row";
          columns = 4;
        };
        Bookmarks = {
          style = "row";
          columns = 4;
        };
        Media = {
          style = "row";
          columns = 3;
        };
        Other = {
          style = "row";
          columns = 3;
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
          disk = "/mnt/main";
          network = true;
        };
      }
    ];

    # Services - https://gethomepage.dev/configs/services/
    services = [

      # # Media Group
      # { 
      #   "Media" = [
      #     {
      #       "Jellyfin" = {
      #         icon = "jellyfin.png";
      #         description = "Better than Plex";
      #         href = "https://watch.gumbachi.com";
      #         siteMonitor = "https://watch.gumbachi.com";
      #         widget = {
      #           type = "jellyfin";
      #           url = "http://localhost:8096";
      #           key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
      #           enableBlocks = false;
      #           showEpisodeNumber = true;
      #         };
      #       };
      #     }
      #
      #     {
      #       "Jellyseerr" = {
      #         icon = "jellyseerr.png";
      #         description = "Better than Overseerr";
      #         href = "https://request.gumbachi.com";
      #         siteMonitor = "https://request.gumbachi.com";
      #         widget = {
      #           type = "jellyseerr";
      #           url = "http://localhost:5055";
      #           key = "{{HOMEPAGE_VAR_JELLYSEERR_KEY}}";
      #         };
      #       };
      #     }
      #
      #     { 
      #       "Radarr" = {
      #         icon = "radarr.png";
      #         description = "Movies";
      #         href = "https://radarr.gumbachi.com";
      #         siteMonitor = "https://radarr.gumbachi.com";
      #         widget = {
      #           type = "radarr";
      #           url = "http://localhost:7878";
      #           key = "{{HOMEPAGE_VAR_RADARR_KEY}}";
      #           fields = [ "wanted" "queued" "movies" ];
      #           enableQueue = true;
      #         };
      #       };
      #     }
      #
      #     {
      #       "Sonarr" = {
      #         icon = "sonarr.png";
      #         description = "Shows";
      #         href = "https://sonarr.gumbachi.com";
      #         siteMonitor = "https://sonarr.gumbachi.com";
      #         widget = {
      #           type = "sonarr";
      #           url = "http://localhost:8989";
      #           key = "{{HOMEPAGE_VAR_SONARR_KEY}}";
      #         };
      #       };
      #     }
      #
      #
      #     {
      #       "Deluge VPN" = {
      #         icon = "deluge.png";
      #         description = "Bittorrent";
      #         href = "https://sail.gumbachi.com";
      #         siteMonitor = "https://sail.gumbachi.com";
      #         widget = {
      #           type = "deluge";
      #           url = "http://localhost:8112";
      #           password = "{{HOMEPAGE_VAR_DELUGE_PASSWORD}}";
      #           enableLeechProgress = true;
      #           fields = [ "leech" "seed" "download" "upload" ];
      #         };
      #       };
      #     }
      #
      #     {
      #       "Prowlarr" = {
      #         icon = "prowlarr.png";
      #         description = "Indexer Management";
      #         href = "https://prowlarr.gumbachi.com";
      #         siteMonitor = "https://prowlarr.gumbachi.com";
      #         widget = {
      #           type = "prowlarr";
      #           url = "http://localhost:9696";
      #           key = "{{HOMEPAGE_VAR_PROWLARR_KEY}}";
      #           fields = [ "numberOfGrabs" "numberOfQueries" ];
      #         };
      #       };
      #     }
      #
      #   ];
      # }

      # # Network Group
      # {
      #   "Other" = [
      #
      #     {
      #       "Adguard" = {
      #         icon = "adguard-home.png";
      #         description = "DNS ad-blocking";
      #         href = "https://adguard.gumbachi.com";
      #         siteMonitor = "https://adguard.gumbachi.com";
      #         widget = {
      #           type = "adguard";
      #           url = "http://localhost:3080";
      #           username = "{{HOMEPAGE_VAR_ADGUARD_USERNAME}}";
      #           password = "{{HOMEPAGE_VAR_ADGUARD_PASSWORD}}";
      #           fields = [ "queries" "blocked" "latency" ];
      #         };
      #       };
      #     }
      #
      #     {
      #       "Immich" = {
      #         icon = "immich.png";
      #         description = "Cloud Photos";
      #         href = "https://photos.gumbachi.com";
      #         siteMonitor = "https://photos.gumbachi.com";
      #         widget = {
      #           type = "immich";
      #           version = 2;
      #           url = "http://localhost:2283";
      #           key = "{{HOMEPAGE_VAR_IMMICH_KEY}}";
      #           fields = [ "photos" "videos" "storage" ];
      #         };
      #       };
      #     }
      #   ];
      # }

      # Uptime Checks
      {
        "Sites" = [

          {
            "Jellyseerr" = {
              icon = "jellyseerr.png";
              description = "Better than Overseerr";
              href = "https://request.gumbachi.com";
              siteMonitor = "http://localhost:5055";
            };
          }

          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              description = "Better than Plex";
              href = "https://watch.gumbachi.com";
              siteMonitor = "http://localhost:8096";
            };
          }

          # {
          #   "Deluge VPN" = {
          #     icon = "deluge.png";
          #     description = "Bittorrent";
          #     href = "https://sail.gumbachi.com";
          #     siteMonitor = "http://localhost:8112";
          #   };
          # }
          {
            "Qbit VPN" = {
              icon = "qbittorrent.png";
              description = "Bittorrent";
              href = "https://qbit-vpn.gumbachi.com";
              siteMonitor = "http://localhost:8668";
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
            "Deluge Open" = {
              icon = "deluge.png";
              description = "Bittorrent";
              href = "https://open-deluge.gumbachi.com";
              siteMonitor = "http://localhost:8111";
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
    bookmarks = [

      {
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

        ];
      }

    ];

  };

}
