{ pkgs, lib, config,  ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.terminals;
in {

  options.terminals = {

    kitty.enable = mkEnableOption "Enable kitty terminal";
    wezterm.enable = mkEnableOption "Enable wezterm terminal";
    alacritty.enable = mkEnableOption "Enable alacritty terminal";
    
  };

  config = mkMerge [

    (mkIf cfg.kitty.enable {
      environment.systemPackages = [ pkgs.kitty ];
      home-manager.sharedModules = [{
        programs.kitty.enable = true;
      }];
    })

    (mkIf cfg.wezterm.enable {
      environment.systemPackages = [ pkgs.wezterm ];
      home-manager.sharedModules = [{
        programs.wezterm.enable = true;
      }];
    })

    (mkIf cfg.alacritty.enable {
      environment.systemPackages = [ pkgs.alacritty ];
      home-manager.sharedModules = [{
        programs.alacritty.enable = true;
      }];
    })

  ];
}
