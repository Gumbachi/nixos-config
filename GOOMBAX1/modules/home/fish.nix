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
      edit = "$EDITOR ${configPath}";
      rebuild = "nh os switch";
      rebuild-boot = "nh os boot";

      sshs1 = "ssh jared@192.168.69.1";
      sshs2 = "ssh jared@192.168.69.2";
    };

    shellAbbrs = {
      nixgc = "sudo nix-collect-garbage -d";
    };

    shellInit = ''set fish_greeting'';
  };

}
