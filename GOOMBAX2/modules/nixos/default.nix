{ ... }: let
  GOOMBAX1 = ../../../GOOMBAX1/modules/nixos;
in {

  imports = [

    # Use modules from GOOMBAX1
    (GOOMBAX1 + /nixos-cli.nix)

  ];

}
