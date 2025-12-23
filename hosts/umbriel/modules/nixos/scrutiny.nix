{ config, lib, ... }: let
  cfg = config.services.scrutiny;
  port = config.variables.scrutiny.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."disks.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''
      basic_auth {
        Gumbachi $2a$14$H1uMhJgDqbJW7R1wdg0xp.P/hmPE76d3ROGNOS1JwvKM3yJarBZQa
      }
      reverse_proxy localhost:${toString port}
    '';
  };

  services.scrutiny = {
    openFirewall = true;
    settings.web.listen.port = port;
  };

}
