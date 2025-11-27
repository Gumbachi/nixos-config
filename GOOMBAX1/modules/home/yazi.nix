{ ... }: {

  # Note: Prepend_* has higher priority

  programs.yazi.initLua = ''
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

  programs.yazi.theme = {
    icon.append_dirs = [
      { name = "games"; text = "󰸿"; }
      { name = "code"; text = "󰅴"; }
      { name = "nixos-config"; text = "󱄅"; }
      { name = "sync"; text = "󰓦"; }
      { name = "downloads"; text = "󰮏"; }
      { name = "documents"; text = "󰧮"; }
      { name = "misc"; text = "󰎂"; }
      { name = "iso"; text = "󰗮"; }
      { name = "screenshots"; text = "󰋩"; }
    ];
  };


  programs.yazi.settings = {

    mgr.show_hidden = false;

    tasks.image_alloc = 0;
    tasks.image_bound = [0 0]; # Render the image. we got enough ram

    preview.ueberzug_scale = 0.5;
    preview.ueberzug_offset = [350 20 0 0];

    opener.play = [
      {
        run = ''mpv "$@"'';
        orphan = true;
        for = "unix";
      }
    ];

    opener.edit = [
      {
        run = ''$EDITOR "$@"'';
        block = true;
        for = "unix";
      }
    ];

    opener.open = [
      {
        run = ''xdg-open "$@"'';
        desc = "Open";
      }
    ];

    opener.unzip = [
      {
        run = ''unar -d "$0"'';
        block = true;
        desc = "Unzip";
      }
    ];

    open.prepend_rules = [
      {
        name = "*.zip";
        use = "unzip";
      }
    ];

  };
}
