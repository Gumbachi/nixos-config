{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault mkEnableOption;
  module = lib.strings.removeSuffix ".nix" (builtins.baseNameOf __curPos.file);
  cfg = config.theme.${module};
  shikiThemes = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/refs/heads/main/packages/tm-themes/themes";
in
{

  options.theme.${module}.enable = mkEnableOption "Enable the ${module} theme.";

  config = mkIf cfg.enable {

    # Set Stylix theme
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${module}.yaml";
      polarity = "light";
    };

    # Set home manager configurations
    home-manager.sharedModules = [{

      # Theme code blocks in vencord
      programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/catppuccin-latte.json";

      # Set XCursor
      home.pointerCursor = {
        package = pkgs.catppuccin-cursors.latteBlue;
        name = "catppuccin-latte-blue-cursors";
      };

      gtk.iconTheme = {
        name = "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };

      # Set Hyprcursor theme
      wayland.windowManager.hyprland.settings.env = [ "HYPRCURSOR_THEME,catppuccin-latte-blue-cursors" ];

    }];
  };
}
