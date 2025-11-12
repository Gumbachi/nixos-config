{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
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

    # Set home manager configurations
    home-manager.sharedModules = [{

      # Theme code blocks in vencord
      programs.vesktop.vencord.settings.plugins.ShikiCodeblocks.theme = "${shikiThemes}/catppuccin-mocha.json";

      gtk.iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

    }];
  };
}
