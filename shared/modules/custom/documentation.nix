{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.documentation;
in
{
  options.documentation = {
    tldr.enable = mkEnableOption "Enable TLDR for short documentation.";
    cheat.enable = mkEnableOption "Enable Cheat for short documentation.";
  };

  config = mkMerge [

    # TLDR
    (mkIf cfg.tldr.enable {
      environment.systemPackages = [ pkgs.tealdeer ];
      home-manager.sharedModules = [{ programs.tealdeer.enable = true; }];
    })

    # Cheat
    (mkIf cfg.cheat.enable {
      environment.systemPackages = [ pkgs.cheat ];
    })

  ];
}
