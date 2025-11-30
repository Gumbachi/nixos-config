{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.theme.icons;
in
{

  options.theme.icons = {
    papirus.enable = mkEnableOption "Install Papirus Icons";
  };

  config = mkMerge [

    (mkIf cfg.papirus.enable {
      home-manager.sharedModules = [{
        home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus/";
        home.file.".icons/Papirus-Dark".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/";
        home.file.".icons/Papirus-Light".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/";
      }];
    })

  ];

}
