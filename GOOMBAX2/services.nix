{ ... }: {

  services = {

    fwupd.enable = false;

    blueman.enable = true;

    playerctld.enable = false;

    printing.enable = true;

    power-profiles-daemon.enable = true;

    openssh.enable = true;

    gvfs.enable = true;

  };
  
}
