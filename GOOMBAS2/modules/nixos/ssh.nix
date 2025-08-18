{ ... }: {

  users.users.jared.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvJ/mvigyGpxh0SNRWqxYLS3HcsBhGPG1Pat7ldit+T jared@GOOMBAX1"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKy7se5rdlXmFkrWzfQj1Uej19mCupQDMoD67TJ7TBA"
  ];

  services.openssh.settings.PasswordAuthentication = false; 

}
