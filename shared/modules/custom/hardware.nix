{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkMerge mkIf;
  cfg = config.hardware;
in
{

  options.hardware = {
    keyboard.zsa = {
      keymapp.enable = mkEnableOption "Enable keymapp to run and start API.";
      kontroll.enable = mkEnableOption "Enable kontroll to control zsa boards with keymapp.";
    };
  };

  config = mkMerge [
    (mkIf cfg.keyboard.zsa.keymapp.enable {
      environment.systemPackages = [ pkgs.keymapp ];
    })

    (mkIf cfg.keyboard.zsa.kontroll.enable {
      environment.systemPackages = [ pkgs.kontroll ];
    })

  ];

  

}
