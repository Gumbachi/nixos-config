{ user, pkgs, lib, ... }: {

  imports = [
    ./programs.nix
    ./services.nix

    ./hardware-configuration.nix # Mandatory hardware config
    ../shared/modules/custom # Custom nix option definitions. Does not install anything
    ./modules # Modules declaring the system layout
  ];

  # Set the system theme with stylix
  theme = {
    wallpaper = ../images/wallpapers/pixeltree.png;
    monokai.enable = true;
  };

  window-managers = {
    hyprland.enable = true;
    niri.enable = false;
  };

  boot = {
    quiet = true;
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    plymouth.enable = true;
    kernelParams = [
      "video=DP-1:3840x2160@240"
      "video=DP-2:2560x1440@120"
      "video=DP-1:2560x1440@120"
    ];
  };

  networking = {
    hostName = "GOOMBAX1";
    firewall.enable = true;
    networkmanager.enable = true;
  };

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

  defaults = {
    browser = [ "chromium.desktop" "librewolf.desktop" ];
    editor = [ "helix.desktop" ];
    audio = [ "mpv.desktop" ];
    video = [ "mpv.desktop" ];
    image = [ "qimgv.desktop" ];
    shell = pkgs.fish;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    logitech.wireless = {
      enable = true;
      enableGraphical = false;
    };

    keyboard.zsa = {
      enable = true;
      disableJoystick = false;
      keymapp.enable = true;
      kontroll.enable = false;
    };

    bluetooth = {
      enable = false;
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

  services.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  nix = {
    nixPath = [ "~/nixos-config" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      # substituters = [];
      # trusted-public-keys = [];
    };
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  documentation = {
    man.enable = false;
    tldr.enable = true;
    nixos.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment? yes
}
