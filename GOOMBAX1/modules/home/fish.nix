{ pkgs, configPath, ... }: {

  # TODO: Conditional import this
  home.packages = with pkgs.fishPlugins; [
    transient-fish
    sponge
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
    };
    shellInit = ''set fish_greeting'';
  };

}
