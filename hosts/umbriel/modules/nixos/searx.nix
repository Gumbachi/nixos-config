{ config, lib, ... }: let
  cfg = config.services.searx;
  port = config.variables.searx.port;
in {

  # Reverse Proxy
  services.caddy.virtualHosts."search.gumbachi.com" = lib.mkIf cfg.enable {
    extraConfig = ''
      basic_auth {
	      Gumbachi $2a$14$H1uMhJgDqbJW7R1wdg0xp.P/hmPE76d3ROGNOS1JwvKM3yJarBZQa
      }
      reverse_proxy localhost:${toString port}
    '';
  };

  # Secrets
  age.secrets.searx.file = ../../secrets/searx.age;
  services.searx.environmentFile = config.age.secrets.searx.path;

  services.searx.settings.engines = [
    {
      name = "brave";
      disabled = true;
    }
    {
      name = "duckduckgo";
      disabled = true;
    }
    {
      name = "wikipedia";
      disabled = false;
    }
    {
      name = "wikidata";
      disabled = true;
    }
    {
      name = "startpage";
      disabled = false;
    }
  ];

  services.searx.settings.server = {
    port = port;
    bind_address = "127.0.0.1";
    secret_key = "$SEARX_SECRET_KEY";
  };

  services.searx.settings.search = {
    default_lang = "en-US";
    languages = [ "en-US" ];
    favicon_resolver = "google";
  };

  services.searx.settings.ui = {
    locale = "en";
    center_alignment = true;
    url_formatting = "pretty";
  };

  services.searx.settings.categories_as_tabs = {
     general = {};
     images = {};
  };

  services.searx.faviconsSettings.favicons = {
    cfg_schema = 1;
    cache = {
      db_url = "/var/cache/searx/faviconcache.db";
      HOLD_TIME = 5184000;
      LIMIT_TOTAL_BYTES = 2147483648;
      BLOB_MAX_BYTES = 40960;
      MAINTENANCE_MODE = "auto";
      MAINTENANCE_PERIOD = 600;
    };
  };

}
