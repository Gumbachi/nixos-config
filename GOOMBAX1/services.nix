{ ... }: {

  services = {

    # Printing
    printing.enable = true;

    openssh.enable = true;

    # Automatic firmware updater
    fwupd.enable = false;

    # Media Control Service
    playerctld.enable = false;

    # Gnome Virtual File System - needed for AGS images
    gvfs.enable = true;

    syncthing.enable = true;

    sunshine.enable = false;

    power-profiles-daemon.enable = true;

    nixos-cli.enable = true;

    # Bluetooth if needed
    blueman.enable = false;

  };

  # Home manager programs
  home-manager.sharedModules = [{
    services = {
      hypridle.enable = true;
      hyprpaper.enable = true;
      hyprpolkitagent.enable = true;
      clipse.enable = true;
      wlsunset.enable = true;
    };
  }];


}
