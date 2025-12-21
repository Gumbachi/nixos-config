{ config, lib, pkgs, ... }: let
  inherit (lib) mkIf;
  cfg = config.services.nixos-cli;
in {

  environment.systemPackages = mkIf cfg.enable [ pkgs.nvd pkgs.nix-output-monitor ];

  services.nixos-cli.config = {
    config_location = "~/nixos-config";
    confirmation.always = false;
    use_nvd = true;
    apply.use_nom = true;
  };

}
