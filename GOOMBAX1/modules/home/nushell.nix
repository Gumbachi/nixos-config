{ ... }: {

  home.shell.enableNushellIntegration = true;

  programs.nushell.settings = {
    show_banner = false;
  };

  programs.nushell.shellAliases = {
    edit = ''$env.EDITOR ${configPath}'';
    rebuild = "nixos apply --yes";
    rebuild-boot = "nixos apply --yes --no-activate";
    sshs2 = "ssh jared@192.168.69.2";
  };
    # functions = {
    #   upload-wallpaper = "scp $argv jared@192.168.69.2:main/config/caddy/srv/wallpapers";
    # };
  };

}
