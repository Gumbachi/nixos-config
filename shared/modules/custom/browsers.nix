{ inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.browsers;
in {

  options.browsers = {
    firefox.enable = mkEnableOption "Enable firefox browser.";
    floorp.enable = mkEnableOption "Enable floorp browser.";
    zen.enable = mkEnableOption "Enable zen browser.";
    chromium.enable = mkEnableOption "Enable chromium browser.";
  };

  config = mkMerge [
    
    (mkIf cfg.firefox.enable {
      programs.firefox.enable = true;
      home-manager.sharedModules = [{ programs.firefox.enable = true; }];
    })

    (mkIf cfg.floorp.enable {
      environment.systemPackages = [ pkgs.floorp ];
      home-manager.sharedModules = [{ programs.floorp.enable = true; }];
    })

    (mkIf cfg.chromium.enable {
      environment.systemPackages = [ pkgs.chromium ];
      home-manager.sharedModules = [{ programs.chromium.enable = true; }];
    })

    (mkIf cfg.zen.enable {
      environment.systemPackages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
    })

  ];
}
