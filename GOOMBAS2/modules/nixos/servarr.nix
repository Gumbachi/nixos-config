{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.services;
  ports = {
    bazarr = 6767;
    prowlarr = 9696;
    radarr = 7878;
    sonarr = 8989;
  };
in
{

  # Reverse Proxy
  services.caddy.virtualHosts = {
    "prowlarr.gumbachi.com".extraConfig = 
      mkIf cfg.prowlarr.enable ''reverse_proxy localhost:${toString ports.prowlarr}'';
    "sonarr.gumbachi.com".extraConfig = 
      mkIf cfg.sonarr.enable ''reverse_proxy localhost:${toString ports.sonarr}'';
    "bazarr.gumbachi.com".extraConfig = 
      mkIf cfg.bazarr.enable ''reverse_proxy localhost:${toString ports.bazarr}'';
    "radarr.gumbachi.com".extraConfig = 
      mkIf cfg.radarr.enable ''reverse_proxy localhost:${toString ports.radarr}'';
  };

  # API Keys
  age.secrets = {
    radarr.file = ../../secrets/radarr.age;
    sonarr.file = ../../secrets/sonarr.age;
    prowlarr.file = ../../secrets/prowlarr.age;
  };

  services = {
    prowlarr = {
      # dataDir = "/mnt/main/config/prowlarr";
      environmentFiles = [ config.age.secrets.prowlarr.path ];
      settings.server.port = ports.prowlarr;
      # settings.auth = {
      #   authenticationmethod = "Forms";
      #   authenticationrequired = "Enabled";
      # };
      # This settings gets the DB to lock too often just hold off until nixified
    };

    radarr = {
      group = "media";
      dataDir = "/mnt/main/config/radarr";
      environmentFiles = [ config.age.secrets.radarr.path ];
      settings.server.port = ports.radarr;
      settings.auth = {
        authenticationmethod = "Forms";
        authenticationrequired = "Enabled";
      };
    };

    sonarr = {
      group = "media";
      dataDir = "/mnt/main/config/sonarr";
      environmentFiles = [ config.age.secrets.sonarr.path ];
      settings.server.port = ports.sonarr;
      settings.auth = {
        authenticationmethod = "Forms";
        authenticationrequired = "Enabled";
      };
    };

    bazarr = {
      listenPort = ports.bazarr; # Bazarr option gotta be different for some reason
      group = "media";
      dataDir = "/mnt/main/config/bazarr";
    };

  };

}
