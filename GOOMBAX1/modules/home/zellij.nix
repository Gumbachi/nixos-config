{ ... }: {

  programs.zellij = {
    attachExistingSession = true;
    exitShellOnExit = true;
    enableFishIntegration = true;
  };

}
