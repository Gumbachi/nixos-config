{ inputs, pkgs, ... }: {

  programs.floorp = {
    # Temp fix - Remove when https://github.com/NixOS/nixpkgs/issues/418473 is merged
    # package = inputs.floorp-disable-lto.legacyPackages.x86_64-linux.floorp;
    profiles.default = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden 
        ];
      };

      # search = {
      #   default = "ddg";
      #   order = [ "ddg" "google" ];
      #   force = false;
      # };

      settings = {
        "extensions.autoDisableScopes" = 0; # Auto enable plugins

        "browser.startup.page" = 1;
        "browser.startup.homepage" = "https://homepage.gumbachi.com";
        "browser.aboutwelcome.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.proton.toolbar.version" = 3;
        "browser.theme.toolbar-theme" = 0;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.search.suggest.enabled" = false; # Disable suggestions
        "browser.search.separatePrivateDefault" = false; # Use the same engine for private tabs

        # Set deafult background to disable to match color theme
        "browser.newtabpage.activity-stream.floorp.background.type" = 0;
        "browser.newtabpage.activity-stream.floorp.newtab.releasenote.hide" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;

        "browser.newtabpage.pinned" = [
          {
            label = "Nixpkgs";
            url = "https://search.nixos.org/options?channel=unstable";
            customScreenshotURL = "https://wiki.nixos.org/nixos.png";
          }
          {
            label = "HM Options";
            url = "https://home-manager-options.extranix.com/?query=&release=master";
          }
          {
            label = "GitHub";
            url = "https://github.com";
          }
          {
            label = "Codeberg";
            url = "https://codeberg.org";
          }
          {
            label = "YouTube";
            url = "https://youtube.com";
          }
          {
            label = "Reddit";
            url = "https://reddit.com";
          }
          {
            label = "SteamDB";
            url = "https://steamdb.info";
          }
          {
            label = "ProtonDB";
            url = "https://protondb.com";
          }
          {
            label = "Photos";
            url = "https://photos.gumbachi.com";
          }
          {
            label = "Jellyfin";
            url = "https://watch.gumbachi.com";
          }
          {
            label = "Jellyseerr";
            url = "https://request.gumbachi.com";
          }
          {
            label = "Deluge";
            url = "https://deluge.gumbachi.com";
          }
          {
            label = "Open Deluge";
            url = "https://open-deluge.gumbachi.com";
          }
          {
            label = "Prowlarr";
            url = "https://prowlarr.gumbachi.com";
          }
          {
            label = "Radarr";
            url = "https://radarr.gumbachi.com";
          }
          {
            label = "Sonarr";
            url = "https://sonarr.gumbachi.com";
          }
          {
            label = "Porkbun";
            url = "https://porkbun.com";
          }
          {
            label = "PurelyMail";
            url = "https://purelymail.com";
          }

        #   {"url":"http://192.168.69.2:9696","label":"Prowlarr"},
        #   {"url":"http://192.168.69.2:7878","label":"Radarr"},
        #   {"url":"http://192.168.69.2:8989","label":"Sonarr"},
        #   {"url":"http://192.168.69.2:3080","label":"Adguard"},
        #   {"url":"https://amazon.com","label":"Amazon"},
        #   {"url":"https://www.nexusmods.com/","label":"Nexus Mods"}
        ];

        "browser.tabs.inTitlebar" = 0; # Disable Close button on title bar

        "floorp.browser.tabs.verticaltab" = true;
        "floorp.verticaltab.hover.enabled" = true; # Collapse vertical tabs
        "floorp.verticaltab.show.newtab.button" = false;
        "floorp.browser.user.interface" = 2; # Enable Firefox Proton UI
        "floorp.browser.sidebar.enable" = false;
        "floorp.browser.workspaces.enabled" = false;

        "extensions.formautofill.creditCards.enabled" = false;

        "browser.uiCustomization.state" = ''{
          "placements":{
            "widget-overflow-fixed-list":[],
            "unified-extensions-area":["firefoxcolor_mozilla_com-browser-action"],
            "nav-bar":[
              "back-button",
              "forward-button",
              "home-button",
              "stop-reload-button",
              "customizableui-special-spring1",
              "customizableui-special-spring2",
              "save-to-pocket-button",
              "urlbar-container",
              "downloads-button",
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action",
              "ublock0_raymondhill_net-browser-action",
              "unified-extensions-button"
            ],
            "toolbar-menubar":["menubar-items"],
            "TabsToolbar":["workspaces-toolbar-button","tabbrowser-tabs"],
            "PersonalToolbar":["import-button","personal-bookmarks"],
            "statusBar":["status-text"]
          },
          "seen":["developer-button","sidebar-reverse-position-toolbar","undo-closed-tab","profile-manager","workspaces-toolbar-button","firefoxcolor_mozilla_com-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action"],
          "dirtyAreaCache":["nav-bar","statusBar","PersonalToolbar","TabsToolbar","unified-extensions-area","toolbar-menubar"],
          "currentVersion":20,
          "newElementCount":10
        }'';
      };

    };
  };

}
  
