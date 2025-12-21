{ ... }: {

  users.users.jared.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDunG/8V8/5tvAJdVpYqoMtb4FaI6LYgie/5VmmS5ChH jared@enceladus"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKy7se5rdlXmFkrWzfQj1Uej19mCupQDMoD67TJ7TBA"
  ];

  services.openssh.settings.PasswordAuthentication = false;

}
