{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  module = "viewers";
  cfg = config.${module};
in {

  options.${module} = {
    imv.enable = mkEnableOption "Enable imv image viewer.";
    qimgv.enable = mkEnableOption "Enable qimgv image/video viewer";
    mpv.enable = mkEnableOption "Enable mpv video player";
    vlc.enable = mkEnableOption "Enable vlc video player";
  };

  config = mkMerge [
    
    (mkIf (cfg.imv.enable) {
      home-manager.sharedModules = [{ programs.imv.enable = true; }];
    })

    (mkIf (cfg.qimgv.enable) {
      environment.systemPackages = [ pkgs.qimgv ];
    })

    (mkIf (cfg.mpv.enable) {
      home-manager.sharedModules = [{ programs.mpv.enable = true; }];
    })

    (mkIf (cfg.vlc.enable) {
      environment.systemPackages = [ pkgs.vlc ];
    })

  ];
}
