{ inputs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  module = "launchers";
  cfg = config.${module};
in {

  options.${module} = {
    rofi.enable = mkEnableOption "Enable rofi. Make sure to set rofi package in config.";
    fuzzel.enable = mkEnableOption "Enable fuzzel app launcher.";
    walker.enable = mkEnableOption "Enable walker launcher.";
  };

  config = {
    home-manager.sharedModules = [
      {
        programs.rofi.enable = cfg.rofi.enable;
        programs.fuzzel.enable = cfg.fuzzel.enable;
      }

      (mkIf cfg.walker.enable {
        imports = [
          inputs.walker.homeManagerModules.default
          ../../../GOOMBAX1/modules/home/launchers/walker.nix
        ];
        programs.walker.enable = cfg.walker.enable;
      })

    ];
  };

}
