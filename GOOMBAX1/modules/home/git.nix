{ ... }: {

  programs.git = {
    enable = true;
    settings = {
      user.name = "Gumbachi";
      user.email = "github@gumbachi.com";
      merge.ff = true;
    };
  };
}
