{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge mkPackageOption;
  cfg = config.shells;
in
{

  options.shells = {
    default = mkPackageOption pkgs "bash" { };
    fish.enable = mkEnableOption "Enable fish shell.";
    nushell.enable = mkEnableOption "Enable nushell.";
  };

  config = mkMerge [

    { users.defaultUserShell = cfg.default; }

    (mkIf cfg.fish.enable {
      programs.fish.enable = true;
      home-manager.sharedModules = [{
        programs.fish.enable = true;
      }];
    })

    (mkIf cfg.nushell.enable {
      environment.systemPackages = [ pkgs.nushell ];
      home-manager.sharedModules = [{
        programs.nushell.enable = true;
      }];
    })

  ];

}
