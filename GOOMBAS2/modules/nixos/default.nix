{ ... }: {

  # These are just configs they do not enable the programs themselves
  # That should be done in programs.nix or services.nix
  imports = [

    # Programs
    ../../../GOOMBAX1/modules/nixos/nvf.nix
      
    # System Services
    ./greetd.nix
    ./ssh.nix

    # Torrent Clients
    ./torrent-clients/deluge.nix
    ./torrent-clients/deluge-vpn.nix
    ./torrent-clients/qbit-vpn.nix

    # Homelab services
    ./adguardhome.nix
    ./caddy.nix
    ./gumbotchi.nix
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./matrix.nix
    ./minecraft.nix
    ./servarr.nix
    ./syncthing.nix
    ./uptime-kuma.nix
    ./vibrant.nix

  ];

}
