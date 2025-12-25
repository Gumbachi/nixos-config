{ ... }: {

  services = {
    # System Services
    nixos-cli.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = false;
    openssh.enable = true;
    greetd.enable = false;

    # Outward Services
    caddy.enable = true; # Auto HTTPS and Reverse Proxy
    adguardhome.enable = true; # DNS Adblocking
    homepage-dashboard.enable = true; # Homepage for service overview
    searx.enable = true; # Self hosted meta search engine
    scrutiny.enable = true; # Disk health monitoring

    immich.enable = true; # Photos backup and WebUI
    jellyfin.enable = true; # WebUI for serving movies and shows
    mopidy.enable = true; # Music Server
    chhoto-url.enable = false; # URL Shortener

    deluge.enable = true; # Deluge Bittorrent Manager
    syncthing.enable = true; # Sync files across devices
    prowlarr.enable = false; # Indexer manager
    radarr.enable = true; # Movie manager
    sonarr.enable = true; # Show Manager
    lidarr.enable = true; # Music Manager
    bazarr.enable = false; # Subtitle Manager
    jackett.enable = true; # A different indexer manager
    flaresolverr.enable = true; # Bypass cloudflare

    # Containerized
    gumbotchi.enable = false; # The goat
    vibrant.enable = true; # Color bot
    qbit-vpn.enable = true; # Qbit under a vpn in a container

  };
}
