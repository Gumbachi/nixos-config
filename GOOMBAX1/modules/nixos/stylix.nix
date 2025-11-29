{ pkgs, ... }: {

  # Default theme settings: applicable to all themes
  stylix.autoEnable = true;
  stylix.image = null;
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
}
