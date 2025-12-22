{ config, ... }: {

  boot.loader.limine.maxGenerations = 50;

  boot.loader.limine.style = {
    interface.branding = config.networking.hostName;
    interface.resolution = "3840x2160";
    wallpapers = with pkgs; [
      nixos-artwork.wallpapers.nineish-dark-gray
    ];
  };

  boot.loader.limine.extraConfig = ''
  '';

}
