{ lib, ... }:
let
  inherit (lib) mkOption;
in
{

  options.variables = {
    adguardhome.port = mkOption { default = 3080; };
  };

}
