{ config, lib, ... }:
let
  cfg = config.services.caddy;
in
{

  networking.firewall.allowedTCPPorts = lib.mkIf cfg.enable [ 80 443 ];

  services.caddy = {
    virtualHosts = {

      # ! README !
      #
      # Most caddy hosts configuration is found in the services respective module
      # in hostname/modules/nixos/
      
      # Base Domain - For profile page eventually
      "gumbachi.com".extraConfig = ''
        respond "Howdy"
      '';

      # Simple file server for image hosting mostly
      "files.gumbachi.com".extraConfig = ''
        root * /mnt/main/config/caddy/srv
        file_server browse
      '';

    };
  };

}
