{ config, lib, ... }:
let
  cfg = config.services.caddy;
  ports = {
    adguardhome = config.variables.adguardhome.port;
  };
in
{

  networking.firewall.allowedTCPPorts = lib.mkIf cfg.enable [ 80 443 ];

  services.caddy = {
    email = "caddy@gumbachi.com";
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

      # # Simple file server for image hosting mostly
      # "login.gumbachi.com".extraConfig = ''
      #   basic_auth {
		    #   Gumbachi $2a$14$H1uMhJgDqbJW7R1wdg0xp.P/hmPE76d3ROGNOS1JwvKM3yJarBZQa
	     #  }
	     #  respond "Welcome, {http.auth.user.id}" 200
      # '';

    };
  };

}
