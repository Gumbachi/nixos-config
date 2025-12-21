{ ... }: {
   
  services.greetd = {
    settings = rec {
      initial_session = {
        command = "btop";
        user = "jared";
      };
      default_session = initial_session;
    };
  };

}
