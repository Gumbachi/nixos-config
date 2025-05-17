{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.overway.packages.${system}.default
    inputs.astal.packages.${system}.default

    youtube-music

    element-desktop

    # Make an option for video tools
    vlc # Video Player

    r2modman # Thunderstore mod Manager
  ];

  terminal = {
    dropInUpgrades.enable = true; # eza, ripgrep, bat, etc..
    ricing.enable = true; # fastfetch, cava, pipes, cbonsai
    systemctl-tui.enable = true;
    unar.enable = true; # Zip archives
    unrar.enable = true; # Rar archives
  };

  gaming = {
    steam = {
      enable = true;
      forceDesktopScaling = true;
    };
    mangohud.enable = true;
    protonup.enable = true;
    minecraft.enable = true;
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    android.enable = false;
    just.enable = true;
  };

  programs = {
    nix-ld.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    java.enable = true;
    thunar.enable = false;
    thunderbird.enable = true;
  };

  emulation = {
    gba.mgba.enable = true;
    switch.ryubing.enable = true;
  };

  editors = {

    libreoffice.enable = true;

    image = {
      gimp.enable = true;
      krita.enable = true;
    };

    video = {
      handbrake.enable = true;
      losslesscut.enable = true;
    };

    text.nvf = {
      enable = true;
      setDefault = true;
      languages = {
        python.enable = true;
        markdown.enable = true;
        css.enable = true;
        nix = {
          enable = true;
          format.enable = false;
          lsp.server = "nixd";
        };
        ts = {
          enable = true;
          format.enable = false;
        };
      };
    };

  };

}
