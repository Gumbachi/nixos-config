{ pkgs, config, lib, ... }:
let
  inherit (lib) mkOption;
  cfg = config.theme;
in
{

  imports = [
    ../../styles/patch.nix # Nix file for patching css
    ../themes # Import theme modifications for the options below
  ];

  options.theme = {
    wallpaper = mkOption {
      type = lib.types.path;
      default = ../../../images/wallpapers/nix-gray.png;
    };
  };

  config = {

    # Enable default icon theme
    icons.papirus.enable = true;

    # Default theme settings: applicable to all themes
    stylix.autoEnable = true;
    stylix.image = cfg.wallpaper;
    stylix.overlays.enable = true;

    stylix.icons = {
      enable = false;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    stylix.fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.blex-mono;
        name = "BlexMono Nerd Font";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 8;
        terminal = 12;
      };

    };

    # Home Manager Options
    home-manager.sharedModules = [{

      # Enable cursor theming
      home.pointerCursor = {
        enable = true;
        size = 24;
        gtk.enable = true;
        hyprcursor.size = 32;
        hyprcursor.enable = true;
      };

      stylix.targets.cava.rainbow.enable = true;

      stylix.targets.floorp = {
        colorTheme.enable = true;
        profileNames = [ "default" ];
      };

      stylix.targets.librewolf = {
        colorTheme.enable = true;
        profileNames = [ "jared" "default" ];
      };

    }];
  };
}
