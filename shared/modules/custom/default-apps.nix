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
      default = [ pkgs.firefox ];
    };

    terminal = mkOption {
      type = listOf package;
      description = "Set the default terminal emulator.";
      example = [ pkgs.kitty pkgs.ghostty ];
      default = [ pkgs.kitty ];
    };

    files = mkOption {
      type = listOf package;
      description = "Set the default file manager.";
      example = [ pkgs.yazi pkgs.xfce.thunar ];
      default = [ pkgs.xfce.thunar ];
    };

    text = mkOption {
      type = listOf package;
      description = "Set the default text editor";
      example = [ pkgs.helix pkgs.vim ];
      default = [ pkgs.helix ];
    };

    video = mkOption {
      type = listOf package;
      description = "Set the default video player";
      example = [ pkgs.mpv pkgs.vlc ];
      default = [ pkgs.mpv ];
    };

    audio = mkOption {
      type = listOf package;
      description = "Set the default audio player";
      example = [ pkgs.mpv pkgs.cantata ];
      default = [ pkgs.mpv ];
    };

    image = mkOption {
      type = listOf package;
      description = "Set the default image viewer";
      example = [ pkgs.imv ];
      default = [ pkgs.imv ];
    };

    shell = mkPackageOption pkgs "bash" {};
  };

  config = {

    users.defaultUserShell = cfg.shell;

    environment.sessionVariables = {
      EDITOR = getExe (elemAt cfg.text 0);
      BROWSER = getExe (elemAt cfg.browser 0);
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
