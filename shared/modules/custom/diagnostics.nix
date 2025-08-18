{ user, config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkMerge mkIf;
  cfg = config.diagnostics;
in
{

  options.diagnostics = {
    lact.enable = mkEnableOption "Enabled lact and the daemon.";
    btop.enable = mkEnableOption "Enable btop system monitor.";
    systemctl-tui.enable = mkEnableOption "Enable TUI for systemctl";
    networking-tools.enable = mkEnableOption "Enable wireshark, dig, traceroute.";
    lm-sensors.enable = mkEnableOption "install lm-sensors";
  };

  config = mkMerge [

    (mkIf cfg.lact.enable {
      environment.systemPackages = [ pkgs.lact ];
      systemd.packages = [ pkgs.lact ];
      systemd.services.lactd.wantedBy = [ "multi-user.target" ];    
    })

    (mkIf cfg.btop.enable {
      home-manager.sharedModules = [{ programs.btop.enable = true; }];
    })

    (mkIf cfg.systemctl-tui.enable {
      environment.systemPackages = [ pkgs.systemctl-tui ];
    })

    (mkIf cfg.networking-tools.enable {
      programs.traceroute.enable = true;
      environment.systemPackages = [ pkgs.dig ];
      programs.wireshark.enable = true; # wireshark available as tshark
      users.users.${user}.extraGroups = [ "wireshark" ];
    })

    (mkIf cfg.lm-sensors.enable {
      environment.systemPackages = [ pkgs.lm_sensors ];
    })

  ];

}
