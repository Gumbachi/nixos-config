{ inputs, pkgs, ... }: {

  # System Programs
  environment.systemPackages = with pkgs; [
    youtube-music
    quickshell
    playerctl
    wl-clipboard # Clipboard backend
    hyprpicker # Color Picker
    pavucontrol # Sound Settings
    hyprshot
    nwg-look # GTK Style GUI
    inlyne
  ];

  # Home manager programs
  home-manager.sharedModules = [{
    wayland.windowManager.hyprland.enable = true;
    programs.hyprlock.enable = true;
    programs.zellij.enable = true;

    programs.nh = {
      enable = true;
      flake = "~/nixos-config";
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
    unrar.enable = false; # Rar archives
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    direnv.silent = true;
    android.enable = false;
    just.enable = true;
  };

  diagnostics = {
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
      # setDefault = true;
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
    retroarch.enable = false;
  };

  file-managers = {
    yazi.enable = true;
    thunar.enable = false;
  };

  gaming = {
    steam.enable = true;
    mangohud.enable = true;
    lutris.enable = false;
    protonplus.enable = false;
    minecraft.enable = true;
  };

  launchers = {
    fuzzel.enable = true;
    walker.enable = false;
  };

  terminals.kitty.enable = true;

  viewers = {
    qimgv.enable = true;
    mpv.enable = true;
  };

  social = {
    vesktop.enable = true;
    element.enable = false;
  };

  shells = {
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
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  virtualisation = {
    virt-manager.enable = true;
    docker = {
      enable = true;
      addUserToGroup = true;
    };
    libvirtd = {
      enable = true;
      addUserToGroup = true;
    };
  };

  window-managers = {
    hyprland.enable = true;
    niri.enable = false;
  };

}
