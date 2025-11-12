{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  module = lib.strings.removeSuffix ".nix" (builtins.baseNameOf __curPos.file);
  cfg = config.theme.${module};
  # shikiThemes = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/refs/heads/main/packages/tm-themes/themes";
in
{

  options.theme.${module}.enable = mkEnableOption "Enable the ${module} theme";

  config = mkIf cfg.enable {

    # Set Stylix theme
    stylix = {
      enable = true;
      base16Scheme = {
        scheme = "Sunset";

        # Background colors
        base00 = "240F4A"; # base
        base01 = "2D135A"; # mantle
        base02 = "423A4F"; # surface0
        base03 = "544C63"; # surface1
        base04 = "6F6482"; # surface2

        # Text
        base05 = "D0C9DB"; # text

        # Main Colors
        base06 = "#FCC2AC"; # rosewater
        base07 = "D89AF6"; # lavender
        base08 = "DF2A4B"; # red
        base09 = "B847EF"; # mauve
        base0A = "F76028"; # orange
        base0B = "46FB64"; # green
        base0C = "94e2d5"; # teal
        base0D = "FCB421"; # yellow # Primary Accent
        base0E = "46BFFB"; # blue # Alternate Accent
        base0F = "F27499"; # flamingo
      };
      polarity = "dark";
    };

    # Set home manager configurations
    home-manager.sharedModules = [{

      gtk.iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

    }];
  };
}
