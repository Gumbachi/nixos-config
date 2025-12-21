{ config, osConfig, ... }:
let
  colors = if config.stylix.enable then with config.lib.stylix.colors.withHashtag; {
    text = base05;
    accent = base0D;
    background = base00;
    highlight = base01;
    error = base08;
  } else {
    background = "#1e1e2e";
    text = "#cdd6f4";
    accent = "#89b4fa";
    highlight = "#cdd6f4";
    error = "#FF0000";
  };
in
{

  programs.walker = {
    runAsService = true;

    config = {
      theme = "stlyix";
      force_keyboard_focus = true;

      placeholders."default" = {
        input = "";
        list = "No Results";
      };

      # Disable hotkeys
      keybinds.quick_activate = [];

      providers."default" = [
        "desktopapplications"
        "calc"
        # "runner"
        "menus"
        "websearch"
      ];
    };

    themes."stylix".style = ''
      @define-color window_bg_color ${colors.background};
      @define-color accent_bg_color ${colors.accent};
      @define-color theme_fg_color ${colors.text};
      @define-color error_bg_color ${colors.highlight};
      @define-color error_fg_color ${colors.error};

      * {
        all: unset;
      }

      .normal-icons {
        -gtk-icon-size: 16px;
      }

      .large-icons {
        -gtk-icon-size: 32px;
      }

      scrollbar {
        opacity: 0;
      }

      .box-wrapper {
        box-shadow:
          0 19px 38px rgba(0, 0, 0, 0.3),
          0 15px 12px rgba(0, 0, 0, 0.22);
        background: @window_bg_color;
        padding: 20px;
        border-radius: 20px;
        border: 1px solid darker(@accent_bg_color);
      }

      .preview-box,
      .elephant-hint,
      .placeholder {
        color: @theme_fg_color;
      }

      .box {
      }

      .search-container {
        border-radius: 10px;
      }

      .input placeholder {
        opacity: 0.5;
      }

      .input {
        caret-color: @theme_fg_color;
        background: lighter(@window_bg_color);
        padding: 10px;
        color: @theme_fg_color;
      }

      .input:focus,
      .input:active {
      }

      .content-container {
      }

      .placeholder {
      }

      .scroll {
      }

      .list {
        color: @theme_fg_color;
      }

      child {
      }

      .item-box {
        border-radius: 10px;
        padding: 10px;
      }

      .item-quick-activation {
        margin-left: 10px;
        background: alpha(@accent_bg_color, 0.25);
        border-radius: 5px;
        padding: 10px;
      }

      child:hover .item-box,
      child:selected .item-box {
        background: alpha(@accent_bg_color, 0.25);
      }

      .item-text-box {
      }

      .item-text {
      }

      .item-subtext {
        font-size: 12px;
        opacity: 0.5;
      }

      .item-image,
      .item-image-text {
        margin-right: 10px;
      }

      .item-image-text {
        font-size: 28px;
      }

      .preview {
        border: 1px solid alpha(@accent_bg_color, 0.25);
        padding: 10px;
        border-radius: 10px;
        color: @theme_fg_color;
      }

      .calc .item-text {
        font-size: 24px;
      }

      .calc .item-subtext {
      }

      .symbols .item-image {
        font-size: 24px;
      }

      .todo.done .item-text-box {
        opacity: 0.25;
      }

      .todo.urgent {
        font-size: 24px;
      }

      .todo.active {
        font-weight: bold;
      }

      .bluetooth.disconnected {
        opacity: 0.5;
      }

      .preview .large-icons {
        -gtk-icon-size: 64px;
      }

      .keybinds-wrapper {
        border-top: 1px solid lighter(@window_bg_color);
        font-size: 12px;
        opacity: 0.5;
        color: @theme_fg_color;
      }

      .keybinds {
      }

      .keybind {
      }

      .keybind-bind {
        /* color: lighter(@window_bg_color); */
        font-weight: bold;
        text-transform: lowercase;
      }

      .keybind-label {
      }

      .error {
        padding: 10px;
        background: @error_bg_color;
        color: @error_fg_color;
      }

    '';

  };

}





    # # If this is not set the default styling is used.
    # theme.style = ''
    #   @define-color foreground rgba(255, 255, 255, 0.8);
    #   @define-color background hsla(240, 12.7%, 13.9%, 0.98);
    #   @define-color color1 hsl(172, 100%, 25.3%);

    #   #window,
    #   #box,
    #   #search,
    #   #password,
    #   #input,
    #   #prompt,
    #   #clear,
    #   #typeahead,
    #   #list,
    #   child,
    #   scrollbar,
    #   slider,
    #   #item,
    #   #text,
    #   #label,
    #   #bar,
    #   #sub,
    #   #activationlabel {
    #     all: unset;
    #   }

    #   #cfgerr {
    #     background: ${colors.error};
    #     margin-top: 20px;
    #     padding: 8px;
    #     font-size: 1.2em;
    #   }

    #   #window {
    #     color: ${colors.text};
    #     border: 4px solid ${colors.accent};
    #     border-radius: 10px;
    #   }

    #   #box {
    #     border-radius: 2px;
    #     background: ${colors.background};
    #     padding: 32px;
    #   }

    #   #search {
    #     background-color: ${colors.background};
    #     padding: 8px;
    #     font-size: 1.4em;
    #     font-weight: bold;
    #   }

    #   #prompt {
    #     margin-left: 4px;
    #     margin-right: 12px;
    #     color: ${colors.text};
    #     opacity: 0.2;
    #     font-size: 1.4em;
    #   }

    #   #clear {
    #     color: ${colors.text};
    #     opacity: 0.8;
    #   }

    #   #password,
    #   #input,
    #   #typeahead {
    #     border-radius: 2px;
    #   }

    #   #input {
    #     background: none;
    #   }

    #   #password {
    #   }

    #   #spinner {
    #     padding: 8px;
    #   }

    #   #typeahead {
    #     color: ${colors.text};
    #     opacity: 0.8;
    #   }

    #   #input placeholder {
    #     opacity: 0.5;
    #   }

    #   #list {
    #   }

    #   child {
    #     padding: 8px;
    #     border-radius: 2px;
    #   }

    #   child:selected,
    #   child:hover {
    #     background: ${colors.highlight};
    #   }

    #   #item {
    #   }

    #   #icon {
    #     margin-right: 8px;
    #   }

    #   #text {
    #   }

    #   #label {
    #     font-weight: 500;
    #   }

    #   #sub {
    #     opacity: 0.5;
    #     font-size: 0.8em;
    #   }

    #   #activationlabel {
    #   }

    #   #bar {
    #   }

    #   .barentry {
    #   }

    #   .activation #activationlabel {
    #   }

    #   .activation #text,
    #   .activation #icon,
    #   .activation #search {
    #     opacity: 0.5;
    #   }
    # '';
