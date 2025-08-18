{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.email;
in
{
  options.email = {
    thunderbird.enable = mkEnableOption "Enable thunderbird email client.";
    aerc.enable = mkEnableOption "Enable aerc email client.";
  };

  config = mkMerge [

    (mkIf cfg.thunderbird.enable {
      programs.thunderbird.enable = true;
      # home-manager.sharedModules = [{ programs.thunderbird.enable = true; }];
    })

    # Cheat
    (mkIf cfg.aerc.enable {
      home-manager.sharedModules = [{ programs.aerc.enable = true; }];
    })

  ];
}
