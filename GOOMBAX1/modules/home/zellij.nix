{ ... }: {

  programs.zellij = {
    attachExistingSession = true;
    exitShellOnExit = false;
    enableFishIntegration = true;
  };

}
