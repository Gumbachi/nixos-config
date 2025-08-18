{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkMerge mkIf;
  cfg = config.hardware;
in
{

  options.hardware = {
    keyboard.zsa = {
      disableJoystick = mkEnableOption "Disable the joystick udev device.";
      keymapp.enable = mkEnableOption "Enable keymapp to run and start API.";
      kontroll.enable = mkEnableOption "Enable kontroll to control zsa boards with keymapp.";
    };
  };

  config = mkMerge [

    (mkIf cfg.keyboard.zsa.disableJoystick {     
      systemd.services.remove-joystick-device = {
        enable = true;
        path = [  pkgs.coreutils ];
        wantedBy = ["multi-user.target"];
        description = "Removes Joystick Device.";
        script = ''rm $(readlink -f /dev/input/by-path/pci-0000:0c:00.0-usb-0:5:1.2-event-joystick)'';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          RemainAfterExit = true;
          # ExecStart = ''rm $(readlink -f /dev/input/by-path/pci-0000:0c:00.0-usb-0:5:1.2-event-joystick)'';
        };
      };
    })

    (mkIf cfg.keyboard.zsa.keymapp.enable {
      environment.systemPackages = [ pkgs.keymapp ];
    })

    (mkIf cfg.keyboard.zsa.kontroll.enable {
      environment.systemPackages = [ pkgs.kontroll ];
    })

  ];

  

}
