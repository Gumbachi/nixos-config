{ config, lib, ... }:
let
  cfg = config.services.vibrant;
in
{

  options.services.vibrant.enable = lib.mkEnableOption "Enable vibrant discord bot as a service";

  config = lib.mkIf cfg.enable {

    age.secrets.vibrant.file = ../../secrets/vibrant.age;

    virtualisation.oci-containers.containers.vibrant = {
      image = "docker.io/gumbachi/vibrant";
      environmentFiles = [ config.age.secrets.vibrant.path ];
    };    

  };


}
