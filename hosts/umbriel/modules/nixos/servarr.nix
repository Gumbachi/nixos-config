{ config, lib, ... }:
let
  cfg = config.services;
  ports = {
    bazarr = config.variables.bazarr.port;
    prowlarr = config.variables.prowlarr.port;
    radarr = config.variables.radarr.port;
    sonarr = config.variables.sonarr.port;
    lidarr = config.variables.lidarr.port;
  };
in
{

  # Reverse Proxy
  services.caddy.virtualHosts = {
    "prowlarr.gumbachi.com".extraConfig =
      lib.mkIf cfg.prowlarr.enable ''reverse_proxy localhost:${toString ports.prowlarr}'';
    "sonarr.gumbachi.com".extraConfig =
      lib.mkIf cfg.sonarr.enable ''reverse_proxy localhost:${toString ports.sonarr}'';
    "bazarr.gumbachi.com".extraConfig =
      lib.mkIf cfg.bazarr.enable ''reverse_proxy localhost:${toString ports.bazarr}'';
    "radarr.gumbachi.com".extraConfig =
      lib.mkIf cfg.radarr.enable ''reverse_proxy localhost:${toString ports.radarr}'';
    "lidarr.gumbachi.com".extraConfig =
      lib.mkIf cfg.radarr.enable ''reverse_proxy localhost:${toString ports.lidarr}'';
  };

  # Secrets
  age.secrets.radarr.file = ../../secrets/radarr.age;
  services.radarr.environmentFiles = [ config.age.secrets.radarr.path ];

  age.secrets.sonarr.file = ../../secrets/sonarr.age;
  services.sonarr.environmentFiles = [ config.age.secrets.sonarr.path ];

  # Main Config
  services.prowlarr = {
    # dataDir = "/mnt/main/config/prowlarr"; # Cant enable this
    openFirewall = true;
    settings.server.port = ports.prowlarr;
    settings.auth = {
      authenticationmethod = "Forms";
      authenticationrequired = "Enabled";
    };
  };

  services.radarr = {
    openFirewall = true;
    settings.server.port = ports.radarr;
    group = "media";
    dataDir = "/mnt/main/config/radarr";
    settings.auth = {
      authenticationmethod = "Forms";
      authenticationrequired = "Enabled";
    };
  };

  services.sonarr = {
    openFirewall = true;
    settings.server.port = ports.sonarr;
    group = "media";
    dataDir = "/mnt/main/config/sonarr";
    settings.auth = {
      authenticationmethod = "Forms";
      authenticationrequired = "Enabled";
    };
  };

  services.lidarr = {
    openFirewall = true;
    settings.server.port = ports.lidarr;
    group = "media";
    dataDir = "/mnt/main/config/lidarr";
    settings.auth = {
      authenticationmethod = "Forms";
      authenticationrequired = "Enabled";
    };
  };

  # Allow flaresolverr
  services.flaresolverr.openFirewall = true;

  services.bazarr = {
    listenPort = ports.bazarr; # Bazarr option gotta be different for some reason
    group = "media";
    dataDir = "/mnt/main/config/bazarr";
  };

}
