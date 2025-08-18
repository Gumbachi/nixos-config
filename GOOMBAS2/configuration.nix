{ ... }: {

  imports = [
    ./hardware-configuration.nix # Hardware config

    # System Software
    ./programs.nix
    ./services.nix

    # Config Modules
    ../shared/modules/custom # Custom nix options. Does not install anything
    ./modules # System specific config
  ];

  theme.catppuccin-mocha.enable = true;

  networking = {
    hostName = "GOOMBAS2";
    networkmanager.enable = true;
    firewall.enable = true;
    enableIPv6 = false;
  };

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

  boot = {
    initrd.luks.mitigateDMAAttacks = true; # This is for firewire. enable when no longer needed
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "video=DP-1:1024x1280@60,rotate=90" ];
  };

  services.xserver.videoDrivers = ["nvidia"]; # You need this
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = false;
      open = false;
    };
  };


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # # Backup FS
  # fileSystems."/mnt/backup" = {
  #   device = "/dev/disk/by-uuid/928B-0238";
  #   fsType = "exfat";
  #   options = ["users" "nofail"];
  # };


  # Access groups
  users.groups = {
    media = {};
    backup = {};
  };

  users.users.jared = {
    isNormalUser = true;
    description = "Jared";
    extraGroups = ["networkmanager" "wheel" "video" "minecraft" "docker" "media" "backup" ];
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05"; # Did you read the comment? Yep
}
