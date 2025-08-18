{ ... }: {

  # Plugins
  programs.nvf.settings.vim = {

    ui.nvim-ufo.enable = true;
    statusline.lualine.enable = true;
    binds.whichKey.enable = true;
    visuals.rainbow-delimiters.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    mini.indentscope.enable = true;
    mini.pairs.enable = true;
    mini.comment.enable = true;
    mini.surround.enable = true;

    dashboard.startify = {
      enable = true;
      lists = [
        {
          header = [ "Bookmarks" ];
          type = "bookmarks";
        }
        {
          header = [ "MRU" ];
          type = "dir";
        }
        {
          header = [ "Commands" ];
          type = "commands";
        }
      ];
      bookmarks = [
        { c = "~/nixos-config"; }
        { n = "~/sync/Notes"; }
        { i = "~/code/icosearch"; }
        { o = "~/code/overway"; }
        { g = "~/code/gumbotchi"; }
      ];
    };

    tabline.nvimBufferline = {
      enable = true;
      setupOpts.options = {
        style_preset = "no_italic";
        numbers = "none";
        tab_size = 14;
        show_buffer_close_icons = false;
        separator_style = "thick";
        middle_mouse_command = {
          _type = "lua-inline";
          expr = ''
            function(bufnum)
              require("bufdelete").bufdelete(bufnum, false)
            end
          '';
        };
      };
    };

    ui.colorizer = {
      enable = true;
      setupOpts.filetypes."*" = { }; # Enable on all file types
    };

    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        confirm = "<Tab>";
        next = "<Down>";
        previous = "<Up>";
      };
    };


    terminal.toggleterm = {
      enable = true;
      mappings.open = "<leader>t";
      setupOpts = {
        direction = "float";
        border = "curved";
      };
    };

    utility.yazi-nvim = {
      enable = true;
      mappings.openYazi = "<leader> ";
    };

    utility.preview.markdownPreview = {
      enable = true;
      autoStart = false;
    };

    projects.project-nvim = {
      enable = true;
      setupOpts = {
        show_hidden = true;
        manual_mode = false;
        patterns = [".git" "Makefile" "package.json" "flake.nix" "cargo.toml"];
      };
    };
  };


  # Not Plugins
  programs.nvf.settings.vim = {

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      wrap = false;
      scrolloff = 10;
      foldlevel = 99;
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    lsp = {
      enable = true;
      null-ls.enable = true;
      inlayHints.enable = false;
      lspSignature.enable = true;
      formatOnSave = true;
    };

    languages = {
      yaml.enable = true; # Doesn't have a format option
      ts.enable = true;
      css.enable = true;
      nix = {
        enable = true;
        lsp.server = "nixd";
      };
      markdown = {
        enable = true;
        treesitter.enable = true;
        format.enable = true;
      }; 
      python = {
        enable = true;
        format.enable = true;
        format.type = "ruff";
      };
      bash = {
        enable = true;
        format.enable = true;
      };
      rust.enable = true;
    };

    keymaps = [
      {
        key = "<leader>f";
        mode = "n";
        silent = true;
        action = ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>";
      }
      {
        key = "<leader>m";
        mode = "n";
        silent = true;
        action = ":MarkdownPreview<CR>";
      }
      {
        key = "<leader>h";
        mode = "n";
        silent = true;
        action = ":Startify<CR>";
      }
    ];

    # autocmds = [
    #   {
    #     desc = "4 Spacers";
    #     command = "setlocal shiftwidth=4 | setlocal tabstop=4";
    #     event = ["BufEnter"];
    #     pattern = [
    #       "*.py"
    #       "*.sass"
    #       "*.scss"
    #       "*.css"
    #     ];
    #   }
    # ];
    
  };

}
