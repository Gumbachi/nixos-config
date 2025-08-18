{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  fetchCursor = url: hash: name: pkgs.runCommand "moveUp" {} ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.fetchzip {
      url = url;
      hash = hash;
    }} $out/share/icons/${name}
  '';
  module = "cursors";
  cfg = config.${module};
in
{

  options.${module} = {
    bibata-modern-ice.enable = mkEnableOption "Install Bibata Modern Ice Hyprcursor";
    catppuccin.mocha = {
      mauve.enable = mkEnableOption "Install Catppuccin Mocha Muave Hyprcursor";
      blue.enable = mkEnableOption "Install Catppuccin Mocha Blue Hyprcursor";
      light.enable = mkEnableOption "Install Catppuccin Mocha Light Hyprcursor";
      dark.enable = mkEnableOption "Install Catppuccin Mocha Dark Hyprcursor";
    };
  };

  config = mkMerge [
    
    (mkIf cfg.bibata-modern-ice.enable {
      home-manager.sharedModules = [{      
        home.file = {
          ".local/share/icons/Bibata-Modern-Ice/".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/";
          ".icons/Hypr-Bibata-Modern-Ice/".source = let
            url = "https://github.com/rtgiskard/bibata_cursor/releases/download/v1.0.0/Bibata-Modern-Ice.hypr.tar.zst";
            hash = "sha256-Ji5gqIBrAtFO3S9fCrY/LXPaq5gCY4CkxZJ1uAcjj70=";
            name = "Bibata-Modern-Ice";
          in "${fetchCursor url hash name}/share/icons/${name}";
        };
      }];
    })

    (mkIf cfg.catppuccin.mocha.mauve.enable {
      home-manager.sharedModules = [{ 
        home.file.".local/share/icons/catppuccin-mocha-mauve-cursors/".source = 
          "${pkgs.catppuccin-cursors.mochaMauve}/share/icons/catppuccin-mocha-mauve-cursors/";
      }];
    })

    (mkIf cfg.catppuccin.mocha.blue.enable {
      home-manager.sharedModules = [{ 
        home.file.".icons/catppuccin-mocha-blue-cursors/".source =
          "${pkgs.catppuccin-cursors.mochaBlue}/share/icons/catppuccin-mocha-blue-cursors/";
      }];
    })

    (mkIf cfg.catppuccin.mocha.light.enable {
      home-manager.sharedModules = [{ 
        home.file.".local/share/icons/catppuccin-mocha-light-cursors/".source =
          "${pkgs.catppuccin-cursors.mochaLight}/share/icons/catppuccin-mocha-light-cursors/";
      }];
    })

    (mkIf cfg.catppuccin.mocha.dark.enable {
      home-manager.sharedModules = [{ 
        home.file.".local/share/icons/catppuccin-mocha-dark-cursors/".source =
          "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors/";
      }];
    })

  ];

}
