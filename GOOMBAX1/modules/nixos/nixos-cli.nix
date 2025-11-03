{ ... }: {

  services.nixos-cli.config = {
    config_location = "$HOME/nixos-config";
    no_confirm = true;
    use_nvd = true;

    apply = {
      ignore_dirty_tree = true;
      use_nom = true;
    };
  };

}
