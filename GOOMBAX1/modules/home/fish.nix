{ pkgs, configPath, lib, osConfig, ... }: {

  home.packages = lib.mkIf osConfig.programs.fish.enable [
    pkgs.fishPlugins.transient-fish
    pkgs.fishPlugins.sponge
  ];

  # enable integrations
  home.shell.enableFishIntegration = true;

  programs.fish = {
    shellAliases = {
      edit = ''$EDITOR ${configPath}'';
    };
    shellAbbrs = {
      rebuild = "nixos apply --yes";
      rebuild-boot = "nixos apply --yes --no-activate";
      sshs2 = "ssh jared@192.168.69.2";
      mkvedit = "~/scripts/mkv-bulk-edit.sh";
    };
    shellInit = ''set fish_greeting'';
    functions = {
      upload-wallpaper = "scp $argv jared@192.168.69.2:main/config/caddy/srv/wallpapers";
    };
  };

}
