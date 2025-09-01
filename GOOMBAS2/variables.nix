{ lib, ... }:
let
  inherit (lib) mkOption;
in
{

  options.variables = {
    adguardhome.port = mkOption { default = 3080; };
    homepage.port = mkOption { default = 8082; };
    immich.port = mkOption { default = 2283; };
    jellyfin.port = mkOption { deafult = 8096; };
    jellyseerr.port = mkOption { default = 5055; };
    syncthing.port = mkOption { default = 8384; };

    radarr.port = mkOption { default = 7878; };
    sonarr.port = mkOption { default = 8989; };
    prowlarr.port = mkOption { default = 9696; };
    bazarr.port = mkOption { default = 6767; };

    qbit-vpn.port = mkOption { default = 8668; };
    deluge.port = mkOption { default = 8112; };
  };

}
