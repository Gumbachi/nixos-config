{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  module = "icons";
  cfg = config.${module};
in
{

  options.${module} = {
    papirus.enable = mkEnableOption "Install Papirus Icons";
  };

  config = mkMerge [

    (mkIf cfg.papirus.enable {
      home-manager.sharedModules = [{
        gtk.iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
        home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus/";
      }];
    })

  ];

}
