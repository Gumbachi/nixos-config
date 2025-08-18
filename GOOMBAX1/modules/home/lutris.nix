{ pkgs, osConfig, ... }: {

  programs.lutris = {
    extraPackages = with pkgs; [ mangohud winetricks ];
    steamPackage = osConfig.programs.steam.package;
    winePackages = [ pkgs.wineWow64Packages.waylandFull ];
    protonPackages = [ pkgs.proton-ge-bin ];
  };

}
