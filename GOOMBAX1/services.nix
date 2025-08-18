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

    # Helps speed up boot
    journald.extraConfig = ''
      Storage=volatile
      SystemMaxFileSize=50M
    '';

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
