{ user, pkgs, config, lib, ... }:

with lib;

let 
  cfg = config.development;
in
{
  
  options.development = {
    android.enable = mkEnableOption "Enable the required tools for Android development."; 
    devenv.enable = mkEnableOption "Enable devenv for declarative, reproducible dev environments.";
    direnv.enable = mkEnableOption "Enable direnv for to automatically activate dev environments when entering directory.";
    direnv.silent = mkEnableOption "Silence direnv output";
    just.enable = mkEnableOption "Enable just for easily running commands.";
  };

  config = mkMerge [

    (mkIf cfg.android.enable {
      programs.adb.enable = true;
      users.users.${user}.extraGroups = [ "adbusers" "kvm" ];
      environment.systemPackages = [ pkgs.android-studio ];
    })

    (mkIf cfg.devenv.enable {
      environment.systemPackages = [ pkgs.devenv ];
      nix.extraOptions = ''trusted-users = root ${user}''; # Devenv shells
    })

    (mkIf cfg.direnv.enable {
      home-manager.sharedModules = [{
        programs.direnv = {
          enable = true;
          silent = cfg.direnv.silent;
        };
      }];
    })

    (mkIf cfg.just.enable {
      environment.systemPackages = [ pkgs.just ];
    })

  ];


}
