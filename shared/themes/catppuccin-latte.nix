{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault;
  cfg = config.theme.catppuccin-latte;
  shikiThemes = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/refs/heads/main/packages/tm-themes/themes";
in
{
  config = mkIf cfg.enable {

    # Set Stylix theme
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
      polarity = "light"; 
    };

    # Set a default wallpaper
    theme.wallpaper = mkDefault ../../images/wallpapers/tall-grass-forest.jpg;

    # Set home manager configurations
    home-manager.sharedModules = [{
      
      # Theme code blocks in vencord
      programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/catppuccin-latte.json";        

      # Set XCursor
      home.pointerCursor = {
        package = pkgs.catppuccin-cursors.latteBlue;
        name = "catppuccin-latte-blue-cursors";
      };

      # Set Hyprcursor theme
      wayland.windowManager.hyprland.settings.env = [ "HYPRCURSOR_THEME,catppuccin-latte-blue-cursors" ];

    }];
  };
}
