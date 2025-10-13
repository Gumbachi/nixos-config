{ pkgs, lib, ... }: {

  programs.fuzzel = {
    settings = {

      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        prompt = ''" "'';
        width = 35;
        lines = 10;
        tabs = 4;
        inner-pad = 10;
        horizontal-pad = 12;
        vertical-pad = 12;
        line-height = 30;
        letter-spacing = 1;
        hide-before-typing = false;
        font = lib.mkForce "Inter normal:size=16";
        icon-theme = "Papirus";
      };

      border = {
        width = 4;
        radius = 4;
      };
    };
  };

}
