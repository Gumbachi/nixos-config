{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str listOf;
  module = "default-apps";
  cfg = config.${module};
in {

  options.${module} = {

    enable = mkEnableOption "Enable settings default apps via this module";

    browser = mkOption {
      type = listOf str;
      description = "Set the default browser. Can set more than one default to be used";
      example = [ "firefox.desktop" "chromium.desktop" ];
      default = [];
    };
    editor = mkOption {
      type = listOf str;
      description = "Set the default text editor";
      example = [ "nvim.desktop" ];
      default = [];
    };
    video = mkOption {
      type = listOf str;
      description = "Set the default video player";
      example = [ "mpv.desktop" ];
      default = [];
    };
    audio = mkOption {
      type = listOf str;
      description = "Set the default audio player";
      example = [ "mpv.desktop" ];
      default = [];
    };
    image = mkOption {
      type = listOf str;
      description = "Set the default image viewer";
      example = [ "imv.desktop" ];
      default = [];
    };
  };

  config = mkIf cfg.enable {
    home-manager.sharedModules = [{
          
      xdg.mimeApps = let
        browser = {
          prefix = "x-scheme-handler";
          types = [ "http" "https" "about" "unknown" ];
          apps = cfg.browser;
        };
        audio = {
          prefix = "audio";
          types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
          apps = cfg.audio;
        };
        video = {
          prefix = "video";
          types = [ "mp4" "webm" "x-msvideo" "mpeg" "ogg" "quicktime" "x-matroska" ];
          apps = cfg.video;
        };
        image = {
          prefix = "image";
          types = [ "apng" "avif" "bmp" "gif" "x-icon" "jpeg" "png" "svg+xml" "tiff" "webp" ];
          apps = cfg.image;
        };
      in {
        enable = true;
        defaultApplications = 
          builtins.listToAttrs ( map (type: { name = "${audio.prefix}/${type}" ; value = audio.apps; }) audio.types ) //
          builtins.listToAttrs ( map (type: { name = "${video.prefix}/${type}" ; value = video.apps; }) video.types ) //
          builtins.listToAttrs ( map (type: { name = "${image.prefix}/${type}" ; value = image.apps; }) image.types ) //
          builtins.listToAttrs ( map (type: { name = "${browser.prefix}/${type}" ; value = browser.apps; }) browser.types );
      };
    }];

  };

}
