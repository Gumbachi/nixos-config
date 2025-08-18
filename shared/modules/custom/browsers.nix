{ inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.browsers;
in {

  options.browsers = {
    firefox.enable = mkEnableOption "Enable firefox browser.";
    librewolf.enable = mkEnableOption "Enable librewolf browser.";
    floorp.enable = mkEnableOption "Enable floorp browser.";
    zen.enable = mkEnableOption "Enable zen browser.";
    chromium.enable = mkEnableOption "Enable chromium browser.";
    ladybird.enable = mkEnableOption "Enable the ladybird browser.";
  };

  config = mkMerge [
    
    (mkIf cfg.firefox.enable {
      home-manager.sharedModules = [{ programs.firefox.enable = true; }];
    })

    (mkIf cfg.librewolf.enable {
      home-manager.sharedModules = [{ programs.librewolf.enable = true; }];
    })

    (mkIf cfg.floorp.enable {
      home-manager.sharedModules = [{ programs.floorp.enable = true; }];
    })

    (mkIf cfg.chromium.enable {
      home-manager.sharedModules = [{ programs.chromium.enable = true; }];
    })

    (mkIf cfg.zen.enable {
      environment.systemPackages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
    })

    (mkIf cfg.ladybird.enable {
      programs.ladybird.enable = true;
    })

  ];
}
