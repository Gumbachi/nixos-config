{ ... }: {

  services.matrix-conduit = {
    settings.global = {
      server_name = "chat.gumbachi.com";
      allow_registration = true;
    };
  };

}
