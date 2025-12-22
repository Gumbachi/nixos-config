{ inputs, pkgs, config, ... }: {

  boot.loader.limine.maxGenerations = 50;

  boot.loader.limine.style.interface = {
    branding = config.networking.hostName;
    resolution = "3840x2160";
  };

  boot.loader.limine.style.wallpapers = with pkgs; [
    inputs.wallpaper
    # nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath
  ];

  # boot.loader.limine.style.graphicalTerminal = {
  #   background = ""
  # };

}
