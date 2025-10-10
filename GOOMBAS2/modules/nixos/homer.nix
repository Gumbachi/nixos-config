{ config, lib, ... }: let
  cfg = config.services.homer;
  port = config.variables.homer.port;
  vars = config.variables;
in {

  # Reverse Proxy
  # services.homer.virtualHost = lib.mkIf cfg.enable {
  #   caddy.enable = true;
  #   domain = "homer.gumbachi.com";
  # };

  # Yaml Config
  # services.homer.settings = {
  # Reverse proxy
  services.caddy.virtualHosts."homer.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:8080'';
  };

    
  # };
  services.homer.enable = true;
}
