{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault;
  cfg = config.theme.sunset;
  # shikiThemes = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/refs/heads/main/packages/tm-themes/themes";
in
{
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

    # Set a default wallpaper
    theme.wallpaper = mkDefault ../../images/wallpapers/bisbiswas05.jpg;

    # Set home manager configurations
    home-manager.sharedModules = [{
      
      # Theme code blocks in vencord
      # programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/monokai.json";        

      # Set XCursor
      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };

      # Set Hyprcursor theme
      wayland.windowManager.hyprland.settings.env = [ "HYPRCURSOR_THEME,Bibata-Modern-Ice" ];

    }];
  };
}
