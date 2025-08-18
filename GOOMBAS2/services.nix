{ ... }: {
  
  services = {
    # System Services
    power-profiles-daemon.enable = true;
    printing.enable = false;
    openssh.enable = true;
    greetd.enable = true;

    # Outward Services
    caddy.enable = true; # Auto HTTPS and Reverse Proxy
    uptime-kuma.enable = false; # Uptime WebUI
    adguardhome.enable = true; # DNS Adblocking
    homepage-dashboard.enable = true; # Homepage for service overview
    immich.enable = true; # Photos backup and WebUI
    jellyfin.enable = true; # WebUI for serving movies and shows
    jellyseerr.enable = true; # WebUI for requesting movies and shows
    deluge.enable = true; # Deluge Bittorrent Manager
    syncthing.enable = true; # Sync files across devices
    prowlarr.enable = true; # Indexer manager
    radarr.enable = true; # Movie manager
    sonarr.enable = true; # Show Manager
    bazarr.enable = true; # Subtitle Manager

    # Containerized
    gumbotchi.enable = true; # The goat
    vibrant.enable = true; # Color bot
    deluge-vpn.enable = false; # Deluge running under a vpn in a container
    qbit-vpn.enable = true; # Qbit under a vpn in a container

  };
}
