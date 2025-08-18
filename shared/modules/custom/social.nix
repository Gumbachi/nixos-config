{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  module = "social";
  cfg = config.${module};
in {

  options.${module} = {
    vesktop.enable = mkEnableOption "Enable vesktop.";
    element.enable = mkEnableOption "Enable element client.";
  };

  config = mkMerge [
    
    (mkIf cfg.vesktop.enable {
      home-manager.sharedModules = [{ programs.vesktop.enable = true; }];
    })

    (mkIf cfg.element.enable {
      home-manager.sharedModules = [{ programs.element-desktop.enable = true; }];
    })

  ];
}
