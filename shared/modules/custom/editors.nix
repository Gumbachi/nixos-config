{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf mkMerge types;
  cfg = config.editors;
in {
  options.editors = {

    libreoffice.enable = mkEnableOption "Enable LibreOffice for edting various filetypes.";

    image = {
      gimp.enable = mkEnableOption "Enable gimp for image editing.";
      krita.enable = mkEnableOption "Enable Krita for image editing.";
    };

    video = {
      handbrake.enable = mkEnableOption "Enable handbrake for GUI tool management.";
      losslesscut.enable = mkEnableOption "Enable lossless cut for easily trimming videos.";
    };

    text = {
      helix = {
        enable = mkEnableOption "Enable helix text editor.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to helix.";
      };
      vscodium = {
        enable = mkEnableOption "Enable vscodium text editor.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to codium.";
      };
      nvf = {
        enable = mkEnableOption "Enable nvim/nvf.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to nvim.";
        languages = mkOption {
          type = types.attrs;
          description = "The whole block for programs.nvf.settings.vim.languages";
          example = "{ python.enable = true; }";
          default = { };
        };
      };
    };
  };

  config = mkMerge [
    
    (mkIf cfg.libreoffice.enable {
      environment.systemPackages = with pkgs; [
        libreoffice # Office Software
        hunspell # Spellcheck for libreoffice
        hunspellDicts.en_US # US Dictionary for spellcheck
      ];
    })

    (mkIf cfg.image.gimp.enable {
      environment.systemPackages = [ pkgs.gimp3 ];
    })

    (mkIf cfg.image.krita.enable {
      environment.systemPackages = [ pkgs.krita ];
    })

    (mkIf cfg.video.handbrake.enable {
      environment.systemPackages = [ pkgs.handbrake ];
    })

    (mkIf cfg.video.losslesscut.enable {
      environment.systemPackages = [ pkgs.losslesscut-bin ];
    })

    (mkIf cfg.text.vscodium.enable {
      environment.systemPackages = [ pkgs.vscodium ];
      environment.sessionVariables.EDITOR = mkIf cfg.text.vscodium.setDefault "codium";
    })

    (mkIf cfg.text.helix.enable {
      environment.systemPackages = [ pkgs.helix ];
      environment.sessionVariables.EDITOR = mkIf cfg.text.helix.setDefault "helix";
      home-manager.sharedModules = [{ programs.helix.enable = true; }];
    })

    (mkIf cfg.text.nvf.enable {
      environment.sessionVariables.EDITOR = mkIf cfg.text.nvf.setDefault "nvim";

      programs.nvf.enable = true;

      programs.nvf.settings.vim.options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        wrap = false;
      };

      # Vim Settings
      programs.nvf.settings.vim = {
        statusline.lualine.enable = true;
        binds.whichKey.enable = true;
        visuals.rainbow-delimiters.enable = true;
        dashboard.dashboard-nvim.enable = true;
        telescope.enable = true;
        treesitter.enable = true;


        ui.colorizer = {
          enable = true;
          setupOpts.filetypes = {
            "*" = { }; # Enable on all file types
          };
        };

        autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            confirm = "<Tab>";
            next = "<Down>";
            previous = "<Up>";
          };
        };

        mini = {
          indentscope.enable = true;
          pairs.enable = true;
          comment.enable = true;
          surround.enable = true;
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
          # setupOpts.open_for_directories = true;
        };

        utility.preview.markdownPreview = {
          enable = true;
          autoStart = true;
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


      programs.nvf.settings.vim.clipboard = {
        enable = true;
      };

      programs.nvf.settings.vim.lsp = {
        enable = true;
        inlayHints.enable = true;
        lspSignature.enable = true;
        formatOnSave = false;
      };

      # Languages
      programs.nvf.settings.vim.languages = mkMerge [
        {
          # Language Defaults
          enableTreesitter = false;
          enableFormat = true;
        }
        cfg.text.nvf.languages
      ];

      programs.nvf.settings.vim.keymaps = [
        {
          key = "<leader>f";
          mode = "n";
          silent = true;
          action = ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>";
        }
      ];

      programs.nvf.settings.vim.autocmds = [
        {
          desc = "4 Spacers";
          command = "setlocal shiftwidth=4 | setlocal tabstop=4";
          event = ["BufEnter"];
          pattern = [
            "*.py"
            "*.sass"
            "*.scss"
            "*.css"
          ];
        }
      ];
    })
  ];
}
