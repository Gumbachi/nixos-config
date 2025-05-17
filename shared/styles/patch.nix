{ config, ... }:{

  home-manager.sharedModules = [{

    # GTK Keyboard control outline fix
    stylix.targets.gtk.extraCss = ''
      * button:focus {
        box-shadow: none; outline: none;
      }

      * { outline: none; }

      scale slider {
        border: 2px solid @accent_color;
        background-color: @theme_bg_color;
      }
      
      * scale:focus {
        outline: none;
        box-shadow: none;
        border: none;
      }
    '';


    # Floorp color swap tab background and toolbar background to look better
    programs.floorp.profiles.default.userChrome = with config.lib.stylix.colors; ''
      #TabsToolbar {
        background-color: #${base00} !important;
      } 
      .tab-background:is([selected],[multiselected]) {
        background-color: #${base02} !important;
      }
    '';

    # Add a stylix youtube music theme
    xdg.configFile."YouTube Music/stylix-alt.css".text = with config.lib.stylix.colors; '' 
      html:not(.style-scope)
      {
        --ctp-base: #${base00};
        --ctp-mantle: #${base01};
        --ctp-crust: #${base01};

        --ctp-surface0: #${base02};
        --ctp-surface1: #${base03};
        --ctp-surface2: #${base04};

        --ctp-text: #${base05};
        --ctp-subtext0: #${base05};
        --ctp-subtext1: #${base05};

        --ctp-rosewater: #${base06};
        --ctp-lavender: #${base07};
        --ctp-red: #${base08};
        --ctp-peach: #${base09};
        --ctp-yellow: #${base0A};
        --ctp-green: #${base0B};
        --ctp-teal: #${base0C};
        --ctp-blue: #${base0D};
        --ctp-mauve: #${base0E};
        --ctp-flamingo: #${base0F};

        --ctp-accent: var(--ctp-blue);

        --unthemed-yet: inherit !important;

        --yt-spec-commerce-filled-hover: var(--ctp-accent) !important;
      }
    '' + builtins.readFile ./youtube-music.css;

    xdg.configFile."YouTube Music/stylix.css".text = with config.lib.stylix.colors; '' 

      html:not(.style-scope)
      { 
        --cust-ytmusic-play-nav-color: #${base01};
        --cust-ytmusic-dark-background: #${base00};
        --cust-ytmusic-dark-foreground: #${base01};
        
        --cust-ytmusic-light-text-1: #${base0D};
        --cust-ytmusic-light-2: #${base0D};
        --cust-ytmusic-light-3: #00FF00;
        --cust-ytmusic-light-4: #${base06};
        --cust-ytmusic-light-5: #00FFFF;
        
        --cust-ytmusic-medium-1: #${base06}b8;
        --cust-ytmusic-medium-2: #0000FF;
        --cust-ytmusic-medium-3: #${base0D};
        --cust-ytmusic-medium-4: #FF0000;
        --cust-ytmusic-medium-5: #${base0D};
        
        --cust-ytmusic-subscribe-color: #${base08};
        --cust-ytmusic-playbutton-color:#${base0D};
        --cust-ytmusic-tertiary-nav-button-color: #${base0D};
        --cust-ytmusic-nowplaying-color: #${base0D};
        
        --cust-ytmusic-main-text-1: #${base05};
        --cust-ytmusic-header-text-1: #${base05}c9;
        --cust-ytmusic-header-text-2: #${base05}c7; 

        --cust-ytmusic-scroll-width: 0px;

    '' + builtins.readFile ./youtube-music-alt.css;
  }];

}
