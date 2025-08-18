{ ... }: {

  # Note: Prepend_* has higher priority

  programs.yazi = {
    initLua = ''
      -- This is for adding group:user to status bar
      Status:children_add(function()
        local h = cx.active.current.hovered
        if not h or ya.target_family() ~= "unix" then
          return ""
        end

        return ui.Line {
          ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
          ":",
          ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
          " ",
        }
      end, 500, Status.RIGHT)
    '';
    theme = {
      icon = {
        append_dirs = [
          { name = "games"; text = "󰸿"; }
          { name = "code"; text = "󰅴"; }
          { name = "nixos-config"; text = "󱄅"; }
          { name = "sync"; text = "󰓦"; }
          { name = "downloads"; text = "󰮏"; }
          { name = "Downloads"; text = "󰮏"; }
          { name = "documents"; text = "󰧮"; }
        ];
      }; 
    };
    settings = {
      yazi = {
        manager.show_hidden = false;
        opener = {
          play = [
            {
              run = ''mpv "$@"'';
              orphan = true;
              for = "unix";
            }
          ];
          edit = [
            {
              run = ''$EDITOR "$@"'';
              block = true;
              for = "unix";
            }
          ];
          open = [
            {
              run = ''xdg-open "$@"'';
              desc = "Open";
            }
          ];
          unzip = [
            {
              run = ''unar -d "$0"'';
              block = true;
              desc = "Unzip";
            }
          ];
        };

        open = {
          prepend_rules = [
            {
              name = "*.zip";
              use = "unzip";
            }
          ];
        };
      };
    };
  };

}
