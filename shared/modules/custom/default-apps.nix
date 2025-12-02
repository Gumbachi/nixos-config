{ config, lib, pkgs, ... }:
let
  inherit (builtins) elemAt length;
  inherit (lib) mkPackageOption mkOption getExe mkIf;
  inherit (lib.types) listOf package;
  module = "default-apps";
  cfg = config.${module};
in {

  options.${module} = {

    browser = mkOption {
      type = listOf package;
      description = "Set the default browser.";
      example = [ pkgs.chromium pkgs.firefox ];
      default = [];
    };

    terminal = mkOption {
      type = listOf package;
      description = "Set the default terminal emulator.";
      example = [ pkgs.kitty pkgs.ghostty ];
      default = [];
    };

    files = mkOption {
      type = listOf package;
      description = "Set the default file manager.";
      example = [ pkgs.yazi pkgs.xfce.thunar ];
      default = [];
    };

    text = mkOption {
      type = listOf package;
      description = "Set the default text editor";
      example = [ pkgs.helix pkgs.vim ];
      default = [];
    };

    video = mkOption {
      type = listOf package;
      description = "Set the default video player";
      example = [ pkgs.mpv pkgs.vlc ];
      default = [];
    };

    audio = mkOption {
      type = listOf package;
      description = "Set the default audio player";
      example = [ pkgs.mpv pkgs.cantata ];
      default = [];
    };

    image = mkOption {
      type = listOf package;
      description = "Set the default image viewer";
      example = [ pkgs.imv ];
      default = [];
    };

    shell = mkPackageOption pkgs "bash" {};
  };

  config = {

    users.defaultUserShell = cfg.shell;

    environment.sessionVariables = {
      EDITOR = mkIf (length cfg.text > 0) (getExe (elemAt cfg.text 0));
      BROWSER = mkIf (length cfg.browser > 0) (getExe (elemAt cfg.browser 0));
    };

    home-manager.sharedModules = [{
      xdg.mimeApps = {
        enable = true;
        defaultApplicationPackages = cfg.image
          ++ cfg.video
          ++ cfg.audio
          ++ cfg.files
          ++ cfg.text
          ++ cfg.terminal
          ++ cfg.browser;
      };
    }];

  };

}
