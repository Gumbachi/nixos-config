{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    youtube-music
    vlc # Video Player

    brightnessctl
    playerctl
    quickshell
    pavucontrol

    jmtpfs
    hyprshot

    # Make a nice little option for this
    libreoffice # Office Software
    hunspell # Spellcheck for libreoffice
    hunspellDicts.en_US # US Dictionary for spellcheck
  ];

  programs = {
    nix-ld.enable = true;
    firefox.enable = false;
    thunderbird.enable = true;
    adb.enable = false;
    nm-applet.enable = false;
  };

  file-managers.yazi.enable = true;

  launchers.fuzzel.enable = true;

  browsers.librewolf.enable = true;

  shells.fish.enable = true;

  editors.text.helix = {
    enable = true;
    setDefault = true;
  };

  cli-tools = {
    upgrades.enable = true; # eza, ripgrep, bat, etc..
    starship.enable = true;
    unar.enable = true; # Zip archives
    unrar.enable = true; # Rar archives
  };

  diagnostics = {
    btop.enable = true;
    systemctl-tui.enable = true;
  };

  gaming = {
    steam.enable = true;
    mangohud.enable = true;
    protonup.enable = true;
  };

  development = {
    devenv.enable = true;
    direnv.enable = true;
    just.enable = true;
  };

}
