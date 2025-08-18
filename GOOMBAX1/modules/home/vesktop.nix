{ ... }: {

  programs.vesktop = {
    settings = {
      discordBranch = "stable";
      customTitleBar = false;
      enableMenu = true;
      minimizeToTray = false;
      splashTheming = true;
      tray = true;
      hardwareAcceleration = true;
    };
    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = true;
      useQuickCss = true;

      plugins = {
        AlwaysTrust.enabled = true;
        ClearURLs.enabled = true;
        CopyFileContents.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FakeNitro.enabled = true;
        MentionAvatars.enabled = true;
        NoF1.enabled = true;
        NoOnboardingDelay.enabled = true;
        RoleColorEverywhere.enabled = true;
        ShowTimeoutDuration.enabled = true;
        TypingTweaks.enabled = true;
        Unindent.enabled = true;
        VolumeBooster.enabled = true;
        WebScreenShareFixes.enabled = true;
        WhoReacted.enabled = true;
        YoutubeAdblock.enabled = true;
        ShikiCodeblocks.enabled = true;
      };
    };

  };

}
