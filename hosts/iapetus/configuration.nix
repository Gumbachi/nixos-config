{ inputs, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix # Mandatory hardware config

    ./programs.nix
    ./services.nix

    ../shared/modules/custom # Custom Nix Options
    ../shared/modules/theme # Custom simple theming system
    ./modules # Modules declaring the system layout
  ];

  theme = {
    wallpaper.landscape = inputs.wallpaper;
    monokai.enable = true;
    cursor.bibata-modern-ice.enable = true;
  };

  window-managers.hyprland.enable = true;

  networking = {
    hostName = "GOOMBAX2";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  defaults = {
    browser = [ "librewolf.desktop" "chromium.desktop" ];
    editor = [ "helix.desktop" ];
    audio = [ "mpv.desktop" ];
    video = [ "mpv.desktop" ];
    image = [ "qimgv.desktop" ];
    shell = pkgs.fish;
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

  environment.sessionVariables.CONFIG = "/home/jared/nixos-config";

  # Sound configuration
  # services.pulseaudio.enable = lib.mkForce false;
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
      substituters = [
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      trusted-public-keys = [
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
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
