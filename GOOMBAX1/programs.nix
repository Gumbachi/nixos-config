{ inputs, pkgs, ... }: {

  # System Programs
  environment.systemPackages = with pkgs; [
    inputs.overway.packages.${system}.default

    youtube-music
    quickshell

    playerctl
    # archipelago
    # poptracker

    wl-clipboard # Clipboard backend
    hyprpicker # Color Picker
    pavucontrol # Sound Settings
    hyprshot
    nwg-look # GTK Style GUI
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

  browsers = {
    floorp.enable = false;
    chromium.enable = true;
    librewolf.enable = true;
    ladybird.enable = false;
  };

  cli-tools = {
    upgrades.enable = true; # Upgrade common tools like ls,cat,etc
    ricing.enable = true; # Enable for fun style tools like cava
    tokei.enable = false; # Line counter
    unar.enable = true; # Zip archives
    unrar.enable = true; # Rar archives
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    direnv.silent = true;
    android.enable = false;
    just.enable = true;
  };

  diagnostics = {
    lact.enable = true;
    btop.enable = true;
    systemctl-tui.enable = true;
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
      enable = false;
      setDefault = false;
    };

  };

  email = {
    thunderbird.enable = true;
    aerc.enable = true;
  };


  emulation = {
    gba.mgba.enable = false;
    switch.ryubing.enable = false;
    retroarch.enable = true;
  };
  
  file-managers = {
    yazi.enable = true;
    thunar.enable = false;
  };

  gaming = {
    steam.enable = true;
    mangohud.enable = true;
    steam-tui.enable = false;
    lutris.enable = false;
    heroic.enable = false;
    protonplus.enable = true;
    minecraft.enable = true;
  };

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
    element.enable = false;
  };

  shells = {
    default = pkgs.fish;
    fish.enable = true;
    nushell.enable = false;
  };

  programs = {
    nix-ld.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    java.enable = true;
  };

  virtualisation = {
    virt-manager.enable = false;
    docker = {
      enable = true;
      addUserToGroup = true;
    };
    libvirtd = {
      enable = true;
      addUserToGroup = true;
    };
  };


}
