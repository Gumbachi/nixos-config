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

    # All options from the config.json can be used here.
    config = {
      app_launch_prefix = if osConfig.programs.uwsm.enable then "uwsm app -- " else "";
      
      ui.fullscreen = false;
      list = {
        height = 300;
      };

      activation_mode.disabled = true;

      builtins.applications.actions = {
        enabled = false;
      };

      builtins.runner = {
        prefix = ":r ";
        hidden = true;
      };

      builtins.websearch = {
        prefix = ":s ";
        hidden = true;
      };

      builtins.windows = {
        prefix = ":w ";
        hidden = true;
      };

      builtins.translation = {
        prefix = ":t ";
        hidden = true;
        provider = "googlefree";
      };

      builtins.clipboard = {
        prefix = ":c ";
        hidden = true;
      };

      builtins.emojis = {
        prefix = ":e ";
        hidden = true;
      };
    };


    # If this is not set the default styling is used.
    theme = {
      style = ''
        @define-color foreground rgba(255, 255, 255, 0.8);
        @define-color background hsla(240, 12.7%, 13.9%, 0.98);
        @define-color color1 hsl(172, 100%, 25.3%);

        #window,
        #box,
        #search,
        #password,
        #input,
        #prompt,
        #clear,
        #typeahead,
        #list,
        child,
        scrollbar,
        slider,
        #item,
        #text,
        #label,
        #bar,
        #sub,
        #activationlabel {
          all: unset;
        }

        #cfgerr {
          background: ${colors.error};
          margin-top: 20px;
          padding: 8px;
          font-size: 1.2em;
        }

        #window {
          color: ${colors.text};
          border: 4px solid ${colors.accent};
          border-radius: 10px;
        }

        #box {
          border-radius: 2px;
          background: ${colors.background};
          padding: 32px;
        }

        #search {
          background-color: ${colors.background};
          padding: 8px;
          font-size: 1.4em;
          font-weight: bold;
        }

        #prompt {
          margin-left: 4px;
          margin-right: 12px;
          color: ${colors.text};
          opacity: 0.2;
          font-size: 1.4em;
        }

        #clear {
          color: ${colors.text};
          opacity: 0.8;
        }

        #password,
        #input,
        #typeahead {
          border-radius: 2px;
        }

        #input {
          background: none;
        }

        #password {
        }

        #spinner {
          padding: 8px;
        }

        #typeahead {
          color: ${colors.text};
          opacity: 0.8;
        }

        #input placeholder {
          opacity: 0.5;
        }

        #list {
        }

        child {
          padding: 8px;
          border-radius: 2px;
        }

        child:selected,
        child:hover {
          background: ${colors.highlight};
        }

        #item {
        }

        #icon {
          margin-right: 8px;
        }

        #text {
        }

        #label {
          font-weight: 500;
        }

        #sub {
          opacity: 0.5;
          font-size: 0.8em;
        }

        #activationlabel {
        }

        #bar {
        }

        .barentry {
        }

        .activation #activationlabel {
        }

        .activation #text,
        .activation #icon,
        .activation #search {
          opacity: 0.5;
        }
      '';
    };

  };

}
