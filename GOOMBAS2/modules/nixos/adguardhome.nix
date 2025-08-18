{ lib, config, ... }:
let
  cfg = config.services.adguardhome;
  port = "3080";
in
{

  # Important Firewall Ports
  networking.firewall = lib.mkIf cfg.enable {
    allowedTCPPorts = [ 53 5443 ];
    allowedUDPPorts = [ 53 5443 ];
  };

  # Reverse Proxy
  services.caddy.virtualHosts."adguard.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''reverse_proxy localhost:${port}'';
  };

  services.adguardhome = {
    port = 3080;
    settings = {
      http.address = "0.0.0.0:${port}"; 
      users = [
        {
          name = "Gumbachi";
          password = "$2a$10$Z3ZX/e/VBObnsrLynWkD8uUv5H26nVimsv4LDBAbjnuLQ5MTOVvGC"; # This is a hash. It is safe to leave
        }
      ];
      dns = {
        anonymize_client_ip = false;
        ratelimit = 0;
        ratelimit_whitelist = [
          "192.168.69.2"
        ];
        refuse_any = false;
        upstream_dns = [
          "1.1.1.1"
        ];
        bootstrap_dns = [
          "9.9.9.10"
          "149.112.112.10"
          "2620:fe::10"
          "2620:fe::fe:10"
          "1.1.1.1"
        ];
        fallback_dns = [
          "8.8.8.8"
        ];
        upstream_mode = "load_balance";
        aaaa_disabled = false;
        enable_dnssec = true;
        max_goroutines = 600;
      };
      tls.enabled = false;
      dhcp.enabled = false;
      user_rules = [
        "'@@||s.youtube.com^'"
        "||mtalk.google.com^$important"
      ];
      filters = [
        {
          enabled = false;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          name = "AdGuard DNS filter";
          id = 1;
        }
        {
          enabled = false;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
          name = "AdAway Default Blocklist";
          id = 2;
        }
        {
          enabled = false;
          url = "https://github.com/ppfeufer/adguard-filter-list/blob/master/blocklist?raw=true";
          name = "Big List";
          id = 1738986649;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easylist.txt";
          name = "Easy List";
          id = 1738986650;
        }
        {
          enabled = true;
          url = "https://secure.fanboy.co.nz/fanboy-annoyance.txt";
          name = "Fanboy Annoyance List";
          id = 1738986651;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easyprivacy.txt";
          name = "Easy Privacy";
          id = 1738986652;
        }
      ];
    };
  };
}
