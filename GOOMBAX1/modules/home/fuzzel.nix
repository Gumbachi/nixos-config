{ pkgs, lib, ... }: {

  programs.fuzzel = {
    enable = true;
    settings = {

      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        prompt = ''" "'';
        width = 35;
        lines = 10;
        tabs = 4;
        inner-pad = 10;
        line-height = 25;
        letter-spacing = 1;
        font = lib.mkForce "BlexMono Nerd Font SemiBold:size=18";
        icon-theme = "Papirus";
      };

      border = {
        width = 4;
        radius = 10;
      };
    };
  };

}
