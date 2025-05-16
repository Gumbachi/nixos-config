{ pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix # Mandatory hardware config
    ../shared/modules/custom # Custom Nix Options
    ./modules # Modules declaring the system layout
  ];

  theme = {
    wallpaper = ../images/wallpapers/bisbiswas09.jpg;
    catppuccin-mocha.enable = true; 
  };

  networking = {
    hostName = "GOOMBAX2";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    firewall.enable = true;
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  }; 

  fonts = {
    enableDefaultPackages = true; 
    packages = with pkgs; [
      nerd-fonts.blex-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      inter
      vistafonts # Calibri
    ];
  };

  documentation = {
    man.enable = false;
    tldr.enable = true;
  };

  boot = {
    quiet = false;
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    plymouth.enable = false;
  };

  environment.sessionVariables.CONFIG = "/home/jared/NixOS-Config";

  # Base shell Config
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Sound configuration
  services.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Nixpkgs/nix config
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    extraOptions = ''trusted-users = root jared''; # Devenv shells
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.jared = {
    isNormalUser = true;
    description = "Jared";
    extraGroups = ["networkmanager" "wheel" "video" "adbusers"];
  };

  system.stateVersion = "23.11"; # Did you read the comment? yes
}
