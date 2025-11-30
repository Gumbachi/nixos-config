{ pkgs, config, lib, ... }: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.theme.cursor;
in {

  options.theme.cursor = {
    bibata-modern-ice.enable = mkEnableOption "Enable Bibata Modern Ice Cursor";
    catppuccin-mocha-light.enable = mkEnableOption "Enable Catppuccin-Cursor";
  };

  config.home-manager.sharedModules = [

    {
      home.pointerCursor = mkIf cfg.bibata-modern-ice.enable {
        enable = true;
        gtk.enable = true;
        hyprcursor.enable = true;
        hyprcursor.size = 32;
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
    }

    {
      home.pointerCursor = mkIf cfg.catppuccin-mocha-light.enable {
        enable = true;
        gtk.enable = true;
        hyprcursor.enable = true;
        hyprcursor.size = 32;
        name = "catppuccin-mocha-light-cursors";
        package = pkgs.catppuccin-cursors.mochaLight;
        size = 24;
      };
    }

  ];

}

    # home.file.".icons/Bibata-Modern-Ice/" = mkIf cfg.bibata-modern-ice.enable {
    #   source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/";
    # };


#   fetchCursor = url: hash: name: pkgs.runCommand "moveUp" {} ''
#     mkdir -p $out/share/icons
#     ln -s ${pkgs.fetchzip {
#       url = url;
#       hash = hash;
#     }} $out/share/icons/${name}
#   '';
