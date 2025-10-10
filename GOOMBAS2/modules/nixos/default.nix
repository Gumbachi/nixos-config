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
    ./deluge.nix
    ./deluge-vpn.nix
    ./qbit-vpn.nix

    # Homelab services
    ./adguardhome.nix
    ./caddy.nix
    ./gumbotchi.nix
    ./homepage.nix
    ./homer.nix
    ./immich.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./minecraft.nix
    ./servarr.nix
    ./syncthing.nix
    ./vibrant.nix

  ];

}
