{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.networking;
in
{

  options.networking = {
    toolbox.enable = mkEnableOption "Enable common programs that allow for debug/dianostics.";
  };

  config = mkMerge [

    (mkIf cfg.toolbox.enable {
      programs.traceroute.enable = true;
      environment.systemPackages = [ pkgs.dig ];
      programs.wireshark.enable = true; # wireshark available as tshark
      users.users.jared.extraGroups = [ "wireshark" ];
    })

  ];

}
