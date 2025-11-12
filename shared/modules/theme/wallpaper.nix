{ pkgs, config, lib, ... }:
let
  inherit (lib) mkOption mkForce;
  cfg = config.theme.wallpaper;
in
{

  options.theme.wallpaper = {

    landscape = mkOption {
      type = lib.types.path;
      default = pkgs.fetchurl {
        url = "https://files.gumbachi.com/wallpapers/nix-gray.png";
        hash = "07zl1dlxqh9dav9pibnhr2x1llywwnyphmzcdqaby7dz5js184ly";
      };
    };

    portrait = mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };

  };

  config.home-manager.sharedModules = [{

    services.hyprpaper.settings = {
      preload = if (cfg.portrait != null) then
        [ "${cfg.landscape}" "${cfg.portrait}" ]
      else
        [ "${cfg.landscape}" ];

      wallpaper = if (cfg.portrait != null) then
        [
          "DP-1,${cfg.landscape}"
          "DP-2,${cfg.portrait}"
          "DP-3,${cfg.portrait}"
        ]
      else
        [ ",${cfg.landscape}" ];
    };

    programs.hyprlock.settings.background = let
      value = if (cfg.portrait != null) then
      [
        {
          monitor = "DP-1";
          path = "${cfg.landscape}";
          blur_passes = 3;
        }
        {
          monitor = "DP-2";
          path = "${cfg.portrait}";
          blur_passes = 3;
        }
        {
          monitor = "DP-3";
          path = "${cfg.portrait}";
          blur_passes = 3;
        }
      ]
    else
      [
        {
          path = "${cfg.landscape}";
          blur_passes = 3;
        }
      ];
    in mkForce value;

  }];
}
