{ pkgs, lib, config, ...}: 
let
  inherit (lib) mkIf mkMerge mkEnableOption; 
  cfg = config.file-managers;
in
{

  options.file-managers = {
    yazi.enable = mkEnableOption "Enable yazi, a terminal file explorer.";
    thunar.enable = mkEnableOption "Enable thunar, a GUI file explorer.";
  };

  config = mkMerge [

    (mkIf cfg.yazi.enable {
      programs.yazi.enable = true;
      home-manager.sharedModules = [{
        programs.yazi.enable = true;
      }];
    })

    (mkIf cfg.thunar.enable { 
      programs.thunar.enable = true;
    })

  ];
}
