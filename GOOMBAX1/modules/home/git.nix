{ ... }: {

  programs.git = {
    enable = true;
    userName = "Gumbachi";
    userEmail = "github@gumbachi.com";
    extraConfig = {
      merge.ff = true;
    };
  };

  programs.gitui = {
    enable = true;
  };

}
