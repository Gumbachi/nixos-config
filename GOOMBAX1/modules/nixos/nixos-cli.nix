{ config, lib, pkgs, ... }: let
  inherit (lib) mkIf;
  cfg = config.services.nixos-cli;
in {

  environment.systemPackages = mkIf cfg.enable [ pkgs.nvd pkgs.nix-output-monitor ];

  services.nixos-cli.config = {
    config_location = "/home/jared/nixos-config";
    no_confirm = true;
    use_nvd = true;
    apply.use_nom = true;
  };

}
