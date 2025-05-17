{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault;
  cfg = config.theme.zenbones;
  # shikiThemes = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/refs/heads/main/packages/tm-themes/themes";
in
{
  config = mkIf cfg.enable {

    # Set Stylix theme
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/zenbones.yaml";
      polarity = "dark"; 
    };

    # Set a default wallpaper
    theme.wallpaper = mkDefault ../../images/wallpapers/bisbiswas13.jpg;

    # Set home manager configurations
    home-manager.sharedModules = [{
      
      # Theme code blocks in vencord
      # programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/catppuccin-mocha.json";        

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
