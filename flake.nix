{
  description = "Gumbachi NixOS Config";
  inputs = {

    # Default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # System
    stylix.url = "github:danth/stylix";

    agenix.url = "github:ryantm/agenix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # Applications
    overway.url = "github:Gumbachi/overway";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    niri.url = "github:sodiboo/niri-flake";

    nvf.url = "github:notashelf/nvf";

    walker.url = "github:abenz1267/walker";

    nixos-cli.url = "github:nix-community/nixos-cli";

    helix.url = "github:helix-editor/helix";

    # Fetch wallpapers and load into nix store
    wallpaper.url = "https://files.gumbachi.com/wallpapers/cyberpunk.png";
    wallpaper.flake = false;

    wallpaper-portrait.url = "https://files.gumbachi.com/wallpapers/cyberpunk-portrait-compressed.png";
    wallpaper-portrait.flake = false;

  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: let
    user = "jared";
    configPath = "/home/${user}/nixos-config";
  in {
    # Host Name = <GOOMBA><X/S/L><Number>
    # GOOMBA = Name
    # X/S = Desktop/Laptop, Server
    # Number = ID

    nixosConfigurations.GOOMBAX1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; };
      modules = [
        ./GOOMBAX1/configuration.nix # Main Config

        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs configPath; };
          };
          home-manager.users.${user}.imports = [ ./GOOMBAX1/home.nix ];
        }

        # Overlays
        { nixpkgs.overlays = [
          inputs.niri.overlays.niri
        ]; }

        # Hardware Support
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate

        # Third Party
        inputs.stylix.nixosModules.stylix
        inputs.nvf.nixosModules.default
        inputs.nur.modules.nixos.default
        inputs.niri.nixosModules.niri
        inputs.nixos-cli.nixosModules.nixos-cli
      ];
    };

    nixosConfigurations.GOOMBAS2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; };
      modules = [
        ./GOOMBAS2/configuration.nix # Main Config

        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs user configPath; };
          };
          home-manager.users.${user}.imports = [ ./GOOMBAS2/home.nix ];
        }

        # Hardware Support
        inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
        inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

        # Third Party
        inputs.nvf.nixosModules.default # Neovim
        inputs.stylix.nixosModules.stylix
        inputs.agenix.nixosModules.default
        inputs.nixos-cli.nixosModules.nixos-cli

      ];
    };

    nixosConfigurations.GOOMBAX2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; };
      modules = [
        ./GOOMBAX2/configuration.nix # Main Config

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs user configPath; };
            users.jared.imports = [ ./GOOMBAX2/home.nix ];
          };
        }

        # Hardware Config
        inputs.nixos-hardware.nixosModules.dell-xps-15-9560

        # Third Party Modules
        inputs.stylix.nixosModules.stylix
        inputs.nvf.nixosModules.default
        inputs.nur.modules.nixos.default
        inputs.niri.nixosModules.niri
        inputs.nixos-cli.nixosModules.nixos-cli
      ];
    };

  };
}
