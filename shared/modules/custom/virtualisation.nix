{ user, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.virtualisation;
in {

  options.virtualisation = {
    docker.addUserToGroup = mkEnableOption ''Add user to "docker" group'';
    libvirtd.addUserToGroup = mkEnableOption ''Add user to "libvirtd" group'';
    virt-manager.enable = mkEnableOption "Enable virt-manager tool";
  };

  config = mkMerge [

    (mkIf (cfg.docker.enable && cfg.docker.addUserToGroup) {
      users.users.${user}.extraGroups = [ "docker" ];
    })

    (mkIf (cfg.libvirtd.enable && cfg.libvirtd.addUserToGroup) {
      users.users.${user}.extraGroups = [ "libvirtd" ];
    })

    (mkIf (cfg.virt-manager.enable) {
      programs.virt-manager.enable = true;
    })

  ];
}
