{ pkgs, lib, config, ...}:
let
  inherit (lib) types mkIf mkMerge mkEnableOption mkOption;
  cfg = config.emulation;
in
{

  options.emulation = {
    switch.ryubing.enable = mkEnableOption "Enable switch emulation with Ryubing.";
    gba.mgba.enable = mkEnableOption "Enable standalone mGBA emulator.";

    retroarch = {
      enable = mkEnableOption "Enable Retroarch software with some basic cores.";
      extraCores = mkOption {
        type = types.list;
        default = [];
        description = "Extra cores to install with Retroarch.";
      };
    };

  };

  config = mkMerge [

    # Switch Emulation // Ryubing
    (mkIf cfg.switch.ryubing.enable {
      environment.systemPackages = [ pkgs.ryubing ];
    })

    # GBA Multiplayer emulation mGBA
    (mkIf cfg.gba.mgba.enable {
      environment.systemPackages = [ pkgs.mgba ];
    })

    # Retroarch
    (mkIf cfg.retroarch.enable {
      environment.systemPackages = [(
        pkgs.retroarch.withCores (cores: with cores; [
          melonds
          mgba
        ])
      )];
    })

  ];
}
