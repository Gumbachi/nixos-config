{ pkgs, config, ... }: 
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{

  programs.rofi = {
    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun";
      icon-theme = "Papirus";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      hide-scrollbar = true;
      display-drun = "";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = false;
    };

    theme = {
    
      "*" = {
        font = "BlexMono Nerd Font 12";
        width = 800;
      };

      window = {
        height = 360;
        border = 4;
        border-radius = 10;
      };

      inputbar = {
        children = map mkLiteral ["prompt" "entry"];
        border-radius = 5;
        padding = 2;
      };

      prompt = {
        padding = 6;
        border-radius = 3;
        margin = mkLiteral "20px 0px 0px 20px";
      };

      textbox-prompt-colon = {
        expand = false;
        str = ":";
      };

      entry = {
        padding = 6;
        margin = mkLiteral "20px 0px 0px 10px";
      };


      listview = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 0px 0px 20px";
          columns = 2;
          lines = 5;
      };

      element = {
        padding = 5;
        background = mkLiteral "@background";
      };

      element-icon = {
        size = 25;
      };

      mode-switcher = {
        spacing = 0;
      };

      button = {
        padding = 10;
        vertical-align = mkLiteral "0.5"; 
        horizontal-align = mkLiteral "0.5";
      };

      message = {
        margin = 2;
        padding = 2;
        border-radius = 5;
      };

      textbox = {
        padding = 6;
        margin = mkLiteral "20px 0px 0px 20px";
      };

    };
  };

}
