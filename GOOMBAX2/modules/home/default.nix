{ ... }:
let
  GOOMBAX1 = ../../../GOOMBAX1/modules/home;
in
{

  imports = [

    # Use modules from GOOMBAX1
    (GOOMBAX1 + /fish.nix)
    (GOOMBAX1 + /hypridle.nix)
    (GOOMBAX1 + /kitty.nix)
    (GOOMBAX1 + /mangohud.nix)
    (GOOMBAX1 + /rofi.nix)
    (GOOMBAX1 + /starship.nix)
    (GOOMBAX1 + /vesktop.nix)
    (GOOMBAX1 + /yazi.nix)
    (GOOMBAX1 + /floorp.nix)

    # Custom for X2
    ./hyprland.nix
    ./hyprlock.nix

  ];

}
