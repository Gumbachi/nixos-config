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
    homer.enable = false; # Homepage for services overview

    immich.enable = true; # Photos backup and WebUI
    jellyfin.enable = true; # WebUI for serving movies and shows

    deluge.enable = true; # Deluge Bittorrent Manager
    syncthing.enable = true; # Sync files across devices
    prowlarr.enable = true; # Indexer manager
    radarr.enable = true; # Movie manager
    sonarr.enable = true; # Show Manager
    lidarr.enable = true; # Music Manager
    bazarr.enable = false; # Subtitle Manager
    jackett.enable = true; # A different indexer manager

    # Containerized
    gumbotchi.enable = false; # The goat
    vibrant.enable = true; # Color bot
    qbit-vpn.enable = true; # Qbit under a vpn in a container

  };
}
