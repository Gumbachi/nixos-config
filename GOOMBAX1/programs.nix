{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.overway.packages.${system}.default
    inputs.agenix.packages.${system}.default

    inputs.caelestia.packages.${system}.default

    youtube-music
    quickshell

    playerctl

    wl-clipboard # Clipboard backend
    hyprpicker # Color Picker
    pavucontrol # Sound Settings
    hyprshot
    nwg-look # GTK Style GUI
    wally-cli
  ];

  # Home manager programs
  home-manager.sharedModules = [{
    wayland.windowManager.hyprland.enable = true;
    programs.hyprlock.enable = true;

    programs.nh = {
      enable = true;
      flake = "/home/jared/nixos-config";
    };
  }];

  launchers = {
    fuzzel.enable = false;
    walker.enable = true;
  };

  terminals.kitty.enable = true;

  viewers = {
    qimgv.enable = true;
    imv.enable = false;
    mpv.enable = true;
    vlc.enable = true;
  };

  social = {
    vesktop.enable = true;
    element.enable = true;
  };

  shells = {
    default = pkgs.fish;
    fish.enable = true;
    nushell.enable = false;
  };

  file-managers = {
    yazi.enable = true;
    thunar.enable = false;
  };

  cli-tools = {
    upgrades.enable = true; # Upgrade common tools like ls,cat,etc
    ricing.enable = true; # Enable for fun style tools like cava
    tokei.enable = true; # Line counter
    unar.enable = true; # Zip archives
    unrar.enable = true; # Rar archives
  };

  gaming = {
    steam.enable = true;
    mangohud.enable = true;
    steam-tui.enable = true;
    lutris.enable = true;
    heroic.enable = false;
    protonplus.enable = true;
    minecraft.enable = true;
  };

  email = {
    thunderbird.enable = true;
    aerc.enable = true;
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    direnv.silent = true;
    android.enable = true;
    just.enable = true;
  };

  browsers = {
    floorp.enable = true;
    chromium.enable = true;
    librewolf.enable = false;
    ladybird.enable = false;
  };

  programs = {
    nix-ld.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    java.enable = true;
  };

  diagnostics = {
    lact.enable = true;
    btop.enable = true;
    systemctl-tui.enable = true;
  };

  emulation = {
    gba.mgba.enable = false;
    switch.ryubing.enable = false;
    retroarch.enable = true;
  };

  editors = {

    libreoffice.enable = true;

    image = {
      gimp.enable = true;
      krita.enable = false;
    };

    video = {
      handbrake.enable = false;
      losslesscut.enable = false;
    };

    text.helix = {
      enable = true;
      setDefault = true;
    };

    text.nvf = {
      enable = true;
      setDefault = false;
    };

  };

}
