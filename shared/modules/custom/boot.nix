{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.boot;
in
{

  options.boot = {
    quiet = mkEnableOption "Enable various settings to suppress output on boot.";
  };

  config = mkMerge [

    (mkIf cfg.quiet { 
      boot = {
        loader.timeout = 0; # Dont show nixos generations. Can still be accessed by tapping buttons
        consoleLogLevel = 0;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
        ];
      };
    })

  ];

}
