{ user, ... }: {

  # This file mostly just serves as a shortcut to keep imports looking clean in configuration.nix

  # Import all nixos related submodules
  imports = [ ./nixos ];

  # Import all home manager related submodules
  home-manager.users.${user}.imports = [ ./home ];

}
