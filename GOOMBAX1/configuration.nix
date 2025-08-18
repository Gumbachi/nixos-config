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
    wallpaper = ../images/wallpapers/swan.jpg;
    monokai.enable = true;
    # sunset.enable = true;
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
  };

  networking = {
    hostName = "GOOMBAX1";
    firewall.enable = true;
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

  default-apps = {
    enable = true;
    browser = [ "floorp.desktop" "chromium.desktop" ];
    editor = [ "nvim.desktop" ];
    audio = [ "mpv.desktop" ];
    video = [ "mpv.desktop" ];
    image = [ "qimgv.desktop" ];
  };

  virtualisation = {
    virt-manager.enable = true;
    docker = {
      enable = false;
      addUserToGroup = true;
    };
    libvirtd = {
      enable = true;
      addUserToGroup = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.rocmPackages.rocm-smi ];
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
  };

  qt.enable = true;

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
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://hyprland.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    rocmSupport = true;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  documentation = {
    man.enable = true;
    tldr.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment? yes
}
