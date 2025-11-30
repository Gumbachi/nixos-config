{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    inputs.agenix.packages.${system}.default

    # DV recording Tools
    dvgrab
    ffmpeg-headless
    mkvtoolnix-cli
    yt-dlp # YoutubeDL
    immich-go

    jdk # Java 21
    jdk8 # Java 8

    rsync
    fdupes

    btrfs-progs

  ];

  home-manager.sharedModules = [{
    programs.nh = {
      enable = true;
      flake = "/home/jared/nixos-config";
    };
  }];

  terminals.kitty.enable = true;

  shells.fish.enable = true;

  file-managers.yazi.enable = true;

  documentation = {
    man.enable = false;
    tldr.enable = true;
  };

  cli-tools = {
    upgrades.enable = true; # Upgrade common tools like ls,cat,etc
    starship.enable = true;
    fastfetch.enable = true;
    unar.enable = true; # Zip archives
    unrar.enable = true; # Rar archives
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    just.enable = true;
  };

  programs = {
    nix-ld.enable = true;
  };

  diagnostics = {
    btop.enable = true;
    systemctl-tui.enable = true;
    networking-tools.enable = true;
    lm-sensors.enable = true;
  };

  editors.text.helix = {
    enable = true;
    setDefault = true;
  };

}
