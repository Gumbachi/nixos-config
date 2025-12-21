{ lib, user, ... }: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;

  # Function to generate a list all nix files to import from a provided directory
  # This is safe because all files here should not install anything
  # and should just be configuration. Installation/Enabling should be in services.nix and programs.nix
  importAll = dir: filter (hasSuffix ".nix") (
    map toString (filter (p: p != ./default.nix) (listFilesRecursive dir))
  );

in {
  # Import all nixos related submodules
  imports = let
    # generate list of modules to borrow from /hosts/enceladus/modules/nixos
    enceladus-modules = map (module: ../../enceladus/modules/nixos + module) [ /nixos-cli.nix ];
  in importAll ./nixos ++ enceladus-modules;

  # Import all home manager related submodules
  home-manager.users.${user}.imports = let
    # generate list of modules to borrow from /hosts/enceladus/modules/home
    enceladus-modules = map (module: ../../enceladus/modules/home + module) [
      /fish.nix
      /git.nix
      /helix.nix
      /starship.nix
      /yazi.nix
      /kitty.nix
    ];
  in importAll ./home ++ enceladus-modules;

}
