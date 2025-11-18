{ config, lib, pkgs, ... }:
let
  inherit (lib) mkPackageOption mkOption;
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

    # Shell
    users.defaultUserShell = cfg.shell;

    home-manager.sharedModules = [{

      xdg.mimeApps.enable = true;
      xdg.mimeApps.defaultApplicationPackages = cfg.browser
        ++ cfg.files
        ++ cfg.text
        ++ cfg.video
        ++ cfg.audio
        ++ cfg.image;

    #   xdg.mimeApps = let
    #     # browser = {
    #     #   prefix = "x-scheme-handler";
    #     #   types = [ "http" "https" "about" "unknown" ];
    #     #   apps = cfg.browser;
    #     # };
    #     audio = {
    #       prefix = "audio";
    #       types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
    #       apps = cfg.audio;
    #     };
    #     video = {
    #       prefix = "video";
    #       types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
    #       apps = cfg.video;
    #     };
    #     image = {
    #       prefix = "image";
    #       types = [ "apng" "avif" "bmp" "gif" "x-icon" "jpeg" "png" "svg+xml" "tiff" "webp" ];
    #       apps = cfg.image;
    #     };
    #   in {
    #     enable = true;
    #     defaultApplications =
    #       builtins.listToAttrs ( map (type: { name = "${audio.prefix}/${type}" ; value = audio.apps; }) audio.types ) //
    #       builtins.listToAttrs ( map (type: { name = "${video.prefix}/${type}" ; value = video.apps; }) video.types ) //
    #       builtins.listToAttrs ( map (type: { name = "${image.prefix}/${type}" ; value = image.apps; }) image.types );
    #       # builtins.listToAttrs ( map (type: { name = "${browser.prefix}/${type}" ; value = browser.apps; }) browser.types );
    #   };
    }];

  };

}
