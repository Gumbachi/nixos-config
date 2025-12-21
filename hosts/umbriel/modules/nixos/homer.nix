{ config, lib, ... }: let
  cfg = config.services.homer;
  vars = config.variables;
in {

  # Server
  services.homer.virtualHost = lib.mkIf cfg.enable {
    caddy.enable = true;
    domain = "homer.gumbachi.com";
  };

  services.homer.settings = {
    title = "Umbriel";
    subtitle = "Dashboard";
    # logo = "assets/logo.png";
    header = false;
    columns = "3";
    connectivityCheck = true;

    defaults = {
      layout = "columns";
      colorTheme = "auto";
    };

    theme = "default";

    links = [
      {
        name = "GitHub";
        icon = "fab fa-github";
        url = "https://github.com";
      }
      {
        name = "NixOS Search";
        icon = "fas fa-snowflake";
        url = "https://search.nixos.org";
      }
    ];

    services = [
      {
        name = "Services";
        icon = "fas fa-server";
        items = [
          {
            name = "Immich";
            icon = "fas fa-image";
            subtitle = "Self hosted photos";
            url = "localhost:2283";
            target = "_self";
          }
          {
            name = "Jellyfin";
            icon = "fas fa-video";
            subtitle = "Better than plex";
            url = "localhost:8096";
            target = "_self";
          }
        ];
      }
      # {
      #   name = "Bookmarks";
      #   icon = "fas fa-bookmark";
      #   items = [
      #     {
      #       name = "Pi-hole";
      #       target = "_blank";
      #     }
      #   ];
      # }
    ];
  };


  # services.homer.settings = {
  #   title = "Umbriel";
  #   subtitle = "Homepage";
  #   columns = 3;
  #   connectivityCheck = true;

  #   defaults = {
  #     layout = "columns";
  #     colorTheme = "auto";
  #   };


  #   services = [
  #     # Group 1
  #     {
  #       name = "Group 1";
  #       icon = "fas fa-code-branch";
  #       items = [
  #         {
  #           name = "Immich";
  #           logo = "fas fa-images";
  #           url = "localhost:2283";
  #         }
  #         {
  #           name = "Jellyfin";
  #           logo = "fas fa-video";
  #           url = "localhost:8096";
  #         }
  #       ];
  #     }

  #     # Group 2 goes here

  #   ];


  # };

}
