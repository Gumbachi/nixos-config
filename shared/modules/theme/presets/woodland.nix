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
      polarity = "dark";
    };

    # Set a default wallpaper
    theme.wallpaper = mkDefault (pkgs.fetchurl {
      url = "https://files.gumbachi.com/wallpapers/pixeltree.png";
      sha256 = "1m0xkmjaspcnaqm51b69g6djbk5767lckhzlvlgfgaf5g04dzs6m";
    });

    cursors.bibata-modern-ice.enable = true;

    # Set home manager configurations
    home-manager.sharedModules = [{

      # Theme code blocks in vencord
      programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/monokai.json";

      # Set XCursor
      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };

      gtk.iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      # Set Hyprcursor theme
      wayland.windowManager.hyprland.settings.env = [ "HYPRCURSOR_THEME,Bibata-Modern-Ice" ];

    }];
  };
}
