{ pkgs, ... }: {

  # Default theme settings: applicable to all themes
  stylix.autoEnable = false;
  stylix.image = null;
  stylix.overlays.enable = true;

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };

    sizes.terminal = 12;
  };

  stylix.targets = {
    console.enable = true;
  };

  # Home Manager Options
  home-manager.sharedModules = [{
    style.targets = {
      bat.enable = true;
      btop.enable = true;
      fish.enable = true;
      fzf.enable = true;
      helix.enable = true;
      kitty.enable = true;
      nushell.enable = true;
      sharship.enable = true;
      zellij.enable = true;
    };
  }];
}
