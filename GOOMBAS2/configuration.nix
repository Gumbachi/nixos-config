{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix # Hardware config

    # System Software
    ./programs.nix
    ./services.nix
    ./variables.nix

    # Config Modules
    ../shared/modules/custom # Custom nix options. Does not install anything
    ./modules # System specific config
  ];

  networking = {
    hostName = "GOOMBAS2";
    networkmanager.enable = true;
    firewall.enable = true;
    enableIPv6 = false;
  };

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    graphics.enable = true;
    nvidia.open = false;
  };

  default-apps = with pkgs; {
    shell = fish; # I dont like this
    text = [ helix ];
    terminal = [ kitty ];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Access groups
  users.groups = {
    media = {};
    backup = {};
  };

  users.users.jared = {
    isNormalUser = true;
    description = "Jared";
    extraGroups = ["networkmanager" "wheel" "video" "minecraft" "media" "backup" ];
  };

  nix = {
    nixPath = [ "~/nixos-config" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05"; # Did you read the comment? Yep
}
