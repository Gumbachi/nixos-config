{ user, pkgs, lib, inputs, ... }: {

  imports = [
    ./programs.nix
    ./services.nix

    ./hardware-configuration.nix # Mandatory hardware config
    ../shared/modules/custom # Custom nix option definitions. Does not install anything
    ../shared/modules/theme # Custom simple theming system
    ./modules # Modules declaring the system layout
  ];

  # Set the system theme with Stylix and Home Manager
  theme = {
    monokai.enable = true;
    wallpaper.landscape = inputs.wallpaper;
    wallpaper.portrait = inputs.wallpaper-portrait;
    cursor.bibata-modern-ice.enable = true;
  };

  default-apps = {
    browser = [ pkgs.librewolf pkgs.chromium ];
    files = [ pkgs.yazi ];
    text = [ pkgs.helix ];
    audio = [ pkgs.mpv ];
    video = [ pkgs.mpv ];
    image = [ pkgs.qimgv ];
    shell = pkgs.fish;
  };

  boot = {
    quiet = true;
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    plymouth.enable = true;
    kernelParams = [
      "video=DP-1:3840x2160@240"
      "video=DP-2:2560x1440@120"
      "video=DP-3:2560x1440@120"
    ];
  };

  networking = {
    hostName = "GOOMBAX1";
    firewall.enable = true;
    networkmanager.enable = true;
  };

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

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
      vista-fonts # Calibri
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
