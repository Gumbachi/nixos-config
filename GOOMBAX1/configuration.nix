{ inputs, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix # Mandatory hardware config
    ../shared/modules/custom # Custom Nix Options
    ./modules # Modules declaring the system layout
  ];

  # Set the system theme with stylix
  theme = {
    # wallpaper = ../images/wallpapers/monokai.png;
    # monokai.enable = true;
    # sunset.enable = true;
    # catppuccin-latte.enable = true;
    # woodland.enable = true;
    steam.enable = true;
    # gruvbox-light.enable = true;
    # zenbones.enable = true;
    # catppuccin-mocha.enable = true;
  };

  boot = {
    quiet = true;
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    plymouth.enable = true;
  };

  networking = {
    hostName = "GOOMBAX1";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  environment.sessionVariables.CONFIG = "/home/jared/NixOS-Config";

  diagnostics.lact.enable = true;

  programs.virt-manager.enable = true;
  virtualisation = {
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
      enableGraphical = true;
    };

    keyboard.zsa = {
      enable = true; 
      keymapp.enable = true;
      kontroll.enable = true;
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
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    extraOptions = ''trusted-users = root jared''; # Devenv shells
  };

  nixpkgs.config = {
    allowUnfree = true;
    rocmSupport = true;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jared = {
    isNormalUser = true;
    description = "Jared";
    extraGroups = [ "networkmanager" "wheel" "video" "syncthing" ];
  };

  documentation = {
    man.enable = true;
    tldr.enable = true;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
